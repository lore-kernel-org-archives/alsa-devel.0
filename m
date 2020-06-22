Return-Path: <SRS0=6Zlx=AD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DEEC433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:45:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC12A2073E
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jNrMSqpn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC12A2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 862681710;
	Mon, 22 Jun 2020 17:44:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 862681710
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592840731;
	bh=hGEUotuuecgtSd2HJgfus5Sdkovi7hhYMfOsU1M0hMQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jNrMSqpn5CYS7sdKsmzop54gDwjwG6BwQYqlfDd7aCuxBlQGti0w8C2T6Xppgu7K5
	 K5eZLf0KEGs23OCSP4IAREkjLKvbDbNvj8ey786XK4peyu2Ao70CorajMiuYB7empI
	 u5wxsKvM5l/0w714fUtMHBW4ssP7Eijo4s97IOCY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 481D2F801DB;
	Mon, 22 Jun 2020 17:43:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 35D06F802A9; Mon, 22 Jun 2020 17:43:04 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DDB08F801DB
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2020 17:42:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DDB08F801DB
IronPort-SDR: aqgp6QHRvU+eo9PaqSZJHxRZsdVjKs+hX1qnhZ1olKK3U43wDydhyYWKFdUEbGO5ADlwNLicDe
 7IzKKg69n3hQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9659"; a="141300448"
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; d="scan'208";a="141300448"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2020 08:42:51 -0700
IronPort-SDR: JnyrCNBFpO++mMygX7zDdDScyB2QNkgjoUcUXRtShRXOgLFCrz00aHYN/1dR+EkP37WKvtIzoX
 Rtf1CsTQzsfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; d="scan'208";a="478425160"
Received: from somsubhr-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.74.194])
 by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2020 08:42:50 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/5] ASoC: intel: sof_rt5682: move disabling jack to dai
 link's exit()
Date: Mon, 22 Jun 2020 10:42:40 -0500
Message-Id: <20200622154241.29053-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200622154241.29053-1-pierre-louis.bossart@linux.intel.com>
References: <20200622154241.29053-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Fred Oh <fred.oh@linux.intel.com>, broonie@kernel.org,
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

From: Fred Oh <fred.oh@linux.intel.com>

Move disabling jack from platform driver's remove() to dai link's exit().
This is symmetrical change as jack is enabled in init().

Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Fred Oh <fred.oh@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_rt5682.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 13a48b0c35ae..f80ed62025f3 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -206,6 +206,13 @@ static int sof_rt5682_codec_init(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 };
 
+static void sof_rt5682_codec_exit(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
+
+	snd_soc_component_set_jack(component, NULL, NULL);
+}
+
 static int sof_rt5682_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
@@ -525,6 +532,7 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
 	links[id].platforms = platform_component;
 	links[id].num_platforms = ARRAY_SIZE(platform_component);
 	links[id].init = sof_rt5682_codec_init;
+	links[id].exit = sof_rt5682_codec_exit;
 	links[id].ops = &sof_rt5682_ops;
 	links[id].nonatomic = true;
 	links[id].dpcm_playback = 1;
@@ -786,21 +794,6 @@ static int sof_audio_probe(struct platform_device *pdev)
 					  &sof_audio_card_rt5682);
 }
 
-static int sof_rt5682_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-	struct snd_soc_component *component = NULL;
-
-	for_each_card_components(card, component) {
-		if (!strcmp(component->name, rt5682_component[0].name)) {
-			snd_soc_component_set_jack(component, NULL, NULL);
-			break;
-		}
-	}
-
-	return 0;
-}
-
 static const struct platform_device_id board_ids[] = {
 	{
 		.name = "sof_rt5682",
@@ -836,7 +829,6 @@ static const struct platform_device_id board_ids[] = {
 
 static struct platform_driver sof_audio = {
 	.probe = sof_audio_probe,
-	.remove = sof_rt5682_remove,
 	.driver = {
 		.name = "sof_rt5682",
 		.pm = &snd_soc_pm_ops,
-- 
2.20.1

