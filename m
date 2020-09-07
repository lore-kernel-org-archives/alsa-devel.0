Return-Path: <SRS0=BS+q=CQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99425C43461
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:20:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8121421473
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vkm/8+tI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8121421473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C6CEC177D;
	Mon,  7 Sep 2020 13:20:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C6CEC177D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599477653;
	bh=UXB89SyvRomFkn54IM+399AKIyQDzEoIVSOTN35JDxU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vkm/8+tIUpWPoQUO7b0tMK36U9HC9mVHwzTCktxDjt+kSNZ3imX/Yu6SKtmZhaOzX
	 BfTYFJB1VGMQpcjg+zOkD7REQhWvOInB2W/jjUlEexZ3mbXurJS6+dzVgd8nOKxPly
	 HaV7bnmTZWSA9NRkIJ0n6kUdSWTELKuRptHVQY20=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 50A9AF800B9;
	Mon,  7 Sep 2020 13:20:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1BAA3F80227; Mon,  7 Sep 2020 13:20:01 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 70A3AF800B9
 for <alsa-devel@alsa-project.org>; Mon,  7 Sep 2020 13:19:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 70A3AF800B9
IronPort-SDR: XOoTGd6muSisGFMVC8HgK89gopQ5WMVGRhDdThLoerzQWEBNnhZPAz0KjWIozHyP/Co/GTDtDp
 mOVSTnIEbdqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="155486586"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; d="scan'208";a="155486586"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2020 04:19:50 -0700
IronPort-SDR: e+X4q5MiKTwTfXC1OgOTYLNnXeK0VrxII918JcjJmEQcLqUy+MOgSSlU50Uli3zegu8F50+qv4
 e+do5K2wpg/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; d="scan'208";a="343197020"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by orsmga007.jf.intel.com with ESMTP; 07 Sep 2020 04:19:48 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2] ASoC: core: Do not cleanup uninitialized dais on
 soc_pcm_open failure
Date: Mon,  7 Sep 2020 13:19:39 +0200
Message-Id: <20200907111939.16169-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
Cc: pierre-louis.bossart@linux.intel.com,
 Cezary Rojewski <cezary.rojewski@intel.com>, kuninori.morimoto.gx@renesas.com,
 lgirdwood@gmail.com, tiwai@suse.com, broonie@kernel.org
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

Introduce for_each_rtd_dais_rollback macro which behaves exactly like
for_each_codec_dais_rollback and its cpu_dais equivalent but for all
dais instead.

Use newly added macro to fix soc_pcm_open error path and prevent
uninitialized dais from being cleaned-up.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Fixes: 5d9fa03e6c35 ("ASoC: soc-pcm: tidyup soc_pcm_open() order")
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---

Changes in v2:
- no functional changes
- appended missing Fixes tag, plus Acked-by from review

 include/sound/soc.h | 2 ++
 sound/soc/soc-pcm.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index b94ebff12350..09a7d8409ade 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1193,6 +1193,8 @@ struct snd_soc_pcm_runtime {
 	     ((i) < (rtd)->num_cpus + (rtd)->num_codecs) &&		\
 		     ((dai) = (rtd)->dais[i]);				\
 	     (i)++)
+#define for_each_rtd_dais_rollback(rtd, i, dai)		\
+	for (; (--(i) >= 0) && ((dai) = (rtd)->dais[i]);)
 
 void snd_soc_close_delayed_work(struct snd_soc_pcm_runtime *rtd);
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 00ac1cbf6f88..4c9d4cd8cf0b 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -812,7 +812,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	return 0;
 
 config_err:
-	for_each_rtd_dais(rtd, i, dai)
+	for_each_rtd_dais_rollback(rtd, i, dai)
 		snd_soc_dai_shutdown(dai, substream);
 
 	snd_soc_link_shutdown(substream);
-- 
2.17.1

