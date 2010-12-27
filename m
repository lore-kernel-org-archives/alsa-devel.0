From: andi@lisas.de
Subject: [patch 3/6] sound azt3328: cosmetics: use a helper
 variable for codec setup
Date: Mon, 27 Dec 2010 21:17:00 +0100
Message-ID: <20101227201700.GD28432@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B0BB103824
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2010 21:17:00 +0100 (CET)
Content-Disposition: inline; filename=codec_setup
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Andreas Mohr <andi@lisas.de>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Andreas Mohr <andi@lisas.de>

Index: linux-2.6/sound/pci/azt3328.c
===================================================================
--- linux-2.6.orig/sound/pci/azt3328.c	2010-12-27 14:29:14.322851001 -0500
+++ linux-2.6/sound/pci/azt3328.c	2010-12-27 14:29:16.686184335 -0500
@@ -2195,6 +2195,7 @@ snd_azf3328_create(struct snd_card *card
 	};
 	u8 dma_init;
 	enum snd_azf3328_codec_type codec_type;
+	struct snd_azf3328_codec *codec_setup;
 
 	*rchip = NULL;
 
@@ -2232,15 +2233,17 @@ snd_azf3328_create(struct snd_card *card
 	chip->opl3_io  = pci_resource_start(pci, 3);
 	chip->mixer_io = pci_resource_start(pci, 4);
 
-	chip->codecs[AZF_CODEC_PLAYBACK].io_base =
-				chip->ctrl_io + AZF_IO_OFFS_CODEC_PLAYBACK;
-	chip->codecs[AZF_CODEC_PLAYBACK].name = "PLAYBACK";
-	chip->codecs[AZF_CODEC_CAPTURE].io_base =
-				chip->ctrl_io + AZF_IO_OFFS_CODEC_CAPTURE;
-	chip->codecs[AZF_CODEC_CAPTURE].name = "CAPTURE";
-	chip->codecs[AZF_CODEC_I2S_OUT].io_base =
-				chip->ctrl_io + AZF_IO_OFFS_CODEC_I2S_OUT;
-	chip->codecs[AZF_CODEC_I2S_OUT].name = "I2S_OUT";
+	codec_setup = &chip->codecs[AZF_CODEC_PLAYBACK];
+	codec_setup->io_base = chip->ctrl_io + AZF_IO_OFFS_CODEC_PLAYBACK;
+	codec_setup->name = "PLAYBACK";
+
+	codec_setup = &chip->codecs[AZF_CODEC_CAPTURE];
+	codec_setup->io_base = chip->ctrl_io + AZF_IO_OFFS_CODEC_CAPTURE;
+	codec_setup->name = "CAPTURE";
+
+	codec_setup = &chip->codecs[AZF_CODEC_I2S_OUT];
+	codec_setup->io_base = chip->ctrl_io + AZF_IO_OFFS_CODEC_I2S_OUT;
+	codec_setup->name = "I2S_OUT";
 
 	if (request_irq(pci->irq, snd_azf3328_interrupt,
 			IRQF_SHARED, card->shortname, chip)) {

-- 
