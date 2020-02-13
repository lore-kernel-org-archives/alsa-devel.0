Return-Path: <SRS0=t/pq=4B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD118C352A3
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 21:02:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BC2F206B6
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 21:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fB8Lbc+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC2F206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CBBFE16BA;
	Thu, 13 Feb 2020 22:01:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CBBFE16BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581627725;
	bh=9gCqO8/tw2Ja/ocjcWvNB61kbLcaKM7TsoCAqiK0cPY=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=fB8Lbc+bp+mvaFqaDe2pn38Nz4o+U/ovI2HhbKsM4IfdsPtJ9ezl5SgCtJDAGBCQt
	 jYvT+jNJY2bcWKBvdU5N617koDMPQ/8n5k43x0A8feEGL76JLrLq6oxujvegGK0GXt
	 MN+UE+EwzX3VCpFqwsFIX3YyUkXfHRbSsG5scS6o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2AB3DF8028F;
	Thu, 13 Feb 2020 21:59:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D8A8EF80146; Thu, 13 Feb 2020 21:58:25 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 81C69F80138
 for <alsa-devel@alsa-project.org>; Thu, 13 Feb 2020 21:58:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81C69F80138
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33A961FB;
 Thu, 13 Feb 2020 12:58:17 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A92D43F6CF;
 Thu, 13 Feb 2020 12:58:16 -0800 (PST)
Date: Thu, 13 Feb 2020 20:58:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
In-Reply-To: <20200213155159.3235792-6-jbrunet@baylibre.com>
Message-Id: <applied-20200213155159.3235792-6-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-amlogic@lists.infradead.org
Subject: [alsa-devel] Applied "ASoC: meson: aiu: add hdmi codec control
	support" to the asoc tree
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The patch

   ASoC: meson: aiu: add hdmi codec control support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From b82b734c0e9a75e1b956214ac523a8eb590f51f3 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 13 Feb 2020 16:51:55 +0100
Subject: [PATCH] ASoC: meson: aiu: add hdmi codec control support

Add the codec to codec component which handles the routing between
the audio producers (PCM and I2S) and the synopsys hdmi controller
on the amlogic GX SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20200213155159.3235792-6-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/Kconfig          |   2 +
 sound/soc/meson/Makefile         |   1 +
 sound/soc/meson/aiu-codec-ctrl.c | 152 +++++++++++++++++++++++++++++++
 sound/soc/meson/aiu.c            |  34 ++++++-
 sound/soc/meson/aiu.h            |   8 ++
 5 files changed, 196 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/meson/aiu-codec-ctrl.c

diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index ca269dedfc7f..19de97ae4ce9 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -4,7 +4,9 @@ menu "ASoC support for Amlogic platforms"
 
 config SND_MESON_AIU
 	tristate "Amlogic AIU"
+	select SND_MESON_CODEC_GLUE
 	select SND_PCM_IEC958
+	imply SND_SOC_HDMI_CODEC if DRM_MESON_DW_HDMI
 	help
 	  Select Y or M to add support for the Audio output subsystem found
 	  in the Amlogic GX SoC family
diff --git a/sound/soc/meson/Makefile b/sound/soc/meson/Makefile
index a7b79d717288..3b21f648e322 100644
--- a/sound/soc/meson/Makefile
+++ b/sound/soc/meson/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR MIT)
 
 snd-soc-meson-aiu-objs := aiu.o
+snd-soc-meson-aiu-objs += aiu-codec-ctrl.o
 snd-soc-meson-aiu-objs += aiu-encoder-i2s.o
 snd-soc-meson-aiu-objs += aiu-encoder-spdif.o
 snd-soc-meson-aiu-objs += aiu-fifo.o
