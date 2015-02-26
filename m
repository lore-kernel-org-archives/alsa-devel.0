From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/10] ALSA: hda - Decouple PCM and hwdep
	devices from codec object
Date: Thu, 26 Feb 2015 18:00:16 +0100
Message-ID: <1424970025-8082-2-git-send-email-tiwai@suse.de>
References: <1424970025-8082-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A829C2614BC
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 18:00:31 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5C288ADC8
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 17:00:31 +0000 (UTC)
In-Reply-To: <1424970025-8082-1-git-send-email-tiwai@suse.de>
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

This is a preliminary patch for the hda_bus implementation, removing
the parent device setup to codec device.  Since the bus and the class
devices can't be crossed over, leave the sound devices to the default
parent device as is.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_beep.c       | 1 -
 sound/pci/hda/hda_controller.c | 3 ---
 sound/pci/hda/hda_hwdep.c      | 3 ---
 3 files changed, 7 deletions(-)

diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
index 1e7de08e77cb..d6be4e852c4d 100644
--- a/sound/pci/hda/hda_beep.c
+++ b/sound/pci/hda/hda_beep.c
@@ -168,7 +168,6 @@ static int snd_hda_do_attach(struct hda_beep *beep)
 	input_dev->evbit[0] = BIT_MASK(EV_SND);
 	input_dev->sndbit[0] = BIT_MASK(SND_BELL) | BIT_MASK(SND_TONE);
 	input_dev->event = snd_hda_beep_event;
-	input_dev->dev.parent = &codec->dev;
 	input_set_drvdata(input_dev, beep);
 
 	beep->dev = input_dev;
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index ebb7a644bd86..4c7a6f9bfcde 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -958,9 +958,6 @@ static int azx_attach_pcm_stream(struct hda_bus *bus, struct hda_codec *codec,
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
 					      chip->card->dev,
 					      size, MAX_PREALLOC_SIZE);
-	/* link to codec */
-	for (s = 0; s < 2; s++)
-		pcm->streams[s].dev.parent = &codec->dev;
 	return 0;
 }
 
diff --git a/sound/pci/hda/hda_hwdep.c b/sound/pci/hda/hda_hwdep.c
index 11b5a42b4ec8..125f3420fa6a 100644
--- a/sound/pci/hda/hda_hwdep.c
+++ b/sound/pci/hda/hda_hwdep.c
@@ -116,9 +116,6 @@ int snd_hda_create_hwdep(struct hda_codec *codec)
 	hwdep->ops.ioctl_compat = hda_hwdep_ioctl_compat;
 #endif
 
-	/* link to codec */
-	hwdep->dev.parent = &codec->dev;
-
 	/* for sysfs */
 	hwdep->dev.groups = snd_hda_dev_attr_groups;
 	dev_set_drvdata(&hwdep->dev, codec);
-- 
2.3.0
