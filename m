Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F63EC433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Apr 2022 20:34:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5D044170D;
	Thu, 21 Apr 2022 22:33:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5D044170D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650573242;
	bh=F8zk+agD4BJAVcs4I4XR3/E7p3eYhXuY6cReY/P867g=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nQZkDbRJTvC6IErdhEoG3fhlWcFGueRAJidbpEZmqPHYQFCaczG0+lGcgfy8ah4PN
	 8CB0+4Q8B9bgBzCrTfSxbTUz7zQfeWMPimWfOQ9u8BBNhysa+VTsBpn2wjeZUfJLvl
	 kluLwkv2RLSruivLPXDxtd1XMCFmNp7oY4vxlFLM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BB579F804FE;
	Thu, 21 Apr 2022 22:32:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6D7EBF80536; Thu, 21 Apr 2022 22:32:51 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D543AF80507
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2022 22:32:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D543AF80507
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="UoLIvZUI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650573164; x=1682109164;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=F8zk+agD4BJAVcs4I4XR3/E7p3eYhXuY6cReY/P867g=;
 b=UoLIvZUIHCXFqGTRNgLfQANdFGrKEWsgBWitb4JR+zd4zuAmvvG3Q73l
 cPYQAQdHtoDx0QOPfepzYkOSmzMh7ZxJ2VrUCqtbDELRRxaTGNGpV5Cy5
 idBLbZcU8qMlRIDGDkPTFjwfNEe2PAOOpd1MKow9oAaYBdopbZD8M3/Fd
 IUz+OV7BTVDzwtpnGlExsM3Ykp8kPKNAa7VB4p8fQ1liUniddUaEmBViS
 GE0P7ModOPjGN6tfc4BFU7v9u/knMhcBfzxjo112iIlMUgIiewSwDyvwq
 dYs2OmyxoWj3Dw1RDjgfo+CPrRT2wrz417VSx1Eq3wPRpXilk/jsnlsJ6 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="245047612"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; d="scan'208";a="245047612"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2022 13:32:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; d="scan'208";a="577455769"
Received: from qingsu-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.212.148.250])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2022 13:32:14 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 05/14] ASoC: SOF: Intel: hda-dai: use snd_soc_dai_get_widget()
 helper
Date: Thu, 21 Apr 2022 15:31:52 -0500
Message-Id: <20220421203201.1550328-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220421203201.1550328-1-pierre-louis.bossart@linux.intel.com>
References: <20220421203201.1550328-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Rander Wang <rander.wang@intel.com>,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>
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

Use helper instead of open-coding the same thing multiple times.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/intel/hda-dai.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index 3113f61ae7370..245009809894b 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -203,10 +203,7 @@ static int hda_dai_hw_params(struct snd_pcm_substream *substream,
 
 	stream_tag = hdac_stream(hext_stream)->stream_tag;
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		w = dai->playback_widget;
-	else
-		w = dai->capture_widget;
+	w = snd_soc_dai_get_widget(dai, substream->stream);
 
 	/* set up the DAI widget and send the DAI_CONFIG with the new tag */
 	ret = hda_dai_widget_update(w, stream_tag - 1, true);
@@ -359,10 +356,7 @@ static int hda_dai_hw_free(struct snd_pcm_substream *substream,
 
 	hda_stream = hstream_to_sof_hda_stream(hext_stream);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		w = dai->playback_widget;
-	else
-		w = dai->capture_widget;
+	w = snd_soc_dai_get_widget(dai, substream->stream);
 
 	/* free the link DMA channel in the FW and the DAI widget */
 	ret = hda_dai_widget_update(w, DMA_CHAN_INVALID, false);
@@ -407,10 +401,7 @@ static int ssp_dai_setup_or_free(struct snd_pcm_substream *substream, struct snd
 {
 	struct snd_soc_dapm_widget *w;
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		w = dai->playback_widget;
-	else
-		w = dai->capture_widget;
+	w = snd_soc_dai_get_widget(dai, substream->stream);
 
 	if (setup)
 		return hda_ctrl_dai_widget_setup(w, SOF_DAI_CONFIG_FLAGS_NONE, NULL);
-- 
2.30.2

