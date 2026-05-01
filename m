Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D316CCFA13
	for <alsa-devel@archiver.kernel.org>; Fri,  1 May 2026 21:12:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ECC4C60207;
	Fri,  1 May 2026 23:12:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ECC4C60207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777669960;
	bh=bPQYXxpEVeQ+u59bIPZGupJanl7ISR7bo1nha2m/NJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=tNiFPti4GlfXv2VM1T41U7CNNeqDmoPOZZPkP8rAw4QpLPGKc+n/Yu6TMtYRjNWOb
	 HJ3HsKlv5vVW0/UEmvRcdS6142APFnRhbKBzbq1YT5nwxpLnvlXBKCPa6wnayn7wIY
	 quCQEWUsGzI6Exrx3e6LOvg6Fa9F9DacMaaEzFbA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9F232F805EB; Fri,  1 May 2026 23:12:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D42E0F805F2;
	Fri,  1 May 2026 23:12:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 57F1BF8055A; Fri,  1 May 2026 23:11:59 +0200 (CEST)
Received: from hellmouth.base.nu (hellmouth.base.nu [192.248.168.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA512)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2A128F80100
	for <alsa-devel@alsa-project.org>; Fri,  1 May 2026 23:11:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2A128F80100
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=base.nu header.i=@base.nu header.a=rsa-sha256
 header.s=20250128 header.b=1UabbrTD
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20250128; bh=bPQYXxpEVeQ
	+u59bIPZGupJanl7ISR7bo1nha2m/NJQ=; h=in-reply-to:references:subject:
	cc:to:from:date; d=base.nu; b=1UabbrTDlDjJio38opFpqticLfkJtdp6szhbwWJC
	wqXgCeB8vLp5E+ElTaMpZxU0qzEjwnCLoncZiFKy5hLLEYfqOBEQFJOyRNv3UZa7HIZjMU
	H4IFOXdE7Yrq/9KUapHMNL+fwfUI/KaMtOptQeyusrED8LTSp5fZ4i6GKX9JhKqucLZDh0
	GzofYq6B5dmASBMBxTHF7M7HnMVYWWpr5AumOGFOLP0LRbbxQo2d7ySfGi1tYjkxlAxfCG
	gkqi+kkg3XwU1+r2d7RKCvHjBVESMzAnyNyYSqX7F6HCuOKBtFHILAekKiun2J+Q9P7jkh
	acRY5J3+0src7kSyKKK8Ew==
Received: from hellmouth.base.nu (localhost [127.0.0.1])
	by hellmouth.base.nu (OpenSMTPD) with ESMTP id 225cd1c0;
	Fri, 1 May 2026 21:11:55 +0000 (UTC)
Received: from localhost ([194.55.157.139])
	by hellmouth.base.nu with ESMTPSA
	id 06UJMRsX9WnmgwAADaPQrA
	(envelope-from <livvy@base.nu>); Fri, 01 May 2026 21:11:55 +0000
Date: Fri, 1 May 2026 22:11:45 +0100
From: Olivia Mackintosh <livvy@pandaemonium>
To: alsa-devel@alsa-project.org
Cc: simon@mungewell.org
Subject: Re: M-Audio FT C600 - driver missing control for disabling the
 Output Gain Knob
Message-ID: <afUWW3v7iUpqFM2l@pandaemonium>
References: <dba75d85bdff152847ef0ee91a9872d0@mungewell.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dba75d85bdff152847ef0ee91a9872d0@mungewell.org>
Message-ID-Hash: SWONV6SEQOXMDF6L56KEBJMF33Y5OI5R
X-Message-ID-Hash: SWONV6SEQOXMDF6L56KEBJMF33Y5OI5R
X-MailFrom: livvy@base.nu
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SWONV6SEQOXMDF6L56KEBJMF33Y5OI5R/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, May 01, 2026 at 04:10:51PM -0400, simon@mungewell.org wrote:
> Hi all,
> I recently thrifted a C600 for a bargain price, and happily most of the
> functionality is working fine. I did notice a couple of controls (as seen in
> Windows app) are not presented under Linux.
> 
> There is the ability to disable the large Output Gain Knob (on right side of
> the device), which by defaults controls all of the stereo outputs (1/2, 3/4,
> 5/6).
> 
> Snooping the USB bus under Windows I see there is a USB packet sent with a
> bit mapped values to disable gain control of each stereo output. Wireshark
> Caps available if needed/wanted.
> 
> I suspect this is a moderately easy fix, and likely applies to the C400 as
> well. Happy to work with/test patches to get this implement, but I'm not
> experienced with building ALSA.
> 
> Cheers,
> Simon.

Hi Simon,

Congratuations on the thrift! Happy to help where I can as I have some
experience with making alsa controls. You're on the right track having
captured the control values.

There seems to already be c400 controls set up in the mixer_quirks.c
file, so it should be fairly straightforward to adapt this to also
support the c600.

Let me know if you need support in any way.

Olivia

