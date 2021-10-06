Return-Path: <SRS0=AF2s=O2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DF2C433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 11:11:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E658610E5
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 11:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8E658610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1EE6E1677;
	Wed,  6 Oct 2021 13:10:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1EE6E1677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633518669;
	bh=6N8U3xoLEkCnah+Ig5HLSizHY1cox81x6YzwyNd9Qfs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MyM/88ImuMtlNvyoZGX7DXzIkbiHl++cvRzOuz5QnonKAv8jNT3FgvFViApUAcNsM
	 aTda8GS65Gf1X+4G0/jdDFOiPGDtAgAzNCEKB4uDodaVXP0EXVHRFv6Y+hNTSlcSWt
	 f0sigxN5oeuNv+Lq3ORRqpRDYHxHFpS4F5/Mr9KM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B367BF80528;
	Wed,  6 Oct 2021 13:07:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EB83EF80529; Wed,  6 Oct 2021 13:07:19 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24ADFF80518
 for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2021 13:07:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24ADFF80518
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="223366468"
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; d="scan'208";a="223366468"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2021 04:07:10 -0700
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; d="scan'208";a="439081127"
Received: from byurovit-mobl1.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.249.39.239])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2021 04:07:08 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com
Subject: [PATCH 12/19] ASoC: SOF: ipc: Re-enable dumps after successful IPC tx
Date: Wed,  6 Oct 2021 14:06:38 +0300
Message-Id: <20211006110645.26679-13-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006110645.26679-1-peter.ujfalusi@linux.intel.com>
References: <20211006110645.26679-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: guennadi.liakhovetski@linux.intel.com, alsa-devel@alsa-project.org,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com
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

The dumps are silenced after an IPC tx timeout by default.
The IPC timeout can indicate severe error (firmware crash) or in some cases
it is less devastating and the firmware remains operational, the timeout
was due to a scheduling spike or other anomaly.

In any case consequent IPC timeouts will not print dumps but if any IPC do
succeed than we should re-enable the dumps to print dumps the next time
a timeout might happen.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/ipc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/sof/ipc.c b/sound/soc/sof/ipc.c
index 53593df95155..5c698fa662f4 100644
--- a/sound/soc/sof/ipc.c
+++ b/sound/soc/sof/ipc.c
@@ -267,6 +267,12 @@ static int tx_wait_done(struct snd_sof_ipc *ipc, struct snd_sof_ipc_msg *msg,
 				memcpy(reply_data, msg->reply_data,
 				       msg->reply_size);
 		}
+
+		/* re-enable dumps after successful IPC tx */
+		if (sdev->ipc_dump_printed) {
+			sdev->dbg_dump_printed = false;
+			sdev->ipc_dump_printed = false;
+		}
 	}
 
 	return ret;
-- 
2.33.0

