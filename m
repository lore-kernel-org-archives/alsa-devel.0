From: Hector Martin <hector@marcansoft.com>
Subject: Re: [PATCH] HDA: add powersaving hook for Realtek
Date: Sun, 20 Dec 2009 23:00:57 +0100
Message-ID: <4B2E9E99.9070505@marcansoft.com>
References: <4B2E9C63.30808@marcansoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030400060008090701010006"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.marcansoft.com (marcansoft.com [80.68.93.119])
	by alsa0.perex.cz (Postfix) with ESMTP id DB030103822
	for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2009 23:00:58 +0100 (CET)
In-Reply-To: <4B2E9C63.30808@marcansoft.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030400060008090701010006
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Missed a coupld #ifdefs, resending.

The current Realtek code makes no specific provision for turning stuff
off. The codec chip is placed into low-power mode generically, but this
doesn't turn off any external hardware connected to it, in particular
external amplifiers.

This patch creates a hook function that is called by the codec
suspend/resume functions. It ought to disable any external hardware in a
device-specific way. I've implemented a generic ALC889 function that
sets the EAPD pin properly, and used it for the Acer Aspire 8930G which
can benefit from this feature.

On my laptop, this results in ~0.5W extra savings.

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc


--------------030400060008090701010006
Content-Type: text/plain;
 name="realtek-add-power-hooks.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="realtek-add-power-hooks.patch"

Signed-off-by: Hector Martin <hector@marcansoft.com>

--- linux-2.6.32/sound/pci/hda/patch_realtek_orig.c	2009-12-20 19:31:08.940900751 +0100
+++ linux-2.6.32/sound/pci/hda/patch_realtek.c	2009-12-20 22:14:11.852025021 +0100
@@ -334,6 +334,9 @@
 	/* hooks */
 	void (*init_hook)(struct hda_codec *codec);
 	void (*unsol_event)(struct hda_codec *codec, unsigned int res);
+#ifdef CONFIG_SND_HDA_POWER_SAVE
+	void (*power_hook)(struct hda_codec *codec, int power);
+#endif
 
 	/* for pin sensing */
 	unsigned int sense_updated: 1;
@@ -385,6 +388,7 @@
 	void (*init_hook)(struct hda_codec *);
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	struct hda_amp_list *loopbacks;
+	void (*power_hook)(struct hda_codec *codec, int power);
 #endif
 };
 
@@ -897,6 +901,7 @@
 	spec->unsol_event = preset->unsol_event;
 	spec->init_hook = preset->init_hook;
 #ifdef CONFIG_SND_HDA_POWER_SAVE
+	spec->power_hook = preset->power_hook;
 	spec->loopback.amplist = preset->loopbacks;
 #endif
 
@@ -1824,6 +1845,16 @@
 	spec->autocfg.speaker_pins[2] = 0x1b;
 }
 
+#ifdef CONFIG_SND_HDA_POWER_SAVE
+static void alc889_power_eapd(struct hda_codec *codec, int power)
+{
+	snd_hda_codec_write(codec, 0x14, 0,
+			    AC_VERB_SET_EAPD_BTLENABLE, power ? 2 : 0);
+	snd_hda_codec_write(codec, 0x15, 0,
+			    AC_VERB_SET_EAPD_BTLENABLE, power ? 2 : 0);
+}
+#endif
+
 /*
  * ALC880 3-stack model
  *
@@ -3611,12 +3642,29 @@
 	snd_hda_detach_beep_device(codec);
 }
 
+#ifdef CONFIG_SND_HDA_POWER_SAVE
+static int alc_suspend(struct hda_codec *codec, pm_message_t state)
+{
+	struct alc_spec *spec = codec->spec;
+	if (spec && spec->power_hook)
+		spec->power_hook(codec, 0);
+	return 0;
+}
+#endif
+
 #ifdef SND_HDA_NEEDS_RESUME
 static int alc_resume(struct hda_codec *codec)
 {
+#ifdef CONFIG_SND_HDA_POWER_SAVE
+	struct alc_spec *spec = codec->spec;
+#endif
 	codec->patch_ops.init(codec);
 	snd_hda_codec_resume_amp(codec);
 	snd_hda_codec_resume_cache(codec);
+#ifdef CONFIG_SND_HDA_POWER_SAVE
+	if (spec && spec->power_hook)
+		spec->power_hook(codec, 1);
+#endif
 	return 0;
 }
 #endif
@@ -3633,6 +3677,7 @@
 	.resume = alc_resume,
 #endif
 #ifdef CONFIG_SND_HDA_POWER_SAVE
+	.suspend = alc_suspend,
 	.check_power_status = alc_check_power_status,
 #endif
 };
@@ -9320,6 +9365,9 @@
 		.unsol_event = alc_automute_amp_unsol_event,
 		.setup = alc889_acer_aspire_8930g_setup,
 		.init_hook = alc_automute_amp,
+#ifdef CONFIG_SND_HDA_POWER_SAVE
+		.power_hook = alc889_power_eapd,
+#endif
 	},
 	[ALC888_ACER_ASPIRE_7730G] = {
 		.mixers = { alc883_3ST_6ch_mixer,

--------------030400060008090701010006
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------030400060008090701010006--
