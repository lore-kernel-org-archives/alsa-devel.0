Return-Path: <SRS0=svzq=2Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADC4C2D0C2
	for <alsa-devel@archiver.kernel.org>; Sat,  4 Jan 2020 19:04:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 419C624650
	for <alsa-devel@archiver.kernel.org>; Sat,  4 Jan 2020 19:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lAH6F3iG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419C624650
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F2461779;
	Sat,  4 Jan 2020 20:03:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F2461779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578164684;
	bh=uKRUK+c4EowscAWW4PZcpaR+uA+2JbC9KGsm1bSd7u8=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lAH6F3iG7GWvdB7V/dZYh825okbH+z/++Ez6lzaJv+n+9noMrzyfHwPPnDxX3feh8
	 sEHsOvg8Xl2sQXEBpR6nDKw4kA+5gAMHLDtVK2Vy82WrNV+0Lddtcj8c2EiY39L/Zg
	 Kngl/m1quF0mGYEwfnw/w7XX5y9oUTxVLMNEFGZQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 60EC4F80240;
	Sat,  4 Jan 2020 20:03:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F18D3F80257; Sat,  4 Jan 2020 20:03:23 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 9A10CF8020B
 for <alsa-devel@alsa-project.org>; Sat,  4 Jan 2020 20:03:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A10CF8020B
MIME-Version: 1.0
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1578164601400027037-webhooks-bot@alsa-project.org>
References: <1578164601400027037-webhooks-bot@alsa-project.org>
Message-Id: <20200104190323.F18D3F80257@alsa1.perex.cz>
Date: Sat,  4 Jan 2020 20:03:23 +0100 (CET)
Subject: [alsa-devel] No support for Kaby Lake DA7219 (on Chromebooks)
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

alsa-project/alsa-ucm-conf issue #11 was edited from FantasyCookie17:

I'm sorry if this is the wrong page and the bug tracking mailing list would be better, or if this is the wrong part of the ALSA project, however this seems indeed related to ALSA UCM configuration. The original issue is [here](https://github.com/GalliumOS/galliumos-distro/issues/536), however OP and developers did not seem to care or know what to do, so I wondered whether a fixed version of this could be put into the standard ALSA configuration. The support in the kernel seems to be there, at least theoretically. The firmware might be adopted into alsa-firmware, if it is actually needed.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/11
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
