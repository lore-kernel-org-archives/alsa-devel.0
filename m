From: Dylan Reid <dgreid@chromium.org>
Subject: [RFCv2 03/22] ALSA: hda - Keep pointer to bdl_pos_fix
	in chip struct
Date: Fri, 28 Feb 2014 15:41:14 -0800
Message-ID: <1393630893-29010-4-git-send-email-dgreid@chromium.org>
References: <1393630893-29010-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f73.google.com (mail-oa0-f73.google.com
 [209.85.219.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 3926F26598A
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 00:42:52 +0100 (CET)
Received: by mail-oa0-f73.google.com with SMTP id n16so60830oag.2
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

This will allow for a platform hda driver to use it as well.  It
removes the dependency on the module param from hda_intel, which will
allow for azx_setup_periods to be shared.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_intel.c | 12 ++++++++----
 sound/pci/hda/hda_priv.h  |  1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 45718fb..9fcd1d1 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1147,7 +1147,7 @@ static int azx_setup_periods(struct azx *chip,
 {
 	u32 *bdl;
 	int i, ofs, periods, period_bytes;
-	int pos_adj;
+	int pos_adj = 0;
 
 	/* reset BDL address */
 	azx_sd_writel(chip, azx_dev, SD_BDLPL, 0);
@@ -1160,7 +1160,9 @@ static int azx_setup_periods(struct azx *chip,
 	bdl = (u32 *)azx_dev->bdl.area;
 	ofs = 0;
 	azx_dev->frags = 0;
-	pos_adj = bdl_pos_adj[chip->dev_index];
+
+	if (chip->bdl_pos_adj)
+		pos_adj = chip->bdl_pos_adj[chip->dev_index];
 	if (!azx_dev->no_period_wakeup && pos_adj > 0) {
 		struct snd_pcm_runtime *runtime = substream->runtime;
 		int pos_align = pos_adj;
@@ -1173,7 +1175,7 @@ static int azx_setup_periods(struct azx *chip,
 		pos_adj = frames_to_bytes(runtime, pos_adj);
 		if (pos_adj >= period_bytes) {
 			dev_warn(chip->card->dev,"Too big adjustment %d\n",
-				 bdl_pos_adj[chip->dev_index]);
+				 pos_adj);
 			pos_adj = 0;
 		} else {
 			ofs = setup_bdle(chip, snd_pcm_get_dma_buf(substream),
@@ -1184,6 +1186,7 @@ static int azx_setup_periods(struct azx *chip,
 		}
 	} else
 		pos_adj = 0;
+
 	for (i = 0; i < periods; i++) {
 		if (i == periods - 1 && pos_adj)
 			ofs = setup_bdle(chip, snd_pcm_get_dma_buf(substream),
@@ -2143,7 +2146,7 @@ static int azx_position_ok(struct azx *chip, struct azx_dev *azx_dev)
 	if (wallclk < (azx_dev->period_wallclk * 5) / 4 &&
 	    pos % azx_dev->period_bytes > azx_dev->period_bytes / 2)
 		/* NG - it's below the first next period boundary */
-		return bdl_pos_adj[chip->dev_index] ? 0 : -1;
+		return chip->bdl_pos_adj[chip->dev_index] ? 0 : -1;
 	azx_dev->start_wallclk += wallclk;
 	return 1; /* OK, it's fine */
 }
@@ -3207,6 +3210,7 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
 			break;
 		}
 	}
+	chip->bdl_pos_adj = bdl_pos_adj;
 
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
 	if (err < 0) {
diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
index 6d082d6..17afe90 100644
--- a/sound/pci/hda/hda_priv.h
+++ b/sound/pci/hda/hda_priv.h
@@ -357,6 +357,7 @@ struct azx {
 
 	/* flags */
 	int position_fix[2]; /* for both playback/capture streams */
+	const int *bdl_pos_adj;
 	int poll_count;
 	unsigned int running:1;
 	unsigned int initialized:1;
-- 
1.8.1.3.605.g02339dd
