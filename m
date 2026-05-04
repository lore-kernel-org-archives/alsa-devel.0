Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB98FF885A
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2026 19:08:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 560D860228;
	Mon,  4 May 2026 21:08:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 560D860228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777921719;
	bh=HVl2NF+PVhOeTQYURt9BDAKRlB41Ycr8kgQaU0GGPTU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=pt5oCAAY+HX5c3hrnOeb5Nc2r8cgxPjsXAvkLmXWHxwZ2sGaFcUFzZLbiv8h3PKE7
	 THcM7Yh5b2YRZwENO2yOW3q6v4rcv1LtwOSbuN19XwQ1VJUu7L7ZUJLjqg2BpRl8aS
	 KyDnIcLt88eJRIdOmMRcoBaaLo5CdwIz8HuhJv5I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1EDF6F805F2; Mon,  4 May 2026 21:08:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F1299F805EF;
	Mon,  4 May 2026 21:08:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 226B1F8021D; Mon,  4 May 2026 21:08:00 +0200 (CEST)
Received: from hellmouth.base.nu (hellmouth.base.nu [192.248.168.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA512)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6C542F800C1
	for <alsa-devel@alsa-project.org>; Mon,  4 May 2026 21:07:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6C542F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=base.nu header.i=@base.nu header.a=rsa-sha256
 header.s=20250128 header.b=Fo/AC2EF
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20250128; bh=HVl2NF+PVhO
	eTQYURt9BDAKRlB41Ycr8kgQaU0GGPTU=; h=in-reply-to:references:to:from:
	subject:cc:date; d=base.nu; b=Fo/AC2EFAnaGRbLp5qW+kgc8V25E19W0eI0Fsxu5
	LA6ddSISLVJtIQ1BfpUP9CCLZq//7kGt5Qq987CyTTEfdBsqFRJmRbV/HptrIlVzkY4l22
	q6ugBEOVtXaA70hgYNjuheViS2qsfICYfXrVHq7rVFR/mFlxhriQbIBdwr6NZ8SQEhVlTW
	KAXWzapgqFFP2f1P0+aImGZurrgpCjvvmxKg1gPBzvNFMXHiClU6Kzj8V7uypd303r/HWq
	O6tnozhKEgmNaa0WcvS+RYVva6an067WcfUZWJFNSHyMhi2nm8TMZn8dXB/l0Z2A4EbVvs
	l2VFy28JHSm7trT7uAHlGQ==
Received: from hellmouth.base.nu (localhost [127.0.0.1])
	by hellmouth.base.nu (OpenSMTPD) with ESMTP id d81dcc4b;
	Mon, 4 May 2026 19:07:57 +0000 (UTC)
Received: from localhost ([194.55.157.139])
	by hellmouth.base.nu with ESMTPSA
	id o7trEo3u+GkiegAADaPQrA
	(envelope-from <livvy@base.nu>); Mon, 04 May 2026 19:07:57 +0000
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 May 2026 20:07:57 +0100
Message-Id: <DIA4MUV7QM6D.9JBYEDTE2MMF@base.nu>
Cc: "Eldad Zack" <eldad@fogrefinery.com>
Subject: Re: RFC: M-Audio FT C600 - control for disabling the Output Gain
 Knob
From: "Olivia Mackintosh" <livvy@base.nu>
To: <simon@mungewell.org>, <alsa-devel@alsa-project.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <dba75d85bdff152847ef0ee91a9872d0@mungewell.org>
 <afUWW3v7iUpqFM2l@pandaemonium>
 <ed7a49ad09c2534813de239b8e7ff85d@mungewell.org>
 <238004e257377814c5695d30ea258a5c@mungewell.org>
In-Reply-To: <238004e257377814c5695d30ea258a5c@mungewell.org>
Message-ID-Hash: K373Z37GWLR4TEUSE64KOELWHKAMFV5Z
X-Message-ID-Hash: K373Z37GWLR4TEUSE64KOELWHKAMFV5Z
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/K373Z37GWLR4TEUSE64KOELWHKAMFV5Z/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

> I can formally sign/submit a patch if there's no comments. Is that done=
=20
> here or on the kernel mailing lists?

You can submit patch here following
    https://kernel.org/doc/html/latest/process/submitting-patches.html

but it would be best to rebase/test against the tiwai/sound tree :)
    https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/

Regards,
Olivia
