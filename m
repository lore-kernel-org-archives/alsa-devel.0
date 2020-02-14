Return-Path: <SRS0=Q+Fc=4C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916E5C2BA83
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:56:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20B002187F
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EJqi1MkI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSu8di0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B002187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 69D871697;
	Fri, 14 Feb 2020 16:55:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 69D871697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581695778;
	bh=YP4YI9+Bse5nrhbaSfpyaXQlwOZ49cneDGZfsbfw8OM=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EJqi1MkIznKHimE/0/8LfMyVv3Q5cBk6A60snq1/Kf6yBIe2HlOaWHOVKrUlACiRY
	 YvjzsvD59+rvYxHqOe7s8dQFNcz9NJK+qtPhPMbEDy5lwq0O/fm2SqMKZXWhEtOM/x
	 2rsLGiZg7xwBMbJciRbCGFfpk651FFAieRfzSLmk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B1C2CF80158;
	Fri, 14 Feb 2020 16:54:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 62AA3F8019B; Fri, 14 Feb 2020 16:54:38 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6DFC0F8014F
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2020 16:54:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6DFC0F8014F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="XSu8di0J"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BC270222C4;
 Fri, 14 Feb 2020 15:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581695673;
 bh=BMSj3i+Zs6AHfdEoKpkr+5pJSuTkEp65CL/I5pXfE30=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XSu8di0JnhYlh1SBQhs6NLHue/AsXLF8HKyUUprOAv0ndit8VpImYH0Rilj0ld9k1
 7ofH1uHeI0PpC/FtRW2lXmLXv6R9PEt2Aige31bCrYRC/rZARvOonqG+pkZIpKS+Qj
 9/V0kiWQ/dB/t6bnd475xQY2V6d03eSmzXc0v+lA=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Fri, 14 Feb 2020 10:44:13 -0500
Message-Id: <20200214154854.6746-261-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, Hulk Robot <hulkci@huawei.com>,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 YueHaibing <yuehaibing@huawei.com>
Subject: [alsa-devel] [PATCH AUTOSEL 5.5 261/542] ASoC: Intel:
	kbl_da7219_max98357a: remove unused variable
	'constraints_16000' and 'ch_mono'
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit c5614fb8e3d13be7bba79f71b798468a3a6224f7 ]

sound/soc/intel/boards/kbl_da7219_max98357a.c:343:48:
 warning: constraints_16000 defined but not used [-Wunused-const-variable=]
sound/soc/intel/boards/kbl_da7219_max98357a.c:348:27:
 warning: ch_mono defined but not used [-Wunused-const-variable=]

They are never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20191224140237.36732-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/kbl_da7219_max98357a.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c b/sound/soc/intel/boards/kbl_da7219_max98357a.c
index 537a88932bb69..0d55319a0773c 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98357a.c
@@ -336,19 +336,6 @@ static struct snd_soc_ops kabylake_dmic_ops = {
 	.startup = kabylake_dmic_startup,
 };
 
-static const unsigned int rates_16000[] = {
-	16000,
-};
-
-static const struct snd_pcm_hw_constraint_list constraints_16000 = {
-	.count = ARRAY_SIZE(rates_16000),
-	.list  = rates_16000,
-};
-
-static const unsigned int ch_mono[] = {
-	1,
-};
-
 SND_SOC_DAILINK_DEF(dummy,
 	DAILINK_COMP_ARRAY(COMP_DUMMY()));
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
