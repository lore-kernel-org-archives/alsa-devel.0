Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CC6C4828F
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Feb 2024 21:25:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EFDA4852;
	Wed,  7 Feb 2024 22:25:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EFDA4852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1707341154;
	bh=ZEs2TzHH+d3Wm5jhxzkC1qvnQNqoUe+++fHFK2VxUtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=k4tFANacL4kpeewtg8Pk036yPjIBedJVF7lxwJPcmY8XLFRy7urb9QXd6I8GpQ23X
	 ygGVU9oxGUbnafnZoHUIlLlEbRz6LDAFDsy7AOyD9OWufkZ4OO3w9DBvbP2oFX3tg1
	 N6TzqLc+a+kp1rHx2s6aUEYKHUxdWF6YRWHRy618=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BBE86F805A1; Wed,  7 Feb 2024 22:25:23 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 99512F805A8;
	Wed,  7 Feb 2024 22:25:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6C4C7F801EB; Wed,  7 Feb 2024 22:25:19 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 819DAF8016E
	for <alsa-devel@alsa-project.org>; Wed,  7 Feb 2024 22:25:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 819DAF8016E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Q9NFWHO6
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E3A0F61A30;
	Wed,  7 Feb 2024 21:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439B2C43399;
	Wed,  7 Feb 2024 21:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341115;
	bh=ZEs2TzHH+d3Wm5jhxzkC1qvnQNqoUe+++fHFK2VxUtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9NFWHO6U0iLZf0Uk/Bawq6HOy+QCafe+ptx1iYVGJLpzJvIWEuo5hy3lE97hSNTG
	 Rp2mSNE4VRkEmEc+xXc+xLo9N/WIplWgWGAVI5S1tue1keWuONXS/T21PYt0QxyIiB
	 fxvUwgM9MXx7c1jeb6OQwu1ZLoRECXysfCY80m/NZll3fKTNxNKh4MkZ68DAfVT74e
	 kTyfognxjvAQZE7gt9EkC/b8swNFg+wIai3ngUCZA7UigGBD8Yolu4doivBAGxIpth
	 22vNyv4FALJUtmdfX7Vbao1GJmKyOfC/9+lCdLxWbcvi95Si3rYOkGKjNmQioeh1Oj
	 W2PtSjtmjNHUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	srinivas.kandagatla@linaro.org,
	bgoswami@quicinc.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 06/29] ASoC: codecs: wcd934x: drop unneeded
 regulator include
Date: Wed,  7 Feb 2024 16:24:31 -0500
Message-ID: <20240207212505.3169-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212505.3169-1-sashal@kernel.org>
References: <20240207212505.3169-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
Content-Transfer-Encoding: 8bit
Message-ID-Hash: L7EEOKUMIQQO6ZWEJELYILZI62NEF2Q3
X-Message-ID-Hash: L7EEOKUMIQQO6ZWEJELYILZI62NEF2Q3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/L7EEOKUMIQQO6ZWEJELYILZI62NEF2Q3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 35314e39dabcfb256832654ad0e856a9fba744bd ]

Driver does not use any regulator code, so drop redundant include of
regulator/consumer.h header.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://msgid.link/r/20240117151208.1219755-3-krzysztof.kozlowski@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wcd934x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 0b5999c819db..86d0907a5f97 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -13,7 +13,6 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/slimbus.h>
 #include <sound/pcm_params.h>
-- 
2.43.0

