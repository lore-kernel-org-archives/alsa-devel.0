Return-Path: <SRS0=rI3+=CL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4074AC433E7
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:28:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43B020767
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="liUNzByT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43B020767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 453DA189B;
	Wed,  2 Sep 2020 23:27:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 453DA189B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599082083;
	bh=zUTsCy7/7fcCVCyQCW9W2ess/aluYwFYoA/9h0Wtgpk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=liUNzByTf2ATqdV0jgEF3tp7t6bNi+EB7EvqGwS9R8uy5wE02Bfcd1FZQQg+CVbpr
	 4yoFE0dNM+E7I63VFL5lzwhM8QXSHKvqD1wTWdNR1nlvn3UAiyZUrQpFIpB5yC9pmr
	 y5dCYnKhoJ9E1xA/HZ+IZtgaA9h5Dr2gACcClAQg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8772DF80308;
	Wed,  2 Sep 2020 23:22:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 59F5CF80305; Wed,  2 Sep 2020 23:22:29 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DAA01F802BC
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2020 23:22:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DAA01F802BC
IronPort-SDR: 88kus5pVCmw1p7XNxgAZf0AhgPDuRA+hhmx0kkDxugwqzrnehU0ac8Cmcm5VE3SasFca9UfLsq
 gAU9DAItr74Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="157482868"
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="157482868"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 14:22:05 -0700
IronPort-SDR: 14Ixlj80XKVk5gnk7Lucy8ezRNuX8l/tZxoyyXl1ALv2acfios202mM+3QxgH5nfXKUpngMBc7
 oRgHyc4UtEWg==
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="477798280"
Received: from rnagarat-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.56.27])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 14:22:04 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 08/18] ALSA: core: init: use DECLARE_COMPLETION_ONSTACK() macro
Date: Wed,  2 Sep 2020 16:21:23 -0500
Message-Id: <20200902212133.30964-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902212133.30964-1-pierre-louis.bossart@linux.intel.com>
References: <20200902212133.30964-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, vkoul@kernel.org, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Follow recommendation in Documentation/scheduler/completion.rst and use
macro to declare local 'struct completion'

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/core/init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index 0478847ba2b8..764dbe673d48 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -519,10 +519,9 @@ EXPORT_SYMBOL(snd_card_free_when_closed);
  */
 int snd_card_free(struct snd_card *card)
 {
-	struct completion released;
+	DECLARE_COMPLETION_ONSTACK(released);
 	int ret;
 
-	init_completion(&released);
 	card->release_completion = &released;
 	ret = snd_card_free_when_closed(card);
 	if (ret)
-- 
2.25.1

