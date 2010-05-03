From: Shahin Ghazinouri <shahin.ghazinouri@pelagicore.com>
Subject: [PATCH] hda_intel: Fixes distorted recording on US15W
	chipset
Date: Mon, 3 May 2010 16:46:56 +0200
Message-ID: <399F8F37-FCF5-47E9-98A1-F1AA2972B12B@pelagicore.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out12.han.skanova.net (smtp-out12.han.skanova.net
	[195.67.226.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DA932460E
	for <alsa-devel@alsa-project.org>;
	Mon,  3 May 2010 16:47:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

The HDA controller in US15W (Poulsbo) reports inaccurate position values for capture streams when using the LPIB read method, resulting in distorted recordings. 
However, using the position buffer is broken for playback streams, resulting in a fallback to the LPIB method with the current driver. This patch works around the issue by independently detecting the read position method for capture and playback streams.
The patch will not have any effect if the position fix method is explicitly set.
Signed-off-by: Shahin Ghazinouri <shahin.ghazinouri@pelagicore.com>
---
--- linux-2.6.34-rc6/sound/pci/hda/hda_intel.c	2010-04-30 05:02:05.000000000 +0200
+++ linux-2.6.34-rc6_patch/sound/pci/hda/hda_intel.c	2010-04-30 11:31:57.000000000 +0200
@@ -425,7 +425,8 @@
	struct snd_dma_buffer posbuf;

	/* flags */
-	int position_fix;
+	int playback_position_fix;
+	int capture_position_fix;
	int poll_count;
	unsigned int running :1;
	unsigned int initialized :1;
@@ -1302,8 +1303,10 @@
	azx_sd_writel(azx_dev, SD_BDLPU, upper_32_bits(azx_dev->bdl.addr));

	/* enable the position buffer */
-	if (chip->position_fix == POS_FIX_POSBUF ||
-	    chip->position_fix == POS_FIX_AUTO ||
+	if (chip->capture_position_fix == POS_FIX_POSBUF ||
+	    chip->capture_position_fix == POS_FIX_AUTO ||
+	    chip->playback_position_fix == POS_FIX_POSBUF ||
+	    chip->playback_position_fix == POS_FIX_AUTO ||
	    chip->via_dmapos_patch) {
		if (!(azx_readl(chip, DPLBASE) & ICH6_DPLBASE_ENABLE))
			azx_writel(chip, DPLBASE,
@@ -1843,13 +1846,24 @@

	if (chip->via_dmapos_patch)
		pos = azx_via_get_position(chip, azx_dev);
-	else if (chip->position_fix == POS_FIX_POSBUF ||
-		 chip->position_fix == POS_FIX_AUTO) {
-		/* use the position buffer */
-		pos = le32_to_cpu(*azx_dev->posbuf);
+	else if (azx_dev->index < chip->playback_index_offset) {
+		/* Capture stream */
+		if (chip->capture_position_fix == POS_FIX_POSBUF ||
+		    chip->capture_position_fix == POS_FIX_AUTO)
+			/* use the position buffer */
+			pos = le32_to_cpu(*azx_dev->posbuf);
+		else
+			/* read LPIB */
+			pos = azx_sd_readl(azx_dev, SD_LPIB);
	} else {
-		/* read LPIB */
-		pos = azx_sd_readl(azx_dev, SD_LPIB);
+		/* Playback stream */
+		if (chip->playback_position_fix == POS_FIX_POSBUF ||
+		    chip->playback_position_fix == POS_FIX_AUTO)
+			/* use the position buffer */
+			pos = le32_to_cpu(*azx_dev->posbuf);
+		else
+			/* read LPIB */
+			pos = azx_sd_readl(azx_dev, SD_LPIB);
	}
	if (pos >= azx_dev->bufsize)
		pos = 0;
@@ -1884,15 +1898,30 @@
	azx_dev->start_flag = 0;

	pos = azx_get_position(chip, azx_dev);
-	if (chip->position_fix == POS_FIX_AUTO) {
-		if (!pos) {
-			printk(KERN_WARNING
-			       "hda-intel: Invalid position buffer, "
-			       "using LPIB read method instead.\n");
-			chip->position_fix = POS_FIX_LPIB;
-			pos = azx_get_position(chip, azx_dev);
-		} else
-			chip->position_fix = POS_FIX_POSBUF;
+	if (azx_dev->index < chip->playback_index_offset) {
+		/* Capture stream  */
+		if (chip->capture_position_fix == POS_FIX_AUTO) {
+			if (!pos) {
+				printk(KERN_WARNING
+				       "hda-intel: Invalid position buffer, "
+				       "using LPIB read method instead.\n");
+				chip->capture_position_fix = POS_FIX_LPIB;
+				pos = azx_get_position(chip, azx_dev);
+			} else
+				chip->capture_position_fix = POS_FIX_POSBUF;
+		}
+	} else {
+		/* Playback stream */
+		if (chip->playback_position_fix == POS_FIX_AUTO) {
+			if (!pos) {
+				printk(KERN_WARNING
+				       "hda-intel: Invalid position buffer, "
+				       "using LPIB read method instead.\n");
+				chip->playback_position_fix = POS_FIX_LPIB;
+				pos = azx_get_position(chip, azx_dev);
+			} else
+				chip->playback_position_fix = POS_FIX_POSBUF;
+		}
	}

	if (!bdl_pos_adj[chip->dev_index])
@@ -2431,7 +2460,10 @@
	chip->dev_index = dev;
	INIT_WORK(&chip->irq_pending_work, azx_irq_pending_work);

-	chip->position_fix = check_position_fix(chip, position_fix[dev]);
+	chip->capture_position_fix =
+	  check_position_fix(chip, position_fix[dev]);
+	chip->playback_position_fix =
+	  check_position_fix(chip, position_fix[dev]);
	check_probe_mask(chip, dev);

	chip->single_cmd = single_cmd;
