Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240FBCA0EF3
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Sep 2023 12:50:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3AB8693A;
	Thu, 14 Sep 2023 14:49:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3AB8693A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694695824;
	bh=FP3eNrPDfTE206rFeSBr56F/vhjnjhpFBtPYZnpSBIg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=lO0/4nVnWYxs7y9WPd+rfVQxjmL95n6Js7gi9naUIKMlFTNuM5yIVmE4+SM52lrHi
	 DXMNmWrE7BxA37WWOtRZwt0DWRCvWHWnOUt1TQ9zN5PWql9v8WH236TSEZ6bC5e8ke
	 /Ki05yQ+iuXVw/YmeOm/OKplWQ6NfEK0VxTZuxdA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 60493F80246; Thu, 14 Sep 2023 14:49:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EA7FDF80425;
	Thu, 14 Sep 2023 14:49:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 550E6F80425; Thu, 14 Sep 2023 14:48:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 66E24F80141
	for <alsa-devel@alsa-project.org>; Thu, 14 Sep 2023 14:47:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66E24F80141
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=TFjvEdjZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694695651; x=1726231651;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FP3eNrPDfTE206rFeSBr56F/vhjnjhpFBtPYZnpSBIg=;
  b=TFjvEdjZotybkD/t3P38HliOb/Yasn+LQRoDJFLGuxMdNvpmdnEh18i+
   eIjUKdW2Aujmn4j131QbkOK1di8gAd6r9nSdl/jLDOTr9EO7DAH/zGCw1
   OBxLGSUFX3UWyI7aP/sJPmj6rLLJzr4X64odc3a1sqwtzN5ylMewK903w
   pCjS2RbbKNOLq5Pbe8yMTWfY7DvxSvz3hCRHugYZOZGMiKy93gLILsyyO
   6hb35jZUUHQylZEa40wjxdOLsA7w1CUcwgiy5jVSapkruWgtn9jOpwgsA
   3iumoIirEBCBFngH/3/AL0vLMR/de9eJE4A59ibChhJHzqcr7cvb7R0RA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="378858346"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000";
   d="scan'208";a="378858346"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2023 05:47:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="744521433"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000";
   d="scan'208";a="744521433"
Received: from pakurapo-mobl3.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.37.8])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2023 05:47:20 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	pierre-louis.bossart@linux.intel.com
Cc: alsa-devel@alsa-project.org,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com
Subject: [PATCH] ASoC: SOF: sof-audio: Fix DSP core put imbalance on widget
 setup failure
Date: Thu, 14 Sep 2023 15:47:25 +0300
Message-ID: <20230914124725.17397-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: BESYCQLCZHHP4ME74UU6IZGD7I6ZBE54
X-Message-ID-Hash: BESYCQLCZHHP4ME74UU6IZGD7I6ZBE54
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BESYCQLCZHHP4ME74UU6IZGD7I6ZBE54/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

In case the widget setup fails we should only decrement the core usage
count if the sof_widget_free_unlocked() has not been called as part of
the error handling.
sof_widget_free_unlocked() calls snd_sof_dsp_core_put() and the additional
core_put will cause imbalance in core usage count.
Use the existing use_count_decremented to handle this issue.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/sof-audio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index e7ef77012c35..e5405f854a91 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -212,7 +212,8 @@ static int sof_widget_setup_unlocked(struct snd_sof_dev *sdev,
 	sof_widget_free_unlocked(sdev, swidget);
 	use_count_decremented = true;
 core_put:
-	snd_sof_dsp_core_put(sdev, swidget->core);
+	if (!use_count_decremented)
+		snd_sof_dsp_core_put(sdev, swidget->core);
 pipe_widget_free:
 	if (swidget->id != snd_soc_dapm_scheduler)
 		sof_widget_free_unlocked(sdev, swidget->spipe->pipe_widget);
-- 
2.42.0

