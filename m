Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7945BC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Mar 2022 04:30:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B3ECB16F3;
	Thu, 10 Mar 2022 05:29:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B3ECB16F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646886637;
	bh=vqxJCGfKK1aFARKmjRI10bWwmKTRKUy5GX+L15uh40Y=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KCTSGVWYm8OSxH4AjX9Ik8tGmgdGnLruyRefFYufFENlhFMilxQrItC0Q21QEF4uZ
	 DyUtVa60G+HBOrr9u3pneBLpvYhydAsyiLxWDxEDJv7sjC7/x/XECACHYlvApCL6ts
	 uCd8XcR9zGlrp6a5IA6TdsqR6ZLPIrBNjP61GAyY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BDF2EF80516;
	Thu, 10 Mar 2022 05:28:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EDD7DF8051B; Thu, 10 Mar 2022 05:27:54 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0DC24F8015B
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2022 05:27:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0DC24F8015B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="GpYft+j/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646886467; x=1678422467;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vqxJCGfKK1aFARKmjRI10bWwmKTRKUy5GX+L15uh40Y=;
 b=GpYft+j/eSld9UqoX0WZ/ArOxd8Mm1fvd3p5sfC3Ke7k4HxlURpTNPIX
 cTNMlXrWoYPmfa83ZtmRH+Pvhb6xd9cEhI5x8HdptBaARtfX4s4KoJNW5
 C8NeQT45PZIKL8/qFnkJfHvqz+rE10V4OdNSKMdJUm8lj9wJnKZBXs9ST
 0oqQuSwMznX1CL6BMiB+IjldUOpU9dgsSs5x5GwtnhUi6SWa1Bnzyc8Ks
 EWVOy1Z4zRqU6Fzz3nSXLJjGflJH1Pugbru4IAeeP8Lt0l2pn7XaqmTgG
 zvUBRJa/BjhZ42eJgtOplRq81qDB1A9d9PdvveLpETNWGVQgLmiRdxEJq Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="318380889"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; d="scan'208";a="318380889"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2022 20:27:32 -0800
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; d="scan'208";a="547884681"
Received: from ttahmed-mobl2.amr.corp.intel.com (HELO
 rsridh2-mobl1.localdomain) ([10.254.50.225])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2022 20:27:32 -0800
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 05/10] ASoC: SOF: Mark snd_sof_dsp_ops.ipc_pcm_params()
 callback optional
Date: Wed,  9 Mar 2022 20:27:15 -0800
Message-Id: <20220310042720.976809-6-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310042720.976809-1-ranjani.sridharan@linux.intel.com>
References: <20220310042720.976809-1-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>
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

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

AMD is only implementing an empty function to pass the required test and
it is going to be deprecated in favor of the IPC agnostic
set_stream_data_offset() callback.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/core.c     | 3 +--
 sound/soc/sof/ops.h      | 5 ++++-
 sound/soc/sof/sof-priv.h | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 95a845d26f6e..9217644e2eab 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -361,8 +361,7 @@ int snd_sof_device_probe(struct device *dev, struct snd_sof_pdata *plat_data)
 	if (!sof_ops(sdev) || !sof_ops(sdev)->probe || !sof_ops(sdev)->run ||
 	    !sof_ops(sdev)->block_read || !sof_ops(sdev)->block_write ||
 	    !sof_ops(sdev)->send_msg || !sof_ops(sdev)->load_firmware ||
-	    !sof_ops(sdev)->ipc_msg_data || !sof_ops(sdev)->ipc_pcm_params ||
-	    !sof_ops(sdev)->fw_ready) {
+	    !sof_ops(sdev)->ipc_msg_data || !sof_ops(sdev)->fw_ready) {
 		dev_err(dev, "error: missing mandatory ops\n");
 		return -EINVAL;
 	}
diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
index f21d4a7ac261..aeea73efcb2f 100644
--- a/sound/soc/sof/ops.h
+++ b/sound/soc/sof/ops.h
@@ -473,7 +473,10 @@ snd_sof_ipc_pcm_params(struct snd_sof_dev *sdev,
 		       struct snd_pcm_substream *substream,
 		       const struct sof_ipc_pcm_params_reply *reply)
 {
-	return sof_ops(sdev)->ipc_pcm_params(sdev, substream, reply);
+	if (sof_ops(sdev) && sof_ops(sdev)->ipc_pcm_params)
+		return sof_ops(sdev)->ipc_pcm_params(sdev, substream, reply);
+
+	return 0;
 }
 
 /* host side configuration of the stream's data offset in stream mailbox area */
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 3a2804c82bae..2791d25f7ac3 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -224,7 +224,7 @@ struct snd_sof_dsp_ops {
 	/* host configure DSP HW parameters */
 	int (*ipc_pcm_params)(struct snd_sof_dev *sdev,
 			      struct snd_pcm_substream *substream,
-			      const struct sof_ipc_pcm_params_reply *reply); /* mandatory */
+			      const struct sof_ipc_pcm_params_reply *reply); /* optional */
 
 	/* host side configuration of the stream's data offset in stream mailbox area */
 	int (*set_stream_data_offset)(struct snd_sof_dev *sdev,
-- 
2.25.1

