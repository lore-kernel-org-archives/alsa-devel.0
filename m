Return-Path: <SRS0=aG7p=AR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6F0C433E1
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:10:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 411F320739
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qZNRYVc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411F320739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D13FA1660;
	Mon,  6 Jul 2020 12:09:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D13FA1660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594030211;
	bh=T/xanlNEuTTonvtvb2U4+LI7LPBI2xUYSv+qe2PzvHo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qZNRYVc3zw5akIqd+5QgZM0MOLt/ddGxGiZCFSZEGm5/jJR3pFtDnOiDARRQxqHtl
	 i2bgoLmJoOpvbNB/nmbZNgppolCQEBPtn/q0e3eRp/9bopn+zcMfv5eR1ZcpEN7Mz6
	 2ppnCO0qruDjsnc2ROd05DnBTQTMguUsdKv8M6uE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2817FF802BC;
	Mon,  6 Jul 2020 12:07:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9ABCF802A0; Mon,  6 Jul 2020 12:07:40 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3FA9EF8015C
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2020 12:07:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3FA9EF8015C
IronPort-SDR: QshCA7UNL6xdGfM5WLlFu36dRqFbVRqIFoNkSDsTtROg+kA8C6KBaJZiyM1BcJkzMLMASbexje
 PbIDsOn0Rrpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="135637962"
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; d="scan'208";a="135637962"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 03:07:35 -0700
IronPort-SDR: xjrdLASryMolo3tWccF9DPC06AA/5uvQjbLrmLleUCXyC/G2Mo9i0q5Ps3DJh0SfxtOl1htd0b
 m8xB0P0etpLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; d="scan'208";a="313912996"
Received: from test-hp-compaq-8100-elite-cmt-pc.igk.intel.com ([10.237.149.93])
 by orsmga008.jf.intel.com with ESMTP; 06 Jul 2020 03:07:34 -0700
From: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 03/10] topology: decode: Remove decoding values for enum
 control
Date: Mon,  6 Jul 2020 11:05:56 +0200
Message-Id: <1594026363-30276-4-git-send-email-piotrx.maziarz@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594026363-30276-1-git-send-email-piotrx.maziarz@linux.intel.com>
References: <1594026363-30276-1-git-send-email-piotrx.maziarz@linux.intel.com>
Cc: cezary.rojewski@intel.com, amadeuszx.slawinski@intel.com
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

Values have no representation in UCM file, therefore there is no need to
populate them. Also memory for values wasn't allocated which was causing
undefined behaviour.

Change-Id: I86b990d20808091eb61fb6710b35a0c1f1cbce10
---
 src/topology/ctl.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/src/topology/ctl.c b/src/topology/ctl.c
index 0aa49ab..02e482e 100644
--- a/src/topology/ctl.c
+++ b/src/topology/ctl.c
@@ -1367,11 +1367,8 @@ int tplg_decode_control_enum1(snd_tplg_t *tplg,
 		et->texts = tplg_calloc(heap, sizeof(char *) * ec->items);
 		if (!et->texts)
 			return -ENOMEM;
-		for (i = 0; i < ec->items; i++) {
-			unsigned int j = i * sizeof(int) * ENUM_VAL_SIZE;
+		for (i = 0; i < ec->items; i++)
 			et->texts[i] = ec->texts[i];
-			et->values[i] = (int *)&ec->values[j];
-		}
 	}
 
 	et->map = tplg_calloc(heap, sizeof(struct snd_tplg_channel_map_template));
-- 
2.7.4

