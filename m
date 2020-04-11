Return-Path: <SRS0=q721=53=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F84C2BBC7
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Apr 2020 23:09:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 028DE2173E
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Apr 2020 23:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YwILMy1k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lutHJVOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028DE2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B26116A3;
	Sun, 12 Apr 2020 01:08:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B26116A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586646563;
	bh=BxXLBpgwH6EXg66oe1ub4AhqhGU8Fy3XgguV6DuFB0c=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YwILMy1k5WADGc539fWe4k1g8IUXcQ+V8Q/SdI2yc00Ydm1lYIbrS5G2MaACJcRLT
	 BCFESRW+LFoe/OAtWz7kMAPv+FMaWOF37Vjy7i/3zYdfRZUhm13vhIzSLLXpdUbBp0
	 johuaN9XFqUx1L2O4PoCGxO/NDUVRfzpzxh+1lkE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BE35DF8007E;
	Sun, 12 Apr 2020 01:08:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 148B4F801DA; Sun, 12 Apr 2020 01:08:31 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3009FF800CB
 for <alsa-devel@alsa-project.org>; Sun, 12 Apr 2020 01:08:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3009FF800CB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="lutHJVOl"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DCADD20708;
 Sat, 11 Apr 2020 23:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586646506;
 bh=BxXLBpgwH6EXg66oe1ub4AhqhGU8Fy3XgguV6DuFB0c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lutHJVOlJbff/jfxV86Jx/HQBNAYe25y+bgVGVx3AuXo1rBa6/O9y+/VoOHepXWcm
 Z7Mo/Q7WXDnYadX3dggugckeaP6pJujOGmxx10c+X87pBYIyfBrjqeYrVFpWW28lA6
 hiky0AZzJkYzHSwYJHX9m7gl7IkbIiE2Op4KLcy4=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 066/121] ASoC: mediatek: mt8183-da7219: pull TDM
 GPIO pins down when probed
Date: Sat, 11 Apr 2020 19:06:11 -0400
Message-Id: <20200411230706.23855-66-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230706.23855-1-sashal@kernel.org>
References: <20200411230706.23855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Tzung-Bi Shih <tzungbi@google.com>, Mark Brown <broonie@kernel.org>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
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

From: Tzung-Bi Shih <tzungbi@google.com>

[ Upstream commit 8726ee6148fe24e2b29d4a961ad95c4ff8025d1d ]

1. Switch TDM GPIO pins according to playback on or off.
2. Pull TDM GPIO pins down when probed to avoid current leakage.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Link: https://lore.kernel.org/r/20200213112003.2.I1d568b0c99742c6e755d051aadfd52e4be3cc0a5@changeid
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mediatek/mt8183/mt8183-da7219-max98357.c  | 104 +++++++++++++++++-
 1 file changed, 98 insertions(+), 6 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
index 43f99e59a0786..897a7bc4d3f3f 100644
--- a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
@@ -18,6 +18,22 @@
 
 static struct snd_soc_jack headset_jack;
 
