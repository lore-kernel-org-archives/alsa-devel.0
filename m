From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: workaround: change the timing of
 alsa_sound_last_init()
Date: Thu, 19 Apr 2012 12:43:50 +0100
Message-ID: <20120419114349.GD3046@opensource.wolfsonmicro.com>
References: <20120413103529.GQ3168@opensource.wolfsonmicro.com>
	<87r4vo5exv.wl%kuninori.morimoto.gx@renesas.com>
	<20120416082239.GB3238@opensource.wolfsonmicro.com>
	<87obqs5baf.wl%kuninori.morimoto.gx@renesas.com>
	<s5hvcl0ror0.wl%tiwai@suse.de>
	<20120416100509.GF3238@opensource.wolfsonmicro.com>
	<s5hr4vorng1.wl%tiwai@suse.de>
	<878vhsh1oa.wl%kuninori.morimoto.gx@renesas.com>
	<s5haa288ei1.wl%tiwai@suse.de>
	<8762cwgq9k.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1982799555578708154=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7665110B917
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Apr 2012 13:43:52 +0200 (CEST)
In-Reply-To: <8762cwgq9k.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Takashi Iwai <tiwai@suse.de>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1982799555578708154==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sgneBHv3152wZ8jf"
Content-Disposition: inline


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2012 at 12:00:27AM -0700, Kuninori Morimoto wrote:
> Current alsa_sound_last_init() was called as __initcall().
> So, on current ALSA, only devices that had been properly
> registered at this point were shown.
> So, it will show "No soundcards found" if driver requests
> probe deferment. it's often misleading.
> This patch delays the timing of alsa_sound_last_init()
> as workaround.
>=20
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--sgneBHv3152wZ8jf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPj/pvAAoJEBus8iNuMP3ddlQP/isxnFL5KqfjswRefSGi7DmB
nItx82jvtX3/e5/V8N51YlAm6pieztt8MkYKC9RN3fc3Er2ZO2+2XcUMyp1AoLcu
DTJwmg/QbEaL41HHuxsJrmAM6m6CUPaLE0DZSu0T8UU4rBN97Wv1H+kULOsI+lKg
dp8Z7DT6Zf5yTyMcvpTiwEDAqeeENCQjk4b13xsliuS3d92Cuxxc1Q0lFKgElziS
vpRsEBPq66dQRpqOLx1e/OsXwQnhJqQRPi3J2LLt36SBXWITMegQPJWzpzjKdSOu
NYxuW34c3FAvkiKYbeR9fMfQaP2qyv5ALZ4vvpEhc2Atzk79GK7I9GlJfgIesJ7S
R7czRYjq3BjtSbvOb1soTp64cHALo0lHWveQd31vJw+DMjTdoEnUad7Rvd6+rR37
9ck4LEavF4fuVt5N3Rg4x5/2oiBAbO6D+WAsZnnT9tlDEKpEfa8KSY3D6IsJMDWL
YemAGU0cok1e7KMpvt1cg+Oz9ZUPsCE9XtjZ+dc/WNF4CezeDt6mMHSNnBuFP4E+
eeZvFha6X1qvrlZjF+uDjsItTiSicYSl+n3txbr4xEGG/2l3Wz3SG33v6luuI4I4
fjMQPVQWZhMcbnk+PGUzg04PtigtoD0aG1jkVs8d/I+HQlgC0VZiRb72JYHkXgwc
HmbQqUciGr9qqhO2L4oe
=To5j
-----END PGP SIGNATURE-----

--sgneBHv3152wZ8jf--

--===============1982799555578708154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1982799555578708154==--
