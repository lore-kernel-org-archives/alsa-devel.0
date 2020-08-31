Return-Path: <SRS0=wuVw=CJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BE6C433E2
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2020 09:14:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63CFF208CA
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2020 09:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BLaBu+T+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63CFF208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E299C1849;
	Mon, 31 Aug 2020 11:13:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E299C1849
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598865250;
	bh=4tipX2opyLWyj6zkYG9FErrSDcJh1xv5sk1B+NKnnp4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BLaBu+T+nLZz4vIKM/ij7fOUYUGF81AfFeov+EcnXtTdX49nf9M7vd9ArE+u8qb7S
	 d9wYWBa3WFiwO9gakkolXaXr9t/nqNCpklm5IRyPebQDTOhRTDLXyJvyM2WCGbEBmZ
	 VtdIiNnq1Q73863I4R0PT8QeuwGE07/+Ex2XhTEk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 96C79F80306;
	Mon, 31 Aug 2020 11:08:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BA639F802E9; Mon, 31 Aug 2020 11:08:32 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9CD03F802BC
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2020 11:08:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9CD03F802BC
IronPort-SDR: 5h3ugySDcVJv2EXfOZIcKJnfP2/N/1CxJNrLiFuozyvvK/BME81U4lEVBlrj4ENybnxZkbJFci
 fwd91TFrv0Aw==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="136466780"
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; d="scan'208";a="136466780"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 02:08:18 -0700
IronPort-SDR: cRh4TV9tHBkv1spdWoRZ6eqOqGKHpmCwr2YYs8yim8IWA4yPaKX/TRJ2D2X1Le2Pxsxu55LqoA
 qykD1yp3295A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; d="scan'208";a="314286937"
Received: from test-hp-compaq-8100-elite-cmt-pc.igk.intel.com ([10.237.149.93])
 by orsmga002.jf.intel.com with ESMTP; 31 Aug 2020 02:08:16 -0700
From: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v4 09/10] topology: decode: Add DAI name printing
Date: Mon, 31 Aug 2020 11:09:02 +0200
Message-Id: <1598864943-22883-10-git-send-email-piotrx.maziarz@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598864943-22883-1-git-send-email-piotrx.maziarz@linux.intel.com>
References: <1598864943-22883-1-git-send-email-piotrx.maziarz@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com, cezary.rojewski@intel.com,
 amadeuszx.slawinski@linux.intel.com, tiwai@suse.com
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

DAI name is a part of topology binary. Not printing makes data loss while
converting from binary to standard ALSA configuration file.

Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 src/topology/pcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 49c5eab..5a54e15 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -781,7 +781,9 @@ int tplg_save_fe_dai(snd_tplg_t *tplg ATTRIBUTE_UNUSED,
 	struct snd_soc_tplg_pcm *pcm = elem->pcm;
 	int err = 0;
 
-	if (pcm->dai_id > 0)
+	if (strlen(pcm->dai_name))
+		err = tplg_save_printf(dst, pfx, "dai.'%s'.id %u\n", pcm->dai_name, pcm->dai_id);
+	else if (pcm->dai_id > 0)
 		err = tplg_save_printf(dst, pfx, "dai.0.id %u\n", pcm->dai_id);
 	return err;
 }
-- 
2.7.4

