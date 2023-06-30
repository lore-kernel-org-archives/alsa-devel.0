Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F6CEB64DC
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Jul 2023 08:34:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 54DF3846;
	Mon,  3 Jul 2023 10:33:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 54DF3846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688373248;
	bh=NRFErKcwJ/XzcSK0nLh18CLPEbv6pza++M+LD175n/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nvgrbMd+EUgFBY/ENLSVYctl0UvSUXmuUk/5fuBGHW5BzImN+pP0U6rSHlirjNlEx
	 BSSZIQLHtLEqnAejj3aUSegZl//UjjGBOtXCaD3i7xRq+TC42Ktu6+7tVyOjvw5snq
	 KTOhJuz8lSJpOWx+GPjpv4OctOiXrc7PRYuzL/WQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 29FAEF80557; Mon,  3 Jul 2023 10:32:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 449CBF80549;
	Mon,  3 Jul 2023 10:32:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 291E4F80535; Fri, 30 Jun 2023 16:27:28 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AE24DF8027B
	for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2023 16:27:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AE24DF8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Rp+wfgt/
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4617661761;
	Fri, 30 Jun 2023 14:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB990C433CC;
	Fri, 30 Jun 2023 14:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688135238;
	bh=NRFErKcwJ/XzcSK0nLh18CLPEbv6pza++M+LD175n/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rp+wfgt/fmfucldMXsQFVG5qrpdRwt2MhBa4hhvoo9tTSd9s8F6S09guVvviSPh/b
	 bvOMCWwmWygIQDX8yK6ABQIriIUp8fSs+G96HhRVrxiNbzy/Jzjym4F4HEXRvJr38o
	 gC1AOgAl0g1w86zqKQY7JJuc/k18l98/0N+CmP+cNX7oB5wTM7wwvtQEAtZD/9Ir5F
	 mGDRP0qyjIWKfFkJ2vWj9TyXN7gTh5by1Z+O3tZKJQKV65lK9/L+Zc2tQgIUr1nrKA
	 YXv08G+0rd0aWGx3sd2Nr0LQsBCE87E0E+qlvOnS2I9yA/SEKhID5PrCkmf02qkMXs
	 Mrgz7snhumXqQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1qFF5p-0001O7-8o; Fri, 30 Jun 2023 16:27:25 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/5] ASoC: codecs: wcd938x: fix mbhc impedance loglevel
Date: Fri, 30 Jun 2023 16:27:13 +0200
Message-Id: <20230630142717.5314-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230630142717.5314-1-johan+linaro@kernel.org>
References: <20230630142717.5314-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: johan+linaro@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: ABST7UQIUJH6FIFAE5TKBXAOKWUBWEPF
X-Message-ID-Hash: ABST7UQIUJH6FIFAE5TKBXAOKWUBWEPF
X-Mailman-Approved-At: Mon, 03 Jul 2023 08:32:22 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ABST7UQIUJH6FIFAE5TKBXAOKWUBWEPF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Demote the MBHC impedance measurement printk, which is not an error
message, from error to debug level.

While at it, fix the capitalisation of "ohm" and add the missing space
before the opening parenthesis.

Fixes: bcee7ed09b8e ("ASoC: codecs: wcd938x: add Multi Button Headset Control support")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/wcd938x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index e3ae4fb2c4db..b8a52a1a63d5 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -2165,8 +2165,8 @@ static inline void wcd938x_mbhc_get_result_params(struct wcd938x_priv *wcd938x,
 	else if (x1 < minCode_param[noff])
 		*zdet = WCD938X_ZDET_FLOATING_IMPEDANCE;
 
-	pr_err("%s: d1=%d, c1=%d, x1=0x%x, z_val=%d(milliOhm)\n",
-		__func__, d1, c1, x1, *zdet);
+	pr_debug("%s: d1=%d, c1=%d, x1=0x%x, z_val=%d (milliohm)\n",
+		 __func__, d1, c1, x1, *zdet);
 ramp_down:
 	i = 0;
 	while (x1) {
-- 
2.39.3

