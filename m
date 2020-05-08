Return-Path: <SRS0=uvJZ=6W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F6DC38A2A
	for <alsa-devel@archiver.kernel.org>; Fri,  8 May 2020 08:15:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9095B206D5
	for <alsa-devel@archiver.kernel.org>; Fri,  8 May 2020 08:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GYNrQYU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9095B206D5
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C2A371831;
	Fri,  8 May 2020 10:14:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C2A371831
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588925731;
	bh=qpNlytDCVn5uNL5HK5jEjtDPEY8Q4Yxis3aEGsc+TBc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GYNrQYU0k4aF5dLV5J/l3Xnthph2e1MQ6OO92lf4EawEO/jsWwH81N7HifbrxLdBT
	 XFQ+D8/LAzK/6pk9U2xAzrmDTxTeF5x/ZymbH6heA6aiZt/eoLmOu6mxB6vwFAnaUr
	 ACetJDNy+wyhODWLNz5PGtUrYIr+pqZBd8lPSR7Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 48831F800F6;
	Fri,  8 May 2020 10:14:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 63511F8023E; Fri,  8 May 2020 10:14:39 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id C9FBFF800E7
 for <alsa-devel@alsa-project.org>; Fri,  8 May 2020 10:14:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9FBFF800E7
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1588925673549724102-webhooks-bot@alsa-project.org>
References: <1588925673549724102-webhooks-bot@alsa-project.org>
Subject: crackling microphone
Message-Id: <20200508081439.63511F8023E@alsa1.perex.cz>
Date: Fri,  8 May 2020 10:14:39 +0200 (CEST)
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

alsa-project/alsa-plugins issue #10 was edited from riddicc:

Hi!

When I send a 800Hz sine wave with rate 12345 to pcm.outmic and
when I arecord from pcm.micend at rate 8000 with 1 channel ([/etc/asound.conf](https://github.com/alsa-project/alsa-plugins/files/4597703/etc-asound-conf.txt)),
then I get a lot of tiny little gaps (see attachment) and a lot of messages like "overrun!!! (at least 0.014 ms long)" (the "ms" vary from 0.008 to 0.043; and arecord continues to record) and sometimes even this error: "arecord: xrun:1672: read/write error, state = RUNNING" (it causes arecord to terminate).

1. > speaker-test -D outmic -t sine -f 800 -c2 -r 12345
2. > arecord -D micend -r 8000 -c 1 -f S16_LE /tmp/bla.wav

twinkle makes even bigger gaps, when I let it use pcm.micend as microphone...
But with hw:Generic,0,0 as mic device twinkle works fine...
https://github.com/LubosD/twinkle/issues/207

"samplerate_best" and "samplerate_order" seems to make it worse...

How can I fix that?

Thx.

Bye.

![audacity screenshot](https://user-images.githubusercontent.com/33246439/81384628-7ad51080-9101-11ea-849d-6afb14bf1307.png)

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/10
Repository URL: https://github.com/alsa-project/alsa-plugins
