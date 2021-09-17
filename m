Return-Path: <SRS0=EuHN=OH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6260BC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Sep 2021 09:00:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 310BB6113A
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Sep 2021 09:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 310BB6113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C312317D2;
	Fri, 17 Sep 2021 10:59:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C312317D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631869235;
	bh=CVKK4udkRyCjKgYJxXTSEkWZlH4l+5Ch+57Ia635+QM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eUoqPv7StFO+ykCzZ4LGK1Zv6AuqyuRgi1HSBUvQW76Ym2syLQVO+NXWPs2in5hrg
	 zO3YAuzUlN1MdTNgykWMOqc2QRRzEpVu5BGuubayQ5gzcAnhPdVMKE/cLa5cdqGFNa
	 cxg1EVaZsDh/+YfppcJYlmsJ8O1cACgl+v0Nvl0U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A565CF804E5;
	Fri, 17 Sep 2021 10:58:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CC955F804E1; Fri, 17 Sep 2021 10:58:52 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C6A5EF8032C
 for <alsa-devel@alsa-project.org>; Fri, 17 Sep 2021 10:58:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C6A5EF8032C
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="308300250"
X-IronPort-AV: E=Sophos;i="5.85,300,1624345200"; d="scan'208";a="308300250"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2021 01:58:32 -0700
X-IronPort-AV: E=Sophos;i="5.85,300,1624345200"; d="scan'208";a="473064391"
Received: from akostadi-mobl2.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.251.216.45])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2021 01:58:30 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com
Subject: [PATCH 2/2] ASoC: SOF: ipc: Print 0x prefix for errors in
 ipc_trace/stream_message()
Date: Fri, 17 Sep 2021 11:58:23 +0300
Message-Id: <20210917085823.27222-3-peter.ujfalusi@linux.intel.com>
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

The dev_err() in ipc_trace_message() and ipc_stream_message() is missing
the 0x prefix for the hexadecimal number when printed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 sound/soc/sof/ipc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc.c b/sound/soc/sof/ipc.c
index 2d7e942a3c70..a916812a0f64 100644
--- a/sound/soc/sof/ipc.c
+++ b/sound/soc/sof/ipc.c
@@ -465,7 +465,7 @@ static void ipc_trace_message(struct snd_sof_dev *sdev, u32 msg_type)
 		snd_sof_trace_update_pos(sdev, &posn);
 		break;
 	default:
-		dev_err(sdev->dev, "error: unhandled trace message %x\n", msg_type);
+		dev_err(sdev->dev, "error: unhandled trace message %#x\n", msg_type);
 		break;
 	}
 }
@@ -547,7 +547,7 @@ static void ipc_stream_message(struct snd_sof_dev *sdev, u32 msg_cmd)
 		ipc_xrun(sdev, msg_id);
 		break;
 	default:
-		dev_err(sdev->dev, "error: unhandled stream message %x\n",
+		dev_err(sdev->dev, "error: unhandled stream message %#x\n",
 			msg_id);
 		break;
 	}
-- 
2.33.0

