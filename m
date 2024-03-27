Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E67C47DD9
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Mar 2024 17:46:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 123BF2C46;
	Wed, 27 Mar 2024 18:46:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 123BF2C46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1711561589;
	bh=hnGUSISMWJyKzUzYwhipDPpfcmTFJLBeQqZyefNwj0Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rOnwl7iYquK48e7BI7nik6yo2wQDteETOpPTCKksrsg2F+/yphyTBc7YOpvxpwvj/
	 tJpchy0bpvvuB48VeqChvaufFhvn+PmYmHBl4H5LGDgp1p+Xtzdw1vERGBWBgLfRty
	 OlfrsfU7GCZIQCMVLLhEJSeWGpaOKwL1TMQ7tjYg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5FB43F805FD; Wed, 27 Mar 2024 18:45:28 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E0B8AF8060B;
	Wed, 27 Mar 2024 18:45:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F0B60F805DF; Wed, 27 Mar 2024 18:45:22 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 63681F805AD
	for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2024 18:45:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63681F805AD
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id ABC5A615EB;
	Wed, 27 Mar 2024 17:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D915CC433F1;
	Wed, 27 Mar 2024 17:45:13 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 18:44:38 +0100
Subject: [PATCH 03/18] ASoC: tlv320aic3x-spi: drop driver owner assignment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-var-v1-3-86d5002ba6dc@linaro.org>
References: <20240327-module-owner-var-v1-0-86d5002ba6dc@linaro.org>
In-Reply-To: <20240327-module-owner-var-v1-0-86d5002ba6dc@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
 Baojun Xu <baojun.xu@ti.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=707;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=hnGUSISMWJyKzUzYwhipDPpfcmTFJLBeQqZyefNwj0Q=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBFsOhPk3ZT6rW9aW41+tt1GhJmtZw4eivIzRi
 2ZnIV2XDO+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgRbDgAKCRDBN2bmhouD
 1yOdEACI2wi4JJYyNZ/aFgOP+1zVwgvyQbAte66nrWJH4bhhKiu7El6ePUWWzvY+S9QcRxefKSB
 WBpC4PxTsjYPg2kKMQJdH8keyl/qtNjGs9SBuLfvjaKr4awvPX65mozDQV4HgowKG5DTllrUIr3
 rdt8W4PVnD0aYKVeao1DDrOl4OgQk5IterLd9d5IgAIEWpUFrf2B9cqcu/byEn4Xzep0JgQZSwT
 rLiCdYzv8Fee/CQZ8oFAYJa+mLbsdAsMOtfbFuh8ILV0LOu57wyzxYz5ovlgG2eHYA2hck1cY6M
 qQNx+2XT8vsTWikmhmARRJajaPYVVG8wkmZ+TE44S0D5PxpDOVDenb3xK1SkG3RuqdEqkpEzqC+
 SBj3Cfk9IdQgrlWtz50U+Bx7PlxfqXZWFoLYANJAPAaCXDAx+5jG3OSKqBWijOMmZh/eAWl0imc
 sjRRT8mv6l6WCHywvVOJ5FVy/XgKkLhNA9rLYgRczPfPZ/inGoub7NxmuwLQFFh3NRRd3akH2C1
 d9pYswKdgIWBrN+Z9CjnmH6Ibn+36qUX3DHbn3XGA41BHU4lRy5sYd+CHbyWdLgopBKQI0RNu//
 ZsC80XbcF5ED41An2v7/Z/Eh6uKwzHK95nm+hZg+Qpp7j9Ih98Qk1bqnmDi+4m3Ye5OvNZr/Utk
 99RKUsUBTvbA3UQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Message-ID-Hash: 5UWYH2VIMYONJHVNVMXT5JYPM5AXVETU
X-Message-ID-Hash: 5UWYH2VIMYONJHVNVMXT5JYPM5AXVETU
X-MailFrom: SRS0=G+Mr=LB=linaro.org=krzysztof.kozlowski@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5UWYH2VIMYONJHVNVMXT5JYPM5AXVETU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Core in spi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/tlv320aic3x-spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic3x-spi.c b/sound/soc/codecs/tlv320aic3x-spi.c
index deed6ec7e081..f8c1c16eaa0e 100644
--- a/sound/soc/codecs/tlv320aic3x-spi.c
+++ b/sound/soc/codecs/tlv320aic3x-spi.c
@@ -63,7 +63,6 @@ MODULE_DEVICE_TABLE(of, aic3x_of_id);
 static struct spi_driver aic3x_spi_driver = {
 	.driver = {
 		.name = "tlv320aic3x",
-		.owner = THIS_MODULE,
 		.of_match_table = aic3x_of_id,
 	},
 	.probe = aic3x_spi_probe,

-- 
2.34.1

