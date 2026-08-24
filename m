Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2292C5DF81
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:58:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 224FF60265;
	Mon, 24 Aug 2026 10:57:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 224FF60265
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787561883;
	bh=9wEyajwfsS9ErOpdt4xpI8i6Nh7ux2hIVIXpxTXt6Cg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=p997c18c4nQIlp9/WtkCJ8G4W/DXOoEtvkVJu7m/bDpejpIgevs+z1WH+ewLGqWGm
	 ORFZvL6cxbV2XNJsgxM+2Ps/7CCswMkIRKpV8qnG+UBNPemafDag6Ctv5KUyBzVzxY
	 Mru/pLMFIsMfEkZvxh4+ptF8p5r2ebP96hKuVuuQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 289CFF805F5; Mon, 24 Aug 2026 10:57:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C0EEF805FA;
	Mon, 24 Aug 2026 10:57:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 13C32F805A8; Mon, 24 Aug 2026 10:57:19 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787561838;
	b=d6sI1u/4FpfGndA6DhjStmqeNSAkkBlOnVu/puFcJ6n6JvEwD/XdwkrxsWwpKEek22er
	 WxYd1lKBGTrImjeBsm5LtSaMIwOHegK3gNU1YWnuoJf87wNsw+669UoiV/DRHRccYwgti
	 pY8c/ZLq6/IH7GP4abQei9HnUGUddRv3RUZPPblREFx72sQg4pscw5Iv0FLWrSNJeQZDX
	 ef8waI+/wp0PmjkP1oycG2avpYCLdZx2rXe3mUP7bO0dYEXIcOK216mRKCUDcvqaUXogu
	 lNZOjXhS0NuvoPWhtUPvxkTkEnweihtI8uQ9CuelfifXk7lrGLLxipd1qBDyi9zgfRA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787561838;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=9wEyajwfsS9ErOpdt4xpI8i6Nh7ux2hIVIXpxTXt6Cg=;
	b=YoZRSqZIc8y72MHeiI4YkeF6iScp2v7jN35Mpz6DRn2BTDIkyYz0IkUSQE770B6T5lxO
	 ymjYq42kkjHfuQrRplkZeDioffZjF7fMqpwEdOimasd4AOMUiygcyFn99Yx7tAten/tha
	 M3OJZFhNi/LLw4XuV7tNtknmcH7pblT9cw0i/E3hR90RfUY57UpmW80c+QyZigXuBncdW
	 RAQgce6aj4tmuHW+UwxCWuKjG7efzRJ8zmJvyEHQLlJHudBn774CFKODqx4D3zRCw2VRD
	 NfvoCX7zyq++UUsz1zSIq2oyIVxzh2b6tLt3YYyBTNbOYQ84xI8FwglcI1k2QjJAVsg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 20ED2F80075
	for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2026 10:57:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20ED2F80075
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ceb204f2cd7700-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/837@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/837@alsa-project.org>
Subject: ucm2: USB-Audio: fix channel counts for SSL 2+ MK II
Date: Mon, 24 Aug 2026 10:57:19 +0200 (CEST)
Message-ID-Hash: GLDPLEWZTOBSLSYEYANW6FTGT5NBDIQE
X-Message-ID-Hash: GLDPLEWZTOBSLSYEYANW6FTGT5NBDIQE
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GLDPLEWZTOBSLSYEYANW6FTGT5NBDIQE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #837 was opened from lofiwatercat:

Got an SSL 2+ MK II and hit the UCM errors described in #795.

#681 added MK II support, but the author had no SSL 2+ MK II and could
not verify it. The merged regex (`USB31e9:000[29]`) therefore gives the SSL 2+ MK I the SSL 2+ MK II channel counts of 4 playback / 4 capture.

The SSL 2+ MK II actually has 6 playback and 8 capture channels, so the
config describes the device incorrectly and the card shows as
`[ALSA UCM error]`.

[alsa_info.txt](https://alsa-project.org/db/?f=a322db1c1bb51cf1ab611bbba3a5900fffc846b8)

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/837
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/837.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
