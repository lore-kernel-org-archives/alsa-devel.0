Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18451C2D0C5
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 19:26:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DF6B24686
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 19:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kPCqnGaZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF6B24686
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 125EE1672;
	Mon,  9 Dec 2019 20:06:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 125EE1672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575918454;
	bh=Sqf3t5FXxBoPU0YSix+jyMMiQ1bpP3bciagFIV69Xps=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=kPCqnGaZoMMvkqOSWotJotZSNOS1Slek98mwIFinkkmn4TdzMQNWBrq+4iCG4hUJp
	 svzd1EybWkL6QkPlFIL9blvRyfs5X8iAH6GtVm+S6MmlD3dPz/yOBJKRBJunLaht7m
	 Njwh2Hay6K8ewtVEx9M7uYHj4o3LcNTxphU2eYHo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70778F802F7;
	Mon,  9 Dec 2019 19:59:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 36959F8029B; Mon,  9 Dec 2019 19:59:09 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 4231BF8028E
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 19:59:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4231BF8028E
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B848511D4;
 Mon,  9 Dec 2019 10:59:03 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37E293F6CF;
 Mon,  9 Dec 2019 10:59:03 -0800 (PST)
Date: Mon, 09 Dec 2019 18:59:01 +0000
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20191204211556.12671-3-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20191204211556.12671-3-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] Applied "ASoC: Intel - use control components to
	describe card config" to the asoc tree
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

   ASoC: Intel - use control components to describe card config

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

From 0d5c8187562848b619a35f2ffc5e18ce703e9f3d Mon Sep 17 00:00:00 2001
From: Jaroslav Kysela <perex@perex.cz>
Date: Wed, 4 Dec 2019 15:15:45 -0600
Subject: [PATCH] ASoC: Intel - use control components to describe card config

Use the control interface (field 'components' in the info structure)
to pass the I/O configuration details. The goal is to replace
the card long name with this.

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20191204211556.12671-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcht_es8316.c |  9 ++++++++-
 sound/soc/intel/boards/bytcr_rt5640.c  |  6 ++++++
 sound/soc/intel/boards/bytcr_rt5651.c  | 18 +++++++++++-------
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 46612331f5ea..efa33f30dcac 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -361,6 +361,7 @@ static struct snd_soc_dai_link byt_cht_es8316_dais[] = {
 /* SoC card */
 static char codec_name[SND_ACPI_I2C_ID_LEN];
 static char long_name[50]; /* = "bytcht-es8316-*-spk-*-mic" */
+static char components_string[32]; /* = "cfg-spk:* cfg-mic:* */
 
 static int byt_cht_es8316_suspend(struct snd_soc_card *card)
 {
@@ -572,11 +573,17 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 		}
 	}
 
-	/* register the soc card */
+	snprintf(components_string, sizeof(components_string),
+		 "cfg-spk:%s cfg-mic:%s",
+		 (quirk & BYT_CHT_ES8316_MONO_SPEAKER) ? "1" : "2",
+		 mic_name[BYT_CHT_ES8316_MAP(quirk)]);
+	byt_cht_es8316_card.components = components_string;
 	snprintf(long_name, sizeof(long_name), "bytcht-es8316-%s-spk-%s-mic",
 		 (quirk & BYT_CHT_ES8316_MONO_SPEAKER) ? "mono" : "stereo",
 		 mic_name[BYT_CHT_ES8316_MAP(quirk)]);
 	byt_cht_es8316_card.long_name = long_name;
+
+	/* register the soc card */
 	snd_soc_card_set_drvdata(&byt_cht_es8316_card, priv);
 
 	ret = devm_snd_soc_register_card(dev, &byt_cht_es8316_card);
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index dd2b5ad08659..7bc6d3cec94c 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -1083,6 +1083,7 @@ static char byt_rt5640_codec_name[SND_ACPI_I2C_ID_LEN];
 static char byt_rt5640_codec_aif_name[12]; /*  = "rt5640-aif[1|2]" */
 static char byt_rt5640_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
 static char byt_rt5640_long_name[40]; /* = "bytcr-rt5640-*-spk-*-mic" */
+static char byt_rt5640_components[32]; /* = "cfg-spk:* cfg-mic:*" */
 
 static int byt_rt5640_suspend(struct snd_soc_card *card)
 {
@@ -1305,6 +1306,11 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		}
 	}
 
+	snprintf(byt_rt5640_components, sizeof(byt_rt5640_components),
+		 "cfg-spk:%s cfg-mic:%s",
+		 (byt_rt5640_quirk & BYT_RT5640_MONO_SPEAKER) ? "1" : "2",
+		 map_name[BYT_RT5640_MAP(byt_rt5640_quirk)]);
+	byt_rt5640_card.components = byt_rt5640_components;
 	snprintf(byt_rt5640_long_name, sizeof(byt_rt5640_long_name),
 		 "bytcr-rt5640-%s-spk-%s-mic",
 		 (byt_rt5640_quirk & BYT_RT5640_MONO_SPEAKER) ?
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 4606f6f582d6..80a5674ddb1b 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -798,6 +798,7 @@ static char byt_rt5651_codec_name[SND_ACPI_I2C_ID_LEN];
 static char byt_rt5651_codec_aif_name[12]; /*  = "rt5651-aif[1|2]" */
 static char byt_rt5651_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
 static char byt_rt5651_long_name[50]; /* = "bytcr-rt5651-*-spk-*-mic[-swapped-hp]" */
+static char byt_rt5651_components[50]; /* = "cfg-spk:* cfg-mic:*" */
 
 static int byt_rt5651_suspend(struct snd_soc_card *card)
 {
@@ -876,7 +877,6 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	const char *platform_name;
 	struct acpi_device *adev;
 	struct device *codec_dev;
-	const char *hp_swapped;
 	bool is_bytcr = false;
 	int ret_val = 0;
 	int dai_index = 0;
@@ -1080,16 +1080,20 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (byt_rt5651_quirk & BYT_RT5651_HP_LR_SWAPPED)
-		hp_swapped = "-hp-swapped";
-	else
-		hp_swapped = "";
-
+	snprintf(byt_rt5651_components, sizeof(byt_rt5651_components),
+		 "cfg-spk:%s cfg-mic:%s%s",
+		 (byt_rt5651_quirk & BYT_RT5651_MONO_SPEAKER) ? "1" : "2",
+		 mic_name[BYT_RT5651_MAP(byt_rt5651_quirk)],
+		 (byt_rt5651_quirk & BYT_RT5651_HP_LR_SWAPPED) ?
+			" cfg-hp:lrswap" : "");
+	byt_rt5651_card.components = byt_rt5651_components;
 	snprintf(byt_rt5651_long_name, sizeof(byt_rt5651_long_name),
 		 "bytcr-rt5651-%s-spk-%s-mic%s",
 		 (byt_rt5651_quirk & BYT_RT5651_MONO_SPEAKER) ?
 			"mono" : "stereo",
-		 mic_name[BYT_RT5651_MAP(byt_rt5651_quirk)], hp_swapped);
+		 mic_name[BYT_RT5651_MAP(byt_rt5651_quirk)],
+		 (byt_rt5651_quirk & BYT_RT5651_HP_LR_SWAPPED) ?
+			"-hp-swapped" : "");
 	byt_rt5651_card.long_name = byt_rt5651_long_name;
 
 	/* override plaform name, if required */
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
