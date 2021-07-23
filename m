Return-Path: <SRS0=VrYT=MP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183E1C4338F
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Jul 2021 03:31:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4715360EBD
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Jul 2021 03:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4715360EBD
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E864316E4;
	Fri, 23 Jul 2021 05:30:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E864316E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627011084;
	bh=OW3HVwzvJcnCkUNybqsFTlT/PEYWV8Yx9+je4Qnn8wY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=khsAW1wca82mkeiT5xj+cBfksSORUp0aqJPYghaRZ85h2BAYWFPj580noyBBxfl/O
	 Nw8jC7mPMAvHV/4jQuweuA7ihN16N/0mPOZaYsDSAk+PF6aiFf4xcOn5anOeHT1soy
	 OWuppQ9pfigBcb/2RIVb024tiGdWQM2yjcUC0dOY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 52F6EF804AB;
	Fri, 23 Jul 2021 05:30:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B367AF8016C; Fri, 23 Jul 2021 05:30:24 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id DA3D3F800DA
 for <alsa-devel@alsa-project.org>; Fri, 23 Jul 2021 05:30:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA3D3F800DA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1627011009456574917-webhooks-bot@alsa-project.org>
References: <1627011009456574917-webhooks-bot@alsa-project.org>
Subject: sof-hda-dsp: Set Capture Switch on in the BootSequence
Message-Id: <20210723033024.B367AF8016C@alsa1.perex.cz>
Date: Fri, 23 Jul 2021 05:30:24 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #107 was opened from jason77-wang:

We found an issue that the PA source of Mic2/Headset and Mic2 is
muted by default after newly install an OS, the root cause is the
'Capture Switch' is set to off in the kernel.

Without ucm, the /usr/share/alsa/init/default will set the 'Capture
Switch' to on, similarly we set it to on in the BootSequence of ucm.

Signed-off-by: Hui Wang <hui.wang@canonical.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/107
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/107.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
