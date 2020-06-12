Return-Path: <SRS0=DU/y=7Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3A5C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 20:36:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3759207ED
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 20:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pYYhtLhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3759207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 65780166E;
	Fri, 12 Jun 2020 22:35:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 65780166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591994179;
	bh=DinoFv/zAG1H56tuWBL9ZPDb0T0A0hO3Is9370qG+Zs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pYYhtLhPT4dTIqgUxb/VW7z6OMwioX3z+o8HVTGeeoEezyEwWazIOK6ICjjKVBMFG
	 1/iwt4pfddr50k1UU2tOO0hpTeK48Gi2PaFWaOwW6xUeYJu4khjCO5R73ztMutZvcO
	 hj5uOuwLqre8dP7ID9StaiOcsgUm5yheW8QP9BQs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B6AF7F801F7;
	Fri, 12 Jun 2020 22:35:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2CE31F801F7; Fri, 12 Jun 2020 22:35:27 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E7D56F80058
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 22:35:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7D56F80058
IronPort-SDR: hcUqLBdYTd71y5s3C7H1HVuf4dfDxHpv/jqYMWVfHr14OVQaaKSchDf8vgFmUs5tjh3OPrwSWD
 pC8DKEaccwZQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2020 13:35:11 -0700
IronPort-SDR: 9BX5ne8AYJPxFa5YMb+a4lcvP3/WIM9WXIwLKsyTD4LwSWZahNbes9kA3tlkbldtJ+dradmv4H
 V02u92RSKNLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,504,1583222400"; d="scan'208";a="474166888"
Received: from tcampell-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.231.137])
 by fmsmga006.fm.intel.com with ESMTP; 12 Jun 2020 13:35:11 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: soc-pcm: fix checks for multi-cpu FE dailinks
Date: Fri, 12 Jun 2020 15:35:07 -0500
Message-Id: <20200612203507.25621-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

soc_dpcm_fe_runtime_update() is called for all dailinks, and we want
to first discard all back-ends, then deal with front-ends.

The existing code first reports an error with multi-cpu front-ends,
and that check needs to be moved after we know that we are dealing
with a front-end.

BugLink: https://github.com/thesofproject/linux/issues/1970
Fixes: 6e1276a5e613d ('ASoC: Return error if the function does not
support multi-cpu')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/soc-pcm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 2c114b4542ce..c517064f5391 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2630,15 +2630,15 @@ static int soc_dpcm_fe_runtime_update(struct snd_soc_pcm_runtime *fe, int new)
 	int count, paths;
 	int ret;
 
+	if (!fe->dai_link->dynamic)
+		return 0;
+
 	if (fe->num_cpus > 1) {
 		dev_err(fe->dev,
 			"%s doesn't support Multi CPU yet\n", __func__);
 		return -EINVAL;
 	}
 
-	if (!fe->dai_link->dynamic)
-		return 0;
-
 	/* only check active links */
 	if (!snd_soc_dai_active(asoc_rtd_to_cpu(fe, 0)))
 		return 0;
-- 
2.20.1

