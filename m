Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72FBC369D6
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Sep 2024 12:15:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB370832;
	Wed, 25 Sep 2024 14:15:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB370832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1727266516;
	bh=lkXxB/YjIjrqCNz9gdjyXC7KTuV69ONi+VaZy64n8X0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kY697gie74VCMpVHwBE/oQ+ck3K8fGIhDw88nQJl/iv2YYUxIzetNS+9PU0uySZh4
	 K/UjIxWNtnIIvnJk3MEBSh2DtCGe6AXWNNdZ94vsAlFRjNSNFXj0q2FEKxiN6yu56z
	 sGBgKl/2m8miryuSi00EN6BFju0gWQDhOOL6GGr0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5081FF805B4; Wed, 25 Sep 2024 14:14:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 008C3F805B4;
	Wed, 25 Sep 2024 14:14:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C0681F802DB; Wed, 25 Sep 2024 14:14:32 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 27702F8010B
	for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2024 14:14:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 27702F8010B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=vBidSwdY
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3B0AE5C4C66;
	Wed, 25 Sep 2024 12:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8191EC4CEC7;
	Wed, 25 Sep 2024 12:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266469;
	bh=lkXxB/YjIjrqCNz9gdjyXC7KTuV69ONi+VaZy64n8X0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vBidSwdYLvYCcse3meUylnZ/947QXbqmUbx6g3msRjDoyNbUHdajIO4YAbaGnvBgP
	 6lxtOP9GIp1gyE8ciJR9L9dgNT7CiIKmNKYtYUW1nTLesULnna2Jp4UdSusgFePq3x
	 UB51YuN/9y3M2QI5NJ0YO47y9Z3yx/HJ/iTVpdmjLJsznfu9M7orNUJF4SYawHjekh
	 ihNf1TmEyZGhyLOvFi6isjD2wmL3Bgu1H7Wu8tmgn3EIWgHHprGU25Tdl+d3fefOeY
	 Yr33QwAPuOTKOZvHeKRyg6qX69aizjOSc0UOw5PMyfiULrbmprpcRKnBDG7ecn92Xl
	 fxOS+NULqYbgg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	srinivas.kandagatla@linaro.org,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 063/139] ASoC: codecs: wsa883x: Handle reading
 version failure
Date: Wed, 25 Sep 2024 08:08:03 -0400
Message-ID: <20240925121137.1307574-63-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit
Message-ID-Hash: RUM7LCXKBBA7NLKVVQUZPD4IYPFB2NOF
X-Message-ID-Hash: RUM7LCXKBBA7NLKVVQUZPD4IYPFB2NOF
X-MailFrom: sashal@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RUM7LCXKBBA7NLKVVQUZPD4IYPFB2NOF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 2fbf16992e5aa14acf0441320033a01a32309ded ]

If reading version and variant from registers fails (which is unlikely
but possible, because it is a read over bus), the driver will proceed
and perform device configuration based on uninitialized stack variables.
Handle it a bit better - bail out without doing any init and failing the
update status Soundwire callback.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://patch.msgid.link/20240710-asoc-wsa88xx-version-v1-2-f1c54966ccde@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wsa883x.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index 2169d93989841..1831d4487ba9d 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -998,15 +998,19 @@ static const struct reg_sequence reg_init[] = {
 	{WSA883X_GMAMP_SUP1, 0xE2},
 };
 
-static void wsa883x_init(struct wsa883x_priv *wsa883x)
+static int wsa883x_init(struct wsa883x_priv *wsa883x)
 {
 	struct regmap *regmap = wsa883x->regmap;
-	int variant, version;
+	int variant, version, ret;
 
-	regmap_read(regmap, WSA883X_OTP_REG_0, &variant);
+	ret = regmap_read(regmap, WSA883X_OTP_REG_0, &variant);
+	if (ret)
+		return ret;
 	wsa883x->variant = variant & WSA883X_ID_MASK;
 
-	regmap_read(regmap, WSA883X_CHIP_ID0, &version);
+	ret = regmap_read(regmap, WSA883X_CHIP_ID0, &version);
+	if (ret)
+		return ret;
 	wsa883x->version = version;
 
 	switch (wsa883x->variant) {
@@ -1041,6 +1045,8 @@ static void wsa883x_init(struct wsa883x_priv *wsa883x)
 				   WSA883X_DRE_OFFSET_MASK,
 				   wsa883x->comp_offset);
 	}
+
+	return 0;
 }
 
 static int wsa883x_update_status(struct sdw_slave *slave,
@@ -1049,7 +1055,7 @@ static int wsa883x_update_status(struct sdw_slave *slave,
 	struct wsa883x_priv *wsa883x = dev_get_drvdata(&slave->dev);
 
 	if (status == SDW_SLAVE_ATTACHED && slave->dev_num > 0)
-		wsa883x_init(wsa883x);
+		return wsa883x_init(wsa883x);
 
 	return 0;
 }
-- 
2.43.0

