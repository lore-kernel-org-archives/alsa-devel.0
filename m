Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7B1C54E67
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Mar 2024 17:49:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B46DE76;
	Wed, 27 Mar 2024 18:49:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B46DE76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1711561784;
	bh=ZFjPJ8bFFVWDPfXrcr0sa1qRi9l9p3U9KSsG8676i5g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gNZHgxmHBP5W81oDU541moqHOBI3QUo2k1QIQqswU9G+wQ+AvrEct0IfCsWLAF6M4
	 WjM8YfeglDccNA+hx2bAZYGcFBK3YV5vPnIIOpaZp4m2LPGLsdUF9ZcYg0l4nlkXjx
	 R8G1LIrmcB4oH6DBt/l+OWFJXqL9Vu4pZwDJnEH0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 352F6F80864; Wed, 27 Mar 2024 18:46:11 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E2327F80897;
	Wed, 27 Mar 2024 18:46:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 164F8F805D6; Wed, 27 Mar 2024 18:46:06 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6B4CBF80792
	for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2024 18:46:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B4CBF80792
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C77AC615ED;
	Wed, 27 Mar 2024 17:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A4CC43394;
	Wed, 27 Mar 2024 17:45:56 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 18:44:49 +0100
Subject: [PATCH 14/18] ASoC: rt712-sdca-sdw: drop driver owner assignment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-var-v1-14-86d5002ba6dc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=715;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ZFjPJ8bFFVWDPfXrcr0sa1qRi9l9p3U9KSsG8676i5g=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBFsY9+zpkWO1Wlj/5upo7qKd5m6OB01R+H0rZ
 nuLk/0FitWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgRbGAAKCRDBN2bmhouD
 19UkEACTtnVCSuzTXbaxBY7IiHr8KjsFsRld7gDZE/B/5i+GdcgnUdFltafvrtp3tU0ECLsmIDJ
 wX8YZvgrFkdxOPtBl1Tn/RNmhj1LLVFKXIcZklKpCHp24HURYsSqJHfNrs5IMrIoLwtL2OvqSaB
 4A+x2vo8q2nWnrqMctUi929TLm3inZVZueavD+tAbV3/LJc5KBIKoa01RIINK0sgdl4EJF9CF1w
 uq7UdaAH+uQ257RiMpcZRTa845m83AId0R4/0fI3PcSiJV/l8G3ac4eORP46IaLnqzc0xBX9RLs
 OOvdF5xKm+jGzW83aUPlHA9AfWI0qgVirFkeHSr9e0RYkmc8Vb5D6+VIGKqeZsbooV82l9H+Os9
 +UHdqxFl7tCBiZWTmzt+Ye5O0OAjEBUNsfdg1eQvqlvXB2dlUugguEna6Fi2kUEZ+dvCFTEOc+H
 NwHWwfByLECQ0dsoJ1FY4WKNZ774+Pu1v0hiMV/VLGgipCONFE81bXp/Llkvy0EZBK7g1nIwMKt
 MkQVquas0ppcUh5DmrfHhjRQ0nBH5j0PdZDbZtYMw+CHCNyE6tpLwLvdBC6IV+lBSU6bZu2oCxY
 W7hALV+kq0ovw0uWpzNlasAeE0LzjvnvW35uX5yrM1hcLPlXBOhU5zRZQb4jk0U3D9ovMBpzX05
 BsIccqvHzRBVYHA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Message-ID-Hash: LRZRD3KLE4H5MFTSFQQYPFCU3J24LQ4K
X-Message-ID-Hash: LRZRD3KLE4H5MFTSFQQYPFCU3J24LQ4K
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
Archived-At: <>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Core in sdw_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/rt712-sdca-sdw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt712-sdca-sdw.c b/sound/soc/codecs/rt712-sdca-sdw.c
index 01ac555cd79b..f04e11980591 100644
--- a/sound/soc/codecs/rt712-sdca-sdw.c
+++ b/sound/soc/codecs/rt712-sdca-sdw.c
@@ -474,7 +474,6 @@ static const struct dev_pm_ops rt712_sdca_pm = {
 static struct sdw_driver rt712_sdca_sdw_driver = {
 	.driver = {
 		.name = "rt712-sdca",
-		.owner = THIS_MODULE,
 		.pm = &rt712_sdca_pm,
 	},
 	.probe = rt712_sdca_sdw_probe,

-- 
2.34.1

