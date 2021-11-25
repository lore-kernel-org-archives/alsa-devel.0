Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A706C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Nov 2021 10:25:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E21D17F5;
	Thu, 25 Nov 2021 11:24:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E21D17F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637835919;
	bh=NwGfbJqvulfieLx7jai7Diy4lmKr6bEVeABcjuA8PJQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k8BDM15/nRUzynrR1yiKvDvZEut72hqSfPsAfSHeMk+8hFydc4GjmRx1fsKs6VRbw
	 RuDvGvyfR15DZGnetzPkX9g2drFWamRPi7VxcOph+D9HuWW+UQ4v3OazHEkBEW+mg2
	 z7ciNNbeSQ3ZBIsp2zbJg5O2+FqeHMhp19E3wSWM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F338F804EC;
	Thu, 25 Nov 2021 11:23:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F367EF804F2; Thu, 25 Nov 2021 11:23:38 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F159F804E6
 for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2021 11:23:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F159F804E6
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="215515170"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; d="scan'208";a="215515170"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2021 02:23:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; d="scan'208";a="741671987"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga006.fm.intel.com with ESMTP; 25 Nov 2021 02:23:25 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 04/10] ASoC: SOF: pcm: invoke platform hw_free for
 STOP/SUSPEND triggers
Date: Thu, 25 Nov 2021 12:15:14 +0200
Message-Id: <20211125101520.291581-5-kai.vehmanen@linux.intel.com>
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

snd_sof_pcm_platform_hw_params() will be called when the stream is
restarted with a prepare ioctl. This happens in two cases i.e. when a
suspended stream is resumed or when a stream is restarted without
intermediate call to sof_pcm_hw_free(). Make sure to call
snd_sof_pcm_platform_hw_free() in both these cases to keep it balanced.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/pcm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 1bf7e60be772..1d0d90551e8f 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -470,6 +470,10 @@ static int sof_pcm_trigger(struct snd_soc_component *component,
 		if (ret < 0)
 			return ret;
 
+		ret = snd_sof_pcm_platform_hw_free(sdev, substream);
+		if (ret < 0)
+			return ret;
+
 		/* free widget list only for SUSPEND trigger */
 		if (free_widget_list)
 			ret = sof_widget_list_free(sdev, spcm, substream->stream);
-- 
2.33.0

