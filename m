Return-Path: <SRS0=ytyY=3K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E04C32771
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jan 2020 01:30:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1DC522527
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jan 2020 01:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GF6lma2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1DC522527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 11F5C1683;
	Tue, 21 Jan 2020 02:29:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 11F5C1683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579570220;
	bh=oXf4L96XEtv73102O362iHQaq3W/rIZhKQmovlsVrbI=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GF6lma2Iqu/L3aUaSPkLxF2bxog2kGUjY3uLZlGFdCznux2dbBzC9eTPCrpIyUDSD
	 HVTQ+fHrwxxu7a4W/I0D198XeL5GjQR0wH9xEo3t/96UzmCCW5eOUzTW1y6H1tzQu0
	 i4Ck8h7vpdoc/orsBXCe0XcPUURSNOF7lcseR+m0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EF6E4F8028F;
	Tue, 21 Jan 2020 02:26:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1DF89F80274; Tue, 21 Jan 2020 02:25:58 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78C95F80248
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2020 02:25:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78C95F80248
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Jan 2020 17:25:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,344,1574150400"; d="scan'208";a="258880021"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by fmsmga002.fm.intel.com with ESMTP; 20 Jan 2020 17:25:44 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de
Date: Mon, 20 Jan 2020 21:29:26 +0800
Message-Id: <20200120132928.25257-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120132928.25257-1-yung-chuan.liao@linux.intel.com>
References: <20200120132928.25257-1-yung-chuan.liao@linux.intel.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org,
 bard.liao@intel.com, pierre-louis.bossart@linux.intel.com,
 kuninori.morimoto.gx@renesas.com
Subject: [alsa-devel] [PATCH RFC v4 4/6] ASoC: Add multiple CPU DAI support
	in DAPM
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

From: Shreyas NC <shreyas.nc@intel.com>

DAPM handles DAIs during soc_dapm_stream_event() and during addition
and creation of DAI widgets i.e., dapm_add_valid_dai_widget() and
dapm_connect_dai_link_widgets().

Extend these functions to handle multiple cpu dai.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/soc-dapm.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1a414054ee23..af4ddca8b7f3 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4358,9 +4358,19 @@ static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
 	struct snd_soc_dai *codec_dai;
 	int i;
 
-	for_each_rtd_codec_dai(rtd, i, codec_dai)
-		dapm_add_valid_dai_widget(card, rtd,
-					  codec_dai, rtd->cpu_dais[0]);
+	if (rtd->num_cpus == 1) {
+		for_each_rtd_codec_dai(rtd, i, codec_dai)
+			dapm_add_valid_dai_widget(card, rtd, codec_dai,
+						  rtd->cpu_dais[0]);
+	} else if (rtd->num_codecs == rtd->num_cpus) {
+		for_each_rtd_codec_dai(rtd, i, codec_dai)
+			dapm_add_valid_dai_widget(card, rtd, codec_dai,
+						  rtd->cpu_dais[i]);
+	} else {
+		dev_err(card->dev,
+			"N cpus to M codecs link is not supported yet\n");
+	}
+
 }
 
 static void soc_dapm_dai_stream_event(struct snd_soc_dai *dai, int stream,
@@ -4424,9 +4434,11 @@ static void soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
 	int event)
 {
 	struct snd_soc_dai *codec_dai;
+	struct snd_soc_dai *cpu_dai;
 	int i;
 
-	soc_dapm_dai_stream_event(rtd->cpu_dai, stream, event);
+	for_each_rtd_cpu_dai(rtd, i, cpu_dai)
+		soc_dapm_dai_stream_event(rtd->cpu_dai, stream, event);
 	for_each_rtd_codec_dai(rtd, i, codec_dai)
 		soc_dapm_dai_stream_event(codec_dai, stream, event);
 
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
