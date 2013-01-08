From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 057/112] ALSA: hda - Check CORB overflow
Date: Tue,  8 Jan 2013 12:38:50 +0100
Message-ID: <1357645185-7645-58-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D6FE2651D8
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 28224A52D7
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add an overflow check of CORB in HD-audio controller and codec drivers
so that flood of sequential writes would work properly.
In the controller side, add a check of CORB read-pointer to make
returning -EAGAIN when it's full.  Meanwhile in the codec side, when
-EAGAIN error is received, it retries the write after flushing the
pending verbs (calling get_response() essentially does it).

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 10 ++++++++--
 sound/pci/hda/hda_intel.c | 11 +++++++++--
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index df4abbe..f362ef7 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -222,8 +222,14 @@ static int codec_exec_verb(struct hda_codec *codec, unsigned int cmd,
  again:
 	snd_hda_power_up(codec);
 	mutex_lock(&bus->cmd_mutex);
-	trace_hda_send_cmd(codec, cmd);
-	err = bus->ops.command(bus, cmd);
+	for (;;) {
+		trace_hda_send_cmd(codec, cmd);
+		err = bus->ops.command(bus, cmd);
+		if (err != -EAGAIN)
+			break;
+		/* process pending verbs */
+		bus->ops.get_response(bus, codec->addr);
+	}
 	if (!err && res) {
 		*res = bus->ops.get_response(bus, codec->addr);
 		trace_hda_get_response(codec, *res);
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index cca8727..d0f42d1 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -794,7 +794,7 @@ static int azx_corb_send_cmd(struct hda_bus *bus, u32 val)
 {
 	struct azx *chip = bus->private_data;
 	unsigned int addr = azx_command_addr(val);
-	unsigned int wp;
+	unsigned int wp, rp;
 
 	spin_lock_irq(&chip->reg_lock);
 
@@ -803,11 +803,18 @@ static int azx_corb_send_cmd(struct hda_bus *bus, u32 val)
 	if (wp == 0xffff) {
 		/* something wrong, controller likely turned to D3 */
 		spin_unlock_irq(&chip->reg_lock);
-		return -1;
+		return -EIO;
 	}
 	wp++;
 	wp %= ICH6_MAX_CORB_ENTRIES;
 
+	rp = azx_readw(chip, CORBRP);
+	if (wp == rp) {
+		/* oops, it's full */
+		spin_unlock_irq(&chip->reg_lock);
+		return -EAGAIN;
+	}
+
 	chip->rirb.cmds[addr]++;
 	chip->corb.buf[wp] = cpu_to_le32(val);
 	azx_writel(chip, CORBWP, wp);
-- 
1.8.0.1
