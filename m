Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C6CCD8C9D
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jun 2026 19:31:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A3C260210;
	Thu, 11 Jun 2026 21:31:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A3C260210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781206290;
	bh=yKAUuOURd9y9p14tOY8p0TL4uJkXphHba6728gxQneY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Cci9yR5bjUIgfEqCHe+nmyZVbHtPAGFsLG3KR3VAXB9WGNCjQx/40I5gYOGUA1Rwx
	 wFX5dbDmbLdqYJouHleUjbmg/sfDGhcV22Dfh07jbqENlMqFpkdNra2FBFUjFUNzlO
	 xhuiFnjG2QR4A6l3ez5hqGXQISOWBgDpKZBgZhCo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EA7FBF805FC; Thu, 11 Jun 2026 21:31:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A46E1F805F5;
	Thu, 11 Jun 2026 21:31:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 85F33F8058C; Wed, 10 Jun 2026 11:12:50 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=202.108.3.212
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781082769;
	b=qsgIX+7Ih7lyj30CvzTQgQSvFWB3Xoptfj1as+9ylTM/kl7V8Kh4Va5RZu8XcqIp5I1o
	 Pb9yGnzX026a2y9S0pXHrjmMrEh3F4XbV4aQBerCZGtTjcwKyomqcL7am/99dWk6n93O5
	 SLATjOVOjD5wV2vwnuhbN2RNan9uO5YbICRM7CL8oZW92GrVBc6T+J4odImtsRIg66wAP
	 9S4NabpfG16L94hVvWvUOtofeu/K3b9Qe541nZaZoiC6GWu2gOfiQ9jstH2AcYpj96JtX
	 DTcGD14H6sUp3U1S3AxxlJrL2WGKOxM6OG9TK5oxHp3O/zlGYZAW0GG5Fa0xWthaJ8w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781082769;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=yKAUuOURd9y9p14tOY8p0TL4uJkXphHba6728gxQneY=;
	b=rbyXhLpwfa5UFODC99RsCen5nkqIxCiutZMcSszZgE5mnK+IfDHioLho758cQJCqYE1m
	 A2l67h7ij0EioKTJBZnnQChA2myyX6hnYVAzeqIWHzeSzzRtLOvBcVlFdKwUVoCHg4XBj
	 t04AFXulH/WmZ4aHuCkXz9l970CJwj5W3LS0mnDk8Od85dh+cCt0m0Oyss/z3RIakRew6
	 nq53l/UQd/y6NmYv5RWcXaR/l8X+Uo2vRrZSTJh6/ljv7+3h91LTUVh6IJGZ7V/E8/Cug
	 qYxFbaVhENg9mwUrepDZ6eDf5tCt+pFncCLSQijyCMzjuMcCwdKLe6iekTeZ+wRGYgQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=202.108.3.212
Received: from r3-212.sinamail.sina.com.cn (r3-212.sinamail.sina.com.cn
 [202.108.3.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B23FEF8011B
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2026 11:12:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B23FEF8011B
Received: from unknown (HELO DESKTOPQJC4P40)([58.38.107.94])
	by sina.net (10.54.253.38) with ESMTP
	id 6A292A8800002E14; Wed, 10 Jun 2026 17:12:41 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 5C8B85373A4342B08C8F646CE9D15207
X-SMAIL-UIID: 5C8B85373A4342B08C8F646CE9D15207-20260610-171241
From: <zhangyi@everest-semi.com>
To: <krzk@kernel.org>
Cc: <alsa-devel@alsa-project.org>,
	<broonie@kernel.org>,
	<conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>,
	<krzk+dt@kernel.org>,
	<robh@kernel.org>,
	<tiwai@suse.com>
Subject: Re: [PATCH 7/7] ASoC: dt-bindings: ES8389: Add members about HPF and
 clock
Date: Wed, 10 Jun 2026 17:12:40 +0800
Message-ID: <070401dcf8b9$4aaa3860$dffea920$@everest-semi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: Adz4t2H8cwE7+5GoRNWBhStZ5ikWXg==
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: QM4G46MEMWS5K2I57H2PLRNJ2ARXN6SJ
X-Message-ID-Hash: QM4G46MEMWS5K2I57H2PLRNJ2ARXN6SJ
X-Mailman-Approved-At: Thu, 11 Jun 2026 19:31:03 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QM4G46MEMWS5K2I57H2PLRNJ2ARXN6SJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

> You already sent v1 and received feedback.
> 
> You just completely ignored it

When I submitted the v0 patch, I received feedback and suggestions from
Sashiko.
I wasn't sure how to handle Sashiko's feedback, and I mistakenly assumed
that if my patch didn't pass Sashiko's tests, you wouldn't receive it. 
So, after modifying the code based on Sashiko's reasonable suggestions, I
submitted a patch with the same version ID.
As a result, you received two consecutive patches from me. I didn't mean to
ignore your valuable feedback, and I apologize for this.

So, when I receive feedback from Sashiko, do I need to wait for the
maintainers to provide their feedback before incorporating the changes into
the next version's patch?

