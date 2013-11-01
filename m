From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dpcm: improve robustness
Date: Fri, 1 Nov 2013 10:54:01 -0700
Message-ID: <20131101175401.GX2493@sirena.org.uk>
References: <20131031150920.GB16735@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5723300911118105678=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 346DF26588B
 for <alsa-devel@alsa-project.org>; Fri,  1 Nov 2013 18:54:13 +0100 (CET)
In-Reply-To: <20131031150920.GB16735@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5723300911118105678==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1hAU+gb7eAuiw2fm"
Content-Disposition: inline


--1hAU+gb7eAuiw2fm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2013 at 03:09:20PM +0000, Russell King - ARM Linux wrote:
> Mark, Liam,
>=20
> You may also wish to consider adding this patch as well - it avoids
> oopsing due to a NULL be_substream when writing be_substream->runtime
> if the frontend is marked as having a playback/capture stream but there
> is no backend.

Applied, thanks.

--1hAU+gb7eAuiw2fm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSc+q2AAoJELSic+t+oim9RrQP/jF50F5MxFLbp7csWFlXGd16
IIGyxcXusFlVXLOWqXDCTy+A2y2upDozd60a999/Ah3wGYfSIGODUqp38lw5dmHw
d2IIZJFdHpadZmKLX5SnaCuydHcOURATSEJGYlAt4dfuoVmyk+cNMc+uJ+GtG2wo
Q6A52vC0MzDf1vPYaZZkXplZcUwTo60ER0ySRGR73W15gMALWNSwbTgrivzuDJ30
iB0fBl4kf+euCphEstaRbFr1Qc9tQXcNJdtjiYGHBu4bX6P8wePAYtBRYjMTgFn7
n7Yu4Yi/sMQl0kn4484v9ClS+iP2Bs7LztHTXrqkP/KblBjxiBVg7+GOArkyv1+w
09rpT+A20D7X/WtBtU3UKmvZJCeVGdjTUUOxYhK4KZOppUAEUU96cR93jzq0QkGo
VMO/nDFQ5v3jQER9+aXfKLeTfk4ui7xLyX5mDa30WvFzWTGAcCy73zST2/zYqLZz
hnJIXTJ/7wAmACr2Phet4EVwZCH2W6m1mH9xm29KVMNv6B25yaHtrJn1rhIxluiy
+yCZZh0L1+PMaV3sw2TP9U/rU25sW2tftKozlAiVDa2N0gSGrVofD0DoNhIOMud1
mtT6slKMhoJML/OtvCvJOOHXQF10yv1hSNgc5mzglTg1VNNCwXa0/x6CnkxBgNwm
2xMCd6GuVDAhaQqO9Gfv
=zEoL
-----END PGP SIGNATURE-----

--1hAU+gb7eAuiw2fm--

--===============5723300911118105678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5723300911118105678==--
