Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BDFC47258
	for <alsa-devel@archiver.kernel.org>; Sun, 28 Jan 2024 13:28:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE668857;
	Sun, 28 Jan 2024 14:27:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE668857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1706448481;
	bh=wjtMckO8PW7oVoKjaFJ2U9jTcutNCSldHHN5+gEojZ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=CQpg+4+BKusEqlIoGG4D/wNQmsdz/SeDAssfCKPlEOw6W5YNXUQLgwZTohWzjRC/L
	 NQInjzpXzhFH/11xlNyt68fnpcsvUB2gHMQA18vwRl4PkLNHns0NYUmZFNoV3iyhZ4
	 vwM6e72z5rrXK0ss3c3xCgAXQ7Kkug214k/TRCZg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 54800F8056F; Sun, 28 Jan 2024 14:27:27 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BD9FCF8057D;
	Sun, 28 Jan 2024 14:27:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 63693F80310; Sun, 28 Jan 2024 14:27:22 +0100 (CET)
Received: from puleglot.ru (puleglot.ru [IPv6:2a01:4f8:1c0c:58e8::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4E8D1F80053
	for <alsa-devel@alsa-project.org>; Sun, 28 Jan 2024 14:27:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4E8D1F80053
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=tsoy.me header.i=@tsoy.me header.a=rsa-sha256
 header.s=mymail header.b=Ao/oJIHg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me;
	s=mymail; h=Sender:MIME-Version:Content-Transfer-Encoding:Content-Type:
	References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
	:List-Post:List-Owner:List-Archive;
	bh=wjtMckO8PW7oVoKjaFJ2U9jTcutNCSldHHN5+gEojZ0=; b=Ao/oJIHgR66n62eC4k/097uYo9
	mk0Ytddd2Ni4rU8S7wcGPNyH0NMhp0AaYxNgpns1gnZV0gyMPBDcjUOuwQl8DfQwyZ835gC04q9Zc
	Cl4sEHDSH6RrLbjjGQbNiffcMJLuPmGDzEkN8qR+s/F/b7BDiRtbbzw6B0l800z0F3CE=;
Received: from [2a00:1370:819a:ceb:89dc:eced:962a:5b2f]
	by puleglot.ru with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <puleglot@puleglot.ru>)
	id 1rU5Bt-00000000B6x-0PxE;
	Sun, 28 Jan 2024 16:27:17 +0300
Message-ID: <d2273d0ac541c82025a01b137bc956ef6fed9261.camel@tsoy.me>
Subject: Re: [PATCH] ALSA: usb-audio: Skip setting clock selector for single
 connections
From: Alexander Tsoy <alexander@tsoy.me>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, Jaroslav
 Kysela <perex@perex.cz>
Date: Sun, 28 Jan 2024 16:27:04 +0300
In-Reply-To: <8734uhoe0a.wl-tiwai@suse.de>
References: <20240123134635.54026-1-alexander@tsoy.me>
	 <87mssw6sry.wl-tiwai@suse.de>
	 <3d4b6eca78d222598f8313c1fca34f3b9ee0bdba.camel@tsoy.me>
	 <8734uhoe0a.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
Sender: puleglot@puleglot.ru
Message-ID-Hash: TCBQAFQRX7RLEMJBYTC2FK2SKSTOFGVG
X-Message-ID-Hash: TCBQAFQRX7RLEMJBYTC2FK2SKSTOFGVG
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TCBQAFQRX7RLEMJBYTC2FK2SKSTOFGVG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

=D0=92 =D0=92=D1=81, 28/01/2024 =D0=B2 13:09 +0100, Takashi Iwai =D0=BF=D0=
=B8=D1=88=D0=B5=D1=82:
> On Sun, 28 Jan 2024 11:35:51 +0100,
> Alexander Tsoy wrote:
> >=20
> > =D0=92 =D0=92=D1=82, 23/01/2024 =D0=B2 15:14 +0100, Takashi Iwai =D0=BF=
=D0=B8=D1=88=D0=B5=D1=82:
> > > > On Tue, 23 Jan 2024 14:46:35 +0100,
> > > > Alexander Tsoy wrote:
> > > > > >=20
> > > > > > Since commit 086b957cc17f5 ("ALSA: usb-audio: Skip the
> > > > > > clock
> > > > > > selector
> > > > > > inquiry for single connections") we are already skipping
> > > > > > clock
> > > > > > selector
> > > > > > inquiry if only one clock source is connected, but we are
> > > > > > still
> > > > > > sending
> > > > > > a set request. Lets skip that too.
> > > > > >=20
> > > > > > This should fix errors when setting a sample rate on
> > > > > > devices
> > > > > > that
> > > > > > don't
> > > > > > have any controls present within the clock selector. An
> > > > > > example
> > > > > > of
> > > > > > such
> > > > > > device is the new revision of MOTU M Series (07fd:000b):
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AudioControl Interface Descripto=
r:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bLength=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 8
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bDescriptorType=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 36
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bDescriptorSubtype=
=C2=A0=C2=A0=C2=A0=C2=A0 11 (CLOCK_SELECTOR)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bClockID=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 1
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bNrInPins=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 1
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 baCSourceID(0)=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bmControls=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iClockSelector=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
> > > > > >=20
> > > > > > Perhaps we also should check if clock selectors are
> > > > > > readable
> > > > > > and
> > > > > > writeable
> > > > > > like we already do for clock sources, but this is out of
> > > > > > scope
> > > > > > of
> > > > > > this
> > > > > > patch.
> > > > > >=20
> > > > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217601
> > > > > > Signed-off-by: Alexander Tsoy <alexander@tsoy.me>
> > > >=20
> > > > Thanks, applied.
> >=20
> > It looks like this patch will bring back problems with Behringer
> > mixers
> > [1]. So we probably should revert. The mentioned case with MOTU M
> > Series should be also covered by "Support read-only clock selector
> > control" commit.
> >=20
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D199327
>=20
> OK, care to submit a patch to revert it?

Sure, done!
