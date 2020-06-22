Return-Path: <SRS0=6Zlx=AD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99981C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:44:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D602074D
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AejWXW2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D602074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 92D521702;
	Mon, 22 Jun 2020 17:43:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 92D521702
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592840682;
	bh=swiv1lI07qNyX+TjC+d0QipZ05edLs4WH5hTHnX6JRA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AejWXW2SDVlJuobhXlJ0cTtYJrgoAWD3b39EPRt4qpNAmbfkvY5IiXWPD4fcXEv0Q
	 nA5pRjTShhmXRpM5kjutoQSBBex34KU4dSrhjiGPF7CrSN+07bJVZ2tGZlnsTWBF91
	 CVoN68PojVOowR+016SEaV1izr88mbvBl2he1364=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 110A7F802A0;
	Mon, 22 Jun 2020 17:43:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D5C43F80157; Mon, 22 Jun 2020 17:42:59 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F052EF80157
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2020 17:42:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F052EF80157
IronPort-SDR: i/X4doCogXI9vDetC6OPvtZc8r5MwZXmkB7wWhl2mgTG70YPzI5VYIkIMpsRyc/fK+YZDC6dcW
 cpHVWiFLGulQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9659"; a="141300440"
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; d="scan'208";a="141300440"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2020 08:42:50 -0700
IronPort-SDR: wzZttn5XdtpXqH+NylYQmVlWQjxzd0Sw7X2JK5R/iW8bimRmNSW723WHsV+Zm1C2twfJUd64hK
 oX2lwrxeAqMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; d="scan'208";a="478425155"
Received: from somsubhr-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.74.194])
 by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2020 08:42:49 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/5] ASoC: Intel: kbl-rt5660: use .exit() dailink callback to
 release gpiod
Date: Mon, 22 Jun 2020 10:42:39 -0500
Message-Id: <20200622154241.29053-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200622154241.29053-1-pierre-louis.bossart@linux.intel.com>
References: <20200622154241.29053-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Curtis Malainey <curtis@malainey.com>, broonie@kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

The gpiod handling is inspired from the bdw-rt5677 code. Apply same
fix to avoid reference count issue while removing modules for
consistency.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Curtis Malainey <curtis@malainey.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/kbl_rt5660.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5660.c b/sound/soc/intel/boards/kbl_rt5660.c
index d2a078454784..f4c0b983c990 100644
--- a/sound/soc/intel/boards/kbl_rt5660.c
+++ b/sound/soc/intel/boards/kbl_rt5660.c
@@ -165,8 +165,8 @@ static int kabylake_rt5660_codec_init(struct snd_soc_pcm_runtime *rtd)
 		dev_warn(component->dev, "Failed to add driver gpios\n");
 
 	/* Request rt5660 GPIO for lineout mute control, return if fails */
-	ctx->gpio_lo_mute = devm_gpiod_get(component->dev, "lineout-mute",
-					   GPIOD_OUT_HIGH);
+	ctx->gpio_lo_mute = gpiod_get(component->dev, "lineout-mute",
+				      GPIOD_OUT_HIGH);
 	if (IS_ERR(ctx->gpio_lo_mute)) {
 		dev_err(component->dev, "Can't find GPIO_MUTE# gpio\n");
 		return PTR_ERR(ctx->gpio_lo_mute);
@@ -207,6 +207,18 @@ static int kabylake_rt5660_codec_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+static void kabylake_rt5660_codec_exit(struct snd_soc_pcm_runtime *rtd)
+{
+	struct kbl_codec_private *ctx = snd_soc_card_get_drvdata(rtd->card);
+
+	/*
+	 * The .exit() can be reached without going through the .init()
+	 * so explicitly test if the gpiod is valid
+	 */
+	if (!IS_ERR_OR_NULL(ctx->gpio_lo_mute))
+		gpiod_put(ctx->gpio_lo_mute);
+}
+
 static int kabylake_hdmi_init(struct snd_soc_pcm_runtime *rtd, int device)
 {
 	struct kbl_codec_private *ctx = snd_soc_card_get_drvdata(rtd->card);
@@ -421,6 +433,7 @@ static struct snd_soc_dai_link kabylake_rt5660_dais[] = {
 		.id = 0,
 		.no_pcm = 1,
 		.init = kabylake_rt5660_codec_init,
+		.exit = kabylake_rt5660_codec_exit,
 		.dai_fmt = SND_SOC_DAIFMT_I2S |
 		SND_SOC_DAIFMT_NB_NF |
 		SND_SOC_DAIFMT_CBS_CFS,
-- 
2.20.1

