From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/4] ASoC: codecs: tas5720: add TAS5722 TDM slot width setting support
Date: Mon, 11 Dec 2017 13:01:57 -0600
Message-ID: <20171211190157.12371-4-afd@ti.com>
References: <20171211190157.12371-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171211190157.12371-1-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>

Unlike the TAS5720, the TAS5722 can be configured to utilize 16-bit wide
slots in TDM mode. This can help easing audio clocking/frequency
requirements.

Signed-off-by: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
---
 sound/soc/codecs/tas5720.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/tas5720.c b/sound/soc/codecs/tas5720.c
index 042068964afb..08e0bfc9390c 100644
--- a/sound/soc/codecs/tas5720.c
+++ b/sound/soc/codecs/tas5720.c
@@ -152,6 +152,7 @@ static int tas5720_set_dai_tdm_slot(struct snd_soc_dai *dai,
 				    int slots, int slot_width)
 {
 	struct snd_soc_codec *codec = dai->codec;
+	struct tas5720_data *tas5720 = snd_soc_codec_get_drvdata(codec);
 	unsigned int first_slot;
 	int ret;
 
@@ -185,6 +186,16 @@ static int tas5720_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	if (ret < 0)
 		goto error_snd_soc_update_bits;
 
+	/* Configure TDM slot width. This is only applicable to TAS5722. */
+	if (tas5720->devtype == TAS5722) {
+		ret = snd_soc_update_bits(codec, TAS5722_DIGITAL_CTRL2_REG,
+					  TAS5722_TDM_SLOT_16B,
+					  slot_width == 16 ?
+					  TAS5722_TDM_SLOT_16B : 0);
+		if (ret < 0)
+			goto error_snd_soc_update_bits;
+	}
+
 	return 0;
 
 error_snd_soc_update_bits:
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
