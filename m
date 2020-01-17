Return-Path: <SRS0=jvLf=3G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F863C33CB1
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:47:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFA7C2072E
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PBN4zC2j";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="fP0iV8qr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA7C2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A525417E2;
	Fri, 17 Jan 2020 16:46:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A525417E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579276035;
	bh=laLqFtp1aGngUfhMU1U7wzTnVlxwFx9IMeYjKRj6uPI=;
	h=From:To:In-Reply-To:Date:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=PBN4zC2jtD2L71M38ZsvjRsgmOHsUd4c3ooHxMP0TmCwsUbUUSv8D/BHaLZU20LiY
	 rlIvZYyl0tdKZW4ZBxhPjs8afUOgG28iE1fT5L0aCwbdWOdJPGL0IlsSlC0F5MOb+o
	 jkriLfj6CgKSRDxRTh87XQUEjVVxCwWwUc/Q9rVs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C8DC7F80227;
	Fri, 17 Jan 2020 16:45:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6427F80228; Fri, 17 Jan 2020 16:44:14 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00AA6F8014B
 for <alsa-devel@alsa-project.org>; Fri, 17 Jan 2020 16:44:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00AA6F8014B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="fP0iV8qr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=6b47MPUinwGNYPym4tHIes9gOEIse0VlGFZoaus3fGw=; b=fP0iV8qrtqxm
 E0JqklwjMn5L1wku9ZwyM0nQ/weZX3OUU88RhUUQahMDexA9aDuMvEU/crMpW8nCepFVC8kNxcXzU
 l6Ad9+D/SwGwXePC6nurUEbC9WjWfiSKN5brgjkHruMajUqYKh6n+NEyBrcGix1wDzU4bBpya7stA
 Lm1Vc=;
Received: from fw-tnat-cam4.arm.com ([217.140.106.52]
 helo=fitzroy.sirena.org.uk) by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1isTn9-0006rp-9x; Fri, 17 Jan 2020 15:44:11 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id 04851D02A2A; Fri, 17 Jan 2020 15:44:11 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Erik Bussing <eabbussing@outlook.com>
In-Reply-To: <20200115164619.101705-2-hdegoede@redhat.com>
Message-Id: <applied-20200115164619.101705-2-hdegoede@redhat.com>
X-Patchwork-Hint: ignore
Date: Fri, 17 Jan 2020 15:44:10 +0000 (GMT)
Cc: Nariman Etemadi <narimantos@gmail.com>, alsa-devel@alsa-project.org,
 Jordy Ubink <jordyubink@hotmail.nl>, Jie Yang <yang.jie@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>,
 Damian van Soelen <dj.vsoelen@gmail.com>
Subject: [alsa-devel] Applied "ASoC: Intel: bytcr_rt5640: Remove code
	duplication in byt_rt5640_codec_fixup" to the asoc tree
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

   ASoC: Intel: bytcr_rt5640: Remove code duplication in byt_rt5640_codec_fixup

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 332719b1840b9bf3e09938d1fda566f414fcf0e6 Mon Sep 17 00:00:00 2001
From: Erik Bussing <eabbussing@outlook.com>
Date: Wed, 15 Jan 2020 17:46:16 +0100
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: Remove code duplication in
 byt_rt5640_codec_fixup

The 16 and 24 bit paths in byt_rt5640_codec_fixup are mostly identical,
introduce a local bits variable to address the only difference and move
the common bits out of the if ... else ... .

Signed-off-by: Erik Bussing <eabbussing@outlook.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20200115164619.101705-2-hdegoede@redhat.com
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 68 +++++++++------------------
 1 file changed, 23 insertions(+), 45 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index dd6310fe8914..c19ae4fbf955 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -940,65 +940,43 @@ static int byt_rt5640_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 			SNDRV_PCM_HW_PARAM_RATE);
 	struct snd_interval *channels = hw_param_interval(params,
 						SNDRV_PCM_HW_PARAM_CHANNELS);
-	int ret;
+	int ret, bits;
 
 	/* The DSP will covert the FE rate to 48k, stereo */
 	rate->min = rate->max = 48000;
 	channels->min = channels->max = 2;
 
 	if ((byt_rt5640_quirk & BYT_RT5640_SSP0_AIF1) ||
-		(byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)) {
-
+	    (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)) {
 		/* set SSP0 to 16-bit */
 		params_set_format(params, SNDRV_PCM_FORMAT_S16_LE);
-
-		/*
-		 * Default mode for SSP configuration is TDM 4 slot, override config
-		 * with explicit setting to I2S 2ch 16-bit. The word length is set with
-		 * dai_set_tdm_slot() since there is no other API exposed
-		 */
-		ret = snd_soc_dai_set_fmt(rtd->cpu_dai,
-					SND_SOC_DAIFMT_I2S     |
-					SND_SOC_DAIFMT_NB_NF   |
-					SND_SOC_DAIFMT_CBS_CFS
-			);
-		if (ret < 0) {
-			dev_err(rtd->dev, "can't set format to I2S, err %d\n", ret);
-			return ret;
-		}
-
-		ret = snd_soc_dai_set_tdm_slot(rtd->cpu_dai, 0x3, 0x3, 2, 16);
-		if (ret < 0) {
-			dev_err(rtd->dev, "can't set I2S config, err %d\n", ret);
-			return ret;
-		}
-
+		bits = 16;
 	} else {
-
 		/* set SSP2 to 24-bit */
 		params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
+		bits = 24;
+	}
 
-		/*
-		 * Default mode for SSP configuration is TDM 4 slot, override config
-		 * with explicit setting to I2S 2ch 24-bit. The word length is set with
-		 * dai_set_tdm_slot() since there is no other API exposed
-		 */
-		ret = snd_soc_dai_set_fmt(rtd->cpu_dai,
-					SND_SOC_DAIFMT_I2S     |
-					SND_SOC_DAIFMT_NB_NF   |
-					SND_SOC_DAIFMT_CBS_CFS
-			);
-		if (ret < 0) {
-			dev_err(rtd->dev, "can't set format to I2S, err %d\n", ret);
-			return ret;
-		}
+	/*
+	 * Default mode for SSP configuration is TDM 4 slot, override config
+	 * with explicit setting to I2S 2ch. The word length is set with
+	 * dai_set_tdm_slot() since there is no other API exposed
+	 */
+	ret = snd_soc_dai_set_fmt(rtd->cpu_dai,
+				  SND_SOC_DAIFMT_I2S     |
+				  SND_SOC_DAIFMT_NB_NF   |
+				  SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set format to I2S, err %d\n", ret);
+		return ret;
+	}
 
-		ret = snd_soc_dai_set_tdm_slot(rtd->cpu_dai, 0x3, 0x3, 2, 24);
-		if (ret < 0) {
-			dev_err(rtd->dev, "can't set I2S config, err %d\n", ret);
-			return ret;
-		}
+	ret = snd_soc_dai_set_tdm_slot(rtd->cpu_dai, 0x3, 0x3, 2, bits);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set I2S config, err %d\n", ret);
+		return ret;
 	}
+
 	return 0;
 }
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
