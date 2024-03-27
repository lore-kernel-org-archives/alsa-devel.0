Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F16C54E67
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Mar 2024 17:46:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0B3E22C17;
	Wed, 27 Mar 2024 18:46:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0B3E22C17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1711561609;
	bh=cOQ1Xw92qWWN6FqyBsmZzqC668ZvHV9yoP5QeZFK6WI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=M+gSFkPQKQqLoXQiONP0dpYh2yFPsvylTj0B9pxfn9XA1iIJpFS5HfZr9CF4GJVzc
	 gIaoQIKUh+u1B6WIf2Odzu3XIuo503qykFf8TcCfPDlk/NF8lsCk6bErbFTPU+gKKn
	 6gn57VOFO7dxNo93JW3fCpajRWQ/BIyBT7vHwBGA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A78C4F8061F; Wed, 27 Mar 2024 18:45:34 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D48E9F80631;
	Wed, 27 Mar 2024 18:45:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 89471F8061E; Wed, 27 Mar 2024 18:45:29 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B2266F805ED
	for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2024 18:45:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2266F805ED
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 66F54CE2381;
	Wed, 27 Mar 2024 17:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB49CC43394;
	Wed, 27 Mar 2024 17:45:17 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 18:44:39 +0100
Subject: [PATCH 04/18] ASoC: max98373-sdw: drop driver owner assignment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-var-v1-4-86d5002ba6dc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=759;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=cOQ1Xw92qWWN6FqyBsmZzqC668ZvHV9yoP5QeZFK6WI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBFsPUJsGs4eDiv8n5erNgyO/pwUcrCGgUvmrn
 /dC66kUeK6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgRbDwAKCRDBN2bmhouD
 1+vJD/9DKOn1WqoFaoyFM+cQ/WCESJFGHHTpy0gGHRagurP7CzisDyFfHxr4eCvXbPBGdjupYdL
 sd9UCd0xA16m2GCwqra4a69NwIubVAtuXEK7wxfqkO68fEGHvnUy8+jzeB0J5NYSeKONPp1Bcd8
 BxEwf4rW9iV/x/Dpz5rESFvrxTB2VVwRdDxUixP2kIiy2r9DTRSxGoPlrwm1HVggUDs/cqXIXSf
 0yjuSBjHup3Keu166pJGQFzDMTTVCh2t0sWJFfhG9MS9mL4axERHbmd7uvMpzk3NFCY2DBJqGdH
 dLzVlL/J7woqZnS54/rThFsRveGoRggDnomZ8c0gwCyq6J96habMOaVtmSYQkTKtLdhE2IFVnaJ
 VIiSXnDAK3IvzHY9g1hgdhzRGK+dLsqleMf6hxUhaqwdluS40MqSX3KVUYbsXf7r19KNw1oPYuQ
 +AnJBUydf8QymNYvysckfJDS6X/h5cSOD8hqIhQn2Eu3GGv7aRb7suPEv964oMg0pEPphkloocF
 8wTpgdimcuymDAfJoKm/cHakbqcbROoBzoelYoih7+SpiIp6hgJ9kTvFiE48RFL0CEbryD6QHhs
 nfaQvWNvs9beFnPx6T8xiSVWEZUUN+mVmOHpwXnFywfAIuWUI02dYUSwg1vUrsBv6sA4uC2ueif
 rPYaeNC14rUJBWw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Message-ID-Hash: 7UWCESAB4626D3GLNRCF4IJL36IRRHZE
X-Message-ID-Hash: 7UWCESAB4626D3GLNRCF4IJL36IRRHZE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7UWCESAB4626D3GLNRCF4IJL36IRRHZE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Core in sdw_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/max98373-sdw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/max98373-sdw.c b/sound/soc/codecs/max98373-sdw.c
index 383e551f3bc7..26860882fd91 100644
--- a/sound/soc/codecs/max98373-sdw.c
+++ b/sound/soc/codecs/max98373-sdw.c
@@ -872,7 +872,6 @@ MODULE_DEVICE_TABLE(sdw, max98373_id);
 static struct sdw_driver max98373_sdw_driver = {
 	.driver = {
 		.name = "max98373",
-		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(max98373_of_match),
 		.acpi_match_table = ACPI_PTR(max98373_acpi_match),
 		.pm = &max98373_pm,

-- 
2.34.1

