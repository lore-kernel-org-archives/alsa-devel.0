Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBB0C433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Mar 2022 16:48:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2023917F6;
	Tue,  8 Mar 2022 17:47:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2023917F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646758105;
	bh=i9+nWjF9KpqPOgYOZbJl2zWHl8mmTVk/yRANRnOt52o=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y00vkfqLBxadE6hK6VKL/9LW9MXbsXLRgNojpbGOqEF0Fgkn7BVx8ZZLcpufri9/y
	 D5TMmwK/CbmZyNLFCdya8BWXmQd3cMv8hKgH+/jpRVgJeBpx3Uia4ohwFvJjuzSC0x
	 Qw/+2QdR62ThIA4O7G+AsJanD6k8hAVZieriYliw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EFA59F80558;
	Tue,  8 Mar 2022 17:44:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61261F804F3; Tue,  8 Mar 2022 17:44:20 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 46177F80121
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2022 17:44:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 46177F80121
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="aIsEor5b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646757853; x=1678293853;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=i9+nWjF9KpqPOgYOZbJl2zWHl8mmTVk/yRANRnOt52o=;
 b=aIsEor5biJf6eWMQaniU+jayiQsnVUq/cagbz8j5HGX3yuo4xUuLZqP9
 FPJEMrmuJAPhRgnUgQ9o3iHPzGJ0JKjUJBet4MgjY6e045m5hyDkMe5nG
 cojwvd7eWfzsbOq9NpvcNGJnVrw3TWDGw8rQZuvPf2XXVZna+ElF9NClN
 4qWhYN3wzuFUiunI4dRlc/xy0b+slyXYbgxLCuPU/Yvfvm4okOqdbS9Nu
 K0/eeWqSiBsAg/n9R9vIOaw7qobMMBUpiXB2bHHf5B8Y5VNDMABWZnwbD
 YGY+QkxeIJKzvyhUIBBK95qgm9vNmxRDd527VzlfKarltDGllHn2oCnmA Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="252307218"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; d="scan'208";a="252307218"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 08:43:54 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; d="scan'208";a="537633234"
Received: from bustam3x-mobl.amr.corp.intel.com (HELO
 rsridh2-mobl1.localdomain) ([10.251.130.225])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 08:43:53 -0800
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 05/18] ASoC: SOF: topology: remove redundant code
Date: Tue,  8 Mar 2022 08:43:31 -0800
Message-Id: <20220308164344.577647-6-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308164344.577647-1-ranjani.sridharan@linux.intel.com>
References: <20220308164344.577647-1-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, amadeuszx.slawinski@linux.intel.com,
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

With the change in the commit:
"ASoC: SOF: Intel: hda: assign link DMA channel at run-time",
there is no need to find the CPU DAI in sof_link_hda_load().

Fixes: bdf4ad3fd01f ('ASoC: SOF: Intel: hda: assign link DMA channel at
run-time')

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/topology.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index add0b3009588..15ec59596300 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -3140,7 +3140,6 @@ static int sof_link_hda_load(struct snd_soc_component *scomp, int index,
 {
 	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(scomp);
 	struct snd_soc_tplg_private *private = &cfg->priv;
-	struct snd_soc_dai *dai;
 	u32 size = sizeof(*config);
 	int ret;
 
@@ -3161,13 +3160,6 @@ static int sof_link_hda_load(struct snd_soc_component *scomp, int index,
 	dev_dbg(scomp->dev, "HDA config rate %d channels %d\n",
 		config->hda.rate, config->hda.channels);
 
-	dai = snd_soc_find_dai(link->cpus);
-	if (!dai) {
-		dev_err(scomp->dev, "error: failed to find dai %s in %s",
-			link->cpus->dai_name, __func__);
-		return -EINVAL;
-	}
-
 	config->hda.link_dma_ch = DMA_CHAN_INVALID;
 
 	ret = sof_set_dai_config(sdev, size, link, config);
-- 
2.25.1

