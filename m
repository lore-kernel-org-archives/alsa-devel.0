Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF717E94114
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Oct 2023 20:55:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B7F601E9;
	Fri,  6 Oct 2023 22:54:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B7F601E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696625722;
	bh=oauOVFT+PrZQ4LbhFiEvzNY1S0t5n89QX4XT55V6IgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hc65H1lAG2CeD/7y8ZgQx4E1Q2APuwxrjG4a4s3siKQNMZltnyWn/yySwJXhmQbOQ
	 Xm724x4mv0qL1MLxD/Pm1HbLWAZkzYQ3nrGyOsnD6NCSmL7r4U1P5E8rYU35IFv7GX
	 pHPi3XUEelhcOLNVpNO+4QUe73DIzzVk8CUZj9JA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9360BF80130; Fri,  6 Oct 2023 22:54:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 462AFF80166;
	Fri,  6 Oct 2023 22:54:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E7430F8047D; Fri,  6 Oct 2023 22:54:07 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 81205F80166
	for <alsa-devel@alsa-project.org>; Fri,  6 Oct 2023 22:54:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81205F80166
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=qykK950d
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E9345CE2932;
	Fri,  6 Oct 2023 20:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF79C433C7;
	Fri,  6 Oct 2023 20:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696625635;
	bh=oauOVFT+PrZQ4LbhFiEvzNY1S0t5n89QX4XT55V6IgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qykK950dTH96BIMrlSxNk8F7VgVWrjQ0wm/EHPGYwP5AOi5ayH7AvATp2Jboup2WN
	 axuuvRZOQBYLh+2+I9jQgJha4Zf+IeSiNhyq+NK4ucPmIkE+VkrIzU8fqG2Z8zZoe9
	 IJp/cG6FvEdOrZFJ5oeN7J3ZL1EUesyalkvY19j+lDFGS1HFG4T+eezRSDgLGhTf0v
	 yVYjdpujB0aRzaD6bzgIiLF6qRYP8j6i+n6hTeUeNqnuHG3KvPYO+c5RSFwfmB4Rbb
	 QPAeXKkDWm8gDryJqedpgaWo3Y0nqLR+AkKYWIKEgr3kNdQ7LdCG1hpT6cEDbbuYW4
	 92aS+GaFg3bdg==
Date: Fri, 6 Oct 2023 21:53:49 +0100
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	asahi@lists.linux.dev, alsa-devel@alsa-project.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ASoC: apple: mca: Annotate struct mca_data with
 __counted_by
Message-ID: <6c7db067-78f2-4637-8064-3dc7c0489b90@sirena.org.uk>
References: <20230922175050.work.819-kees@kernel.org>
 <202310061321.E7247C52B@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xBZ5y17+t2QN5UsW"
Content-Disposition: inline
In-Reply-To: <202310061321.E7247C52B@keescook>
X-Cookie: Rome wasn't burnt in a day.
Message-ID-Hash: PLVGUGGXLA5CNLWU4B43CO47V46QZHJU
X-Message-ID-Hash: PLVGUGGXLA5CNLWU4B43CO47V46QZHJU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PLVGUGGXLA5CNLWU4B43CO47V46QZHJU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--xBZ5y17+t2QN5UsW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 01:22:55PM -0700, Kees Cook wrote:
> On Fri, Sep 22, 2023 at 10:50:50AM -0700, Kees Cook wrote:

> > Prepare for the coming implementation by GCC and Clang of the __counted=
_by
> > attribute. Flexible array members annotated with __counted_by can have
> > their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOU=
NDS
> > (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> > functions).
> >=20
> > As found with Coccinelle[1], add __counted_by for struct mca_data.
>=20
> Friendly ping. Mark, can you pick this up please?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--xBZ5y17+t2QN5UsW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUgc9wACgkQJNaLcl1U
h9AThAf/TVx58WnyibTJozFRT7p4/Ow/TjcP0UNKN4akoSmOUCmaCr8FAebKU1+t
wj1hcUXFXVIQP/EWLB2hf0pPGxzF0pIcx0gGGl46bSCFO0jXks35z0iGcMniCiNA
kSZf/TswG7Guf6j2vwKiwa5eDnnbjtRMzHsW0WZ5UQxslZwRORs/Uvhj80RsfPQ2
NeWrMXwVNs7kmVPS9+12eYUG62+dyFwMKqDhsFraoKIyzUZkIlM+EWi0P9oRm87V
1PyWUzk/CjTMyZpeWWBoj+Q3vtlPIpcFePRpM+LfCN7muZyWQbAvqJqyJgqhW3Iv
mx+Kp3meL06isrlLlnnkOBAXrvPRkQ==
=9Vt7
-----END PGP SIGNATURE-----

--xBZ5y17+t2QN5UsW--
