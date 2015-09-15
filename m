From: Mark Brown <broonie@kernel.org>
Subject: Re: System with multiple arizona (wm5102) codecs
Date: Tue, 15 Sep 2015 15:09:19 +0100
Message-ID: <20150915140919.GE11268@sirena.org.uk>
References: <20150914115439.GA29646@amd> <20150914115255.GE11200@ck-lbox>
 <20150915061832.GA25442@amd> <20150915080648.GG11200@ck-lbox>
 <20150915083552.GA14780@amd>
 <CAG5mAdybV2U5Z9FRPy4zVF10Ws63rybSHCMCEpKQ1ArTBLnXpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0187558178614719988=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EE1D26041D
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2015 16:09:32 +0200 (CEST)
In-Reply-To: <CAG5mAdybV2U5Z9FRPy4zVF10Ws63rybSHCMCEpKQ1ArTBLnXpw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, tiwai@suse.de, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, Pavel Machek <pavel@ucw.cz>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============0187558178614719988==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
Content-Disposition: inline


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 15, 2015 at 06:56:39AM -0700, Caleb Crome wrote:

>    I'd love to see the patches :-)  I've been trying to figure out the
> *right* way to add multiple codecs to a single card (and single CPU
> DAI) for some days now.  Any help would be greatly appreciated.

Like Charles said earlier the Bells machine in mainline has multiple
CODECs hooked up.  Speyside too.  To hook up multiple CODECs to a single
DAI link see 88bd870f02dff5c94 (ASoC: core: Add initial support for DAI
multicodec), sadly I don't think Benoit ever got round to submitting a
machine.

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV+CaOAAoJECTWi3JdVIfQqzwH/iYpaDhhm+EwVV6YV75rT5oO
HsOYwc7CT7xG8V6BUmkDi7LJ6DUd69js7LoKdtN/PO4+EuetbASGmA0UD11Yn1tB
6zXBEx2ajUTAerMTr/UlYwCp62xz0/HRDps2YR4f1QAjr+Set2fKYiTafKkAQkjg
CxOZtdV8m1RpaJR761okHxm9jo9o0keCobYvFqKgsV7xrsvi+47TPmrx8rCYG041
pJJqNvLz/6UX7IwF+aTRURC3yQJLu4PMv3FC10g/Ynx4teSviDmvu2KD7/WxFRSi
17lxoqVbPiJ8ZYHXYVLwfLRMxUgkaiURzjOABqxSxeyv4ZSmBFlzfIwdOwkX2zk=
=J9Rg
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--

--===============0187558178614719988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0187558178614719988==--
