From: mengdong.lin@intel.com
Subject: [PATCH 1/2] ALSA: hda - allow to mask a buggy stream
	DMA by setting it as opened
Date: Tue, 13 May 2014 12:35:59 +0800
Message-ID: <1399955759-3171-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C8462652F1
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 06:34:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

The function azx_init_stream() can accept a bit mask parameter. If the bit for
a stream DMA is set, that stream device will be masked by setting it as opened
and so it will never be assigned to any PCM stream.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 248b90a..378fed7 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -2004,7 +2004,7 @@ EXPORT_SYMBOL_GPL(azx_mixer_create);
 
 
 /* initialize SD streams */
-int azx_init_stream(struct azx *chip)
+int azx_init_stream(struct azx *chip, unsigned int mask)
 {
 	int i;
 
@@ -2022,6 +2022,9 @@ int azx_init_stream(struct azx *chip)
 		/* stream tag: must be non-zero and unique */
 		azx_dev->index = i;
 		azx_dev->stream_tag = i + 1;
+		/* mask a buggy stream DMA by setting it as opened */
+		if (mask & (1 << i))
+			azx_dev->opened = 1;
 	}
 
 	return 0;
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index baf0e77..2fd8e6d 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -48,6 +48,6 @@ int azx_codec_create(struct azx *chip, const char *model,
 		     int *power_save_to);
 int azx_codec_configure(struct azx *chip);
 int azx_mixer_create(struct azx *chip);
-int azx_init_stream(struct azx *chip);
+int azx_init_stream(struct azx *chip, unsigned int mask);
 
 #endif /* __SOUND_HDA_CONTROLLER_H */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index d6bca62..377c3a5 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1364,7 +1364,7 @@ static int azx_first_init(struct azx *chip)
 		return err;
 
 	/* initialize streams */
-	azx_init_stream(chip);
+	azx_init_stream(chip, 0);
 
 	/* initialize chip */
 	azx_init_pci(chip);
-- 
1.8.1.2
