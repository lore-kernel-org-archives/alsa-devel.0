From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 3/3] ALSA: ASoC: cs4271: add optional soft
	reset workaround
Date: Fri, 30 Nov 2012 11:28:57 +0100
Message-ID: <1354271337-15113-3-git-send-email-zonque@gmail.com>
References: <1354271337-15113-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id B425926510C
 for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2012 11:29:14 +0100 (CET)
In-Reply-To: <1354271337-15113-1-git-send-email-zonque@gmail.com>
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

The CS4271 requires its LRCLK and MCLK to be stable before its RESET
line is de-asserted. That also means that clocks cannot be changed
without putting the chip back into hardware reset, which also requires
a complete re-initialization of all registers.

One (undocumented) workaround is to assert and de-assert the PDN bit
in the MODE2 register in the startup hook, in case the other channel
of the codec is not currently running.

This patch adds a new flag to both the DT bindings as well as to the
platform data to enable that workaround.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 Documentation/devicetree/bindings/sound/cs4271.txt | 12 +++++++
 include/sound/cs4271.h                             | 15 +++++++++
 sound/soc/codecs/cs4271.c                          | 39 ++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cs4271.txt b/Documentation/devicetree/bindings/sound/cs4271.txt
index a850fb9..e2cd1d7 100644
--- a/Documentation/devicetree/bindings/sound/cs4271.txt
+++ b/Documentation/devicetree/bindings/sound/cs4271.txt
@@ -20,6 +20,18 @@ Optional properties:
 		!RESET pin
  - cirrus,amuteb-eq-bmutec:	When given, the Codec's AMUTEB=BMUTEC flag
 				is enabled.
+ - cirrus,enable-soft-reset:
+	The CS4271 requires its LRCLK and MCLK to be stable before its RESET
+	line is de-asserted. That also means that clocks cannot be changed
+	without putting the chip back into hardware reset, which also requires
+	a complete re-initialization of all registers.
+
+	One (undocumented) workaround is to assert and de-assert the PDN bit
+	in the MODE2 register. This workaround can be enabled with this DT
+	property.
+
+	Note that this is not needed in case the clocks are stable
+	throughout the entire runtime of the codec.
 
 Examples:
 
diff --git a/include/sound/cs4271.h b/include/sound/cs4271.h
index dd8c48d..70f4535 100644
--- a/include/sound/cs4271.h
+++ b/include/sound/cs4271.h
@@ -20,6 +20,21 @@
 struct cs4271_platform_data {
 	int gpio_nreset;	/* GPIO driving Reset pin, if any */
 	bool amutec_eq_bmutec;	/* flag to enable AMUTEC=BMUTEC */
+
+	/*
+	 * The CS4271 requires its LRCLK and MCLK to be stable before its RESET
+	 * line is de-asserted. That also means that clocks cannot be changed
+	 * without putting the chip back into hardware reset, which also requires
+	 * a complete re-initialization of all registers.
+	 *
+	 * One (undocumented) workaround is to assert and de-assert the PDN bit
+	 * in the MODE2 register. This workaround can be enabled with the
+	 * following flag.
+	 *
+	 * Note that this is not needed in case the clocks are stable
+	 * throughout the entire runtime of the codec.
+	 */
+	bool enable_soft_reset;
 };
 
 #endif /* __CS4271_H */
diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index ac99238..bbc83ef 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -167,6 +167,8 @@ struct cs4271_private {
 	int				gpio_nreset;
 	/* GPIO that disable serial bus, if any */
 	int				gpio_disable;
+	/* enable soft reset workaround */
+	bool				enable_soft_reset;
 };
 
 /*
@@ -403,11 +405,43 @@ static const struct snd_kcontrol_new cs4271_snd_controls[] = {
 		7, 1, 1),
 };
 
+static int cs4271_startup(struct snd_pcm_substream *subs,
+			   struct snd_soc_dai *codec_dai)
+{
+	int ret;
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
+
+	if (!cs4271->enable_soft_reset)
+		return 0;
+
+	/*
+	 * Put the codec in soft reset and back again in case it's not
+	 * currently streaming data. This way of bringing the codec in
+	 * sync to the current clocks is not explicitly documented in
+	 * the data sheet, but it seems to work fine.
+	 */
+
+	if ((subs->stream == SNDRV_PCM_STREAM_PLAYBACK &&
+	     codec_dai->capture_active) ||
+	    (subs->stream == SNDRV_PCM_STREAM_CAPTURE &&
+	     codec_dai->playback_active))
+		return 0;
+
+	ret = snd_soc_update_bits(codec, CS4271_MODE2, CS4271_MODE2_PDN,
+				  CS4271_MODE2_PDN);
+	if (ret < 0)
+		return ret;
+
+	return snd_soc_update_bits(codec, CS4271_MODE2, CS4271_MODE2_PDN, 0);
+}
+
 static const struct snd_soc_dai_ops cs4271_dai_ops = {
 	.hw_params	= cs4271_hw_params,
 	.set_sysclk	= cs4271_set_dai_sysclk,
 	.set_fmt	= cs4271_set_dai_fmt,
 	.digital_mute	= cs4271_digital_mute,
+	.startup	= cs4271_startup,
 };
 
 static struct snd_soc_dai_driver cs4271_dai = {
@@ -484,6 +518,10 @@ static int cs4271_probe(struct snd_soc_codec *codec)
 		if (of_get_property(codec->dev->of_node,
 				     "cirrus,amutec-eq-bmutec", NULL))
 			amutec_eq_bmutec = true;
+
+		if (of_get_property(codec->dev->of_node,
+				     "cirrus,enable-soft-reset", NULL))
+			cs4271->enable_soft_reset = true;
 	}
 #endif
 
@@ -492,6 +530,7 @@ static int cs4271_probe(struct snd_soc_codec *codec)
 			gpio_nreset = cs4271plat->gpio_nreset;
 
 		amutec_eq_bmutec = cs4271plat->amutec_eq_bmutec;
+		cs4271->enable_soft_reset = cs4271plat->enable_soft_reset;
 	}
 
 	if (gpio_nreset >= 0)
-- 
1.7.11.7
