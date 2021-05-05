Return-Path: <SRS0=SRJ/=KA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55889C43460
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 16:36:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CABB61928
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 16:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CABB61928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB04916DA;
	Wed,  5 May 2021 18:35:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB04916DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620232577;
	bh=mKkjTfBgYYQuYW9XJMVZqW5OfGH+RE/LXevOvmxnd4I=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A8HD677axGXL1rkiEpm+SFhAYyfX9ZV5aD+e2SciD0QmEuQI/RDZ+WcSzunXsWz6e
	 pADH5qnAfPvjb7hYRL1G67zG8AZHu9ffi41kHkVnly6+XpPi4BmtAH/yyg92u9bWcn
	 QTwrsR66/MU3kDACkxCf5UIIDgcntv0QP9gX30Cs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A5C9FF804E5;
	Wed,  5 May 2021 18:32:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BC676F804E6; Wed,  5 May 2021 18:32:31 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3DC99F804E5
 for <alsa-devel@alsa-project.org>; Wed,  5 May 2021 18:32:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3DC99F804E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="IyBBi1ha"
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC3666140F;
 Wed,  5 May 2021 16:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620232342;
 bh=mKkjTfBgYYQuYW9XJMVZqW5OfGH+RE/LXevOvmxnd4I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IyBBi1haV51XL2nuwE0fw2osfqjWgzXVVE5KmMu/SnvY8J9d3XZbWl+e6wlSCBSgC
 njI+ty/WD0LUt4mr3SKHPSoGUCNVs6Y/8hNnFnKdycwBIF77s+WrIBW+OjVZbGMuOu
 HBP/nqYX+wA8VPSc0pO7USaTbpviVofcccBOdG5txcRTWXt6sBmYMIeoX1gsKiZfZ5
 MW+6pCb1FQ2Omc3zc8T812RO+nPo4gZKj8zwXFyfUU6eAS8i0CG8+Bp1ZbGFcRIgx5
 c1yyO227EPOcEPkTFwy6pXJgo85lQUQLLc6RUB6H0EdxNFgh07ffG8vdsB98dNDnd6
 0PsS3PB20aV/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 042/116] ASoC: rt5670: Add a quirk for the Dell
 Venue 10 Pro 5055
Date: Wed,  5 May 2021 12:30:10 -0400
Message-Id: <20210505163125.3460440-42-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505163125.3460440-1-sashal@kernel.org>
References: <20210505163125.3460440-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 84cb0d5581b6a7bd5d96013f67e9f2eb0c7b4378 ]

Add a quirk with the jack-detect and dmic settings necessary to make
jack-detect and the builtin mic work on Dell Venue 10 Pro 5055 tablets.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20210402140747.174716-5-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5670.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 4063aac2a443..dd69d874bad2 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2980,6 +2980,18 @@ static const struct dmi_system_id dmi_platform_intel_quirks[] = {
 						 RT5670_GPIO1_IS_IRQ |
 						 RT5670_JD_MODE3),
 	},
+	{
+		.callback = rt5670_quirk_cb,
+		.ident = "Dell Venue 10 Pro 5055",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Venue 10 Pro 5055"),
+		},
+		.driver_data = (unsigned long *)(RT5670_DMIC_EN |
+						 RT5670_DMIC2_INR |
+						 RT5670_GPIO1_IS_IRQ |
+						 RT5670_JD_MODE1),
+	},
 	{
 		.callback = rt5670_quirk_cb,
 		.ident = "Aegex 10 tablet (RU2)",
-- 
2.30.2

