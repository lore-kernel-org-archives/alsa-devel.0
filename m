Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040FDC001B0
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Jun 2023 15:11:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B679844;
	Fri, 23 Jun 2023 17:10:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B679844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687533101;
	bh=R4rREPl7M1d3ioFChOIWdLIDfVQY3LnF6Pcd9QI44rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Qa3mgae6o6TcVHlyIkbt0ujwIsjP7J+3SUbZy73mJvQcl2NPzuyhWLIkXRwTr2miA
	 r0suIluqptIIhpkRdUF2mCbLeMDgXYbZ+lgsNSfkyK47++4p8HM7pYH0xJiDQJjbRu
	 YxnaXksCKr3cqhqSwQCcS9kf7azgPMTsMlFTwXG8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8D393F80549; Fri, 23 Jun 2023 17:10:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 41C51F80132;
	Fri, 23 Jun 2023 17:10:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B729FF80163; Fri, 23 Jun 2023 17:10:24 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 28D73F80132
	for <alsa-devel@alsa-project.org>; Fri, 23 Jun 2023 17:10:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28D73F80132
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=HeYR3jSL
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6879461A81;
	Fri, 23 Jun 2023 15:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C01C433C8;
	Fri, 23 Jun 2023 15:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687533009;
	bh=R4rREPl7M1d3ioFChOIWdLIDfVQY3LnF6Pcd9QI44rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HeYR3jSLHJFXrwraFKlAIUy8AVU0ets41Eq1zl0o3XF3SzJIadmzOHzhEVE9Ih47t
	 zUsPI06COdc+gKYKEnl81wYHxqkVI5sgi1Dz5xnWLocbq/tj+fPD2fHxAfIoZNxpt5
	 fyHsHOUkD/HwIEyvUWDIDmsksoEnDAD4cIg7qkt2NmUZX6PlruAp3E4RHUmIDGXea0
	 0Zu5iK+5e/uf55Ji8ZS22xdYWwtL424q7HkOtxBrtbe1NyCZu4fym/f5dTrGZHmjue
	 RBUujpWdwP3n+MbwLRN2NXBGZdklu7uNkPGXnchreGBAdsWu67+BFuRmET02oE0bZN
	 +4slzTRfAsC0Q==
Date: Fri, 23 Jun 2023 16:10:06 +0100
From: Mark Brown <broonie@kernel.org>
To: "Limonciello, Mario" <mario.limonciello@amd.com>
Cc: Arun Gopal Kondaveeti <arungopal.kondaveeti@amd.com>,
	alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
	Basavaraj.Hiregoudar@amd.com, sunil-kumar.dommati@amd.com,
	venkataprasad.potturu@amd.com, syed.sabakareem@amd.com,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: amd: update pm_runtime enable sequence
Message-ID: <ZJW1zjWMUYXP1XpH@finisterre.sirena.org.uk>
References: <20230623214150.4058721-1-arungopal.kondaveeti@amd.com>
 <80e86035-f6e5-3059-6cf9-7f6cd93fa2ee@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eF6HMMrE3THkHzzf"
Content-Disposition: inline
In-Reply-To: <80e86035-f6e5-3059-6cf9-7f6cd93fa2ee@amd.com>
X-Cookie: Slow day.  Practice crawling.
Message-ID-Hash: JVU2J2545RJVASH5YCO7K24W6PVOTVFQ
X-Message-ID-Hash: JVU2J2545RJVASH5YCO7K24W6PVOTVFQ
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JVU2J2545RJVASH5YCO7K24W6PVOTVFQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--eF6HMMrE3THkHzzf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2023 at 08:40:15AM -0500, Limonciello, Mario wrote:
> On 6/23/2023 4:41 PM, Arun Gopal Kondaveeti wrote:
> > pm_runtime_allow() is not needed for ACP child platform devices.
> > Replace pm_runtime_allow() with pm_runtime_mark_last_busy()
> > & pm_runtime_set_active() in pm_runtime enable sequence for
> > ACP child platform drivers.

> Can you explain what prompted this?

> Does this fix a particular bug, or is it just to correct
> things?=A0 If it fixes a particular bug; I think it should be
> split up across 5 patches (one for each APU) and then
> appropriate Fixes tags applied for each on the code they're
> fixing.

I had already gone ahead and applied this before your mail - it seemed
better to get it into 6.5 than leave it waiting longer.  If there's a
need for backports that can be handled through the stable process.

--eF6HMMrE3THkHzzf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSVtc0ACgkQJNaLcl1U
h9DojAf9Enm/l/OMrjMwbAPilcSH8mRifk/LU9KL085p1vG/y5Pt04uG0eKNREuD
NWq7OxHBKp4Ke93ww07AxVp4XuYWk8u662mhrQa/OuEIAjBQieXo38UuhqOF/nYS
DAmsidTC979HYQuMkl/jGLCldHBTZH1HQT64Gel2M+09T53x++KCbWqkXI0Alwlk
EAv/C7dFvW/+sDpMG1z1N4GdbJERdxLcffKv1CBBeyZOt4JyJOyxHCIQUsY4X6Tv
LNjAcZPXQ+V+IK24foeNiUzwwHX6n7/B7qK2kbnrWZO4+w7Cq8s6bKIJuI22jfax
4qACFcj2rdzPquxozbqxMOY3BXwnQQ==
=tt24
-----END PGP SIGNATURE-----

--eF6HMMrE3THkHzzf--
