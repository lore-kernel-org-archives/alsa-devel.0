Return-Path: <SRS0=BjaJ=H2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FF8C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Feb 2021 12:56:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 156E564FBF
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Feb 2021 12:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156E564FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 60D4C167E;
	Wed, 24 Feb 2021 13:55:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 60D4C167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614171389;
	bh=Ng1Qnl2gKN79P81i6NNXVSpi4OjF2Fsoe904CDvuuTM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L0INhiLeZGWXdrGEypOIvM82xKC/v+S3FnpLbaxWPLgpvSef6PD/2yuXACcutHPQl
	 55xkFvuhUOAATpkFZ+wtGOxyBs9vN8vmSze/nyNhdJJtKnPFeLhKfPtsohP5OhBVf9
	 oWe9Kx48ftcurxAnuq83TAGJ+TZtBOGJ8Ml0AAvU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ED27BF804EB;
	Wed, 24 Feb 2021 13:52:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 89F31F804E1; Wed, 24 Feb 2021 13:52:00 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EE961F804AB
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2021 13:51:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EE961F804AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="dl4bPxCc"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DF4364F39;
 Wed, 24 Feb 2021 12:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614171116;
 bh=Ng1Qnl2gKN79P81i6NNXVSpi4OjF2Fsoe904CDvuuTM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dl4bPxCcx9QmJC9scUIS7SuNsPtMgq+wnn1nTh1w+qPsKnhGvJIPqWdQBNrCWp/Xl
 A2FcgxxRjHU5xnB8LvwKJdw4eI0CzjnYC46QZNte9Soll0TGAy1380SG3QlpZKtRgg
 uT19X08C01uwmfUkmF52ksElGT+Wpyf//oDdkE6IfXtqFot79m9y0fBPWgGlNceN9l
 HWiLxcnTYKwQYZlAYRGExT37MxCjjnJFOD0I6ekDEDOM/PPgeCvqmUOQ4M3tGGapH2
 6T2ZyFREQFpy9kYkz1zb0Esr1rWuYnQar/G12N2GIzIJ1Ib7tERTGUoSUhIhrINw1I
 6Z7tep7WrIMCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 67/67] ASoC: Intel: bytcr_rt5640: Add quirk for
 the Acer One S1002 tablet
Date: Wed, 24 Feb 2021 07:50:25 -0500
Message-Id: <20210224125026.481804-67-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210224125026.481804-1-sashal@kernel.org>
References: <20210224125026.481804-1-sashal@kernel.org>
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

[ Upstream commit c58947af08aedbdee0fce5ea6e6bf3e488ae0e2c ]

The Acer One S1002 tablet is using an analog mic on IN1 and has
its jack-detect connected to JD2_IN4N, instead of using the default
IN3 for its internal mic and JD1_IN4P for jack-detect.

Note it is also using AIF2 instead of AIF1 which is somewhat unusual,
this is correctly advertised in the ACPI CHAN package, so the speakers
do work without the quirk.

Add a quirk for the mic and jack-detect settings.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20210216213555.36555-5-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index ba8ea651a22e6..f00d4e417b6cf 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -402,6 +402,19 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF1 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{	/* Acer One 10 S1002 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "One S1002"),
+		},
+		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
+					BYT_RT5640_JD_SRC_JD2_IN4N |
+					BYT_RT5640_OVCD_TH_2000UA |
+					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_DIFF_MIC |
+					BYT_RT5640_SSP0_AIF2 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-- 
2.27.0

