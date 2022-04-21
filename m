Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E49C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Apr 2022 08:09:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BFFF917EE;
	Thu, 21 Apr 2022 10:08:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BFFF917EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650528548;
	bh=zkvthi76P/YE+QkDLNlyF5yXTNxCHupDAXBsGqej12U=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a1wC+C/FsMJckf24JgpcFjXq4jqiIwbxfWb0OOjOZNyhtWRmXhmNlyKUgRDxIHc8Z
	 nnbjEGhGBERvCKg33oo+/tivwGKSW6F4TFJ7WB3fuODTsFnVpQNLhFFfGZbYImcBI2
	 y0Oj7ciTF/mEX7z/fXUIt1CwUfq2Z5sfB7AtQiK8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 01AEFF8051A;
	Thu, 21 Apr 2022 10:07:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E0975F80526; Thu, 21 Apr 2022 10:07:30 +0200 (CEST)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4AE15F80125
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2022 10:07:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4AE15F80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="BXTt+fiX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650528445; x=1682064445;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zkvthi76P/YE+QkDLNlyF5yXTNxCHupDAXBsGqej12U=;
 b=BXTt+fiXRqSBPLXQlOv5MCd4i4+3pVR7sQlvDqg+8ktoB0Thp5TtXiDc
 CAarrrtXD1NagHbv2u5fGVcbsJ0F7stCTw28aB49w/IVba2yJCIFAccdH
 rHdokwaa7cAS5Jy5RiALMZt+5yYIq3uKLQ6c8F2BdH9gqj5AxU7Wm6gHg
 TeCTda6f9Alvf44rW0kYugHm7s+JbOEWkenOeSCTI8zdO/9ZpRhzfH353
 UjhLV4F5DL0DpQcg9BfVE6zxpGA/HZlLmbLnAvEyU9EFMxitrTDSmEw6R
 exFQ0QjybYqzQuWTN0pwIh/oj/eKw3/h723OIqakHDeFkc8U3IKCvOrYI g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="324718782"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; d="scan'208";a="324718782"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2022 01:07:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; d="scan'208";a="577087050"
Received: from dchirca-mobl4.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.251.215.207])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2022 01:07:19 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com, AjitKumar.Pandey@amd.com,
 daniel.baluta@nxp.com
Subject: [PATCH 3/6] ASoC: SOF: amd: Do not set fw_ready callback
Date: Thu, 21 Apr 2022 11:07:32 +0300
Message-Id: <20220421080735.31698-4-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220421080735.31698-1-peter.ujfalusi@linux.intel.com>
References: <20220421080735.31698-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, ranjani.sridharan@linux.intel.com,
 kai.vehmanen@linux.intel.com
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

The fw_ready is handled internally to ipc3 and the callback no longer in
use.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Ajit Pandey <ajitkumar.pandey@amd.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/amd/renoir.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/sof/amd/renoir.c b/sound/soc/sof/amd/renoir.c
index 73f639fa16a4..275f266c5e4d 100644
--- a/sound/soc/sof/amd/renoir.c
+++ b/sound/soc/sof/amd/renoir.c
@@ -152,7 +152,6 @@ struct snd_sof_dsp_ops sof_renoir_ops = {
 	.ipc_msg_data		= acp_sof_ipc_msg_data,
 	.get_mailbox_offset	= acp_sof_ipc_get_mailbox_offset,
 	.irq_thread		= acp_sof_ipc_irq_thread,
-	.fw_ready		= sof_fw_ready,
 
 	/* DAI drivers */
 	.drv			= renoir_sof_dai,
-- 
2.35.3

