From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC:isabelle:Remove regmap_exit()
Date: Mon, 4 Jun 2012 15:35:58 +0100
Message-ID: <20120604143557.GK7538@opensource.wolfsonmicro.com>
References: <1338812094-10426-1-git-send-email-MR.Swami.Reddy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7574552842576117992=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D5FB22433B
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2012 16:35:59 +0200 (CEST)
In-Reply-To: <1338812094-10426-1-git-send-email-MR.Swami.Reddy@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: MR.Swami.Reddy@ti.com
Cc: alsa-devel@alsa-project.org, vishwas.a.deshpande@ti.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============7574552842576117992==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRokNccIwvMzawGl"
Content-Disposition: inline


--wRokNccIwvMzawGl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04, 2012 at 05:44:54PM +0530, MR.Swami.Reddy@ti.com wrote:
> From: MR Swami Reddy <MR.Swami.Reddy@ti.com>
>=20
> ASoC:isabelle:With devm_ APIs regmap_exit() not needed, so remove regmap_=
exit().

Applied, but please use a changelog style appropriate for the subsystem!

--wRokNccIwvMzawGl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPzMeoAAoJEBus8iNuMP3dYggP/07elEcn+XXE5GZWbKSQ4a7K
ciHz++JEU1pfibXQxv7CIl3LupjpcM0HIIFqQPnoKI64U77xc6qxITUal1t7fSgO
SbzAb+fpDvAgIHRvtou9PKdzDN1gtukjQu/Vu7UG/u+WrZ6nh7u/0Zzc7/HgD2rf
PDaeot0W0LkWsC4TdJjgAORRFN0gH2ZGILI41YR57jsowY865Nwg9CR859jGzbIi
vUitPiHlnUc8JfUBPMavJcW0TWXkL9BZnjBLukD73M2DjWR8rurjD3TZdhLPsMwI
3CrHVqJXgnuwPdgs72oR/oLcSjXenMSYtb4Z/bPEoOu3oImtR7xqezceMI8SF2YY
uLuyJnf+oMSc2wXV88/o1Z7AW4fFJjC3xjXkgJlxrxDxFXGEowhr74r+BnTEbAlT
tQSHbVg39Tzi0ReVTgRYcQaBLqv6TDrOFTiTmWD5bl+kpbqqDCVj0i8ahdFafA1/
woiavT8MZJACmFNJRG7op6BeSdDWBSN6WSjqF8F+WQ70X1nJHIJHd6qse+IRqkif
8RiGYwwLyg6JL3EmUvnNf/eBVgLQohIH6erepZKtrlOzYQqDUXcPPsdOxL3s1gBy
wusESg7Pi/NE8wCY1u+ouoXVpHAKeTJ/vowtdymVyuCceIlp2VFVCHS3rxCzr8cV
NRKKlVn4WCmhgFn2KIKr
=lF+4
-----END PGP SIGNATURE-----

--wRokNccIwvMzawGl--

--===============7574552842576117992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7574552842576117992==--
