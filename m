Return-Path: <SRS0=lYVm=EW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831F0C4742C
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2020 13:35:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76CBB22240
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2020 13:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="R0kZQAiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CBB22240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C02B11764;
	Mon, 16 Nov 2020 14:34:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C02B11764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605533747;
	bh=QN/B8n9X0BOUOMLr1pjaivgDly1El1DjyoNQG8dCK9Q=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R0kZQAiWC4i5uNA0DNb6otiVof9d4zNGAjEDgn+VtMPw51CM/Gcfu6EVYu+5bKaou
	 OcKo8nbGi/MiZ3oV3GbqvkkE0O7LWBkOISs1WcfWzlhreaSIPz7x49KSuZFYGZrtLK
	 PFcM6dgU2SjA0ob+aIL7XFLyV4WC9jbJ+CKnh1jI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 59F70F804BC;
	Mon, 16 Nov 2020 14:34:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9CFA8F8029B; Mon, 16 Nov 2020 14:34:04 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DA3F8F8010A
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2020 14:33:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA3F8F8010A
IronPort-SDR: YH3wLAMPEdC1WFFjfrfGOquklNYlyHopLXB2ykSFV+ZudIuIdQebJuu+fhTY2c/N2fvKFNQgR4
 o3DdrisGod0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="158520542"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; d="scan'208";a="158520542"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2020 05:33:50 -0800
IronPort-SDR: j7CPO5NWOoi53IEm+lUd9hnxPMSbKgC+WLVe1WzTcrkDzbyPaYuPVG1kBTavtg90YC7TkTiFyQ
 hsBwDD62C+vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; d="scan'208";a="475525025"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by orsmga004.jf.intel.com with ESMTP; 16 Nov 2020 05:33:48 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/5] ASoC: Intel: catpt: Correct clock selection for dai
 trigger
Date: Mon, 16 Nov 2020 14:33:29 +0100
Message-Id: <20201116133332.8530-3-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201116133332.8530-1-cezary.rojewski@intel.com>
References: <20201116133332.8530-1-cezary.rojewski@intel.com>
Cc: pierre-louis.bossart@linux.intel.com,
 Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.com,
 lgirdwood@gmail.com, hdegoede@redhat.com, broonie@kernel.org
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

During stream start DSP firmware requires LPCS disabled as that moment in
time is resource heavy. Currently high-clock is selected on start of
second stream onwards while low-clock is re-selected before stream
actually leaves RESUME state i.e. PAUSE_STREAM call. Fix this by always
updating clock before RESUME_STREAM and directly after PAUSE_STREAM.

Fixes: a126750fc865 ("ASoC: Intel: catpt: PCM operations")
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/catpt/pcm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/catpt/pcm.c b/sound/soc/intel/catpt/pcm.c
index afdf6be605aa..408e64e3b5fb 100644
--- a/sound/soc/intel/catpt/pcm.c
+++ b/sound/soc/intel/catpt/pcm.c
@@ -458,10 +458,6 @@ static int catpt_dai_prepare(struct snd_pcm_substream *substream,
 	if (ret)
 		return CATPT_IPC_ERROR(ret);
 
-	ret = catpt_dsp_update_lpclock(cdev);
-	if (ret)
-		return ret;
-
 	ret = catpt_dai_apply_usettings(dai, stream);
 	if (ret)
 		return ret;
@@ -500,6 +496,7 @@ static int catpt_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	resume_stream:
+		catpt_dsp_update_lpclock(cdev);
 		ret = catpt_ipc_resume_stream(cdev, stream->info.stream_hw_id);
 		if (ret)
 			return CATPT_IPC_ERROR(ret);
@@ -507,11 +504,11 @@ static int catpt_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	case SNDRV_PCM_TRIGGER_STOP:
 		stream->prepared = false;
-		catpt_dsp_update_lpclock(cdev);
 		fallthrough;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		ret = catpt_ipc_pause_stream(cdev, stream->info.stream_hw_id);
+		catpt_dsp_update_lpclock(cdev);
 		if (ret)
 			return CATPT_IPC_ERROR(ret);
 		break;
-- 
2.17.1

