From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH v3 8/9] ALSA: hda/ca0132: add
	ca0132_alt_set_vipsource
Date: Sat,  5 May 2018 15:03:19 -0400
Message-ID: <1525547001-17588-9-git-send-email-conmanx360@gmail.com>
References: <1525547001-17588-1-git-send-email-conmanx360@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f194.google.com (mail-io0-f194.google.com
 [209.85.223.194])
 by alsa0.perex.cz (Postfix) with ESMTP id B857D267642
 for <alsa-devel@alsa-project.org>; Sat,  5 May 2018 21:04:21 +0200 (CEST)
Received: by mail-io0-f194.google.com with SMTP id e78-v6so29345141iod.0
 for <alsa-devel@alsa-project.org>; Sat, 05 May 2018 12:04:21 -0700 (PDT)
In-Reply-To: <1525547001-17588-1-git-send-email-conmanx360@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, =?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?= <jeremy.lefaure@lse.epita.fr>, Connor McAdams <conmanx360@gmail.com>, o-takashi@sakamocchi.jp
List-Id: alsa-devel@alsa-project.org

Add function to set vipsource on cards that use_alt_controls. Different
sequence. Also, add cvoice_switch_set at end of ca0132_select_in so that
when switching between inputs cvoice state is maintained.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 71 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index c7822d6..c1753b2 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -3978,6 +3978,71 @@ static int ca0132_set_vipsource(struct hda_codec *codec, int val)
 	return 1;
 }
 
+static int ca0132_alt_set_vipsource(struct hda_codec *codec, int val)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int tmp;
+
+	if (spec->dsp_state != DSP_DOWNLOADED)
+		return 0;
+
+	codec_dbg(codec, "%s\n", __func__);
+
+	chipio_set_stream_control(codec, 0x03, 0);
+	chipio_set_stream_control(codec, 0x04, 0);
+
+	/* if CrystalVoice is off, vipsource should be 0 */
+	if (!spec->effects_switch[CRYSTAL_VOICE - EFFECT_START_NID] ||
+	    (val == 0) || spec->in_enum_val == REAR_LINE_IN) {
+		codec_dbg(codec, "%s: off.", __func__);
+		chipio_set_control_param(codec, CONTROL_PARAM_VIP_SOURCE, 0);
+
+		tmp = FLOAT_ZERO;
+		dspio_set_uint_param(codec, 0x80, 0x05, tmp);
+
+		chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_96_000);
+		chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_96_000);
+		if (spec->quirk == QUIRK_R3DI)
+			chipio_set_conn_rate(codec, 0x0F, SR_96_000);
+
+
+		if (spec->in_enum_val == REAR_LINE_IN)
+			tmp = FLOAT_ZERO;
+		else {
+			if (spec->quirk == QUIRK_SBZ)
+				tmp = FLOAT_THREE;
+			else
+				tmp = FLOAT_ONE;
+		}
+
+		dspio_set_uint_param(codec, 0x80, 0x00, tmp);
+
+	} else {
+		codec_dbg(codec, "%s: on.", __func__);
+		chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_16_000);
+		chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_16_000);
+		if (spec->quirk == QUIRK_R3DI)
+			chipio_set_conn_rate(codec, 0x0F, SR_16_000);
+
+		if (spec->effects_switch[VOICE_FOCUS - EFFECT_START_NID])
+			tmp = FLOAT_TWO;
+		else
+			tmp = FLOAT_ONE;
+		dspio_set_uint_param(codec, 0x80, 0x00, tmp);
+
+		tmp = FLOAT_ONE;
+		dspio_set_uint_param(codec, 0x80, 0x05, tmp);
+
+		msleep(20);
+		chipio_set_control_param(codec, CONTROL_PARAM_VIP_SOURCE, val);
+	}
+
+	chipio_set_stream_control(codec, 0x03, 1);
+	chipio_set_stream_control(codec, 0x04, 1);
+
+	return 1;
+}
+
 /*
  * Select the active microphone.
  * If autodetect is enabled, mic will be selected based on jack detection.
@@ -4140,6 +4205,7 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 		}
 		break;
 	}
+	ca0132_cvoice_switch_set(codec);
 
 	snd_hda_power_down_pm(codec);
 	return 0;
@@ -4353,7 +4419,10 @@ static int ca0132_cvoice_switch_set(struct hda_codec *codec)
 
 	/* set correct vipsource */
 	oldval = stop_mic1(codec);
-	ret |= ca0132_set_vipsource(codec, 1);
+	if (spec->use_alt_functions)
+		ret |= ca0132_alt_set_vipsource(codec, 1);
+	else
+		ret |= ca0132_set_vipsource(codec, 1);
 	resume_mic1(codec, oldval);
 	return ret;
 }
-- 
2.7.4
