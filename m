Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C9EC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jun 2022 21:46:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B52DC1EFC;
	Fri, 10 Jun 2022 23:45:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B52DC1EFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654897572;
	bh=q6e4CzBYiVvQ6+DQWg+G+mAlzv/alAP27AeQc0ewab0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MCFgN5T3cLwbY8zPMFE8tpwY+kOH4fHBwAW1fgNSX1jAMaxAS1EJyzMV6ij3bcVSV
	 Vgi/sR6JVqNeDlGcgtzGlCLaV44iMbxdjRiweMMfhCzWtU+NXbgD2OlIvK4mIf73YE
	 1Iph84QaIE8bdc988CidAWnlKZQYNyHOUrMQzcM4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F478F804D8;
	Fri, 10 Jun 2022 23:45:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1C0CBF804E7; Fri, 10 Jun 2022 23:45:21 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A413F804CF
 for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2022 23:45:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A413F804CF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="CArt7XOa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654897515; x=1686433515;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=q6e4CzBYiVvQ6+DQWg+G+mAlzv/alAP27AeQc0ewab0=;
 b=CArt7XOapcBnnTny/LTl5uyQtsy+L53aQHFJyBDd8SpBZTQYaKi/LgWn
 3D93rm0fHDfqsFygVttKZ8NzCihkuqScoHDFqxsL1D0cMB8sYb4ScB61A
 1/EPhDZ90ge+Ljvum8WubeG9c6MYLjKIxGbheROwrzW1YVcLALd4y+g73
 QCL1CSFmYHUDHLZphSILzg0jTmVEukJD3kJpdvDnMATpcII7OEVT+/W7H
 PGHAHMqQpBqK1PTuMNE3aRVKC3YSgL0N5PEcUeYa6AU10iVVV2ArBegae
 75sqtgjCXHgmvueRtX78+1/mACmh0+ahZLMJjrlsMtDXVnFhZpZx1eXHv g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="364086044"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; d="scan'208";a="364086044"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2022 14:45:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; d="scan'208";a="586402139"
Received: from andrewri-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.126.97])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2022 14:45:10 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: SOF: Intel: hda-dai: enhance debug messages
Date: Fri, 10 Jun 2022 16:45:04 -0500
Message-Id: <20220610214504.42974-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
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

The same message was added twice for dai and link_dma, remove the
latter one and add dai name and direction to better understand
problematic sequences.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/intel/hda-dai.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index 9823230d2ef4a..cb3d253558fe3 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -257,7 +257,6 @@ static int hda_link_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct hdac_ext_stream *hext_stream = snd_soc_dai_get_dma_data(cpu_dai, substream);
 	int ret;
 
-	dev_dbg(cpu_dai->dev, "%s: cmd=%d\n", __func__, cmd);
 	if (!hext_stream)
 		return 0;
 
@@ -408,13 +407,15 @@ static int ipc3_hda_dai_trigger(struct snd_pcm_substream *substream,
 	struct snd_soc_dapm_widget *w;
 	int ret;
 
+	dev_dbg(dai->dev, "%s: cmd=%d dai %s direction %d\n", __func__, cmd,
+		dai->name, substream->stream);
+
 	ret = hda_link_dma_trigger(substream, cmd);
 	if (ret < 0)
 		return ret;
 
 	w = snd_soc_dai_get_widget(dai, substream->stream);
 
-	dev_dbg(dai->dev, "%s: cmd=%d\n", __func__, cmd);
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_STOP:
-- 
2.34.1

