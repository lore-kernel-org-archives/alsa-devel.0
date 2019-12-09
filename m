Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8241C2D0C6
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 19:31:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B0B02080D
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 19:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oAPOngzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B0B02080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F72C166A;
	Mon,  9 Dec 2019 20:12:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F72C166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575918775;
	bh=NrdlkeNEyv37uoLIMWxD0a+Cq8H3iag1/C5ZPQyRFf0=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=oAPOngzrnQ/R4KsMzha46C41r3fxe5VvxOGqlHiy6rxgqKPkuGJOmyH6t/HeRhrAz
	 2zsSKa5rvEMOfAT3LLHXJ29k+gtGgA83DwuQ1kx2S9JmHCbd7vgQHTUBoZm+nEeO4Y
	 Ui2XlUi59hIeyDRlBXha5NHsXwhxkwmg+7drg3RE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 674A6F80349;
	Mon,  9 Dec 2019 19:59:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F0CBF80321; Mon,  9 Dec 2019 19:59:29 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 2ECE6F80304
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 19:59:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2ECE6F80304
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6975F13A1;
 Mon,  9 Dec 2019 10:59:23 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD8FF3F6CF;
 Mon,  9 Dec 2019 10:59:22 -0800 (PST)
Date: Mon, 09 Dec 2019 18:59:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <20191129132719.11603-1-nikita.yoush@cogentembedded.com>
Message-Id: <applied-20191129132719.11603-1-nikita.yoush@cogentembedded.com>
X-Patchwork-Hint: ignore
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, "Andrew F. Davis" <afd@ti.com>,
 Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Subject: [alsa-devel] Applied "ASoC: tlv320aic31xx: Add Volume Soft Stepping
	control" to the asoc tree
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The patch

   ASoC: tlv320aic31xx: Add Volume Soft Stepping control

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 3176f94c467cf89f74120c34a3ddd9aaf8941be2 Mon Sep 17 00:00:00 2001
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Date: Fri, 29 Nov 2019 16:27:19 +0300
Subject: [PATCH] ASoC: tlv320aic31xx: Add Volume Soft Stepping control

Chip supports soft stepping of volume changes and it is enabled by
default.

This patch adds a control for it, so it could be either made slower
(two sample periods per step instead of one), or disabled.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Link: https://lore.kernel.org/r/20191129132719.11603-1-nikita.yoush@cogentembedded.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 8 ++++++++
 sound/soc/codecs/tlv320aic31xx.h | 3 ---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index d6c462f21370..31daa60695bd 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -275,6 +275,12 @@ static const char * const hp_rampup_step_text[] = {
 static SOC_ENUM_SINGLE_DECL(hp_rampup_step_enum, AIC31XX_HPPOP, 1,
 	hp_rampup_step_text);
 
+static const char * const vol_soft_step_mode_text[] = {
+	"fast", "slow", "disabled" };
+
+static SOC_ENUM_SINGLE_DECL(vol_soft_step_mode_enum, AIC31XX_DACSETUP, 0,
+	vol_soft_step_mode_text);
+
 static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -6350, 50, 0);
 static const DECLARE_TLV_DB_SCALE(adc_fgain_tlv, 0, 10, 0);
 static const DECLARE_TLV_DB_SCALE(adc_cgain_tlv, -2000, 50, 0);
@@ -306,6 +312,8 @@ static const struct snd_kcontrol_new common31xx_snd_controls[] = {
 	 */
 	SOC_ENUM("HP Output Driver Power-On time", hp_poweron_time_enum),
 	SOC_ENUM("HP Output Driver Ramp-up step", hp_rampup_step_enum),
+
+	SOC_ENUM("Volume Soft Stepping", vol_soft_step_mode_enum),
 };
 
 static const struct snd_kcontrol_new aic31xx_snd_controls[] = {
diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index 83a8c7604cc3..0523884cee74 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -218,9 +218,6 @@ struct aic31xx_pdata {
 #define AIC31XX_GPIO1_ADC_MOD_CLK	0x10
 #define AIC31XX_GPIO1_SDOUT		0x11
 
-/* AIC31XX_DACSETUP */
-#define AIC31XX_SOFTSTEP_MASK		GENMASK(1, 0)
-
 /* AIC31XX_DACMUTE */
 #define AIC31XX_DACMUTE_MASK		GENMASK(3, 2)
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
