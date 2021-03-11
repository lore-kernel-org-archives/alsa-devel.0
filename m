Return-Path: <SRS0=8+EQ=IJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6F4C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Mar 2021 01:03:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C688664FC1
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Mar 2021 01:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C688664FC1
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B788516F0;
	Thu, 11 Mar 2021 02:02:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B788516F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615424579;
	bh=oNWfCbgHRYtL7A4nJtiVkXpPo9Q3gq78pwnhfinGqLk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G/NebGFFq/YuuE6K3IsOqW5aO+qu9l4iouMtFvLXsHgHm1LS1jLkDbUZ/NXb5LPxx
	 i7JA8SiYjlLUN5RfKcDZdFYvcP/uaXEsXjmzwkr+ksl2UorE85sMXwgBZeo/av8ivK
	 ntb653YSLlsVkmjpHlkRynGuIoaNPkd+zjAxBvo0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3BB23F8014E;
	Thu, 11 Mar 2021 02:02:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 221C7F8012F; Thu, 11 Mar 2021 02:02:08 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 1D046F8012F
 for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2021 02:01:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D046F8012F
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1615424515828613043-webhooks-bot@alsa-project.org>
References: <1615424515828613043-webhooks-bot@alsa-project.org>
Subject: Support for Tascam US-366 card
Message-Id: <20210311010208.221C7F8012F@alsa1.perex.cz>
Date: Thu, 11 Mar 2021 02:02:08 +0100 (CET)
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

alsa-project/alsa-tools issue #5 was opened from sxiii:

Greetings!

It would be really nice to have US-366 card support. I bet this card can be reversed just as the others was. Here's the link:
https://www.tascam.eu/en/downloads/us-366

I am available to test stuff if somebody can give me a hand with this task.

Thanks

Den

Issue URL     : https://github.com/alsa-project/alsa-tools/issues/5
Repository URL: https://github.com/alsa-project/alsa-tools
