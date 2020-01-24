Return-Path: <SRS0=dQ5X=3N=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3392C2D0DB
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jan 2020 21:37:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC5E2071E
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jan 2020 21:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iW+lFRGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC5E2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C8A40166B;
	Fri, 24 Jan 2020 22:36:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C8A40166B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579901850;
	bh=JcmEett7R76aAl9Htw3oh0EAcdvifwNK5E24J+nE1Vg=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iW+lFRGyZBhZ/9pjjH2WKnVxTpyfaEAkoVyXD8k9fu+BefV4+BYoVGVFiYVnZ49UQ
	 8evr1c8ob+nExSv/3Q8wsAnrHHDV+7YTSgYBe9xIo0Z5dXyvou+7NvyLc8yJWZLfYK
	 4vTBmKQv/WNTg1h1Lx3MnX1wNC1/fc8F0zb/wAZ4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2548FF80245;
	Fri, 24 Jan 2020 22:36:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 417FFF80245; Fri, 24 Jan 2020 22:36:38 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C37BF800BA
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2020 22:36:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C37BF800BA
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Jan 2020 13:36:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,359,1574150400"; d="scan'208";a="294313419"
Received: from sascates-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.4.164])
 by fmsmga001.fm.intel.com with ESMTP; 24 Jan 2020 13:36:29 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Fri, 24 Jan 2020 15:36:19 -0600
Message-Id: <20200124213625.30186-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124213625.30186-1-pierre-louis.bossart@linux.intel.com>
References: <20200124213625.30186-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 1/7] ASoC: SOF: fix an Oops,
	caused by invalid topology
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

From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

It is possible to create invalid topology that will cause a kernel
Oops when trying to allocate buffers for a NULL substream.
Specifically such an Oops was caused by a topology, where a DAI on a
capture pipeline was referencing the PCM ID from a playback pipeline.
Fix the Oops by explicitly checking for NULL.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/pcm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 314f3095c12f..29435ba2d329 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -591,6 +591,11 @@ static int sof_pcm_new(struct snd_soc_component *component,
 		"spcm: allocate %s playback DMA buffer size 0x%x max 0x%x\n",
 		caps->name, caps->buffer_size_min, caps->buffer_size_max);
 
+	if (!pcm->streams[stream].substream) {
+		dev_err(component->dev, "error: NULL playback substream!\n");
+		return -EINVAL;
+	}
+
 	snd_pcm_set_managed_buffer(pcm->streams[stream].substream,
 				   SNDRV_DMA_TYPE_DEV_SG, sdev->dev,
 				   le32_to_cpu(caps->buffer_size_min),
@@ -609,6 +614,11 @@ static int sof_pcm_new(struct snd_soc_component *component,
 		"spcm: allocate %s capture DMA buffer size 0x%x max 0x%x\n",
 		caps->name, caps->buffer_size_min, caps->buffer_size_max);
 
+	if (!pcm->streams[stream].substream) {
+		dev_err(component->dev, "error: NULL capture substream!\n");
+		return -EINVAL;
+	}
+
 	snd_pcm_set_managed_buffer(pcm->streams[stream].substream,
 				   SNDRV_DMA_TYPE_DEV_SG, sdev->dev,
 				   le32_to_cpu(caps->buffer_size_min),
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
