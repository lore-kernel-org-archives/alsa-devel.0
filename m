Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CA9C54E58
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:39:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0D46BA4D;
	Mon, 11 Mar 2024 19:39:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0D46BA4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1710182381;
	bh=KK0r7HLEGlnhN25/A0rpX5LySpg3lS7iiWtkuou51PM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=XGzTdM2bEep8Kbj9jTR+JGM2eqY5eulfslhsMbFGQ/v5MiwwIv8wc3aLKv6KwDqnT
	 n+RRo/+v2bTUmPZkwt5PQVQEz4ESJJKB+E4s3X7/1Xh9xHmJAgYT2UUejiGl1yQM67
	 JUO+TBvuWZdiMrMZyLGd35Z00vdghwCCrWFpKoeo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 828BCF8067D; Mon, 11 Mar 2024 19:37:52 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4DF16F8067F;
	Mon, 11 Mar 2024 19:37:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0177EF80570; Mon, 11 Mar 2024 19:37:31 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 56CE6F8014B
	for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2024 19:37:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 56CE6F8014B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Dxe+2nDY
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 36A50CE124A;
	Mon, 11 Mar 2024 18:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A2BC433C7;
	Mon, 11 Mar 2024 18:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182245;
	bh=KK0r7HLEGlnhN25/A0rpX5LySpg3lS7iiWtkuou51PM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dxe+2nDY7YIM4GTeabi7IPTExVCxzl4tizB/HP8eBeyDPntypoqg06mEurUMvSERx
	 GGqzubZdCUkRliD2pmsUsuZyDm3WAAreJQWuPZLwDwmLxNpLZbAGnu5kdlagErnGyl
	 ib+smzLSQu+NeJLHZrZbVEkRYxVTsS2x0gwW+q3vXNbz4TSgPxBctcHO81FW4t8V32
	 Zj0D+ycuH9hjq++XmHZyN9dCp/flXIpwm2ED8oMbWHr+KmC40ujepiyZFBRTv0y9Xx
	 JngDA4lMTmL4+Q3O0VFF8CD3VPwMXIb2qMsnrGWX6z4kQ2QtylZjRXEc2Ep+9612Te
	 BCAOQBuj0FDzw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	patches@opensource.cirrus.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.7 14/14] ASoC: wm8962: Fix up incorrect error
 message in wm8962_set_fll
Date: Mon, 11 Mar 2024 14:36:17 -0400
Message-ID: <20240311183618.327694-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183618.327694-1-sashal@kernel.org>
References: <20240311183618.327694-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 3ALHAL6AJMRRLUJ7O4ZRTBE6QAYQKKPH
X-Message-ID-Hash: 3ALHAL6AJMRRLUJ7O4ZRTBE6QAYQKKPH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3ALHAL6AJMRRLUJ7O4ZRTBE6QAYQKKPH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Stuart Henderson <stuarth@opensource.cirrus.com>

[ Upstream commit 96e202f8c52ac49452f83317cf3b34cd1ad81e18 ]

Use source instead of ret, which seems to be unrelated and will always
be zero.

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Link: https://msgid.link/r/20240306161439.1385643-5-stuarth@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8962.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 2256cc0a37ebd..7c6ed29831285 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2933,7 +2933,7 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 				    WM8962_FLL_FRC_NCO, WM8962_FLL_FRC_NCO);
 		break;
 	default:
-		dev_err(component->dev, "Unknown FLL source %d\n", ret);
+		dev_err(component->dev, "Unknown FLL source %d\n", source);
 		return -EINVAL;
 	}
 
-- 
2.43.0

