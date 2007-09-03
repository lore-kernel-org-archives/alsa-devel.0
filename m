From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: [PATCH 2/6] Fix resume logic,
	when dynamic power managment is on
Date: Mon, 3 Sep 2007 15:17:06 +0300
Message-ID: <200709031517.07008.maximlevitsky@gmail.com>
References: <200709031514.57875.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 734A510391B
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 15:17:34 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so1482713fka
	for <alsa-devel@alsa-project.org>; Mon, 03 Sep 2007 06:17:34 -0700 (PDT)
In-Reply-To: <200709031514.57875.maximlevitsky@gmail.com>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, mranostay@embeddedalley.com
List-Id: alsa-devel@alsa-project.org

>From 3d4f5b6dcf586277ca6ca4ea86068e01566c58c0 Mon Sep 17 00:00:00 2001
From: Maxim Levitsky <maximlevitsky@gmail.com>
Date: Mon, 3 Sep 2007 14:10:11 +0300
Subject: [PATCH] Fix resume logic, when dynamic power managment is on

Comment in hda_intel.c states that
"the explicit resume is needed only when POWER_SAVE isn't set", but this is not true.
There is no code that will automaticly power up the codec on resume, but only code that
powers it up when user accesses it. So if user leaves a sound playing, codec will not be powered

To fix that I check if there are any codecs that should be powered codec->power_count,
and if so I power them up together with main controller.

Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
---
 pci/hda/hda_codec.c |   16 +++++++++++++---
 pci/hda/hda_codec.h |    4 ++++
 pci/hda/hda_intel.c |    8 ++++----
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/pci/hda/hda_codec.c b/pci/hda/hda_codec.c
index 08104e2..e594de0 100644
--- a/pci/hda/hda_codec.c
+++ b/pci/hda/hda_codec.c
@@ -2787,7 +2787,6 @@ int snd_hda_suspend(struct hda_bus *bus, pm_message_t state)
 	return 0;
 }
 
-#ifndef CONFIG_SND_HDA_POWER_SAVE
 /**
  * snd_hda_resume - resume the codecs
  * @bus: the HDA bus
@@ -2803,10 +2802,21 @@ int snd_hda_resume(struct hda_bus *bus)
 	struct hda_codec *codec;
 
 	list_for_each_entry(codec, &bus->codec_list, list) {
-		hda_call_codec_resume(codec);
+		if (snd_hda_codec_needs_resume(codec))
+			hda_call_codec_resume(codec);
 	}
 	return 0;
 }
-#endif /* !CONFIG_SND_HDA_POWER_SAVE */
+#ifdef CONFIG_SND_HDA_POWER_SAVE
+int snd_hda_codecs_inuse(struct hda_bus *bus)
+{
+	struct hda_codec *codec;
 
+	list_for_each_entry(codec, &bus->codec_list, list) {
+		if (snd_hda_codec_needs_resume(codec))
+			return 1;
+	}
+	return 0;
+}
+#endif
 #endif
diff --git a/pci/hda/hda_codec.h b/pci/hda/hda_codec.h
index ca157e5..2bce925 100644
--- a/pci/hda/hda_codec.h
+++ b/pci/hda/hda_codec.h
@@ -686,9 +686,13 @@ int snd_hda_resume(struct hda_bus *bus);
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 void snd_hda_power_up(struct hda_codec *codec);
 void snd_hda_power_down(struct hda_codec *codec);
+#define snd_hda_codec_needs_resume(codec) codec->power_count
+int snd_hda_codecs_inuse(struct hda_bus *bus);
 #else
 static inline void snd_hda_power_up(struct hda_codec *codec) {}
 static inline void snd_hda_power_down(struct hda_codec *codec) {}
+#define snd_hda_codec_needs_resume(codec) 1
+#define snd_hda_codecs_inuse(bus) 1
 #endif
 
 #endif /* __SOUND_HDA_CODEC_H */
diff --git a/pci/hda/hda_intel.c b/pci/hda/hda_intel.c
index 3d06ecc..72fd345 100644
--- a/pci/hda/hda_intel.c
+++ b/pci/hda/hda_intel.c
@@ -1586,11 +1586,11 @@ static int azx_resume(struct pci_dev *pci)
 	if (azx_acquire_irq(chip, 1) < 0)
 		return -EIO;
 	azx_init_pci(chip);
-#ifndef CONFIG_SND_HDA_POWER_SAVE
-	/* the explicit resume is needed only when POWER_SAVE isn't set */
-	azx_init_chip(chip);
+
+	if (snd_hda_codecs_inuse(chip->bus))
+		azx_init_chip(chip);
+
 	snd_hda_resume(chip->bus);
-#endif
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
 	return 0;
 }
-- 
1.5.2.3
