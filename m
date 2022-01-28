Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD92C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Jan 2022 12:37:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D02B81744;
	Fri, 28 Jan 2022 13:36:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D02B81744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643373449;
	bh=NCIzESIrSGyiQGKKQ+Hyf2+KBeKqHX2ef76uLea3UDc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fb0howpOnB4zzaJIsHBPI9G0/TAKDTMwbnBKEYJR1naA2nFtwAc3MepXABUjxiULu
	 G5QfGkNiJIvndyYdXiL8u8aVQzYumo/+quY9j3dbMqKPxk+r3N/kbYd3u3FW3Au8C4
	 +bnlMAlYD1Yupkil0gVG7k2fZO69+5kdU/bdCEhs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 14267F80240;
	Fri, 28 Jan 2022 13:36:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EA410F8014B; Fri, 28 Jan 2022 13:36:02 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E9A7EF8014B
 for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2022 13:35:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9A7EF8014B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="OZDcc6Hp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643373360; x=1674909360;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NCIzESIrSGyiQGKKQ+Hyf2+KBeKqHX2ef76uLea3UDc=;
 b=OZDcc6Hp9GQJSQftQcq2CAL8NC+aNthdtG5gYMxA6QbkRF2TqWAh0cXi
 5gTGilnHaLE2sCfvXw1XxbtYTcxKi6zdY1d03uufQOHTN8ltOTXMBeIfP
 zN/dztSfBzpMpvy4chILlGypLMIfwDach5c4MT15CpEj04yVk6kc3rKc6
 W4wbh4puraiQ+4bcGvVoV4vQ3WvAbYnm0QR960YDnNlg+hTIORVPtnXOJ
 GPNLcSDb0CC7Ti7tvdA+eJxh1ydDv+mlQLr8KQfxwNQQRIYOjnNsw2DDy
 7Ptt9SE4t8q88a+fCOtjkpHAaKCEOnM5fYQg1eLWeqFYOOM9ulqkmbVOm Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="310426932"
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; d="scan'208";a="310426932"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2022 04:35:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; d="scan'208";a="536117066"
Received: from dlita-mobl2.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.249.43.152])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2022 04:35:50 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Subject: [PATCH 1/2] ASoC: SOF: intel: hda-trace: Pass the dma buffer pointer
 to hda_dsp_trace_prepare
Date: Fri, 28 Jan 2022 14:36:22 +0200
Message-Id: <20220128123623.23569-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128123623.23569-1-peter.ujfalusi@linux.intel.com>
References: <20220128123623.23569-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
 AjitKumar.Pandey@amd.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, vsreddy@amd.com, daniel.baluta@nxp.com
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

Pass the snd_dma_buffer pointer as parameter to hda_dsp_trace_prepare()
function.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/hda-trace.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/intel/hda-trace.c b/sound/soc/sof/intel/hda-trace.c
index 29e3da3c63db..c5dc833b57b8 100644
--- a/sound/soc/sof/intel/hda-trace.c
+++ b/sound/soc/sof/intel/hda-trace.c
@@ -19,16 +19,15 @@
 #include "../ops.h"
 #include "hda.h"
 
-static int hda_dsp_trace_prepare(struct snd_sof_dev *sdev)
+static int hda_dsp_trace_prepare(struct snd_sof_dev *sdev, struct snd_dma_buffer *dmab)
 {
 	struct sof_intel_hda_dev *hda = sdev->pdata->hw_pdata;
 	struct hdac_ext_stream *stream = hda->dtrace_stream;
 	struct hdac_stream *hstream = &stream->hstream;
-	struct snd_dma_buffer *dmab = &sdev->dmatb;
 	int ret;
 
 	hstream->period_bytes = 0;/* initialize period_bytes */
-	hstream->bufsize = sdev->dmatb.bytes;
+	hstream->bufsize = dmab->bytes;
 
 	ret = hda_dsp_stream_hw_params(sdev, stream, dmab, NULL);
 	if (ret < 0)
@@ -57,7 +56,7 @@ int hda_dsp_trace_init(struct snd_sof_dev *sdev, u32 *stream_tag)
 	 * initialize capture stream, set BDL address and return corresponding
 	 * stream tag which will be sent to the firmware by IPC message.
 	 */
-	ret = hda_dsp_trace_prepare(sdev);
+	ret = hda_dsp_trace_prepare(sdev, &sdev->dmatb);
 	if (ret < 0) {
 		dev_err(sdev->dev, "error: hdac trace init failed: %d\n", ret);
 		hda_dsp_stream_put(sdev, SNDRV_PCM_STREAM_CAPTURE, *stream_tag);
-- 
2.35.0

