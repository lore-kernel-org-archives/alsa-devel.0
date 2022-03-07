Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F115DC433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Mar 2022 18:14:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3EF7C176C;
	Mon,  7 Mar 2022 19:14:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3EF7C176C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646676893;
	bh=i9+nWjF9KpqPOgYOZbJl2zWHl8mmTVk/yRANRnOt52o=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IpcFiFcF8vRqmu6BLG1UGke0ISNBwh+wVTP4SC+6pWkdZuqBphdKCcfLKaMTMWaGv
	 p9i3FYlIzIiuOBfNV8XSZQRHwbMSsK7pzHy+G5Nl0sEQNFkeaLk4MTqOu+DrhttfiY
	 Va1y3WLa6F2/IDX/4PHhxiSqmVue/p3H2qXIHPhU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2CD54F80543;
	Mon,  7 Mar 2022 19:11:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 12480F80537; Mon,  7 Mar 2022 19:11:42 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DF5AAF80508
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2022 19:11:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DF5AAF80508
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="S2/yuhFr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646676691; x=1678212691;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=i9+nWjF9KpqPOgYOZbJl2zWHl8mmTVk/yRANRnOt52o=;
 b=S2/yuhFrbhsVEb4tNwSRfoHzStKGhxFS3KNHu9Gq8IPOSEWmlxigW/Vc
 cJ0zVxxDZimmySzZpl9TXl4SJjm1pnd2a3j4S0JCdjruvavh4KJic62Pi
 B5E2P//nRSARM8z8vnkHaosb3uI2dcp3etIy2PPQI2XqC9WT1TYNspL60
 lMWmWKe2EBpnz4y8TDC8Uwnn5v6xL7Eijkqgqq0JhTsbbvR/nRC5k1v6z
 /XmGyLduv6LDo73vVv+uhXlkmCqUzmTkKH0AvxB7IL5BfdUSIyA/o9BUb
 /zN0WPmBcSeyFNPBCE1CvMbd7X4OdGKcEUhDAcYpMcHqYETYAVZvql3q5 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254401316"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; d="scan'208";a="254401316"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2022 10:11:26 -0800
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; d="scan'208";a="495146664"
Received: from echun1-mobl.amr.corp.intel.com (HELO rsridh2-mobl1.localdomain)
 ([10.251.130.219])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2022 10:11:26 -0800
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 05/18] ASoC: SOF: topology: remove redundant code
Date: Mon,  7 Mar 2022 10:10:58 -0800
Message-Id: <20220307181111.49392-6-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307181111.49392-1-ranjani.sridharan@linux.intel.com>
References: <20220307181111.49392-1-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org,
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

