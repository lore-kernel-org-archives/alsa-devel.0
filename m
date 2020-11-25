Return-Path: <SRS0=zi5T=E7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C979AC63798
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Nov 2020 17:01:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C6E206D8
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Nov 2020 17:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="joUXzQKE";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzW8twxN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C6E206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B2231894;
	Wed, 25 Nov 2020 18:01:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B2231894
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606323716;
	bh=rHhaaDvCI3oNFGE1+QHFB0i3vECs+/DgQ7hv/ctlhEo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=joUXzQKE3BLAeGqps4+l4ZblR9/2+4kn1/YOv3IrZp5Ae+pEcLgu+Lu8tptkTvgm7
	 w+Ol6S2JCVo9qgxV6ln5bJ8l78v6fDKUHdEFeInmgKp543cokMJXWRFtiEfpDidog2
	 sSnG7lRSwi8ISb5nin9PmAWALzcH14kbHv67rBiA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00A8CF805F9;
	Wed, 25 Nov 2020 17:48:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C84D1F805FB; Wed, 25 Nov 2020 17:48:05 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7FBC0F805F9
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2020 17:48:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7FBC0F805F9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TzW8twxN"
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch
 [84.226.167.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E76822145D;
 Wed, 25 Nov 2020 16:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606322882;
 bh=rHhaaDvCI3oNFGE1+QHFB0i3vECs+/DgQ7hv/ctlhEo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TzW8twxNCk4GeJkwWlA0WbI44EVFTsn9/JGdItKXKkSISPUy9hwSZkj7od1gd+tqn
 5nnfDAmhOPCpjp4ThF+MqZebT+Yf4AF+V3FVtA5rXo4RuDw1aIRUVYGbgCSva491+n
 +P7xU1JYWVt1eS99Ln1PmVJssVsW/RwxqDHLlUQ4=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Support Opensource <support.opensource@diasemi.com>,
 Oder Chiou <oder_chiou@realtek.com>,
 Kevin Cernekee <cernekee@chromium.org>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Neil Armstrong <narmstrong@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Patrick Lai <plai@codeaurora.org>,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Heiko Stuebner <heiko@sntech.de>, Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: [PATCH v2 39/39] ASoC: samsung: smdk_wm8994: remove redundant
 of_match_ptr()
Date: Wed, 25 Nov 2020 17:44:52 +0100
Message-Id: <20201125164452.89239-40-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201125164452.89239-1-krzk@kernel.org>
References: <20201125164452.89239-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Sylwester Nawrocki <snawrocki@kernel.org>
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

of_match_device() already handles properly !CONFIG_OF case, so passing
the argument via of_match_ptr() is not needed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Sylwester Nawrocki <snawrocki@kernel.org>
---
 sound/soc/samsung/smdk_wm8994.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/smdk_wm8994.c b/sound/soc/samsung/smdk_wm8994.c
index 28d6eb14d7db..681b244d5312 100644
--- a/sound/soc/samsung/smdk_wm8994.c
+++ b/sound/soc/samsung/smdk_wm8994.c
@@ -170,7 +170,7 @@ static int smdk_audio_probe(struct platform_device *pdev)
 		smdk_dai[0].platforms->of_node = smdk_dai[0].cpus->of_node;
 	}
 
-	id = of_match_device(of_match_ptr(samsung_wm8994_of_match), &pdev->dev);
+	id = of_match_device(samsung_wm8994_of_match, &pdev->dev);
 	if (id)
 		*board = *((struct smdk_wm8994_data *)id->data);
 
-- 
2.25.1

