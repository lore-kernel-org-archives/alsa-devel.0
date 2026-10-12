Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB287CA9ED2
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2026 21:03:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0FCE4601E1;
	Mon, 12 Oct 2026 23:03:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0FCE4601E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791838992;
	bh=EH4IOmt4AU8UaY5SOCIRF4rXBUnPL75TdNCLGH8qurQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Nj80D51qb8F9W0NcWgxjgyilalg1ULyRrZeJLCca0wPyYyGRfZKIen+/4opBlKvgi
	 9b6Hk3AC+khMEqAVvNMMqTbssHMdCO23i9c2Qzm06bm9452nPdYtH14G7P/FXDayZV
	 N+qcswGwcP3xLNVdqUzJEcHT1l9wv39FQg6SWy2k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0FD5AF805FB; Mon, 12 Oct 2026 23:02:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A4092F80601;
	Mon, 12 Oct 2026 23:02:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 39A38F80526; Mon, 12 Oct 2026 23:02:43 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791838962;
	b=bDTHTL+MmfRpkWvnZ+WxAyLAS2m4hWR5H1YXy3/gkff0Z57927flSQOZRiL117oOcSwa
	 e6ufXGgnfAifaPmPUEOvdSOi5sUv7j+mj1iU1PvZVbO70TI5kvt2X0RLjOc7WsU3gfOdL
	 O2ymcycx4Jw3+sdkaQlgXVmiLmbgEsdSf/+uVNSRi27NEwjeDyhj3TwP0oIXiy2FvpSwB
	 gnQs9sxcG7gqal0M1JeLORpKyfqeQON2LONYQchqZa55A1xrcLxMOxtoJQvYtIOEDN9DD
	 0Nn6TW07vM+Hf6fhv9C0mWzqzsMExDYIuxzF4udHbfm4gTD3095XUSTfDgA0q8UIzBw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791838962;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=EH4IOmt4AU8UaY5SOCIRF4rXBUnPL75TdNCLGH8qurQ=;
	b=KNjS21SV55uzm6lId6fLqios1TjfBiJ9TcE3zt8zwcUoDBvhnVw6p6fszBRLCk7W9cTY
	 dWUzsZOWRxs1YS7Qts87Op6/M4ggT/46Awn8dGVUsUFoPz9foLZJ/Yy8F0GgqFvdT3+X6
	 aieBZTPWBLixZcg5RrDa8mBLiwtBoxw7G8+f7i3uvHCZO8rhh24jVHo5aUNgS37I+pPdT
	 26lZZLPUvEG2kC02VKo6W2KEYjiEztTnhdzlKYU+mTYIDWipRDig7VPDeHkaP/+OHbvj+
	 Foq5ilFI+pgnqeAviNnHN2COaJyklkSikMAK7VBEG6WgW8ERjL6JfckehPlFxZT+Vog==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 253A3F80424
	for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2026 23:02:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 253A3F80424
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18dde40a7cdb9f00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/876@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/876@alsa-project.org>
Subject: HDA: Handle better Bass speaker including 4 channel mode
Date: Mon, 12 Oct 2026 23:02:43 +0200 (CEST)
Message-ID-Hash: 5EO6KEEDV4REIVDH6SX3F6SH354SKEN4
X-Message-ID-Hash: 5EO6KEEDV4REIVDH6SX3F6SH354SKEN4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5EO6KEEDV4REIVDH6SX3F6SH354SKEN4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #876 was opened from CSVincentS:

Follow up of #533.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/876
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/876.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
