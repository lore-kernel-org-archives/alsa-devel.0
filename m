Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BECC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Jan 2022 17:04:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B80B218CC;
	Mon, 17 Jan 2022 18:03:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B80B218CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1642439062;
	bh=hNiXVPwOVmy/4yBg5fl7XcRs2NLXgKTOlk9ADgTFuyA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rvpk+HWmJyS85Te0amcfex25t4xhjp2M5SL7f8r0zq4enIe8rgZ0diVsXvmDoPjq+
	 dYOe5WtMdyKIymphrrZbT7oYdh2fcqSKeiei2fNLS1Yvob2/qeTYqLSDuDGQPolSHJ
	 sD+bX395t+Enh1i3ndG+KrxAZdA9m+dEKJcLrU7E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B9886F80517;
	Mon, 17 Jan 2022 18:03:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 57A57F80254; Mon, 17 Jan 2022 18:03:17 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C7C98F80100
 for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2022 18:03:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7C98F80100
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="gc4rX/9P"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 07576611C2;
 Mon, 17 Jan 2022 17:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DA1C36AE3;
 Mon, 17 Jan 2022 17:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642438992;
 bh=hNiXVPwOVmy/4yBg5fl7XcRs2NLXgKTOlk9ADgTFuyA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gc4rX/9P1ujHKrmdgQLrJnXKXtPFzcsdxoBCkg0zd107DA1V9aqWOtdRekidXBlAQ
 1HPlUdS7kfBQsdHgN0c8z5/Mui7RVqpBOSE6FNxiWB72QTuxVdatVvHe+b06uwUlG0
 M2VrMKPppjLDy8u4XL8YF+9YzKZGFjCZOAq2r5CUfuQWXQQQP8mBFIoqNp8ofzur1i
 KpJn4EkePJPPYZcAEy723xfhR0tiDsvLx9pIB1N2jdpHQ1ozOFk3nZAcfWMgRmt29Y
 aeJ4hoZsraGM6pcvfRx+/twahPp0PzeaivVlnBTV0kuM5u0I5D9lT57dAgfq6HRUCu
 yNSq8YN+qcblg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 40/44] ASoC: mediatek: mt8183: fix device_node
 leak
Date: Mon, 17 Jan 2022 12:01:23 -0500
Message-Id: <20220117170127.1471115-40-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117170127.1471115-1-sashal@kernel.org>
References: <20220117170127.1471115-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 tiwai@suse.com, jiaxin.yu@mediatek.com, lgirdwood@gmail.com,
 Tzung-Bi Shih <tzungbi@google.com>, Mark Brown <broonie@kernel.org>,
 linux-mediatek@lists.infradead.org, rikard.falkeborn@gmail.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
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

[ Upstream commit cb006006fe6221f092fadaffd3f219288304c9ad ]

Fixes the device_node leak.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Link: https://lore.kernel.org/r/20211224064719.2031210-3-tzungbi@google.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c         | 6 +++++-
 sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c | 7 ++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
index a4d26a6fc8492..bda103211e0bd 100644
--- a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
@@ -781,7 +781,11 @@ static int mt8183_da7219_max98357_dev_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	return devm_snd_soc_register_card(&pdev->dev, card);
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+
+	of_node_put(platform_node);
+	of_node_put(hdmi_codec);
+	return ret;
 }
 
 #ifdef CONFIG_OF
diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index 94dcbd36c8697..c7b10c48c6c22 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -780,7 +780,12 @@ mt8183_mt6358_ts3a227_max98357_dev_probe(struct platform_device *pdev)
 				 __func__, ret);
 	}
 
-	return devm_snd_soc_register_card(&pdev->dev, card);
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+
+	of_node_put(platform_node);
+	of_node_put(ec_codec);
+	of_node_put(hdmi_codec);
+	return ret;
 }
 
 #ifdef CONFIG_OF
-- 
2.34.1

