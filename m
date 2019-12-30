Return-Path: <SRS0=zq5f=2U=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5BBC2D0C3
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Dec 2019 05:14:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF452071E
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Dec 2019 05:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DXfheUHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF452071E
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9104016D2;
	Mon, 30 Dec 2019 06:13:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9104016D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1577682855;
	bh=wnyMG9cWPBSJXbH42txOWgb5RwZ1jBjHjkb3tx/Buo8=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DXfheUHS1/Hb8j5ZqQVd82+cfYIb99z+54Wx+RP0XOZOMwgOlSI/ECRFj1GqK9dEp
	 s0+AB/olTsmYmYu1h64yFO8tmwTl4hRJK6LiVajD7pLQKQWObRN5hid7RUmNZFQmal
	 eIid6J6Jour/ev5Pn5Bc2jfr7T+fty6BzMwd9aUI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 094D0F8015C;
	Mon, 30 Dec 2019 06:13:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 53D7DF8015D; Mon, 30 Dec 2019 06:13:22 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 54F1AF80126
 for <alsa-devel@alsa-project.org>; Mon, 30 Dec 2019 06:13:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 54F1AF80126
MIME-Version: 1.0
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1577682798323347092-webhooks-bot@alsa-project.org>
References: <1577682798323347092-webhooks-bot@alsa-project.org>
Message-Id: <20191230051322.53D7DF8015D@alsa1.perex.cz>
Date: Mon, 30 Dec 2019 06:13:22 +0100 (CET)
Subject: [alsa-devel] ctl: misc fixes
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

alsa-project/alsa-gobject pull request #3 was opened from takaswie:

This patchset incldues two changes:

 * rename element event flag with suitable name
 * simplify event dispatching

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/3
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/3.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
