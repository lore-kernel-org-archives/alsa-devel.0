Return-Path: <SRS0=ik9t=YS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290EDCA9EA0
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Oct 2019 22:16:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 192F1205C9
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Oct 2019 22:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cxPsBlEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192F1205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC24618B9;
	Sat, 26 Oct 2019 00:16:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC24618B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572041810;
	bh=HIFPdJPaPOp+lijMf/5GMvSxHWlddRe30REoIYGnA2w=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cxPsBlEZ0iuJZh6Le6zesAnulrUhATYwFQObp5wpXRCmKZotVu9OXJ6cm+5gOe3xE
	 F/ptxgZNDltGIIY6x6uGpwNwY3A8cC+MamMbhU7zDBYnE7Y17HgK+6PF3fRBicPDpQ
	 388ZQgJJGJ6ANZsj13LLkZaj9GQ1fZ6e5YJtIK5k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3BD84F80112;
	Sat, 26 Oct 2019 00:16:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AE33BF8036F; Sat, 26 Oct 2019 00:15:58 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B242F802A0
 for <alsa-devel@alsa-project.org>; Sat, 26 Oct 2019 00:15:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B242F802A0
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 15:15:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400"; d="scan'208";a="201940661"
Received: from annaspen-mobl2.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.251.155.244])
 by orsmga003.jf.intel.com with ESMTP; 25 Oct 2019 15:15:51 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Fri, 25 Oct 2019 17:15:38 -0500
Message-Id: <20191025221538.6668-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org, Keyon Jie <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH] ASoC: SOF: Intel: hda-stream: fix the CONFIG_
	prefix missing
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

From: Keyon Jie <yang.jie@linux.intel.com>

We are missing the 'CONFIG_' prefix when using the kernel configure item
SND_SOC_SOF_HDA_ALWAYS_ENABLE_DMI_L1, here correct them.

Fixes: 43b2ab9009b13b ('ASoC: SOF: Intel: hda: Disable DMI L1 entry during capture')
Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index 450f9c55785f..29ab43281670 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -190,7 +190,7 @@ hda_dsp_stream_get(struct snd_sof_dev *sdev, int direction)
 	 * Workaround to address a known issue with host DMA that results
 	 * in xruns during pause/release in capture scenarios.
 	 */
-	if (!IS_ENABLED(SND_SOC_SOF_HDA_ALWAYS_ENABLE_DMI_L1))
+	if (!IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_ALWAYS_ENABLE_DMI_L1))
 		if (stream && direction == SNDRV_PCM_STREAM_CAPTURE)
 			snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR,
 						HDA_VS_INTEL_EM2,
@@ -228,7 +228,7 @@ int hda_dsp_stream_put(struct snd_sof_dev *sdev, int direction, int stream_tag)
 	spin_unlock_irq(&bus->reg_lock);
 
 	/* Enable DMI L1 entry if there are no capture streams open */
-	if (!IS_ENABLED(SND_SOC_SOF_HDA_ALWAYS_ENABLE_DMI_L1))
+	if (!IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_ALWAYS_ENABLE_DMI_L1))
 		if (!active_capture_stream)
 			snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR,
 						HDA_VS_INTEL_EM2,
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
