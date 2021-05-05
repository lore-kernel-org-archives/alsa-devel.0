Return-Path: <SRS0=SRJ/=KA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7174CC43611
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 16:54:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9875613C9
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 16:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9875613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5890C1756;
	Wed,  5 May 2021 18:54:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5890C1756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620233694;
	bh=fOH8+Z1NGNGOEwSqzcjBU9mOjbTRyXHml1vP4tn/58Y=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F7QQvdHE3DOxFl4yp5wp3Izdhh/vNLBnXxZHWCH9RjTJ8UjwhQUW1uiqbEiHPADfo
	 JwdlgOjf8MLY4zivLHZC3KOzirFaLFBfjL0cbSokS8SCM43/dpd4hDTA5HEWlFtrbz
	 SzKI2LCa5BZQywG4E8AHxlM3ksC6B2Zr3fMa7fk8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3CD17F804B2;
	Wed,  5 May 2021 18:39:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8150F804B2; Wed,  5 May 2021 18:39:05 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 99450F8042F
 for <alsa-devel@alsa-project.org>; Wed,  5 May 2021 18:39:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99450F8042F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ijTaDwzz"
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF25361464;
 Wed,  5 May 2021 16:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620232741;
 bh=fOH8+Z1NGNGOEwSqzcjBU9mOjbTRyXHml1vP4tn/58Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ijTaDwzzBUgaPG4Zh/UShnTIi5mYVLDOU1pmgLKKHe0bpB5meWM7wDFCBLo8gBcm6
 6bFvyQF24i2iXmNu2ORzTdlV5eW/KHLyWYaFp7JoEY/biFwVHnalKohhkCpdZa8V5E
 zRq3C3Q/Nwjag7QotllkKaE61arRqMudJ5oYSG8PwFx1zZeT/sNZxUvAYdy/xTieqj
 SU/Xa7b509T7MQY+Sk52d6SF92zwaThLnQ33ZVbftZFoqtPbVIIK4fZiNn+PfelsU9
 j36WEd3I5Yi+ko76mj3+/atFMRcmIq31Kxoy0une6sU8aRQGhafJaBNmaC8MwHoY4w
 gdeOq6uPj+dvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 03/46] ASoC: Intel: bytcr_rt5640: Enable
 jack-detect support on Asus T100TAF
Date: Wed,  5 May 2021 12:38:13 -0400
Message-Id: <20210505163856.3463279-3-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505163856.3463279-1-sashal@kernel.org>
References: <20210505163856.3463279-1-sashal@kernel.org>
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
index cfd307717473..006cf1e8b602 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -476,6 +476,9 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
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

