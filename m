Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118FDC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Mar 2022 07:25:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4303116CC;
	Mon, 21 Mar 2022 08:24:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4303116CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647847520;
	bh=x+H92M/XxNPY9yvqIZYvnpL9tSuW/7/2xt63pY3+pK8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r+q41GKw9DELF9LXqWzysOmGKzzPqbf4hQDvdoPz9zJvgrV55xlBuU6f16T6SJ+SJ
	 FmsEn0j5LPDvSHujVbhPt9fjOmeFU+lNol9uKSEmqYdrsEHyONL7Zi/zDQI3wMgVVZ
	 fc83JOW2eZ8x3CvnHTUsmgahcDujI69nSSVWC2MI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 30B92F80431;
	Mon, 21 Mar 2022 08:23:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6D76DF801D8; Mon, 21 Mar 2022 08:23:35 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3CB8DF80238
 for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2022 08:23:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3CB8DF80238
X-UUID: 4bf739fa005b435e83b3cd2e366437ea-20220321
X-UUID: 4bf739fa005b435e83b3cd2e366437ea-20220321
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <trevor.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 831013327; Mon, 21 Mar 2022 15:23:16 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Mar 2022 15:23:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Mon, 21 Mar 2022 15:23:15 +0800
From: Trevor Wu <trevor.wu@mediatek.com>
To: <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
 <matthias.bgg@gmail.com>
Subject: [PATCH v3 5/6] ASoC: mediatek: mt8195: add machine support for
 max98390 and rt5682
Date: Mon, 21 Mar 2022 15:23:11 +0800
Message-ID: <20220321072312.14972-6-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220321072312.14972-1-trevor.wu@mediatek.com>
References: <20220321072312.14972-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, tzungbi@google.com,
 linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
 yc.hung@mediatek.com, aaronyu@google.com, linux-arm-kernel@lists.infradead.org,
 angelogioacchino.delregno@collabora.com
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

This patch adds support for mt8195 board with mt6359, max98390 and
rt5682.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/mediatek/Kconfig                |  1 +
 sound/soc/mediatek/mt8195/mt8195-mt6359.c | 72 +++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index d3f4b8b9c0af..ce055cd28dc7 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -207,6 +207,7 @@ config SND_SOC_MT8195_MT6359
 	select SND_SOC_RT1015P
 	select SND_SOC_RT5682_I2C
 	select SND_SOC_RT5682S
+	select SND_SOC_MAX98390
 	select SND_SOC_DMIC
 	select SND_SOC_HDMI_CODEC
 	help
diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359.c b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
index 60279eee22c8..8f8c3b999747 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
@@ -25,6 +25,11 @@
 
 #define RT1011_SPEAKER_AMP_PRESENT		BIT(0)
 #define RT1019_SPEAKER_AMP_PRESENT		BIT(1)
+#define MAX98390_SPEAKER_AMP_PRESENT		BIT(2)
+
+#define MAX98390_CODEC_DAI	"max98390-aif1"
+#define MAX98390_DEV0_NAME	"max98390.2-0038" /* right */
+#define MAX98390_DEV1_NAME	"max98390.2-0039" /* left */
 
 #define RT1011_CODEC_DAI	"rt1011-aif"
 #define RT1011_DEV0_NAME	"rt1011.2-0038"
@@ -121,6 +126,11 @@ static const struct snd_soc_dapm_route mt8195_rt1019_routes[] = {
 	{ "Ext Spk", NULL, "Speaker" },
 };
 
+static const struct snd_soc_dapm_route mt8195_max98390_routes[] = {
+	{ "Left Spk", NULL, "Left BE_OUT" },
+	{ "Right Spk", NULL, "Right BE_OUT" },
+};
+
 #define CKSYS_AUD_TOP_CFG 0x032c
 #define CKSYS_AUD_TOP_MON 0x0330
 
