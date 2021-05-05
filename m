Return-Path: <SRS0=SRJ/=KA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3278C433ED
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 16:33:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A42A761460
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 16:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42A761460
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DD92116BC;
	Wed,  5 May 2021 18:32:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DD92116BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620232401;
	bh=Rns+1bNxYcD0ifBOCha6MGvXKC1aHYbsZJ5327dThkM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MfK46+8HauAz24BPBC/wNogiDqAClaxGUjFi56UMm7zeB/aTidYtYYSGXyasTBIAg
	 ahPQqDxYWyHi9V0TBHjgzokr0ZD4pGe+qZ+SoHCd0XVPwcmKjHh9V0ZxYcM2W9lxlg
	 nOQAiMXWIA5FgzC9TMXQsnnYXNyCjJKExuuEBhFs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F4AEF8026D;
	Wed,  5 May 2021 18:31:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BF063F80279; Wed,  5 May 2021 18:31:49 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6747EF8025F
 for <alsa-devel@alsa-project.org>; Wed,  5 May 2021 18:31:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6747EF8025F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="CgwutEx6"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78474613ED;
 Wed,  5 May 2021 16:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620232301;
 bh=Rns+1bNxYcD0ifBOCha6MGvXKC1aHYbsZJ5327dThkM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CgwutEx6W9BvDG/PTuSKSVYtPoBaoWyexdPf/Y6CJszvFee5RG4JQmBSfwQFTJiR8
 vPU35+GQHIOUh94TaAovoldLjLqAgroey6zm/4weBt2RGRHiIywNvk2KLAh/N44+bm
 SGyA9in3OXAhHaOSwcSl8ti/2mJv38ok4WgCo14+Pgg27D8Z5jTl4DCDgFqCXwTqlN
 /SyPZj1hHtsvv0IZDBorfHokFEi4wV7lydjtHQlWqYc7abZ7oTtAxil83dUb5ZEgzP
 HD7oScqDbmoqn0BzzbcbPoOOyeSajQAvrbqir5XMFtH+SMEp0eyikAUfnTKu28+cPU
 fJY1hVOP8GD8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 012/116] ASoC: Intel: bytcr_rt5640: Enable
 jack-detect support on Asus T100TAF
Date: Wed,  5 May 2021 12:29:40 -0400
Message-Id: <20210505163125.3460440-12-sashal@kernel.org>
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

[ Upstream commit b7c7203a1f751348f35fc4bcb157572d303f7573 ]

The Asus T100TAF uses the same jack-detect settings as the T100TA,
this has been confirmed on actual hardware.

Add these settings to the T100TAF quirks to enable jack-detect support
on the T100TAF.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20210312114850.13832-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 5d48cc359c3d..19faababb78d 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -482,6 +482,9 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TAF"),
 		},
 		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
+					BYT_RT5640_JD_SRC_JD2_IN4N |
+					BYT_RT5640_OVCD_TH_2000UA |
+					BYT_RT5640_OVCD_SF_0P75 |
 					BYT_RT5640_MONO_SPEAKER |
 					BYT_RT5640_DIFF_MIC |
 					BYT_RT5640_SSP0_AIF2 |
-- 
2.30.2

