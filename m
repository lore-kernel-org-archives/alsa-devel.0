Return-Path: <SRS0=9THl=4Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88C7C3F2D2
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Feb 2020 23:20:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36295246B4
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Feb 2020 23:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="u6Jwppvi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36295246B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C01416F4;
	Sat, 29 Feb 2020 00:19:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C01416F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582932004;
	bh=EBUe3yqBPk997DHwdIX9iAR5szU79onmILzbvoZSPgg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u6JwppviBPckmdyKrlktjWJtVaCqiGeNvT3asysMnV4UZs8fyNzGAaVIHtX9EGWyp
	 CUPIPWJ9m/+ouKT5p79y7TaK5RIGbz5Alyzx72VIExPdV/G9FnLV7UOBA1T2qQAWMo
	 ut4HKHEVQ8YTimGSa2jnW/+FtbDwqXjS5dzXpwBc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 467BEF8016F;
	Sat, 29 Feb 2020 00:19:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 05FCBF80246; Sat, 29 Feb 2020 00:19:00 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41F09F8014D
 for <alsa-devel@alsa-project.org>; Sat, 29 Feb 2020 00:18:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41F09F8014D
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Feb 2020 15:18:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,497,1574150400"; d="scan'208";a="272826526"
Received: from billycla-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.95.100])
 by fmsmga002.fm.intel.com with ESMTP; 28 Feb 2020 15:18:53 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/4] ASoC: SOF: pcm: skip DMA buffer pre-allocation
Date: Fri, 28 Feb 2020 17:18:47 -0600
Message-Id: <20200228231850.9226-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228231850.9226-1-pierre-louis.bossart@linux.intel.com>
References: <20200228231850.9226-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org, Keyon Jie <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

From: Keyon Jie <yang.jie@linux.intel.com>

As discussion in ALSA https://patchwork.kernel.org/patch/11336023/, it
is suggested to skip DMA buffer pre-allocation with passing size=0 when
calling snd_pcm_set_managed_buffer(), to make the full buffer_bytes
range configured in topology file selectable from user space, here do
the corresponding change in SOF PCM driver to implement it.

This change doesn't have dependency to the change that Takashi will do
in the ALSA core by adding total_pcm_alloc_bytes limitation to the
struct snd_card, it passes tests both with or without Takashi's coming
change on SOF CML platform.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/pcm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index b239bbff4b5c..f4769e19965a 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -601,8 +601,7 @@ static int sof_pcm_new(struct snd_soc_component *component,
 
 	snd_pcm_set_managed_buffer(pcm->streams[stream].substream,
 				   SNDRV_DMA_TYPE_DEV_SG, sdev->dev,
-				   le32_to_cpu(caps->buffer_size_min),
-				   le32_to_cpu(caps->buffer_size_max));
+				   0, le32_to_cpu(caps->buffer_size_max));
 capture:
 	stream = SNDRV_PCM_STREAM_CAPTURE;
 
@@ -624,8 +623,7 @@ static int sof_pcm_new(struct snd_soc_component *component,
 
 	snd_pcm_set_managed_buffer(pcm->streams[stream].substream,
 				   SNDRV_DMA_TYPE_DEV_SG, sdev->dev,
-				   le32_to_cpu(caps->buffer_size_min),
-				   le32_to_cpu(caps->buffer_size_max));
+				   0, le32_to_cpu(caps->buffer_size_max));
 
 	return 0;
 }
-- 
2.20.1