+enum PINCTRL_PIN_STATE {
+	PIN_STATE_DEFAULT = 0,
+	PIN_TDM_OUT_ON,
+	PIN_TDM_OUT_OFF,
+	PIN_STATE_MAX
+};
+
+static const char * const mt8183_pin_str[PIN_STATE_MAX] = {
+	"default", "aud_tdm_out_on", "aud_tdm_out_off",
+};
+
+struct mt8183_da7219_max98357_priv {
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pin_states[PIN_STATE_MAX];
+};
+
 static int mt8183_mt6358_i2s_hw_params(struct snd_pcm_substream *substream,
 				       struct snd_pcm_hw_params *params)
 {
@@ -204,6 +220,47 @@ SND_SOC_DAILINK_DEFS(tdm,
 	DAILINK_COMP_ARRAY(COMP_DUMMY()),
 	DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
+static int mt8183_da7219_tdm_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct mt8183_da7219_max98357_priv *priv =
+		snd_soc_card_get_drvdata(rtd->card);
+	int ret;
+
+	if (IS_ERR(priv->pin_states[PIN_TDM_OUT_ON]))
+		return PTR_ERR(priv->pin_states[PIN_TDM_OUT_ON]);
+
+	ret = pinctrl_select_state(priv->pinctrl,
+				   priv->pin_states[PIN_TDM_OUT_ON]);
+	if (ret)
+		dev_err(rtd->card->dev, "%s failed to select state %d\n",
+			__func__, ret);
+
+	return ret;
+}
+
+static void mt8183_da7219_tdm_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct mt8183_da7219_max98357_priv *priv =
+		snd_soc_card_get_drvdata(rtd->card);
+	int ret;
+
+	if (IS_ERR(priv->pin_states[PIN_TDM_OUT_OFF]))
+		return;
+
+	ret = pinctrl_select_state(priv->pinctrl,
+				   priv->pin_states[PIN_TDM_OUT_OFF]);
+	if (ret)
+		dev_err(rtd->card->dev, "%s failed to select state %d\n",
+			__func__, ret);
+}
+
+static struct snd_soc_ops mt8183_da7219_tdm_ops = {
+	.startup = mt8183_da7219_tdm_startup,
+	.shutdown = mt8183_da7219_tdm_shutdown,
+};
+
 static struct snd_soc_dai_link mt8183_da7219_max98357_dai_links[] = {
 	/* FE */
 	{
@@ -353,6 +410,8 @@ static struct snd_soc_dai_link mt8183_da7219_max98357_dai_links[] = {
 		.no_pcm = 1,
 		.dpcm_playback = 1,
 		.ignore_suspend = 1,
+		.be_hw_params_fixup = mt8183_i2s_hw_params_fixup,
+		.ops = &mt8183_da7219_tdm_ops,
 		SND_SOC_DAILINK_REG(tdm),
 	},
 };
@@ -409,7 +468,7 @@ static int mt8183_da7219_max98357_dev_probe(struct platform_device *pdev)
 	struct snd_soc_card *card = &mt8183_da7219_max98357_card;
 	struct device_node *platform_node;
 	struct snd_soc_dai_link *dai_link;
-	struct pinctrl *default_pins;
+	struct mt8183_da7219_max98357_priv *priv;
 	int ret, i;
 
 	card->dev = &pdev->dev;
@@ -443,12 +502,45 @@ static int mt8183_da7219_max98357_dev_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	default_pins =
-		devm_pinctrl_get_select(&pdev->dev, PINCTRL_STATE_DEFAULT);
-	if (IS_ERR(default_pins)) {
-		dev_err(&pdev->dev, "%s set pins failed\n",
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	snd_soc_card_set_drvdata(card, priv);
+
+	priv->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (IS_ERR(priv->pinctrl)) {
+		dev_err(&pdev->dev, "%s devm_pinctrl_get failed\n",
 			__func__);
-		return PTR_ERR(default_pins);
+		return PTR_ERR(priv->pinctrl);
+	}
+
+	for (i = 0; i < PIN_STATE_MAX; i++) {
+		priv->pin_states[i] = pinctrl_lookup_state(priv->pinctrl,
+							   mt8183_pin_str[i]);
+		if (IS_ERR(priv->pin_states[i])) {
+			ret = PTR_ERR(priv->pin_states[i]);
+			dev_info(&pdev->dev, "%s Can't find pin state %s %d\n",
+				 __func__, mt8183_pin_str[i], ret);
+		}
+	}
+
+	if (!IS_ERR(priv->pin_states[PIN_TDM_OUT_OFF])) {
+		ret = pinctrl_select_state(priv->pinctrl,
+					   priv->pin_states[PIN_TDM_OUT_OFF]);
+		if (ret)
+			dev_info(&pdev->dev,
+				 "%s failed to select state %d\n",
+				 __func__, ret);
+	}
+
+	if (!IS_ERR(priv->pin_states[PIN_STATE_DEFAULT])) {
+		ret = pinctrl_select_state(priv->pinctrl,
+					   priv->pin_states[PIN_STATE_DEFAULT]);
+		if (ret)
+			dev_info(&pdev->dev,
+				 "%s failed to select state %d\n",
+				 __func__, ret);
 	}
 
 	return ret;
-- 
2.20.1

