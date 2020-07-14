Return-Path: <SRS0=Ss6N=AZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF55C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:29:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89D702245A
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Fp+cg9x6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D702245A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1B09B1660;
	Tue, 14 Jul 2020 14:29:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1B09B1660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594729796;
	bh=zFwpH1r6/0ba8AC04QbvDI4fYPGF2/e1Dd3TP/mE6oc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fp+cg9x6iA1+stLwL1N70/h7LBWQ11A1JwmsTcp/x92J8U5fN7MfvflMtQrLi+B8l
	 MTdQyQeTgAFDL6IIisS0tHmHRbNG7dEKZZcKP4XyaS7ciVLTb4wupvJnNMW7amfvIk
	 4Si5XPm1FLQ2HkO7EUkcALTyWxlUTOAtxymrY19Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 95CEBF802BE;
	Tue, 14 Jul 2020 14:26:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4B5D7F8026F; Tue, 14 Jul 2020 14:26:45 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 32237F801EC
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 14:26:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32237F801EC
IronPort-SDR: RO5vAzlfq8mcu6RihWHkco+7g8VJfhVBQrB8jMBO7Apms6vKBTcSf2+4g9N+eD3uX8mx6xqzxN
 IOFWWtE1Pi7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="166981786"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="166981786"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 05:26:30 -0700
IronPort-SDR: nWpZ+aq55LLnKlLnAfnABKEKzqUj8dssW0r3Oj0xBrPyCIY4fBi9tXliN0cGQHXlDXlLUQF3XL
 WZMBDXvugK2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="485860413"
Received: from test-hp-compaq-8100-elite-cmt-pc.igk.intel.com ([10.237.149.93])
 by fmsmga005.fm.intel.com with ESMTP; 14 Jul 2020 05:26:28 -0700
From: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v3 03/10] topology: decode: Remove decoding values for enum
 control
Date: Tue, 14 Jul 2020 13:25:04 +0200
Message-Id: <1594725911-14308-4-git-send-email-piotrx.maziarz@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594725911-14308-1-git-send-email-piotrx.maziarz@linux.intel.com>
References: <1594725911-14308-1-git-send-email-piotrx.maziarz@linux.intel.com>
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

Values have no representation in standard ALSA configuration files,
therefore there is no need to populate them. Also memory for values
wasn't allocated which was causing undefined behaviour.

Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
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

