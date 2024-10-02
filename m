Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF87CF6D2D
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Oct 2024 15:15:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3061D86F;
	Wed,  2 Oct 2024 17:15:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3061D86F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1727882124;
	bh=2UMd8GmskoKqy4N/TkOwVnnjCGhVBuWUY7EHrHnC5UM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=I2VRQP9uSjLTXU7ophDU8Ny1s8B5YFMr3ypW46lXwY9w9Pbg1oiMZqn+TUa1Ejew/
	 TGKEFXfEEiFPiEWH/0RHtuLc3ZKsBrKQpYBzWbyy6ibyA8ph+gfO2iXWlA5ie6lB5m
	 Ja2yiUdsgU/m4G4am7Cj7pFL/2q+/9Im6tFMkkAI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1A197F805AC; Wed,  2 Oct 2024 17:14:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E331F805B5;
	Wed,  2 Oct 2024 17:14:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 86968F80517; Wed,  2 Oct 2024 17:14:46 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AC585F8001E
	for <alsa-devel@alsa-project.org>; Wed,  2 Oct 2024 17:14:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC585F8001E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=J1XuMtHo
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 870FCA43DB0;
	Wed,  2 Oct 2024 15:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30BEC4CEC2;
	Wed,  2 Oct 2024 15:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727882082;
	bh=2UMd8GmskoKqy4N/TkOwVnnjCGhVBuWUY7EHrHnC5UM=;
	h=From:To:Cc:Subject:Date:From;
	b=J1XuMtHoVpDXWG+dyY0I5crIMd79WXCziK1/hmmg4BJWOpM4fJYDVIUDL/Y5ZaZxn
	 3c3s3KqyYm5eKwaMIApqllmhUjJR8t5r9pQxIiaiWN9aeZyaZCIKjYf73PokmtaQqj
	 GGp0Yqg36aPVKfbZOI5WSL4/6pJQMg4WRrUzwbGmGiW5zmVl2q6VvZFyW3zNejY3Yc
	 QdIcCvRwYLVqt8o+SF5/veOUD1xAL20IgGytq3g1zJAsPbrQaNFZHfZ0CBMCGFyHpl
	 19CzOgyM7R/H/YTKaHzQlJ0n8ui92GjSSNerqRpkFlr5watB9KgF1XprF7+x04YfzC
	 8dsHdG5b4mJ0Q==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] ASoC: codecs: wcd9335: remove unnecessary MODULE_ALIAS()
Date: Thu,  3 Oct 2024 00:14:34 +0900
Message-ID: <20241002151436.43684-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 6NUL7I64WL7ABKK426FTWHMWWVIMVBQL
X-Message-ID-Hash: 6NUL7I64WL7ABKK426FTWHMWWVIMVBQL
X-MailFrom: masahiroy@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6NUL7I64WL7ABKK426FTWHMWWVIMVBQL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Since commit b4b818305578 ("slimbus: generate MODULE_ALIAS() from
MODULE_DEVICE_TABLE()"), modpost automatically generates MODULE_ALIAS()
from MODULE_DEVICE_TABLE(slim, ).

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 sound/soc/codecs/wcd9335.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 373a31ddccb2..a2521e16c099 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -5177,4 +5177,3 @@ static struct slim_driver wcd9335_slim_driver = {
 module_slim_driver(wcd9335_slim_driver);
 MODULE_DESCRIPTION("WCD9335 slim driver");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("slim:217:1a0:*");
-- 
2.43.0

