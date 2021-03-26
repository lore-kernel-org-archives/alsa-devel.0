Return-Path: <SRS0=Z4e1=IY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC8AC433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FDF861953
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDF861953
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 442E516A4;
	Fri, 26 Mar 2021 23:05:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 442E516A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616796403;
	bh=3M6I5GvHiJomyBHDvfRbRiprI4yyHzb07pzIcPF0vJE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LwzJlJPpPERBgubXyA1rKawCOnmfHOf8G03zT2reK8XOpLqINGDjE/6Hjktpwo3Qc
	 1UIn+84s8GzMQhNhE+e1ziGJFrHyiUMOYI5bu4Ls5VGtkvFLUFnXI18fqum1vIfAx1
	 nPt3TGB+OOfu92/aEVBH9iTmiN1K0d+0jkxDfjWQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C32AFF8050F;
	Fri, 26 Mar 2021 23:00:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BBB3AF804BD; Fri, 26 Mar 2021 23:00:25 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 63087F804AA
 for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2021 23:00:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63087F804AA
IronPort-SDR: ROX2pDU7Q2B9SFSrKD5Wra0s0J67tatXfNFlTHKqPO9tQJQP1wrTgpJ7hhg6GQo1aRPhhr2ODE
 iWDaN7RpXj5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="211396766"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; d="scan'208";a="211396766"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 15:00:18 -0700
IronPort-SDR: ASrSkSy8ZzswgpddkfExnkweIrF0cmWYNKVfEIkWOgDZgL5x4QQMuVTx979VYSanpiBWsvpsoE
 oMy7OKeqDUbw==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; d="scan'208";a="416706935"
Received: from zcmahone-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.255.231.203])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 15:00:17 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 15/17] ASoC: ti: omap-mcsp: remove duplicate test
Date: Fri, 26 Mar 2021 16:59:25 -0500
Message-Id: <20210326215927.936377-16-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: "open list:OMAP AUDIO SUPPORT" <linux-omap@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>
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

cppcheck warning:

sound/soc/ti/omap-mcbsp.c:379:11: style: The if condition is the same
as the previous if condition [duplicateCondition]

 if (mcbsp->irq) {
          ^
sound/soc/ti/omap-mcbsp.c:376:11: note: First condition
 if (mcbsp->irq)
          ^
sound/soc/ti/omap-mcbsp.c:379:11: note: Second condition
 if (mcbsp->irq) {
          ^

Keeping two separate tests was probably intentional for clarity, but
since this generates warnings we might as well make cppcheck happy so
that we have fewer warnings.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/ti/omap-mcbsp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
index 6025b30bbe77..db47981768c5 100644
--- a/sound/soc/ti/omap-mcbsp.c
+++ b/sound/soc/ti/omap-mcbsp.c
@@ -373,10 +373,9 @@ static void omap_mcbsp_free(struct omap_mcbsp *mcbsp)
 		MCBSP_WRITE(mcbsp, WAKEUPEN, 0);
 
 	/* Disable interrupt requests */
-	if (mcbsp->irq)
+	if (mcbsp->irq) {
 		MCBSP_WRITE(mcbsp, IRQEN, 0);
 
-	if (mcbsp->irq) {
 		free_irq(mcbsp->irq, (void *)mcbsp);
 	} else {
 		free_irq(mcbsp->rx_irq, (void *)mcbsp);
-- 
2.25.1