diff --git a/sound/soc/meson/aiu-codec-ctrl.c b/sound/soc/meson/aiu-codec-ctrl.c
new file mode 100644
index 000000000000..8646a953e3b3
--- /dev/null
+++ b/sound/soc/meson/aiu-codec-ctrl.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2020 BayLibre, SAS.
+// Author: Jerome Brunet <jbrunet@baylibre.com>
+
+#include <linux/bitfield.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
+#include <dt-bindings/sound/meson-aiu.h>
+#include "aiu.h"
+#include "meson-codec-glue.h"
+
+#define CTRL_CLK_SEL		GENMASK(1, 0)
+#define CTRL_DATA_SEL_SHIFT	4
+#define CTRL_DATA_SEL		(0x3 << CTRL_DATA_SEL_SHIFT)
+
+static const char * const aiu_codec_ctrl_mux_texts[] = {
+	"DISABLED", "PCM", "I2S",
+};
+
+static int aiu_codec_ctrl_mux_put_enum(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+		snd_soc_dapm_kcontrol_component(kcontrol);
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	unsigned int mux, changed;
+
+	mux = snd_soc_enum_item_to_val(e, ucontrol->value.enumerated.item[0]);
+	changed = snd_soc_component_test_bits(component, e->reg,
+					      CTRL_DATA_SEL,
+					      FIELD_PREP(CTRL_DATA_SEL, mux));
+
+	if (!changed)
+		return 0;
+
+	/* Force disconnect of the mux while updating */
+	snd_soc_dapm_mux_update_power(dapm, kcontrol, 0, NULL, NULL);
+
+	/* Reset the source first */
+	snd_soc_component_update_bits(component, e->reg,
+				      CTRL_CLK_SEL |
+				      CTRL_DATA_SEL,
+				      FIELD_PREP(CTRL_CLK_SEL, 0) |
+				      FIELD_PREP(CTRL_DATA_SEL, 0));
+
+	/* Set the appropriate source */
+	snd_soc_component_update_bits(component, e->reg,
+				      CTRL_CLK_SEL |
+				      CTRL_DATA_SEL,
+				      FIELD_PREP(CTRL_CLK_SEL, mux) |
+				      FIELD_PREP(CTRL_DATA_SEL, mux));
+
+	snd_soc_dapm_mux_update_power(dapm, kcontrol, mux, e, NULL);
+
+	return 0;
+}
+
+static SOC_ENUM_SINGLE_DECL(aiu_hdmi_ctrl_mux_enum, AIU_HDMI_CLK_DATA_CTRL,
+			    CTRL_DATA_SEL_SHIFT,
+			    aiu_codec_ctrl_mux_texts);
+
+static const struct snd_kcontrol_new aiu_hdmi_ctrl_mux =
+	SOC_DAPM_ENUM_EXT("HDMI Source", aiu_hdmi_ctrl_mux_enum,
+			  snd_soc_dapm_get_enum_double,
+			  aiu_codec_ctrl_mux_put_enum);
+
+static const struct snd_soc_dapm_widget aiu_hdmi_ctrl_widgets[] = {
+	SND_SOC_DAPM_MUX("HDMI CTRL SRC", SND_SOC_NOPM, 0, 0,
+			 &aiu_hdmi_ctrl_mux),
+};
+
+static const struct snd_soc_dai_ops aiu_codec_ctrl_input_ops = {
+	.hw_params	= meson_codec_glue_input_hw_params,
+	.set_fmt	= meson_codec_glue_input_set_fmt,
+};
+
+static const struct snd_soc_dai_ops aiu_codec_ctrl_output_ops = {
+	.startup	= meson_codec_glue_output_startup,
+};
+
+#define AIU_CODEC_CTRL_FORMATS					\
+	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |	\
+	 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_LE |	\
+	 SNDRV_PCM_FMTBIT_S32_LE)
+
+#define AIU_CODEC_CTRL_STREAM(xname, xsuffix)			\
+{								\
+	.stream_name	= xname " " xsuffix,			\
+	.channels_min	= 1,					\
+	.channels_max	= 8,					\
+	.rate_min       = 5512,					\
+	.rate_max	= 192000,				\
+	.formats	= AIU_CODEC_CTRL_FORMATS,		\
+}
+
+#define AIU_CODEC_CTRL_INPUT(xname) {				\
+	.name = "CODEC CTRL " xname,				\
+	.playback = AIU_CODEC_CTRL_STREAM(xname, "Playback"),	\
+	.ops = &aiu_codec_ctrl_input_ops,			\
+	.probe = meson_codec_glue_input_dai_probe,		\
+	.remove = meson_codec_glue_input_dai_remove,		\
+}
+
+#define AIU_CODEC_CTRL_OUTPUT(xname) {				\
+	.name = "CODEC CTRL " xname,				\
+	.capture = AIU_CODEC_CTRL_STREAM(xname, "Capture"),	\
+	.ops = &aiu_codec_ctrl_output_ops,			\
+}
+
+static struct snd_soc_dai_driver aiu_hdmi_ctrl_dai_drv[] = {
+	[CTRL_I2S] = AIU_CODEC_CTRL_INPUT("HDMI I2S IN"),
+	[CTRL_PCM] = AIU_CODEC_CTRL_INPUT("HDMI PCM IN"),
+	[CTRL_OUT] = AIU_CODEC_CTRL_OUTPUT("HDMI OUT"),
+};
+
+static const struct snd_soc_dapm_route aiu_hdmi_ctrl_routes[] = {
+	{ "HDMI CTRL SRC", "I2S", "HDMI I2S IN Playback" },
+	{ "HDMI CTRL SRC", "PCM", "HDMI PCM IN Playback" },
+	{ "HDMI OUT Capture", NULL, "HDMI CTRL SRC" },
+};
+
+static int aiu_hdmi_of_xlate_dai_name(struct snd_soc_component *component,
+				      struct of_phandle_args *args,
+				      const char **dai_name)
+{
+	return aiu_of_xlate_dai_name(component, args, dai_name, AIU_HDMI);
+}
+
+static const struct snd_soc_component_driver aiu_hdmi_ctrl_component = {
+	.name			= "AIU HDMI Codec Control",
+	.dapm_widgets		= aiu_hdmi_ctrl_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(aiu_hdmi_ctrl_widgets),
+	.dapm_routes		= aiu_hdmi_ctrl_routes,
+	.num_dapm_routes	= ARRAY_SIZE(aiu_hdmi_ctrl_routes),
+	.of_xlate_dai_name	= aiu_hdmi_of_xlate_dai_name,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
+};
+
+int aiu_hdmi_ctrl_register_component(struct device *dev)
+{
+	return aiu_add_component(dev, &aiu_hdmi_ctrl_component,
+				 aiu_hdmi_ctrl_dai_drv,
+				 ARRAY_SIZE(aiu_hdmi_ctrl_dai_drv),
+				 "hdmi");
+}
+
diff --git a/sound/soc/meson/aiu.c b/sound/soc/meson/aiu.c
index a62aced9b687..b765dfb70726 100644
--- a/sound/soc/meson/aiu.c
+++ b/sound/soc/meson/aiu.c
@@ -71,6 +71,26 @@ int aiu_of_xlate_dai_name(struct snd_soc_component *component,
 	return 0;
 }
 
