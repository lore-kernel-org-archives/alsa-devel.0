Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E333C4332F
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Nov 2021 10:24:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 740781887;
	Thu, 25 Nov 2021 11:24:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 740781887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637835891;
	bh=mvWOlYbsfzKnaWhpnV9PEriYvfA9rp/bpZak6TLhy3w=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AGj4vEUf9ML+BT9JlD3ZjVU3h7qaHr3Qq5uz/BLbqqxW5BeFNznLHo9uGLOTG3t7u
	 Ruxl5BfekiFJjWudTCaYRxVYqHtJMFB1XwMJB/jvb0Nd/J13QvZRU3iJy5ES/kbfzc
	 jGdbygCgkFUrEdMsQv2ArK4hG5e7DLj/HXOEE68U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D11CF804E5;
	Thu, 25 Nov 2021 11:23:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C8DC4F80302; Thu, 25 Nov 2021 11:23:13 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A28CCF804AC
 for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2021 11:23:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A28CCF804AC
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="259387198"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; d="scan'208";a="259387198"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2021 02:22:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; d="scan'208";a="741671733"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga006.fm.intel.com with ESMTP; 25 Nov 2021 02:22:57 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 01/10] ASoC: SOF: Intel: hda: clear stream before freeing the
 DAI widget
Date: Thu, 25 Nov 2021 12:15:11 +0200
Message-Id: <20211125101520.291581-2-kai.vehmanen@linux.intel.com>
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

The DAI_CONFIG IPC that is sent during the STOP trigger is used for
stopping the DMA in the FW. This must be done after the DMA RUN bit is
cleared by the host. So move the call to snd_hdac_ext_link_stream_clear()
before hda_link_dai_widget_update() to follow the correct programming
sequence for DMA stop for HDA DAIs.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/intel/hda-dai.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index 5c9ee6c49473..748e8ed61475 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -329,6 +329,8 @@ static int hda_link_pcm_trigger(struct snd_pcm_substream *substream,
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_STOP:
+		snd_hdac_ext_link_stream_clear(link_dev);
+
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			w = dai->playback_widget;
 		else
@@ -347,8 +349,7 @@ static int hda_link_pcm_trigger(struct snd_pcm_substream *substream,
 		}
 
 		link_dev->link_prepared = 0;
-
-		fallthrough;
+		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		snd_hdac_ext_link_stream_clear(link_dev);
 		break;
-- 
2.33.0

