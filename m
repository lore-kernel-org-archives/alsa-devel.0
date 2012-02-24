From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 21/38] ALSA: hda/realtek - Apply probe-fixup
	really after probing
Date: Fri, 24 Feb 2012 17:36:14 +0100
Message-ID: <1330101391-8788-22-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 59CA610431F
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:34 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id A59DA92706
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:33 +0100 (CET)
In-Reply-To: <1330101391-8788-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Move the call of alc_apply_fixup() with ALC_FIXUP_ACT_PROBE after the
whole setups of patch_ops & co, so that the fix-up function may override
the default setup.  This will be needed for installing the own unsol
event handler (e.g. for volume-knob controls).

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e6eec9a..895113e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4566,8 +4566,6 @@ static int patch_alc880(struct hda_codec *codec)
 		set_beep_amp(spec, 0x0b, 0x05, HDA_INPUT);
 	}
 
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
-
 	codec->patch_ops = alc_patch_ops;
 	if (board_config == ALC_MODEL_AUTO)
 		spec->init_hook = alc_auto_init_std;
@@ -4578,6 +4576,8 @@ static int patch_alc880(struct hda_codec *codec)
 		spec->loopback.amplist = alc880_loopbacks;
 #endif
 
+	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
+
 	return 0;
 
  error:
@@ -4749,8 +4749,6 @@ static int patch_alc260(struct hda_codec *codec)
 		set_beep_amp(spec, 0x07, 0x05, HDA_INPUT);
 	}
 
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
-
 	codec->patch_ops = alc_patch_ops;
 	spec->init_hook = alc_auto_init_std;
 	spec->shutup = alc_eapd_shutup;
@@ -4759,6 +4757,8 @@ static int patch_alc260(struct hda_codec *codec)
 		spec->loopback.amplist = alc260_loopbacks;
 #endif
 
+	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
+
 	return 0;
 
  error:
@@ -5165,8 +5165,6 @@ static int patch_alc882(struct hda_codec *codec)
 		set_beep_amp(spec, 0x0b, 0x05, HDA_INPUT);
 	}
 
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
-
 	codec->patch_ops = alc_patch_ops;
 	if (board_config == ALC_MODEL_AUTO)
 		spec->init_hook = alc_auto_init_std;
@@ -5178,6 +5176,8 @@ static int patch_alc882(struct hda_codec *codec)
 		spec->loopback.amplist = alc882_loopbacks;
 #endif
 
+	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
+
 	return 0;
 
  error:
@@ -5331,8 +5331,6 @@ static int patch_alc262(struct hda_codec *codec)
 		set_beep_amp(spec, 0x0b, 0x05, HDA_INPUT);
 	}
 
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
-
 	codec->patch_ops = alc_patch_ops;
 	spec->init_hook = alc_auto_init_std;
 	spec->shutup = alc_eapd_shutup;
@@ -5342,6 +5340,8 @@ static int patch_alc262(struct hda_codec *codec)
 		spec->loopback.amplist = alc262_loopbacks;
 #endif
 
+	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
+
 	return 0;
 
  error:
@@ -5992,8 +5992,6 @@ static int patch_alc269(struct hda_codec *codec)
 		set_beep_amp(spec, 0x0b, 0x04, HDA_INPUT);
 	}
 
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
-
 	codec->patch_ops = alc_patch_ops;
 #ifdef CONFIG_PM
 	codec->patch_ops.resume = alc269_resume;
@@ -6008,6 +6006,8 @@ static int patch_alc269(struct hda_codec *codec)
 		codec->patch_ops.check_power_status = alc269_mic2_mute_check_ps;
 #endif
 
+	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
+
 	return 0;
 
  error:
@@ -6146,8 +6146,6 @@ static int patch_alc861(struct hda_codec *codec)
 		set_beep_amp(spec, 0x23, 0, HDA_OUTPUT);
 	}
 
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
-
 	codec->patch_ops = alc_patch_ops;
 	spec->init_hook = alc_auto_init_std;
 #ifdef CONFIG_SND_HDA_POWER_SAVE
@@ -6156,6 +6154,8 @@ static int patch_alc861(struct hda_codec *codec)
 		spec->loopback.amplist = alc861_loopbacks;
 #endif
 
+	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
+
 	return 0;
 
  error:
@@ -6270,8 +6270,6 @@ static int patch_alc861vd(struct hda_codec *codec)
 		set_beep_amp(spec, 0x0b, 0x05, HDA_INPUT);
 	}
 
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
-
 	codec->patch_ops = alc_patch_ops;
 
 	spec->init_hook = alc_auto_init_std;
@@ -6281,6 +6279,8 @@ static int patch_alc861vd(struct hda_codec *codec)
 		spec->loopback.amplist = alc861vd_loopbacks;
 #endif
 
+	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
+
 	return 0;
 
  error:
@@ -6659,8 +6659,6 @@ static int patch_alc662(struct hda_codec *codec)
 		}
 	}
 
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
-
 	codec->patch_ops = alc_patch_ops;
 	spec->init_hook = alc_auto_init_std;
 	spec->shutup = alc_eapd_shutup;
@@ -6670,6 +6668,8 @@ static int patch_alc662(struct hda_codec *codec)
 		spec->loopback.amplist = alc662_loopbacks;
 #endif
 
+	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
+
 	return 0;
 
  error:
-- 
1.7.9
