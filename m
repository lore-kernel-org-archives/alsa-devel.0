Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97ABBC433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Nov 2021 10:25:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C21DD1878;
	Thu, 25 Nov 2021 11:25:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C21DD1878
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637835957;
	bh=k4DFbTSaiC0AWQUggyzb65ujrIGqXoFx8vbW0la/yig=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q5o9dtIYTPelTr3Lf+aSg1JLCjPCbQBWGJ8rarKIrUSpT05KAf+bXXnoGUIj2hqcL
	 4jW0hsg5KJLY/vFY3/Lxz6d7GCS5rXHX0Q+57p47LplRsQYbISl4/keKggpZYRRMsl
	 Jq3Mw/9vc3gRJl/yF+KkKkf8ObP9u2imJPE14JOI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A54E9F804FB;
	Thu, 25 Nov 2021 11:23:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9EE48F80507; Thu, 25 Nov 2021 11:23:44 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 31106F804ED
 for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2021 11:23:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 31106F804ED
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="215515217"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; d="scan'208";a="215515217"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2021 02:23:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; d="scan'208";a="741672017"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga006.fm.intel.com with ESMTP; 25 Nov 2021 02:23:30 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 05/10] ASoC: SOF: call platform hw_free for paused streams
 during suspend
Date: Thu, 25 Nov 2021 12:15:15 +0200
Message-Id: <20211125101520.291581-6-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211125101520.291581-1-kai.vehmanen@linux.intel.com>
References: <20211125101520.291581-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: kai.vehmanen@linux.intel.com, yung-chuan.liao@linux.intel.com,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com
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

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Paused streams must be stopped and platform hw_free should be invoked
during system suspend so they can be restarted properly after system
resume.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/sof-audio.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index e00ce275052f..d81071b39825 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -751,10 +751,17 @@ static int sof_tear_down_left_over_pipelines(struct snd_sof_dev *sdev)
 				continue;
 
 			if (spcm->stream[dir].list) {
+				/* Free PCM in the DSP */
 				ret = sof_pcm_dsp_pcm_free(substream, sdev, spcm);
 				if (ret < 0)
 					return ret;
 
+				/* stop DMA */
+				ret = snd_sof_pcm_platform_hw_free(sdev, substream);
+				if (ret < 0)
+					return ret;
+
+				/* free the DAPM widget list */
 				ret = sof_widget_list_free(sdev, spcm, dir);
 				if (ret < 0) {
 					dev_err(sdev->dev, "failed to free widgets during suspend\n");
-- 
2.33.0

