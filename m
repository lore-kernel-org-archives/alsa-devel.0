Return-Path: <SRS0=JibJ=5F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507C2C4332D
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 19:49:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02FCD20739
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 19:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UjUWuw99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02FCD20739
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4633474C;
	Fri, 20 Mar 2020 20:48:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4633474C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584733767;
	bh=s35Evdptbiy4KigF3VeLTreHuXRj+sCFaiyWNUn1Eh0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UjUWuw997kYRr8zB9VyyG7YyFk3qJsVZrxfTqd3e4Wh65JUiMbF2VkeUVP28Gx9Ff
	 Hy9KV79Abk7wFcM/kOJiCUAiuvh3sZWnG5l0vKtBSaClwpimnLOA6wfcJIeFOPfl5j
	 zK0HRAMGDsBvJrcjtHGC2i3xiDWzzFW9uTTPRqWI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C31DAF80139;
	Fri, 20 Mar 2020 20:48:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0F368F8015B; Fri, 20 Mar 2020 20:48:35 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 3BDFAF800DD
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2020 20:48:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3BDFAF800DD
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1584733708997910976-webhooks-bot@alsa-project.org>
References: <1584733708997910976-webhooks-bot@alsa-project.org>
Subject: sof-broadwell-rt286: use symlinks to reuse existing UCM
Message-Id: <20200320194835.0F368F8015B@alsa1.perex.cz>
Date: Fri, 20 Mar 2020 20:48:35 +0100 (CET)
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

alsa-project/alsa-ucm-conf pull request #18 was opened from plbossart:

There are no firmware-specific settings to it's fine to reuse the
legacy file as is.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/18
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/18.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
