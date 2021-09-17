Return-Path: <SRS0=EuHN=OH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2CFC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Sep 2021 09:00:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B2C561130
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Sep 2021 09:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B2C561130
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC76417C4;
	Fri, 17 Sep 2021 10:59:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC76417C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631869220;
	bh=uChnu/Y4fatw+cJRXVpxBJKN86FIWXktfbhrAAdm1/M=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C4jIYCUjKoScXjj7IysU40CE3GMXWYZjKI2sJjDvCGbZ+XE4Iom8ymDJoA4MTV8BZ
	 SzAjsGBagMaVRzyHmbLxXvy3xMml5DYfqA703uf2n8iWk5BO+eZYAijHrW9zU9NVTo
	 diNhv64xGJoHjjQ8/WlsYbBshFL2AXDymk1B7IF4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5FFEEF80227;
	Fri, 17 Sep 2021 10:58:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1360EF804BD; Fri, 17 Sep 2021 10:58:50 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D281BF80152
 for <alsa-devel@alsa-project.org>; Fri, 17 Sep 2021 10:58:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D281BF80152
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="308300247"
X-IronPort-AV: E=Sophos;i="5.85,300,1624345200"; d="scan'208";a="308300247"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2021 01:58:30 -0700
X-IronPort-AV: E=Sophos;i="5.85,300,1624345200"; d="scan'208";a="473064383"
Received: from akostadi-mobl2.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.251.216.45])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2021 01:58:27 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com
Subject: [PATCH 1/2] ASoC: SOF: ipc: Clarify the parameter name for
 ipc_trace_message()
Date: Fri, 17 Sep 2021 11:58:22 +0300
Message-Id: <20210917085823.27222-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917085823.27222-1-peter.ujfalusi@linux.intel.com>
References: <20210917085823.27222-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: guennadi.liakhovetski@linux.intel.com, alsa-devel@alsa-project.org,
 kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
 daniel.baluta@nxp.com, bard.liao@intel.com
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

ipc_trace_message() receives the type not the ID.
Use the same naming as the ipc_stream_message() function: msg_type to
help the reader to follow the code.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Bard Liao <bard.liao@intel.com>
---
 sound/soc/sof/ipc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/ipc.c b/sound/soc/sof/ipc.c
index a4fe007a0e4d..2d7e942a3c70 100644
--- a/sound/soc/sof/ipc.c
+++ b/sound/soc/sof/ipc.c
@@ -18,7 +18,7 @@
 #include "sof-audio.h"
 #include "ops.h"
 
-static void ipc_trace_message(struct snd_sof_dev *sdev, u32 msg_id);
+static void ipc_trace_message(struct snd_sof_dev *sdev, u32 msg_type);
 static void ipc_stream_message(struct snd_sof_dev *sdev, u32 msg_cmd);
 
 /*
@@ -454,19 +454,18 @@ EXPORT_SYMBOL(snd_sof_ipc_msgs_rx);
  * IPC trace mechanism.
  */
 
-static void ipc_trace_message(struct snd_sof_dev *sdev, u32 msg_id)
+static void ipc_trace_message(struct snd_sof_dev *sdev, u32 msg_type)
 {
 	struct sof_ipc_dma_trace_posn posn;
 
-	switch (msg_id) {
+	switch (msg_type) {
 	case SOF_IPC_TRACE_DMA_POSITION:
 		/* read back full message */
 		snd_sof_ipc_msg_data(sdev, NULL, &posn, sizeof(posn));
 		snd_sof_trace_update_pos(sdev, &posn);
 		break;
 	default:
-		dev_err(sdev->dev, "error: unhandled trace message %x\n",
-			msg_id);
+		dev_err(sdev->dev, "error: unhandled trace message %x\n", msg_type);
 		break;
 	}
 }
-- 
2.33.0

