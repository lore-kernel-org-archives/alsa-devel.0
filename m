From: David Henningsson <david.henningsson@canonical.com>
Subject: [RFC PATCH] ALSA: hda - Do not accept responses from
	non-existing codecs
Date: Wed, 29 Jan 2014 13:12:31 +0100
Message-ID: <1390997551-7727-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B6B6D261693
 for <alsa-devel@alsa-project.org>; Wed, 29 Jan 2014 13:12:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

While looking into some spurious responses, I found that the addr value was
treated a bit inconsistent: values 8..0xf will be treated as codec 0 and
values 0..7 will be treated as no error regardless of whether there is a codec
there, or not.

With this patch, all non-existing codecs will be treated equally.
In addition, printing rp and wp could help figuring out if the wp value is
reported wrongly from the controller or if something else is wrong.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_intel.c |   23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

Note: this patch is untested (hence the RFC indication)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index fa2879a..e87eac5 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -834,18 +834,6 @@ static unsigned int azx_command_addr(u32 cmd)
 	return addr;
 }
 
-static unsigned int azx_response_addr(u32 res)
-{
-	unsigned int addr = res & 0xf;
-
-	if (addr >= AZX_MAX_CODECS) {
-		snd_BUG();
-		addr = 0;
-	}
-
-	return addr;
-}
-
 /* send a command */
 static int azx_corb_send_cmd(struct hda_bus *bus, u32 val)
 {
@@ -907,8 +895,15 @@ static void azx_update_rirb(struct azx *chip)
 		rp = chip->rirb.rp << 1; /* an RIRB entry is 8-bytes */
 		res_ex = le32_to_cpu(chip->rirb.buf[rp + 1]);
 		res = le32_to_cpu(chip->rirb.buf[rp]);
-		addr = azx_response_addr(res_ex);
-		if (res_ex & ICH6_RIRB_EX_UNSOL_EV)
+		addr = res_ex & 0xf;
+		if ((addr >= AZX_MAX_CODECS) || !(chip->codec_mask & (1 << addr))) {
+			snd_printk(KERN_ERR SFX "%s: spurious response %#x:%#x, rp = %d, wp = %d",
+				   pci_name(chip->pci),
+				   res, res_ex,
+				   chip->rirb.rp, wp);
+			snd_BUG();
+		}
+		else if (res_ex & ICH6_RIRB_EX_UNSOL_EV)
 			snd_hda_queue_unsol_event(chip->bus, res, res_ex);
 		else if (chip->rirb.cmds[addr]) {
 			chip->rirb.res[addr] = res;
-- 
1.7.9.5
