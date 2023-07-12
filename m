Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DB7EB64DD
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Jul 2023 11:15:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 155AA820;
	Wed, 12 Jul 2023 13:15:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 155AA820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689160552;
	bh=Y6+HL5cXUR8pbarN3p3+VttPH3gHnNQ6XxPid37hCR8=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=TBQxkiP9n3bEr92myRSFhzHnPbmAvppNs7WM3z46zC377z/F4faRxyc40acoiDgSO
	 jm74S0sjyZyB709/R5/nfB27z79OpoJyHts11/hKaVrq3vWDr3FE2yWPlmgz/qedIR
	 WF6mIJf1KXu4YckLnswZ4qiy4TgbTaHV+TkiAHos=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3FC6EF80236; Wed, 12 Jul 2023 13:14:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DBAE1F8047D;
	Wed, 12 Jul 2023 13:14:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CF0A6F80249; Wed, 12 Jul 2023 13:14:35 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0A2FBF800D2
	for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2023 13:14:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A2FBF800D2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Ldqv88QB
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A7C5661730;
	Wed, 12 Jul 2023 11:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964B6C433C9;
	Wed, 12 Jul 2023 11:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689160469;
	bh=Y6+HL5cXUR8pbarN3p3+VttPH3gHnNQ6XxPid37hCR8=;
	h=From:Date:Subject:To:Cc:From;
	b=Ldqv88QBLV2MDVWXgVYjElfKL8Ym4/H4j1R72PcSdBA47TCiesI7tIawH0QYyTOmS
	 6E3hcwsrAUAq5WuoL+/Bi/cRmA4aoOIUU2LDqtmcXZIQ6b1QVYuMhwZKAuQ3/9S8xf
	 nhxzgXyomqJGU9nE6nDV1BjU0LjnSFKRgziPysotee0zozTWajkZXV3L2rWenGqJfS
	 yOO8DKC9mzNYIfyfq21Xbr6gyySIcLJVI+5wnIGJxFshLVsyHED5QWN8zbzYNDoTYG
	 C4pqrAaT3+neX66FqV8rR/TVz2sYhvUE1DwQV6UIrGcASNW3NHsZI//PBKY/cV/fxq
	 SIBkfxqr295eg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 12 Jul 2023 12:14:21 +0100
Subject: [PATCH] ASoC: jz4740: Update to use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230712-asoc-jz-maple-v1-1-3f745adf96e5@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAyLrmQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDM2MD3cTi/GTdrCrd3MSCnFTdxMTkpBTjREOjpCQzJaCegqLUtMwKsHn
 RsbW1ALVL6i9fAAAA
To: Paul Cercueil <paul@crapouillou.net>,
 Liam Girdwood <lgirdwood@gmail.com>
Cc: linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1266; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Y6+HL5cXUR8pbarN3p3+VttPH3gHnNQ6XxPid37hCR8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkrosSuIhZE5wvoRzAMzl6sL27d0C6GMGOFJkPp
 pIcVPbuyaOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK6LEgAKCRAk1otyXVSH
 0NQOB/90p5zjN4/f2/gVe1vaYj6jbmlPlBvsMyZ1tPF/Livlnts9y86UQND71L8jqGX91OYF3Cw
 9o5GwxqBULj0CvmiJngv1Ek43dQxgOb15XWPkWMIw+erYWjeExLWJt3A3UK0rhlwooQ3MoILrih
 qbTXJfINuBLDV34hpA9I0NQFYtfR8wFuJmIzrcc/aJQDFEbNtaW+ovRPMPlVN3znQq9I+xZrkqv
 hGBjRhYD2ysR3NTK/lGGKKqcl3q9ZXZknwZ2AlvgTX46kmApfx5s+Dmn42YKqujjlU1asnp5uHi
 Y/oKKFVYisgJWkbvx0Y6eR7l2DK2XsRe3Xy2MVt7OphWnQag
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: E7SZAQP4OC37VKHWMQ753W7SSJDPGYBY
X-Message-ID-Hash: E7SZAQP4OC37VKHWMQ753W7SSJDPGYBY
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/E7SZAQP4OC37VKHWMQ753W7SSJDPGYBY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache. In
v6.5 it has also acquired the ability to generate multi-register writes in
sync operations, bringing performance up to parity with the rbtree cache
there.

Update the jz4740 driver to use the more modern data structure.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/jz4740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index 7c25acf6ff0d..d1cea93bdb59 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -301,7 +301,7 @@ static const struct regmap_config jz4740_codec_regmap_config = {
 
 	.reg_defaults = jz4740_codec_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(jz4740_codec_reg_defaults),
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static int jz4740_codec_probe(struct platform_device *pdev)

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230630-asoc-jz-maple-aacbd3a12bb6

Best regards,
-- 
Mark Brown <broonie@kernel.org>

