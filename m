Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA5DC47DDB
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Feb 2024 10:37:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 40478B76;
	Thu,  1 Feb 2024 11:37:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 40478B76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1706783842;
	bh=gw3OWOfQUIXyqJNESI7+QUXlcp6KFqescLxFFanz6no=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=F4HEd4rR2yLOFMucROZWp6qutnDJwrJNfJ1tdfX0trOcp2wlUy8nUIeCQEMabnUE+
	 pLYqN9/NvbrPYTI1cRWdZiBPQQUTMLcRDiaLsNIL63dwWFDrk0hTvThgdPABmR+qrC
	 FpcG98jEcwUklOVWps/1Rz4tXZ+JboRU4bCIVggY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 63669F80571; Thu,  1 Feb 2024 11:36:39 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EB79AF80588;
	Thu,  1 Feb 2024 11:36:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 302ADF8055C; Thu,  1 Feb 2024 11:36:32 +0100 (CET)
Received: from puleglot.ru (puleglot.ru [IPv6:2a01:4f8:1c0c:58e8::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DC674F80149
	for <alsa-devel@alsa-project.org>; Thu,  1 Feb 2024 11:36:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC674F80149
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=tsoy.me header.i=@tsoy.me header.a=rsa-sha256
 header.s=mymail header.b=E9rY6QO0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me;
	s=mymail; h=Sender:MIME-Version:Content-Transfer-Encoding:Content-Type:
	References:In-Reply-To:Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
	:List-Post:List-Owner:List-Archive;
	bh=gw3OWOfQUIXyqJNESI7+QUXlcp6KFqescLxFFanz6no=; b=E9rY6QO0ycHRh4dquFDJsb+MKU
	ETPkBMT77OmHGUYZQQ2a28MIaeDQLllM4IPffL2mY4ouHU0/doGz4fzP50YWwBCgdYbC6nHWYVC+F
	WnV+Rm/bOb4n5fF00vRsIsP05+yBCbVR6dZL2colgVQQQ4YWGPoN3rnosUxZ09SMTJPM=;
Received: from [2a00:1370:819a:ceb:89dc:eced:962a:5b2f]
	by puleglot.ru with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <puleglot@puleglot.ru>)
	id 1rVUQj-00000000yPJ-00nX;
	Thu, 01 Feb 2024 13:36:25 +0300
Message-ID: <6872e9ea993633dff4e248f01cafd1ac32651355.camel@tsoy.me>
Subject: Re: [PATCH] ALSA: usb-audio: retry clock validate when it takes
 some times
From: Alexander Tsoy <alexander@tsoy.me>
To: vincenttew <vincenttew@google.com>, perex@perex.cz, tiwai@suse.com,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Date: Thu, 01 Feb 2024 13:36:11 +0300
In-Reply-To: <20240201070641.401684-1-vincenttew@google.com>
References: <20240201070641.401684-1-vincenttew@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
Sender: puleglot@puleglot.ru
Message-ID-Hash: O4MWWBK4HKIEMOIAJU7D4FPZOW6EZBR6
X-Message-ID-Hash: O4MWWBK4HKIEMOIAJU7D4FPZOW6EZBR6
X-MailFrom: puleglot@puleglot.ru
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/O4MWWBK4HKIEMOIAJU7D4FPZOW6EZBR6/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

=D0=92 =D0=A7=D1=82, 01/02/2024 =D0=B2 15:06 +0800, vincenttew =D0=BF=D0=B8=
=D1=88=D0=B5=D1=82:
> Behringer UMC202HD and UMC404HD take some times to validate the clock
> source. To prevent more DAC have the same delay which return the
> false
> in the first time, remove the USB id check to have a chance to retry
> the
> clock validate.
>=20
> Signed-off-by: vincenttew <vincenttew@google.com>

Thank you for the patch! My thought about this change:
- Retrying clock source validation probably make sense only in the case
of Internal clock. But I'm not sure.
- If we want to make this a standard driver behaviour, then the code
needs to be moved out of the quirk function IMO.
