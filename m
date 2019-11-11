Return-Path: <SRS0=1ACS=ZD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E537C17441
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 22:35:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E172421872
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 22:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oPMj5P4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E172421872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BEAE31679;
	Mon, 11 Nov 2019 23:34:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BEAE31679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573511743;
	bh=cH7T51NQWvI7c0/RGWgF7aPPX9hXeAEdsM/6N98iaE8=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oPMj5P4G1LfsGiP167LaXCCzflhHZJC2uA5HZ0hXEhpB77tLLyADPDwuC5buanA5C
	 41U0P0RD20r4gBDGif+L6YyRm8yqzIDaPLSZ2oXRJ679E1tZKzvXvZ2v8e7GQU29/E
	 KHHVciNMr6hHyKIP0V3ajouazOw6aKNuqH8vSpLc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 867A7F80275;
	Mon, 11 Nov 2019 23:34:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 06ADCF805FB; Mon, 11 Nov 2019 23:33:58 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F14FEF8015C
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2019 23:33:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F14FEF8015C
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Nov 2019 14:33:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,294,1569308400"; d="scan'208";a="354903224"
Received: from kathyche-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.27.186])
 by orsmga004.jf.intel.com with ESMTP; 11 Nov 2019 14:33:50 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Mon, 11 Nov 2019 16:33:40 -0600
Message-Id: <20191111223343.19986-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191111223343.19986-1-pierre-louis.bossart@linux.intel.com>
References: <20191111223343.19986-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org, Keyon Jie <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 1/4] ASoC: SOF: PM: add state machine to
	comments
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

Add Audio DSP state machine with comments. Note that the
'D0<-->runtime D0I3' part is not implemented yet.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/pm.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/sound/soc/sof/pm.c b/sound/soc/sof/pm.c
index 560a937e0484..3204c92f0e7d 100644
--- a/sound/soc/sof/pm.c
+++ b/sound/soc/sof/pm.c
@@ -428,6 +428,38 @@ int snd_sof_set_d0_substate(struct snd_sof_dev *sdev,
 }
 EXPORT_SYMBOL(snd_sof_set_d0_substate);
 
+/*
+ * Audio DSP states may transform as below:-
+ *
+ *                                         D0I3 compatible stream
+ *     Runtime    +---------------------+   opened only, timeout
+ *     suspend    |                     +--------------------+
+ *   +------------+       D0(active)    |                    |
+ *   |            |                     <---------------+    |
+ *   |   +-------->                     |               |    |
+ *   |   |Runtime +--^--+---------^--+--+ The last      |    |
+ *   |   |resume     |  |         |  |    opened D0I3   |    |
+ *   |   |           |  |         |  |    compatible    |    |
+ *   |   |     resume|  |         |  |    stream closed |    |
+ *   |   |      from |  | D3      |  |                  |    |
+ *   |   |       D3  |  |suspend  |  | d0i3             |    |
+ *   |   |           |  |         |  |suspend           |    |
+ *   |   |           |  |         |  |                  |    |
+ *   |   |           |  |         |  |                  |    |
+ * +-v---+-----------+--v-------+ |  |           +------+----v----+
+ * |                            | |  +----------->                |
+ * |       D3 (suspended)       | |              |      D0I3      +-----+
+ * |                            | +--------------+                |     |
+ * |                            |  resume from   |                |     |
+ * +-------------------^--------+  d0i3 suspend  +----------------+     |
+ *                     |                                                |
+ *                     |                       D3 suspend               |
+ *                     +------------------------------------------------+
+ *
+ * d0i3_suspend = s0_suspend && D0I3 stream opened,
+ * D3 suspend = !d0i3_suspend,
+ */
+
 int snd_sof_resume(struct device *dev)
 {
 	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
