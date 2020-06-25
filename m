Return-Path: <SRS0=XzTt=AG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B42C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:06:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 922A320720
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ujcQWI0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 922A320720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4FED41835;
	Thu, 25 Jun 2020 14:05:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4FED41835
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593086797;
	bh=NLmXwO3fl6JiDSplUQObqbKRReUnA2vhb3UubkhmDbk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ujcQWI0fvOAjc3xsqftLoHnj7UaUsPkP7kwvsC6NmhFuQpYAf+4mPP0TjAYgFXt2F
	 U6RztKoc/uAfhhhDSJdu6zh/ogYVd2iFf1O0tj2eNcLIuladpJYPuADI541OKk6mqA
	 yPCygHJIPIYHzJteGz3dbaL/1suYdhx78ktOAsE8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CB8B9F80158;
	Thu, 25 Jun 2020 14:05:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 62EABF80277; Thu, 25 Jun 2020 14:05:44 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C4B33F80158
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2020 14:05:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C4B33F80158
IronPort-SDR: MC8iEsh0ZUQdVxBKwZQLtvMorHAqM6m+O21Tr+gDvbR4ysiRsHlumJ0yyS3I9DN7cRY8Ln933O
 C4xR0TfoLfqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="206389918"
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; d="scan'208";a="206389918"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2020 05:05:34 -0700
IronPort-SDR: b2dJ3CrglRbVnPhLMpsJhyqJDAhBnh0VUZ1SA9TK7BhCEf609jGyLpdfaQNiZQHrIv4y2U8xHn
 yXQC3HrC1vcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; d="scan'208";a="354438926"
Received: from test-hp-compaq-8100-elite-cmt-pc.igk.intel.com ([10.237.149.93])
 by orsmga001.jf.intel.com with ESMTP; 25 Jun 2020 05:05:33 -0700
From: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib 1/8] topology: decode: fix channel map memory
 allocation
Date: Thu, 25 Jun 2020 13:03:39 +0200
Message-Id: <1593083026-7501-1-git-send-email-piotrx.maziarz@linux.intel.com>
X-Mailer: git-send-email 2.7.4
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

Without proper memory allocation behaviour was undefined.

Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
---
 src/topology/ctl.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/src/topology/ctl.c b/src/topology/ctl.c
index 90241b6..c8c7e94 100644
--- a/src/topology/ctl.c
+++ b/src/topology/ctl.c
@@ -1330,7 +1330,6 @@ int tplg_decode_control_enum1(snd_tplg_t *tplg,
 			      void *bin, size_t size)
 {
 	struct snd_soc_tplg_enum_control *ec = bin;
-	struct snd_tplg_channel_map_template cmt;
 	int i;
 
 	if (size < sizeof(*ec)) {
@@ -1375,11 +1374,11 @@ int tplg_decode_control_enum1(snd_tplg_t *tplg,
 		}
 	}
 
-	et->map = &cmt;
-	memset(&cmt, 0, sizeof(cmt));
-	cmt.num_channels = ec->num_channels;
-	for (i = 0; i < cmt.num_channels; i++) {
-		struct snd_tplg_channel_elem *channel = &cmt.channel[i];
+	et->map = tplg_calloc(heap, sizeof(struct snd_tplg_channel_map_template));
+	et->map->num_channels = ec->num_channels;
+	for (i = 0; i < et->map->num_channels; i++) {
+		struct snd_tplg_channel_elem *channel = &et->map->channel[i];
+
 		tplg_log(tplg, 'D', pos + ((void *)&ec->channel[i] - (void *)ec),
 			 "enum: channel size %d", ec->channel[i].size);
 		channel->reg = ec->channel[i].reg;
-- 
2.7.4

