Return-Path: <SRS0=SRJ/=KA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240BBC43461
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 16:35:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7239361431
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 16:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7239361431
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED44B16E5;
	Wed,  5 May 2021 18:34:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED44B16E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620232548;
	bh=CpMLuKEHmCPFgmTnqBs9Eca2QVcKDVmDMdrnazBcf/M=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NvgFbL33ZulV/mT2cWQaV7VoLXEzl/9g/ic8lm3Poq3lAsDcbH7x868+Lnf3+4Anr
	 mAtpZ5lIUxvoWGk76wz/AyOfDEBLCQJGVPo9/KeJ9KoLNFG+mxXmY9xL0hQYnE2vgZ
	 BhfTpoHg1xcjwgllTPP76Pt+rrhHP2tdeCd+Nd/w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 19814F804E2;
	Wed,  5 May 2021 18:32:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7CE09F804E3; Wed,  5 May 2021 18:32:20 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0764CF804E1
 for <alsa-devel@alsa-project.org>; Wed,  5 May 2021 18:32:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0764CF804E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="dW9db7N7"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6AE861412;
 Wed,  5 May 2021 16:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620232335;
 bh=CpMLuKEHmCPFgmTnqBs9Eca2QVcKDVmDMdrnazBcf/M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dW9db7N7mbzPNj9ex4zicHHMqyW5w7eopmHwu24X24MTzH5zs+yfEy1MDJfpqoH92
 HrFVoB3axXApPJsK7enxuF0N5R4GWmzCj1hirdeuqnkgrjseGVbezgcXb94X8TiuWr
 8Ms6jnpELnBi8MewxexKLzPuxXdC9HTGGHbRUD+GnaU/u98YOAo1VcTsyag7uGzU57
 a4Bx26FvIHCp7a+wtSMQvcOxogYxoKVjeIXB3S7Eep6XycXVpPukV5mlU8ql0792b4
 xdOKxsrl6wMl07NAHx2xeE7US44FqfZAjl2I8ovfJ99k+Wl3sakqMFd65qBKYu3+QE
 4Lxy+iNomzM6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 037/116] ASoC: Intel: bytcr_rt5640: Add quirk for
 the Chuwi Hi8 tablet
Date: Wed,  5 May 2021 12:30:05 -0400
Message-Id: <20210505163125.3460440-37-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505163125.3460440-1-sashal@kernel.org>
References: <20210505163125.3460440-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
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

[ Upstream commit 875c40eadf6ac6644c0f71842a4f30dd9968d281 ]

The Chuwi Hi8 tablet is using an analog mic on IN1 and has its
jack-detect connected to JD2_IN4N, instead of using the default
IN3 for its internal mic and JD1_IN4P for jack-detect.

It also only has 1 speaker.

Add a quirk applying the correct settings for this configuration.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20210325221054.22714-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 19faababb78d..22912cab5e63 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -518,6 +518,23 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF1 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{
+		/* Chuwi Hi8 (CWI509) */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
+			DMI_MATCH(DMI_BOARD_NAME, "BYT-PA03C"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ilife"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "S806"),
+		},
+		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
+					BYT_RT5640_JD_SRC_JD2_IN4N |
+					BYT_RT5640_OVCD_TH_2000UA |
+					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_MONO_SPEAKER |
+					BYT_RT5640_DIFF_MIC |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Circuitco"),
-- 
2.30.2

