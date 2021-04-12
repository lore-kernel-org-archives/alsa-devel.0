Return-Path: <SRS0=Xjxi=JJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033BCC433B4
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Apr 2021 16:25:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A4161399
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Apr 2021 16:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A4161399
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 80E401680;
	Mon, 12 Apr 2021 18:25:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 80E401680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618244752;
	bh=BoVdH6KrJri0ZVRqOkfW+M41yFN1y391Hopf2LtxxdQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cP39U8O3aafTK04nd23o4bGhLtsQovxyRHfGRY9AxBHIWcfpqgBWpuq0kaCIbIKtG
	 AdPGvcAufvS9UskFhPcCNpSxzqOdDhknDGih0pkkv6Lq5fp6zCN2QCrkSc6rlbaI49
	 lYtYxwl2Z99Xkgr5RYyaDCGvnanK2wn82jWQ+mes=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CE15FF8032D;
	Mon, 12 Apr 2021 18:24:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED31DF80425; Mon, 12 Apr 2021 18:24:22 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D539DF80423
 for <alsa-devel@alsa-project.org>; Mon, 12 Apr 2021 18:24:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D539DF80423
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="sX5pShDM"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6977661366;
 Mon, 12 Apr 2021 16:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618244657;
 bh=BoVdH6KrJri0ZVRqOkfW+M41yFN1y391Hopf2LtxxdQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sX5pShDMMpagXKRZfsMgmEXXnHho11sWspVvqEWKdHA8dA83HmDv8s/Le4fra2jB0
 R4q9zwewOQXlSxf4z90Ut4AyJBY6bCH0WBX3EXfjEsG1llK3jLcs6Ee7mxj/ETL0p7
 fnc4FUXhd40XElRzXIqlpL0OB+boxs9sxGucR1i5gsdK2Lpnbmdbv+nynYm1uJc2iI
 xwbQNqM+GcUhheBBJzJGGtWWJYdZoXjJJQeenhJowWElSZZf+5Q0XaMe2WZvPdzqkY
 7Snrc1SV8Ug4dGSGKWV4hVCHmg1PdBe2vNv83cbuXZfD8H/NuaOX4NpEVy+RH8ljaM
 7eLEg1FnJK4Lw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 12/46] ASoC: max98373: Changed amp shutdown
 register as volatile
Date: Mon, 12 Apr 2021 12:23:27 -0400
Message-Id: <20210412162401.314035-12-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210412162401.314035-1-sashal@kernel.org>
References: <20210412162401.314035-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Ryan Lee <ryans.lee@maximintegrated.com>
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

From: Ryan Lee <ryans.lee@maximintegrated.com>

[ Upstream commit a23f9099ff1541f15704e96b784d3846d2a4483d ]

0x20FF(amp global enable) register was defined as non-volatile,
but it is not. Overheating, overcurrent can cause amp shutdown
in hardware.
'regmap_write' compare register readback value before writing
to avoid same value writing. 'regmap_read' just read cache
not actual hardware value for the non-volatile register.
When amp is internally shutdown by some reason, next 'AMP ON'
command can be ignored because regmap think amp is already ON.

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Link: https://lore.kernel.org/r/20210325033555.29377-1-ryans.lee@maximintegrated.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/max98373-i2c.c | 1 +
 sound/soc/codecs/max98373-sdw.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/soc/codecs/max98373-i2c.c b/sound/soc/codecs/max98373-i2c.c
index 92921e34f948..32b0c1d98365 100644
--- a/sound/soc/codecs/max98373-i2c.c
+++ b/sound/soc/codecs/max98373-i2c.c
@@ -440,6 +440,7 @@ static bool max98373_volatile_reg(struct device *dev, unsigned int reg)
 	case MAX98373_R2054_MEAS_ADC_PVDD_CH_READBACK:
 	case MAX98373_R2055_MEAS_ADC_THERM_CH_READBACK:
 	case MAX98373_R20B6_BDE_CUR_STATE_READBACK:
+	case MAX98373_R20FF_GLOBAL_SHDN:
 	case MAX98373_R21FF_REV_ID:
 		return true;
 	default:
diff --git a/sound/soc/codecs/max98373-sdw.c b/sound/soc/codecs/max98373-sdw.c
index fa589d834f9a..14fd2f9a0bf3 100644
--- a/sound/soc/codecs/max98373-sdw.c
+++ b/sound/soc/codecs/max98373-sdw.c
@@ -214,6 +214,7 @@ static bool max98373_volatile_reg(struct device *dev, unsigned int reg)
 	case MAX98373_R2054_MEAS_ADC_PVDD_CH_READBACK:
 	case MAX98373_R2055_MEAS_ADC_THERM_CH_READBACK:
 	case MAX98373_R20B6_BDE_CUR_STATE_READBACK:
+	case MAX98373_R20FF_GLOBAL_SHDN:
 	case MAX98373_R21FF_REV_ID:
 	/* SoundWire Control Port Registers */
 	case MAX98373_R0040_SCP_INIT_STAT_1 ... MAX98373_R0070_SCP_FRAME_CTLR:
-- 
2.30.2

