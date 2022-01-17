Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13B7C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Jan 2022 13:24:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21D811825;
	Mon, 17 Jan 2022 14:23:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21D811825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1642425850;
	bh=HHl+tcKsaJd/EjkC5QH/VuLb6CdI2cBHcVNYB/vWclg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wj1LR68e3/VwUz9ZPRMiXOC3Z7sEllxVdQScfy/PEU013gDtAo6UBfZfnC7Fz0vb8
	 4EIF5GfdWqEw6so5sAVCYG/xvori4GnrShR/cfnFjWjyW1wUs3LV3QvF2v4hyf3dz2
	 7bZy2jOfSzUo+L4vNV02takFzeaR+FHaHBhpYS58=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AEF2DF8051E;
	Mon, 17 Jan 2022 14:22:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 19323F80525; Mon, 17 Jan 2022 14:22:00 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D82E0F8051E
 for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2022 14:21:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D82E0F8051E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="S2P6fFa0"
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: adalessandro) with ESMTPSA id 769371F439D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1642425715;
 bh=HHl+tcKsaJd/EjkC5QH/VuLb6CdI2cBHcVNYB/vWclg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=S2P6fFa0uw/eluYfvxcMao8Xr5PP7TpK1pfsxPrAUf3ehEYZiQoYze2gVB8kqSLEo
 kMZyAWiIlC2cPYo0oajrpH9Ov0TwYPmuqCKJ2Ba2vbydO9FcPZ5hzsta6xFpOXt9lG
 MRwCOBzxRkBFczXOvpLP2FBWSTQEdUBCpz9hdrC2pA4MFo0/hlKA4mGE+99C8tEM5C
 dcKWzFBjHFVWrtbqjFK0wzff9JwnD/cbNSusMIZTba0iJ5mIe+sZHS+bM+DsptZkPZ
 n8C+pE2afJl4GksgRZhH0Bt11eokqmPVvwDXYl96kRgtsJkC5Bvlm7YIHzbnQQtJqp
 ovtVMKtWpRflw==
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 5/5] ASoC: fsl-asoc-card: Remove BCLK default value for
 tlv320aic31xx card
Date: Mon, 17 Jan 2022 10:21:09 -0300
Message-Id: <20220117132109.283365-6-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117132109.283365-1-ariel.dalessandro@collabora.com>
References: <20220117132109.283365-1-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: ariel.dalessandro@collabora.com, kuninori.morimoto.gx@renesas.com,
 Xiubo.Lee@gmail.com, tony@atomide.com, shengjiu.wang@gmail.com, tiwai@suse.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, nicoleotsuka@gmail.com,
 broonie@kernel.org, bcousson@baylibre.com, michael@amarulasolutions.com,
 festevam@gmail.com
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

Now that fsl-asoc-card support setting mclk-id through the device-tree
mclk-id property, let's remove the default BCLK configuration for this
card.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 156d3c669274..370bc790c6ba 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -637,7 +637,6 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		priv->dai_link[2].dpcm_capture = 0;
 		priv->cpu_priv.sysclk_dir[TX] = SND_SOC_CLOCK_OUT;
 		priv->cpu_priv.sysclk_dir[RX] = SND_SOC_CLOCK_OUT;
-		priv->codec_priv.mclk_id = AIC31XX_PLL_CLKIN_BCLK;
 		priv->card.dapm_routes = audio_map_tx;
 		priv->card.num_dapm_routes = ARRAY_SIZE(audio_map_tx);
 	} else if (of_device_is_compatible(np, "fsl,imx-audio-wm8962")) {
-- 
2.34.1

