Return-Path: <SRS0=H50z=GA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925CBC433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Dec 2020 11:06:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E459229C4
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Dec 2020 11:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E459229C4
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A343916FF;
	Mon, 28 Dec 2020 12:05:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A343916FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609153588;
	bh=9vBx+J/sDuMjtptigZEX7ERw1jwLKpEAXKQsVEUjb/E=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dPDAR/sCSzNlFNj5/eUs1E72PBLhcoixpxZM2ZdaHD1EdWBuDfZsF4GiqQ99vzrEL
	 v1Zi/aXSroYhXawdbWvXOXA76VlGZyJp4NRw7AS3cJXVJgDaKj1Wmh3r71Z61Izde3
	 JijPuzzXfNSeyHA4OaKoxTn4b/yKInv5jcXzZ8/4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A095F801ED;
	Mon, 28 Dec 2020 12:05:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51EA8F801F5; Mon, 28 Dec 2020 12:05:36 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 0C648F8014E
 for <alsa-devel@alsa-project.org>; Mon, 28 Dec 2020 12:05:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C648F8014E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1609153532068211079-webhooks-bot@alsa-project.org>
References: <1609153532068211079-webhooks-bot@alsa-project.org>
Subject: pulse: handle reading pulse stream hole
Message-Id: <20201228110536.51EA8F801F5@alsa1.perex.cz>
Date: Mon, 28 Dec 2020 12:05:36 +0100 (CET)
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

alsa-project/alsa-plugins pull request #17 was opened from i-garrison:

If there is a hole in pulse stream, handle it by generating silence.

This should fix #16

Request URL   : https://github.com/alsa-project/alsa-plugins/pull/17
Patch URL     : https://github.com/alsa-project/alsa-plugins/pull/17.patch
Repository URL: https://github.com/alsa-project/alsa-plugins