@@ -670,6 +680,35 @@ static int mt8195_rt1019_init(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
+static int mt8195_max98390_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_card *card = rtd->card;
+	int ret;
+
+	ret = snd_soc_dapm_new_controls(&card->dapm, mt8195_dual_speaker_widgets,
+					ARRAY_SIZE(mt8195_dual_speaker_widgets));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add dapm controls, ret %d\n", ret);
+		/* Don't need to add routes if widget addition failed */
+		return ret;
+	}
+
+	ret = snd_soc_add_card_controls(card, mt8195_dual_speaker_controls,
+					ARRAY_SIZE(mt8195_dual_speaker_controls));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add card controls, ret %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dapm_add_routes(&card->dapm, mt8195_max98390_routes,
+				      ARRAY_SIZE(mt8195_max98390_routes));
+
+	if (ret)
+		dev_err(rtd->dev, "unable to add dapm routes, ret %d\n", ret);
+
+	return ret;
+}
+
 static int mt8195_etdm_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 				       struct snd_pcm_hw_params *params)
 {
@@ -928,6 +967,12 @@ SND_SOC_DAILINK_DEF(rt1011_comps,
 				       COMP_CODEC(RT1011_DEV1_NAME,
 						  RT1011_CODEC_DAI)));
 
+SND_SOC_DAILINK_DEF(max98390_comps,
+		    DAILINK_COMP_ARRAY(COMP_CODEC(MAX98390_DEV0_NAME,
+						  MAX98390_CODEC_DAI),
+				       COMP_CODEC(MAX98390_DEV1_NAME,
+						  MAX98390_CODEC_DAI)));
+
 static const struct sof_conn_stream g_sof_conn_streams[] = {
 	{ "ETDM2_OUT_BE", "AFE_SOF_DL2", SOF_DMA_DL2, SNDRV_PCM_STREAM_PLAYBACK},
 	{ "ETDM1_OUT_BE", "AFE_SOF_DL3", SOF_DMA_DL3, SNDRV_PCM_STREAM_PLAYBACK},
@@ -1251,6 +1296,17 @@ static struct snd_soc_codec_conf rt1011_codec_conf[] = {
 	},
 };
 
+static struct snd_soc_codec_conf max98390_codec_conf[] = {
+	{
+		.dlc = COMP_CODEC_CONF(MAX98390_DEV0_NAME),
+		.name_prefix = "Right",
+	},
+	{
+		.dlc = COMP_CODEC_CONF(MAX98390_DEV1_NAME),
+		.name_prefix = "Left",
+	},
+};
+
 static struct snd_soc_card mt8195_mt6359_soc_card = {
 	.owner = THIS_MODULE,
 	.dai_link = mt8195_mt6359_dai_links,
@@ -1546,6 +1602,13 @@ static int mt8195_mt6359_dev_probe(struct platform_device *pdev)
 				dai_link->num_codecs = ARRAY_SIZE(rt1019_comps);
 				dai_link->init = mt8195_rt1019_init;
 				break;
+			case MAX98390_SPEAKER_AMP_PRESENT:
+				dai_link->codecs = max98390_comps;
+				dai_link->num_codecs = ARRAY_SIZE(max98390_comps);
+				dai_link->init = mt8195_max98390_init;
+				card->codec_conf = max98390_codec_conf;
+				card->num_configs = ARRAY_SIZE(max98390_codec_conf);
+				break;
 			default:
 				break;
 			}
@@ -1576,6 +1639,11 @@ static struct mt8195_card_data mt8195_mt6359_rt1011_rt5682_card = {
 	.quirk = RT1011_SPEAKER_AMP_PRESENT,
 };
 
+static struct mt8195_card_data mt8195_mt6359_max98390_rt5682_card = {
+	.name = "mt8195_m98390_r5682",
+	.quirk = MAX98390_SPEAKER_AMP_PRESENT,
+};
+
 #ifdef CONFIG_OF
 static const struct of_device_id mt8195_mt6359_dt_match[] = {
 	{
@@ -1586,6 +1654,10 @@ static const struct of_device_id mt8195_mt6359_dt_match[] = {
 		.compatible = "mediatek,mt8195_mt6359_rt1011_rt5682",
 		.data = &mt8195_mt6359_rt1011_rt5682_card,
 	},
+	{
+		.compatible = "mediatek,mt8195_mt6359_max98390_rt5682",
+		.data = &mt8195_mt6359_max98390_rt5682_card,
+	},
 };
 #endif
 
-- 
2.18.0

