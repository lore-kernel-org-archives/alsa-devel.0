From: Kailang <kailang@realtek.com>
Subject: hp_pin was NULL value
Date: Wed, 9 Jan 2019 09:31:33 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A18420E8B@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FA7B2665E5
 for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2019 10:31:39 +0100 (CET)
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Could I move the alc294_hp_init(codec) to below line.
Because hp_pin = spec->gen.autocfg.hp_pins[0] was null value when alc294_hp_init(codec) at original line.
Or move alc269_parse_auto_config() upward.

BR,
Kailang
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7514,7 +7514,6 @@ static int patch_alc269(struct hda_codec *codec)
 		spec->codec_variant = ALC269_TYPE_ALC294;
 		spec->gen.mixer_nid = 0; /* ALC2x4 does not have any loopback mixer path */
 		alc_update_coef_idx(codec, 0x6b, 0x0018, (1<<4) | (1<<3)); /* UAJ MIC Vref control by verb */
-		alc294_hp_init(codec);
 		break;
 	case 0x10ec0300:
 		spec->codec_variant = ALC269_TYPE_ALC300;
@@ -7526,7 +7525,6 @@ static int patch_alc269(struct hda_codec *codec)
 		spec->codec_variant = ALC269_TYPE_ALC700;
 		spec->gen.mixer_nid = 0; /* ALC700 does not have any loopback mixer path */
 		alc_update_coef_idx(codec, 0x4a, 1 << 15, 0); /* Combo jack auto trigger control */
-		alc294_hp_init(codec);
 		break;
 
 	}
@@ -7553,6 +7551,16 @@ static int patch_alc269(struct hda_codec *codec)
 	if (err < 0)
 		goto error;
 
+	switch (codec->core.vendor_id) {
+	case 0x10ec0234:
+	case 0x10ec0274:
+	case 0x10ec0294:
+	case 0x10ec0700:
+	case 0x10ec0701:
+	case 0x10ec0703:
+		alc294_hp_init(codec);
+		break;
+	}
 	if (!spec->gen.no_analog && spec->gen.beep_nid && spec->gen.mixer_nid) {
 		err = set_beep_amp(spec, spec->gen.mixer_nid, 0x04, HDA_INPUT);
 		if (err < 0)
