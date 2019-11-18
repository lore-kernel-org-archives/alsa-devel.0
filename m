Return-Path: <SRS0=vuHx=ZK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B050C432C0
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Nov 2019 13:05:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B62EB20692
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Nov 2019 13:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="O5DqqWDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B62EB20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DCA771698;
	Mon, 18 Nov 2019 14:04:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DCA771698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574082308;
	bh=8xK2c+I53yfIn6Q6fOPs8+cAgbnhUIBEIs0aS8Q7z4U=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=O5DqqWDYEoj0+iiRQ53gx8Ag0mQSBuetr/xrBPVEWZbQ0pXJ7xiMN2qZ1vSDBCaZG
	 LbQxcMqEkDq768G1quJK1YdEX0vf3aQLufoF2Sue1NXXpJi9YdSzpFYb976HPIRLOQ
	 XEErbI8IV1TJThKR4cyEbE9rjTlEQpat8E2MILck=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A9CCF801DB;
	Mon, 18 Nov 2019 14:00:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6F155F801ED; Mon, 18 Nov 2019 14:00:52 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 874DCF801DA
 for <alsa-devel@alsa-project.org>; Mon, 18 Nov 2019 14:00:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 874DCF801DA
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B162A113E;
 Mon, 18 Nov 2019 05:00:48 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F0403F6C4;
 Mon, 18 Nov 2019 05:00:47 -0800 (PST)
Date: Mon, 18 Nov 2019 13:00:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Shuming Fan <shumingf@realtek.com>
In-Reply-To: <20191118091624.18699-1-shumingf@realtek.com>
X-Patchwork-Hint: ignore
Message-Id: <20191118130052.6F155F801ED@alsa1.perex.cz>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, lgirdwood@gmail.com, albertchen@realtek.com,
 Mark Brown <broonie@kernel.org>, alexlee@realtek.com, derek.fang@realtek.com,
 flove@realtek.com
Subject: [alsa-devel] Applied "ASoC: rt5682: fix the charge pump capacitor
	discharges" to the asoc tree
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

   ASoC: rt5682: fix the charge pump capacitor discharges

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

From 44d13f6c2a0b739a7c4df3c478c8070320c4fd45 Mon Sep 17 00:00:00 2001
From: Shuming Fan <shumingf@realtek.com>
Date: Mon, 18 Nov 2019 17:16:24 +0800
Subject: [PATCH] ASoC: rt5682: fix the charge pump capacitor discharges

Due to switching the HV to LV mode while stopping playback,
the charge pump capacitor will be discharged to the source of the pump circuit.
Therefore, this patch removed the event control.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Link: https://lore.kernel.org/r/20191118091624.18699-1-shumingf@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5682.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 62b8ed412bd1..5370e4b00104 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -1451,28 +1451,6 @@ static const struct snd_kcontrol_new hpor_switch =
 	SOC_DAPM_SINGLE_AUTODISABLE("Switch", RT5682_HP_CTRL_1,
 					RT5682_R_MUTE_SFT, 1, 1);
 
-static int rt5682_charge_pump_event(struct snd_soc_dapm_widget *w,
-	struct snd_kcontrol *kcontrol, int event)
-{
-	struct snd_soc_component *component =
-		snd_soc_dapm_to_component(w->dapm);
-
-	switch (event) {
-	case SND_SOC_DAPM_PRE_PMU:
-		snd_soc_component_update_bits(component,
-			RT5682_HP_CHARGE_PUMP_1, RT5682_PM_HP_MASK, RT5682_PM_HP_HV);
-		break;
-	case SND_SOC_DAPM_POST_PMD:
-		snd_soc_component_update_bits(component,
-			RT5682_HP_CHARGE_PUMP_1, RT5682_PM_HP_MASK, RT5682_PM_HP_LV);
-		break;
-	default:
-		return 0;
-	}
-
-	return 0;
-}
-
 static int rt5682_hp_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
@@ -1756,8 +1734,7 @@ static const struct snd_soc_dapm_widget rt5682_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("HP Amp R", RT5682_PWR_ANLG_1,
 		RT5682_PWR_HA_R_BIT, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY_S("Charge Pump", 1, RT5682_DEPOP_1,
-		RT5682_PUMP_EN_SFT, 0, rt5682_charge_pump_event,
-		SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+		RT5682_PUMP_EN_SFT, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY_S("Capless", 2, RT5682_DEPOP_1,
 		RT5682_CAPLESS_EN_SFT, 0, NULL, 0),
 
@@ -2655,6 +2632,8 @@ static int rt5682_i2c_probe(struct i2c_client *i2c,
 			RT5682_HPA_CP_BIAS_CTRL_MASK, RT5682_HPA_CP_BIAS_3UA);
 	regmap_update_bits(rt5682->regmap, RT5682_CHARGE_PUMP_1,
 			RT5682_CP_CLK_HP_MASK, RT5682_CP_CLK_HP_300KHZ);
+	regmap_update_bits(rt5682->regmap, RT5682_HP_CHARGE_PUMP_1,
+			RT5682_PM_HP_MASK, RT5682_PM_HP_HV);
 
 	INIT_DELAYED_WORK(&rt5682->jack_detect_work,
 				rt5682_jack_detect_handler);
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
