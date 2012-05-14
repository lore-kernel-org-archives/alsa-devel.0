From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/15] ALSA: hda - Remove pre_resume and
	post_suspend ops
Date: Mon, 14 May 2012 17:31:59 +0200
Message-ID: <1337009526-26256-9-git-send-email-tiwai@suse.de>
References: <1337009526-26256-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E7CC24A23
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:32:18 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id E6E2D9043F
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:32:17 +0200 (CEST)
In-Reply-To: <1337009526-26256-1-git-send-email-tiwai@suse.de>
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

Since the recent commit, the resume procedure is always performed at
the resume time.  This makes the pre_resume hack for VREF mute LED on
some HP laptops superfluous.  As this is the only user of pre_resume
(and there is no user of post_suspend) ops, let's kill them again.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c      |    4 ----
 sound/pci/hda/hda_codec.h      |    2 --
 sound/pci/hda/patch_sigmatel.c |   21 ---------------------
 3 files changed, 27 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index f2bdf38..e0f8667 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -4930,8 +4930,6 @@ int snd_hda_suspend(struct hda_bus *bus)
 	list_for_each_entry(codec, &bus->codec_list, list) {
 		if (hda_codec_is_power_on(codec))
 			hda_call_codec_suspend(codec);
-		if (codec->patch_ops.post_suspend)
-			codec->patch_ops.post_suspend(codec);
 	}
 	return 0;
 }
@@ -4951,8 +4949,6 @@ int snd_hda_resume(struct hda_bus *bus)
 	struct hda_codec *codec;
 
 	list_for_each_entry(codec, &bus->codec_list, list) {
-		if (codec->patch_ops.pre_resume)
-			codec->patch_ops.pre_resume(codec);
 		hda_call_codec_resume(codec);
 	}
 	return 0;
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 77cd995..78f8914 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -704,8 +704,6 @@ struct hda_codec_ops {
 				unsigned int power_state);
 #ifdef CONFIG_PM
 	int (*suspend)(struct hda_codec *codec, pm_message_t state);
-	int (*post_suspend)(struct hda_codec *codec);
-	int (*pre_resume)(struct hda_codec *codec);
 	int (*resume)(struct hda_codec *codec);
 #endif
 #ifdef CONFIG_SND_HDA_POWER_SAVE
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index baf1edd..b04179b 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -4986,20 +4986,6 @@ static int stac92xx_suspend(struct hda_codec *codec, pm_message_t state)
 	return 0;
 }
 
-static int stac92xx_pre_resume(struct hda_codec *codec)
-{
-	struct sigmatel_spec *spec = codec->spec;
-
-	/* sync mute LED */
-	if (spec->vref_mute_led_nid)
-		stac_vrefout_set(codec, spec->vref_mute_led_nid,
-				 spec->vref_led);
-	else if (spec->gpio_led)
-		stac_gpio_set(codec, spec->gpio_mask,
-			      spec->gpio_dir, spec->gpio_data);
-	return 0;
-}
-
 static void stac92xx_set_power_state(struct hda_codec *codec, hda_nid_t fg,
 				unsigned int power_state)
 {
@@ -5023,7 +5009,6 @@ static void stac92xx_set_power_state(struct hda_codec *codec, hda_nid_t fg,
 #else
 #define stac92xx_suspend	NULL
 #define stac92xx_resume		NULL
-#define stac92xx_pre_resume	NULL
 #define stac92xx_set_power_state NULL
 #endif /* CONFIG_PM */
 
@@ -5569,9 +5554,6 @@ again:
 			codec->patch_ops.set_power_state =
 					stac92xx_set_power_state;
 		}
-#ifdef CONFIG_PM
-		codec->patch_ops.pre_resume = stac92xx_pre_resume;
-#endif
 	}
 
 	err = stac92xx_parse_auto_config(codec);
@@ -5878,9 +5860,6 @@ again:
 			codec->patch_ops.set_power_state =
 					stac92xx_set_power_state;
 		}
-#ifdef CONFIG_PM
-		codec->patch_ops.pre_resume = stac92xx_pre_resume;
-#endif
 	}
 
 	spec->multiout.dac_nids = spec->dac_nids;
-- 
1.7.9.2
