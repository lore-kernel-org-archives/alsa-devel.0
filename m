From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/8] ASoC: fsi: convert to SPDX identifiers
Date: Tue, 12 Jun 2018 15:07:25 +0100
Message-ID: <20180612140725.GB10819@sirena.org.uk>
References: <87po0wdda5.wl-kuninori.morimoto.gx@renesas.com>
 <87o9ggdd94.wl-kuninori.morimoto.gx@renesas.com>
 <CAOMZO5ACWxCandV_KhR7ysR0xoAxG8KO7qYCGA42Daq94ZGOxw@mail.gmail.com>
 <s5hlgbkzeae.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4087537370329346820=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id ED506266E77
 for <alsa-devel@alsa-project.org>; Tue, 12 Jun 2018 16:07:31 +0200 (CEST)
In-Reply-To: <s5hlgbkzeae.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Fabio Estevam <festevam@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============4087537370329346820==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 12, 2018 at 08:53:29AM +0200, Takashi Iwai wrote:
> Fabio Estevam wrote:
> > Hi Kuninori-san,

> > // SPDX-License-Identifier: GPL-2.0
> > //
> > // Fifo-attached Serial Interface (FSI) support for SH7724

> ... is this really the consensus as the preferred style in the whole
> Linux kernel tree?  To be honest, I find it rather annoying.

I'm not a big fan either but at least the first line absolutely needs to
be a C++ comment, this has been decided.

> It's a food for bikeshed, and in general I'd postpone such changes
> unless we really have to convert.

Everything is supposed to move to the C++ style comments.

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsf05wACgkQJNaLcl1U
h9BkTgf9HCLG3+szmFk2QM1tjo9Jyn/n6uRh6j0fTj/pP1I46aQ6Ya7aZtHe0xLU
kXEir1MeGQZ29SsRC+mTr5JPuxUe5t+OYZ6i5l1ar+/WC0r8YY3dlm4OxS1+AWOi
PHGx0lFa5IS3ynaV11WzPnXp8GlXa6vMeBBQ3rO01g1AdPKuf6CmFxps4xyo+KML
ldxhvyRCTfbOdNK4gWSmoiHr4DNk9JB6zw4FSFMWu5m2msNV64CTKNcZ5Rm8Hpox
eDh2pQRhk97ZNgx7+uKakzyEj3tjJVY50o9iYgsDAs3nSqI14XtrAzoMcbpjXbmY
jpD6bJyAi9d6nI7zjDadcaGqDulAnA==
=y4qa
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--

--===============4087537370329346820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4087537370329346820==--
