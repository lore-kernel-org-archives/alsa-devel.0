Return-Path: <SRS0=nNdU=W2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B2EC3A59B
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Aug 2019 16:08:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C6D723429
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Aug 2019 16:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iZDCbWFg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="P0uykUgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6D723429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17186166F;
	Fri, 30 Aug 2019 18:07:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17186166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567181328;
	bh=ugMZ0duXq7ZsnPnGml6wYwcBmGCAmibJwX6hi5QLWD4=;
	h=From:To:In-Reply-To:Date:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=iZDCbWFgPOXuX0Lx1aPe0qXAXDUjYU5cCHyxfQ+1JrpdcJvLt00DYBCMLWW5e+0ER
	 LAU0RqLhFEurwE6i4+xsxX9WuF5Fh/m0WsI++BddlkIgp2UcqWmaMnHg/ZPuOJJe8W
	 HQMotsJrE9I6vOArXg4VoRPW9eNoezNNMxBVo5Bw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9DD4AF80377;
	Fri, 30 Aug 2019 18:06:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 45E12F805A0; Fri, 30 Aug 2019 18:06:18 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E70B7F8036C
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 18:06:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E70B7F8036C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="P0uykUgI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=xwVOSc4on5cCdxjhaM3Ov013SwiWVrMLMRy26vK8htU=; b=P0uykUgIDd03
 7ubNMEUYo2n7SP7pjfC+RNasFFEwf4DQcyG0LsjYj+vFihntM7rqPhZzf8YyMIqjoGWTlFF5wG8Wq
 qHF+08tCGpQ4O5o30TJS3s0xLtoRHguGTkCVpOroJFYb0xBx5YBeDqqhVOLD2dDdDVPDZ3e762b+Z
 qbi2Q=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1i3jPc-000797-UB; Fri, 30 Aug 2019 16:06:08 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 6EF7A2742B61; Fri, 30 Aug 2019 17:06:08 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
In-Reply-To: <20190830074240.195166-3-tzungbi@google.com>
X-Patchwork-Hint: ignore
Message-Id: <20190830160608.6EF7A2742B61@ypsilon.sirena.org.uk>
Date: Fri, 30 Aug 2019 17:06:08 +0100 (BST)
Cc: tzungbi@google.com, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, dgreid@google.com, cychiang@google.com
Subject: [alsa-devel] Applied "ASoC: mediatek: mt8183: move headset jack to
	card-specific storage" to the asoc tree
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Message-ID: <20190830160608.f2j0ieJfNrYIa8hUQJGysfZ25VlMDAwge4Qy_r0xZSA@z>

The patch

   ASoC: mediatek: mt8183: move headset jack to card-specific storage

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

From 95d779b4b8e7a62d53c7afeba45207089dcee4c8 Mon Sep 17 00:00:00 2001
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Fri, 30 Aug 2019 15:42:38 +0800
Subject: [PATCH] ASoC: mediatek: mt8183: move headset jack to card-specific
 storage

Move headset jack descriptor from module global scope to card-specific
storage to make its ownership more explicit.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Link: https://lore.kernel.org/r/20190830074240.195166-3-tzungbi@google.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index 1d4a1600f768..a7ad41b6e885 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -15,8 +15,6 @@
 #include "mt8183-afe-common.h"
 #include "../../codecs/ts3a227e.h"
 
-static struct snd_soc_jack headset_jack;
-
 enum PINCTRL_PIN_STATE {
 	PIN_STATE_DEFAULT = 0,
 	PIN_TDM_OUT_ON,
@@ -31,6 +29,7 @@ static const char * const mt8183_pin_str[PIN_STATE_MAX] = {
 struct mt8183_mt6358_ts3a227_max98357_priv {
 	struct pinctrl *pinctrl;
 	struct pinctrl_state *pin_states[PIN_STATE_MAX];
+	struct snd_soc_jack headset_jack;
 };
 
 static int mt8183_mt6358_i2s_hw_params(struct snd_pcm_substream *substream,
@@ -410,6 +409,8 @@ static int
 mt8183_mt6358_ts3a227_max98357_headset_init(struct snd_soc_component *component)
 {
 	int ret;
+	struct mt8183_mt6358_ts3a227_max98357_priv *priv =
+			snd_soc_card_get_drvdata(component->card);
 
 	/* Enable Headset and 4 Buttons Jack detection */
 	ret = snd_soc_card_jack_new(&mt8183_mt6358_ts3a227_max98357_card,
@@ -417,12 +418,12 @@ mt8183_mt6358_ts3a227_max98357_headset_init(struct snd_soc_component *component)
 				    SND_JACK_HEADSET |
 				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				    &headset_jack,
+				    &priv->headset_jack,
 				    NULL, 0);
 	if (ret)
 		return ret;
 
-	ret = ts3a227e_enable_jack_detect(component, &headset_jack);
+	ret = ts3a227e_enable_jack_detect(component, &priv->headset_jack);
 
 	return ret;
 }
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
