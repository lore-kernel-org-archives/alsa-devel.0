From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5] sound/soc/lapis: add machine driver for
 ML7213 Carrier Board
Date: Tue, 6 Mar 2012 11:54:07 +0000
Message-ID: <20120306115407.GE19635@opensource.wolfsonmicro.com>
References: <1329976011-2251-1-git-send-email-tomoya.rohm@gmail.com>
	<1329976011-2251-3-git-send-email-tomoya.rohm@gmail.com>
	<20120302130509.GF3230@opensource.wolfsonmicro.com>
	<CANKRQnhHo1P0cmxyfUAShTinWMv0B81d8v8f7M6Oj3Yx9807zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2239839416654535107=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6C4162433F
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 12:54:09 +0100 (CET)
In-Reply-To: <CANKRQnhHo1P0cmxyfUAShTinWMv0B81d8v8f7M6Oj3Yx9807zg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: alsa-devel@alsa-project.org, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2239839416654535107==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jTMWTj4UTAEmbWeb"
Content-Disposition: inline


--jTMWTj4UTAEmbWeb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2012 at 02:49:24PM +0900, Tomoya MORINAGA wrote:
> 2012=E5=B9=B43=E6=9C=882=E6=97=A522:05 Mark Brown <broonie@opensource.wol=
fsonmicro.com>:

> > You're also missing a blank line between this and the previous stanza.

> Sorry, I can't understand your saying.

Your file should look like other similar files in the kernel.

> > Use snd_soc_register_card() and a real device.
> OK.
> As a matter of interest, why do you recommend me to use
> snd_soc_register_card() ?

It's been the standard since 2.6.38.

--jTMWTj4UTAEmbWeb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVfrZAAoJEBus8iNuMP3d410P/imjuxCBTavWKqO6itbwwxt6
lJ0ia1+zV8TriR5At4vdACD5hDr1CbqTL/I/h95G7o8JWvDGlIgmC1Ha1Jlmbtcq
xfywkJt5nggxr51Z73ArvxOsWWewAS15HyFTF2mTrQYlBFQghoj1Tf3Kmk/XDtt0
69zq7rOOSFTjARICscxW1IwGbzIBQGLqF9Nre66QwM+83h35daJ5q+3853T1Tfb2
/WMrpETmZzwEIHnHLj/GBMfG99ZVuepiD8YR8rKMJVYkpPLtrcrWM2+USoSL+Xri
kvolYugnBmvcquHc9z1mqrsCOZnh4sNzqGp/Ngl8fyIcdNSn9mRgQcwx5wF7e4V/
UFwUnIZnkKidRDkiMwr80/A3ExvIz4SH3OR1hYPRZM8S+wHAxdKb+LwsvneYEvHk
BCVOeUJXZLrx6d39nc5wIdHNhywLnsl+lJ8+VJ49a05DtdGpfJauKdah7u3Eju2y
nzLdMp8fqS5NDTPmtvJjtbDN5l+e8LXIO5zpOIx+sQwJSreNIGV29MVkW/IiRCKR
ou6KPPsk/AN6zEkZ01RBeAjNvPNCYSXJxuYyRO4pYQcDRwEVeqOxSYHhIGsDS5Y8
5H4YpDwWVRvbHNAxPq8eXYMKkcaVMuciWgOzKYCVx/MuPhRUZkzdEZHe4UT6Ju4t
PT2KjS+pdYtY41rcrxB7
=dHXw
-----END PGP SIGNATURE-----

--jTMWTj4UTAEmbWeb--

--===============2239839416654535107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2239839416654535107==--
