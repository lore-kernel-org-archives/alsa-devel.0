From: Dylan Reid <dgreid@chromium.org>
Subject: [RFC 03/19] ALSA: hda - Keep pointer to bdl_pos_fix in
	chip struct
Date: Thu, 27 Feb 2014 22:35:46 -0800
Message-ID: <1393569362-27285-4-git-send-email-dgreid@chromium.org>
References: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f201.google.com (mail-ig0-f201.google.com
 [209.85.213.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E3542650A4
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 07:37:13 +0100 (CET)
Received: by mail-ig0-f201.google.com with SMTP id l13so102638iga.0
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 22:37:12 -0800 (PST)
In-Reply-To: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
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
 sound/pci/hda/hda_intel.c | 7 ++++---
 sound/pci/hda/hda_priv.h  | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index e0ee3d4..8eec5cb 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1179,7 +1179,7 @@ static int azx_setup_periods(struct azx *chip,
 	bdl = (u32 *)azx_dev->bdl.area;
 	ofs = 0;
 	azx_dev->frags = 0;
-	pos_adj = bdl_pos_adj[chip->dev_index];
+	pos_adj = chip->bdl_pos_adj[chip->dev_index];
 	if (!azx_dev->no_period_wakeup && pos_adj > 0) {
 		struct snd_pcm_runtime *runtime = substream->runtime;
 		int pos_align = pos_adj;
@@ -1192,7 +1192,7 @@ static int azx_setup_periods(struct azx *chip,
 		pos_adj = frames_to_bytes(runtime, pos_adj);
 		if (pos_adj >= period_bytes) {
 			dev_warn(chip->card->dev,"Too big adjustment %d\n",
-				 bdl_pos_adj[chip->dev_index]);
+				 chip->bdl_pos_adj[chip->dev_index]);
 			pos_adj = 0;
 		} else {
 			ofs = setup_bdle(chip, snd_pcm_get_dma_buf(substream),
@@ -2162,7 +2162,7 @@ static int azx_position_ok(struct azx *chip, struct azx_dev *azx_dev)
 	if (wallclk < (azx_dev->period_wallclk * 5) / 4 &&
 	    pos % azx_dev->period_bytes > azx_dev->period_bytes / 2)
 		/* NG - it's below the first next period boundary */
-		return bdl_pos_adj[chip->dev_index] ? 0 : -1;
+		return chip->bdl_pos_adj[chip->dev_index] ? 0 : -1;
 	azx_dev->start_wallclk += wallclk;
 	return 1; /* OK, it's fine */
 }
@@ -3226,6 +3226,7 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
 			break;
 		}
 	}
+	chip->bdl_pos_adj = bdl_pos_adj;
 
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
 	if (err < 0) {
diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
index 5a21985..0e3bba1 100644
--- a/sound/pci/hda/hda_priv.h
+++ b/sound/pci/hda/hda_priv.h
@@ -356,6 +356,7 @@ struct azx {
 
 	/* flags */
 	int position_fix[2]; /* for both playback/capture streams */
+	const int *bdl_pos_adj;
 	int poll_count;
 	unsigned int running:1;
 	unsigned int initialized:1;
-- 
1.8.1.3.605.g02339dd
