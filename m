Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65D8C433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:39:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58098206E2
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dNjWESJD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58098206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF3FB16DC;
	Thu,  2 Jul 2020 21:38:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF3FB16DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593718740;
	bh=sNHxeLXRr0SwKX7KQR68Jf5iMb5fWgOvRSwaONvhePY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dNjWESJDgmCvnhxcc/sAO4xgzbubjm6e2fVAMmv2SRWmMDUbs3Zb0G9W9J0aVZqUu
	 I8ipx5znOsJdxj3qAcsRe0J68vNIS3wfsgvZCPYw5I2AEYeLizx/CfqGmy5O06Xyig
	 NROdZ3vHeoYk8GOld0KawMyjg9CN2kePqZbbAXMY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DE31AF80247;
	Thu,  2 Jul 2020 21:36:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE057F802BE; Thu,  2 Jul 2020 21:36:34 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00F45F80134
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 21:36:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00F45F80134
IronPort-SDR: Tq9wDaTS0c18lyIUaJttiTq6uL+6qdqIlbAhhBfRJAvl74oexH41e0Rqwx8U/vNpBtB6bdO8Ko
 0EC9URpUWgxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="148549341"
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="148549341"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 12:36:19 -0700
IronPort-SDR: fvBg1jMAQ7rIJOMiidmlqdN9+HSH51S2p7F2mv9M24hEduWlrPV05x4j/cQg6BNH+ydPqLW0ku
 rR6KNPQCy7ew==
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="482116356"
Received: from dhprice-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.75.219])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 12:36:18 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH 02/23] ALSA: isa/gus: remove 'set but not used' warning
Date: Thu,  2 Jul 2020 14:35:43 -0500
Message-Id: <20200702193604.169059-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702193604.169059-1-pierre-louis.bossart@linux.intel.com>
References: <20200702193604.169059-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Fix W=1 warning by noting variable as __always_unused.

sound/isa/gus/gus_uart.c: In function ‘snd_gf1_interrupt_midi_in’:
sound/isa/gus/gus_uart.c:16:22: warning: variable ‘data’ set but not
used [-Wunused-but-set-variable]
   16 |  unsigned char stat, data, byte;

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/isa/gus/gus_uart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/isa/gus/gus_uart.c b/sound/isa/gus/gus_uart.c
index 7586619770b3..4fb4ed79e262 100644
--- a/sound/isa/gus/gus_uart.c
+++ b/sound/isa/gus/gus_uart.c
@@ -13,7 +13,8 @@
 static void snd_gf1_interrupt_midi_in(struct snd_gus_card * gus)
 {
 	int count;
-	unsigned char stat, data, byte;
+	unsigned char stat, byte;
+	__always_unused unsigned char data;
 	unsigned long flags;
 
 	count = 10;
-- 
2.25.1

