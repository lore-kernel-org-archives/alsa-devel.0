From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: rt5670: add codec irq support
Date: Wed, 12 Nov 2014 11:46:13 +0000
Message-ID: <20141112114613.GF3815@sirena.org.uk>
References: <1415773681-2394-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1336684027681167163=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 04A25265338
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 12:47:37 +0100 (CET)
In-Reply-To: <1415773681-2394-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, mengdong.lin@intel.com, lgirdwood@gmail.com, yao.jin@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============1336684027681167163==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iJ4DPVtG7O6+M1+H"
Content-Disposition: inline


--iJ4DPVtG7O6+M1+H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2014 at 02:28:01PM +0800, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> This patch provide the jack function of rt5670. We use a irq pin
> to notice the jack event. rt5670_irq_detection will determine
> which status should be reported.
> We can get gpio information from gpio number or gpiod_dev. That's
> why we define both on platform data.

I'm missing patches 1-3 of this series.

--iJ4DPVtG7O6+M1+H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUY0iEAAoJECTWi3JdVIfQqcMH+wfMMsOM+QOL04puknJrZ9pU
gB1o22OD8NckQeUJ0QTYwdMPpNJnxHJxPSIHj4ieO7kLJAhJRn3DyQ09wF8vGsxw
jUfcnxKGVKLxyll7y/adStdwqqMcbO+07MjgabR2Zd3xddX2xFfrAoVMEzZYzvP8
9nOeqY0NArIZ4mVDDBDqHTxJGqlpqQHCzb3Je0JLnWAYisfeuZOyvuOgBObY9fcP
8CHuRHtv5Yd5gPVLeMRQ16VAOkpJDshMM7eJcMYKKrNk/AK0bc4JNR7FKMNmFDAL
MLCDhJyqQlTScNuaMrAz67eMuGTzja03rDfLmtxKnJCPVnz7CPecjOvU1vEYprE=
=FnTI
-----END PGP SIGNATURE-----

--iJ4DPVtG7O6+M1+H--

--===============1336684027681167163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1336684027681167163==--