+int aiu_add_component(struct device *dev,
+		      const struct snd_soc_component_driver *component_driver,
+		      struct snd_soc_dai_driver *dai_drv,
+		      int num_dai,
+		      const char *debugfs_prefix)
+{
+	struct snd_soc_component *component;
+
+	component = devm_kzalloc(dev, sizeof(*component), GFP_KERNEL);
+	if (!component)
+		return -ENOMEM;
+
+#ifdef CONFIG_DEBUG_FS
+	component->debugfs_prefix = debugfs_prefix;
+#endif
+
+	return snd_soc_add_component(dev, component, component_driver,
+				     dai_drv, num_dai);
+}
+
 static int aiu_cpu_of_xlate_dai_name(struct snd_soc_component *component,
 				     struct of_phandle_args *args,
 				     const char **dai_name)
@@ -313,9 +333,21 @@ static int aiu_probe(struct platform_device *pdev)
 	ret = snd_soc_register_component(dev, &aiu_cpu_component,
 					 aiu_cpu_dai_drv,
 					 ARRAY_SIZE(aiu_cpu_dai_drv));
-	if (ret)
+	if (ret) {
 		dev_err(dev, "Failed to register cpu component\n");
+		return ret;
+	}
 
+	/* Register the hdmi codec control component */
+	ret = aiu_hdmi_ctrl_register_component(dev);
+	if (ret) {
+		dev_err(dev, "Failed to register hdmi control component\n");
+		goto err;
+	}
+
+	return 0;
+err:
+	snd_soc_unregister_component(dev);
 	return ret;
 }
 
diff --git a/sound/soc/meson/aiu.h b/sound/soc/meson/aiu.h
index a3488027b9d5..9242ab1ab64b 100644
--- a/sound/soc/meson/aiu.h
+++ b/sound/soc/meson/aiu.h
@@ -45,6 +45,14 @@ int aiu_of_xlate_dai_name(struct snd_soc_component *component,
 			  const char **dai_name,
 			  unsigned int component_id);
 
+int aiu_add_component(struct device *dev,
+		      const struct snd_soc_component_driver *component_driver,
+		      struct snd_soc_dai_driver *dai_drv,
+		      int num_dai,
+		      const char *debugfs_prefix);
+
+int aiu_hdmi_ctrl_register_component(struct device *dev);
+
 int aiu_fifo_i2s_dai_probe(struct snd_soc_dai *dai);
 int aiu_fifo_spdif_dai_probe(struct snd_soc_dai *dai);
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
