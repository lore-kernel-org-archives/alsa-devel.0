Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD483C433FE
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Oct 2022 20:51:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 953808AD6;
	Mon, 17 Oct 2022 22:50:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 953808AD6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666039908;
	bh=mOvIwdn+W7SeD5qeY+W1ifTb6gz0O+wAVKDn2Mvw9ZE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rcyk7uCoYOgKAsN+mA8/kaghmdTWanb/Q+b5oatQw5zaP35ZdHnAc7a94McDpWNBq
	 wlb/UR6kWmbtLcRS7cKNbjGpwXv4w9zJwHunUzh2NZ+pAGDnMPa4G4Qy0Tl76qxUiC
	 HmPYtPmsIOcoDMLN86msL06AHBq9gzzTGNvRflgI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4822BF80552;
	Mon, 17 Oct 2022 22:50:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E7CA4F804FE; Mon, 17 Oct 2022 22:50:08 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B1BBF804FE
 for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2022 22:49:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B1BBF804FE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="MRyjPr10"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666039800; x=1697575800;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mOvIwdn+W7SeD5qeY+W1ifTb6gz0O+wAVKDn2Mvw9ZE=;
 b=MRyjPr10GQsYzo/PMzbHehzs0TI3Or+ILh9UEV2XpNjWP/1BLbNTAqUV
 9H6iRcQOfprWtBz6dNk6PulCq0P57MZB/Wobi8givPpVzvhs4mJueDrzp
 TMfj5/IPOtCWxlL0O68nR5mgUAYn6WZCVaCGj57jA/KWAgy8KMBDji/dy
 +kxI1dB2QitZfqygCM+brzGL8Na6xbkfPsnJf+p5qraZuTN3WZpOr4yad
 o3FCXOXwvLciljMYcc//QtcW59inVJZMasfjoVTF8LZ+qpNvVINBhnmFE
 D2Imx6YkchMK2Usl0YktJ8k6QzzsLYWXtCKKeOWDWstRnxDYoMeX5fck5 Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="293286377"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; d="scan'208";a="293286377"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2022 13:49:54 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="717633061"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; d="scan'208";a="717633061"
Received: from cmontgom-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.54.140])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2022 13:49:54 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/3] ASoC: SOF: Intel: hda-dsp: simplify S3 resume flows
Date: Mon, 17 Oct 2022 15:49:46 -0500
Message-Id: <20221017204946.207986-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017204946.207986-1-pierre-louis.bossart@linux.intel.com>
References: <20221017204946.207986-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.de,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

The flow contains surprising parts that seem to have been inspired by
the Skylake driver.

During a resume from S3, the state of the links prior to suspend
should not matter. One would have to assume that the links are powered
down anyways prior to suspend, and there is also no specific code that
turns links on unconditionally on resume.

Likewise, the snd_hdac_init_chip() routine will start the cmd_io
handling, and it's not clear why we should care about the state of the
DMA prior to suspend.

This patch removes these two sequences to simplify the flow.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/intel/hda-dsp.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index 3c76f843454b6..799c50fe24dab 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -677,10 +677,6 @@ static int hda_suspend(struct snd_sof_dev *sdev, bool runtime_suspend)
 
 static int hda_resume(struct snd_sof_dev *sdev, bool runtime_resume)
 {
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
-	struct hdac_bus *bus = sof_to_bus(sdev);
-	struct hdac_ext_link *hlink = NULL;
-#endif
 	int ret;
 
 	/* display codec must be powered before link reset */
@@ -707,16 +703,6 @@ static int hda_resume(struct snd_sof_dev *sdev, bool runtime_resume)
 		if (sdev->system_suspend_target == SOF_SUSPEND_NONE)
 			hda_codec_jack_check(sdev);
 	}
-
-	/* turn off the links that were off before suspend */
-	list_for_each_entry(hlink, &bus->hlink_list, list) {
-		if (!hlink->ref_count)
-			snd_hdac_ext_bus_link_power_down(hlink);
-	}
-
-	/* check dma status and clean up CORB/RIRB buffers */
-	if (!bus->cmd_dma_state)
-		snd_hdac_bus_stop_cmd_io(bus);
 #endif
 
 	/* enable ppcap interrupt */
-- 
2.34.1

