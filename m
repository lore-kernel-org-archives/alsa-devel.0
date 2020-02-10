Return-Path: <SRS0=5/4N=36=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F675C352A3
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:13:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 541DE20714
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Bcq9DjrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 541DE20714
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A554886;
	Mon, 10 Feb 2020 16:12:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A554886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581347581;
	bh=yUoGjJvrmX9B1RjoBVxAl9xDXUcoVh12otpNBk9dk/o=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bcq9DjrRejpMVItsWAo6kZ+2CUo7BwN4sSx28FUplqfDqfzkg+YAQwdSFdU3izn9d
	 fvBTqyxG6dG+NksO9BvwsLpUZ00d0HclXGWtI0B7MQIivWePy41A4ETitbmq7bgwCw
	 bNtiKV1mf1yALCxTNbJll1rwRBM6o5uAG7WNq1fU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 35E05F8014F;
	Mon, 10 Feb 2020 16:12:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 91E3DF80157; Mon, 10 Feb 2020 16:12:09 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 434A0F80118
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 16:12:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 434A0F80118
MIME-Version: 1.0
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1581347526348470926-webhooks-bot@alsa-project.org>
References: <1581347526348470926-webhooks-bot@alsa-project.org>
Message-Id: <20200210151209.91E3DF80157@alsa1.perex.cz>
Date: Mon, 10 Feb 2020 16:12:09 +0100 (CET)
Subject: [alsa-devel] upmix: complete generalizing format
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-plugins pull request #6 was opened from bku-sue:

Unfortunately these lines were overlooked in the [previous pull request](https://github.com/alsa-project/alsa-plugins/pull/2).

Request URL   : https://github.com/alsa-project/alsa-plugins/pull/6
Patch URL     : https://github.com/alsa-project/alsa-plugins/pull/6.patch
Repository URL: https://github.com/alsa-project/alsa-plugins
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
