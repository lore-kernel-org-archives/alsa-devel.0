From: Dylan Reid <dgreid@chromium.org>
Subject: [RFCv2 07/22] ALSA: hda - Add jackpoll_ms to struct azx
Date: Fri, 28 Feb 2014 15:41:18 -0800
Message-ID: <1393630893-29010-8-git-send-email-dgreid@chromium.org>
References: <1393630893-29010-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f74.google.com (mail-pa0-f74.google.com
 [209.85.220.74])
 by alsa0.perex.cz (Postfix) with ESMTP id B7EBF2659CD
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 00:42:52 +0100 (CET)
Received: by mail-pa0-f74.google.com with SMTP id fa1so173140pad.5
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 15:42:51 -0800 (PST)
In-Reply-To: <1393630893-29010-1-git-send-email-dgreid@chromium.org>
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, swarren@wwwdotorg.org
List-Id: alsa-devel@alsa-project.org

Keeping a pointer to the jackpoll_ms array in the chip will allow
azx_codec_create to be shared between hda_intel and hda_platform
drivers.  Also modify get_jackpoll_ms to make the jackpoll_ms member
optional, this way a platform driver can leave it out if it's not
needed.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_intel.c | 8 +++++++-
 sound/pci/hda/hda_priv.h  | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 7cdb4dd..1e7d3f3 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1324,8 +1324,13 @@ static void azx_bus_reset(struct hda_bus *bus)
 
 static int get_jackpoll_interval(struct azx *chip)
 {
-	int i = jackpoll_ms[chip->dev_index];
+	int i;
 	unsigned int j;
+
+	if (!chip->jackpoll_ms)
+		return 0;
+
+	i = chip->jackpoll_ms[chip->dev_index];
 	if (i == 0)
 		return 0;
 	if (i < 50 || i > 60000)
@@ -3172,6 +3177,7 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
 	chip->driver_type = driver_caps & 0xff;
 	check_msi(chip);
 	chip->dev_index = dev;
+	chip->jackpoll_ms = jackpoll_ms;
 	INIT_WORK(&chip->irq_pending_work, azx_irq_pending_work);
 	INIT_LIST_HEAD(&chip->pcm_list);
 	INIT_LIST_HEAD(&chip->list);
diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
index c231c11..0a56e8e 100644
--- a/sound/pci/hda/hda_priv.h
+++ b/sound/pci/hda/hda_priv.h
@@ -321,6 +321,7 @@ struct azx {
 	int capture_streams;
 	int capture_index_offset;
 	int num_streams;
+	const int *jackpoll_ms; /* per-card jack poll interval */
 
 	/* Register interaction. */
 	const struct hda_controller_ops *ops;
-- 
1.8.1.3.605.g02339dd
