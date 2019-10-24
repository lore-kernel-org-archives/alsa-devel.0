Return-Path: <SRS0=DG6G=YR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA3CCA9EAF
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Oct 2019 21:06:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8195B21928
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Oct 2019 21:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="c6GF+wRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8195B21928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4516F1739;
	Thu, 24 Oct 2019 23:05:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4516F1739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571951164;
	bh=W0cUWJSD45x11qq+00SfBOlhFKtSlexgrp+iTmQV5Dw=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c6GF+wRNZ0Jx9PMQfcq8Rp0gOC0dVFXxaPOZ8/Q/a9G1QZbl2AGYT+qzxvpLNg5bH
	 SClOIQet2FDuiM0t7rlpaQZoKYHWSXzwGDtHX6Qz/FcoisOyr5tPTQQHp2tSK+tbru
	 8QyCFzEhZAPyizaWHscSFmQA9iz5ZCvDWwFKJOl4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A5B2F805FD;
	Thu, 24 Oct 2019 23:03:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 94D43F80377; Thu, 24 Oct 2019 23:03:32 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0AA8F80367
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2019 23:03:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0AA8F80367
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Oct 2019 14:03:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,226,1569308400"; d="scan'208";a="398553508"
Received: from ksengupt-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.251.138.183])
 by fmsmga005.fm.intel.com with ESMTP; 24 Oct 2019 14:03:22 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Thu, 24 Oct 2019 16:03:18 -0500
Message-Id: <20191024210318.30068-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024210318.30068-1-pierre-louis.bossart@linux.intel.com>
References: <20191024210318.30068-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, Jaska Uimonen <jaska.uimonen@intel.com>, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [alsa-devel] [PATCH v2 2/2] ASoC: SOF: Intel: only support
	INFO_BATCH for legacy platforms
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The current position update is not precise enough for PulseAudio to
work reliably with the timer-based scheduling on Baytrail,
Cherrytrail, Broadwell.

Disable the NO_PERIOD_WAKEUP capability and use BATCH to signal that
the position is only reliable and updated during period_elapsed
events.

This will be reverted when the firmware provides a more accurate
position for those platforms.

Reviewed-by: Jaska Uimonen <jaska.uimonen@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/bdw.c | 2 +-
 sound/soc/sof/intel/byt.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/intel/bdw.c b/sound/soc/sof/intel/bdw.c
index 7b4cd1f456bf..141dad554764 100644
--- a/sound/soc/sof/intel/bdw.c
+++ b/sound/soc/sof/intel/bdw.c
@@ -598,7 +598,7 @@ const struct snd_sof_dsp_ops sof_bdw_ops = {
 			SNDRV_PCM_INFO_MMAP_VALID |
 			SNDRV_PCM_INFO_INTERLEAVED |
 			SNDRV_PCM_INFO_PAUSE |
-			SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
+			SNDRV_PCM_INFO_BATCH,
 };
 EXPORT_SYMBOL(sof_bdw_ops);
 
diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
index 62edb959f1fc..2abf80b3eb52 100644
--- a/sound/soc/sof/intel/byt.c
+++ b/sound/soc/sof/intel/byt.c
@@ -538,7 +538,7 @@ const struct snd_sof_dsp_ops sof_tng_ops = {
 			SNDRV_PCM_INFO_MMAP_VALID |
 			SNDRV_PCM_INFO_INTERLEAVED |
 			SNDRV_PCM_INFO_PAUSE |
-			SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
+			SNDRV_PCM_INFO_BATCH,
 };
 EXPORT_SYMBOL(sof_tng_ops);
 
@@ -706,7 +706,7 @@ const struct snd_sof_dsp_ops sof_byt_ops = {
 			SNDRV_PCM_INFO_MMAP_VALID |
 			SNDRV_PCM_INFO_INTERLEAVED |
 			SNDRV_PCM_INFO_PAUSE |
-			SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
+			SNDRV_PCM_INFO_BATCH,
 };
 EXPORT_SYMBOL(sof_byt_ops);
 
@@ -773,7 +773,7 @@ const struct snd_sof_dsp_ops sof_cht_ops = {
 			SNDRV_PCM_INFO_MMAP_VALID |
 			SNDRV_PCM_INFO_INTERLEAVED |
 			SNDRV_PCM_INFO_PAUSE |
-			SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
+			SNDRV_PCM_INFO_BATCH,
 };
 EXPORT_SYMBOL(sof_cht_ops);
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
