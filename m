Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBD7D32D8B
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2024 10:39:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E499B22C9;
	Tue, 12 Nov 2024 11:39:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E499B22C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1731407960;
	bh=P/cWhJSzT3puwSZtlig6ZrMwW8z69zWDYWcHupE6Rt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Z0MIXG8uXa3+JPJL/5/KgdfPKFBLa9ouqxpbgVP3Rj6ptzu2N08Imf3BI62AZsS6w
	 VdrnER8qQbL19W2rbnPWW1deG34IZlT4Q5YUwi+Q3bfCJxTnAv63wKMv65MICjGeDB
	 aVXvyLfhzV5l1EQSAl6uKt4mpDOcmNswtM/O8Vew=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 68ADCF8068E; Tue, 12 Nov 2024 11:37:48 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C1612F80691;
	Tue, 12 Nov 2024 11:37:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 08717F805AF; Tue, 12 Nov 2024 11:37:42 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4259AF8058C
	for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2024 11:37:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4259AF8058C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=aXCskZvc
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1EB3E5C5409;
	Tue, 12 Nov 2024 10:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA76C4CECD;
	Tue, 12 Nov 2024 10:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407858;
	bh=P/cWhJSzT3puwSZtlig6ZrMwW8z69zWDYWcHupE6Rt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aXCskZvcklrVg6zOgYlnxaT9bxAabnQfXkFIXICfqH1LiqjQ58XURu8aZ4pUaDiD3
	 YMHP/2z9Ws9IfMp/xKD/WLrue7fyGquY9LrCFTTbL50v7c7f+vfUmUps5ZdfSx2EQR
	 DJ4jbp6rCfHqJQtyRHO/+MUJxfnifaVhYtQ7RP3DoZGFKAAMPDnd929zqAmQg72qKF
	 pwFT5p2Blnd4uRLjF0OzVh6AyTAv/9KGL4l7RiJBhnsP6mn/GZ9gGv4y92/S3ksFXF
	 1L3o1PxQObNMUr5H66gBaH0dSl98Efq5Eqnw66fKvn46vMhhiOL3Clqj8eB8su9Xbs
	 I3otYSaQ0AuEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luo Yifan <luoyifan@cmss.chinamobile.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	arnaud.pouliquen@foss.st.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 10/12] ASoC: stm: Prevent potential division by
 zero in stm32_sai_get_clk_div()
Date: Tue, 12 Nov 2024 05:37:12 -0500
Message-ID: <20241112103718.1653723-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103718.1653723-1-sashal@kernel.org>
References: <20241112103718.1653723-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.116
Content-Transfer-Encoding: 8bit
Message-ID-Hash: XXNNBURDXS7PNYPMSB5PVYO23AS2VRBN
X-Message-ID-Hash: XXNNBURDXS7PNYPMSB5PVYO23AS2VRBN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XXNNBURDXS7PNYPMSB5PVYO23AS2VRBN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Luo Yifan <luoyifan@cmss.chinamobile.com>

[ Upstream commit 23569c8b314925bdb70dd1a7b63cfe6100868315 ]

This patch checks if div is less than or equal to zero (div <= 0). If
div is zero or negative, the function returns -EINVAL, ensuring the
division operation is safe to perform.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
Reviewed-by: Olivier Moysan <olivier.moysan@foss.st.com>
Link: https://patch.msgid.link/20241107015936.211902-1-luoyifan@cmss.chinamobile.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 3d237f75e81f5..0629aa5f2fe4b 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -317,7 +317,7 @@ static int stm32_sai_get_clk_div(struct stm32_sai_sub_data *sai,
 	int div;
 
 	div = DIV_ROUND_CLOSEST(input_rate, output_rate);
-	if (div > SAI_XCR1_MCKDIV_MAX(version)) {
+	if (div > SAI_XCR1_MCKDIV_MAX(version) || div <= 0) {
 		dev_err(&sai->pdev->dev, "Divider %d out of range\n", div);
 		return -EINVAL;
 	}
-- 
2.43.0

