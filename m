Return-Path: <SRS0=PPjj=MG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692EFC07E9A
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 16:26:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409FF61377
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 16:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409FF61377
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A27CA167A;
	Wed, 14 Jul 2021 18:26:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A27CA167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626280013;
	bh=yITBmiUeKzClFsMI1hWbfSrj1JsGZm75bjNrcX443so=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=e5/OOsp0vy3rsU4SWIu7ehj6L8rdimPVpgw4TQY+tHeteb4rnuxq8Mq5S3szRZz9I
	 cAvULENhwfy9UPjicvzfKIgQbyCGA01vGU/DgaPlAeCklh6l7SVn9aY6N9khpDr0nl
	 jxWRMC0GLG6MYIUxSG1CfefF7JKY53cXkB71Plic=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A8F1F804E7;
	Wed, 14 Jul 2021 18:24:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B11E6F804A9; Wed, 14 Jul 2021 18:24:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71ACAF80269
 for <alsa-devel@alsa-project.org>; Wed, 14 Jul 2021 18:24:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71ACAF80269
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="nqvzggoB"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="kYHJdYM/"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id E9C87229F7;
 Wed, 14 Jul 2021 16:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626279865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=E6MZ7vTHGU7nF/5rzye0t5v0fzqCMgN1QCrd2ptNr/o=;
 b=nqvzggoB8JGzyu+JHt91CY3rdF1Pwoxz6hN4u90HWs9cWBn6WpP0TGpSVAGOmFf9NhsCl4
 wbhPCDqGA0gomz5U8SUT6pGVtSx/zfI78pNKZPBA5Up9UTXTdzjHzbSduF2BOIFc7E9BzL
 Ty2fAM9rPrvhmAztzYZSsEtko/GZe20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626279865;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=E6MZ7vTHGU7nF/5rzye0t5v0fzqCMgN1QCrd2ptNr/o=;
 b=kYHJdYM/kvmKdJOTpW6nQWqsX4uo5XAw/ojBZg0BDe1pfyB9J8ITNb+iH1rXi5GKiqcm5y
 bVR8WqNVDsQJg8Cg==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id D7D8EA3B89;
 Wed, 14 Jul 2021 16:24:25 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/2] ALSA: compress: Cleanup and a potential fix
Date: Wed, 14 Jul 2021 18:24:22 +0200
Message-Id: <20210714162424.4412-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
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

Hi,

this series contains a couple of patches for compress-offload API, one
for a cleanup of unused API functions and another for the proper mutex
initialization.  I stumbled on the second while doing the first.


Takashi

===

Takashi Iwai (2):
  ALSA: compress: Drop unused functions
  ALSA: compress: Initialize mutex in snd_compress_new()

 include/sound/compress_driver.h |  2 -
 sound/core/compress_offload.c   | 69 +--------------------------------
 sound/soc/soc-compress.c        |  1 -
 3 files changed, 1 insertion(+), 71 deletions(-)

-- 
2.26.2

