From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5670: add rt5672 codec support
Date: Tue, 11 Nov 2014 12:07:27 +0000
Message-ID: <20141111120727.GU3815@sirena.org.uk>
References: <1415699990-5344-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7289702195700340001=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 45F4F264F36
 for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2014 13:08:47 +0100 (CET)
In-Reply-To: <1415699990-5344-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, mengdong.lin@intel.com, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============7289702195700340001==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="94TgruZZJaqyQsvb"
Content-Disposition: inline


--94TgruZZJaqyQsvb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2014 at 05:59:50PM +0800, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> rt5672 is very similar to rt5670. Therefore we use one codec driver
> to support both codecs. The difference between rt5670 and rt5672 is
> there is some difference in their dapm routing table.

Applied, thanks.

--94TgruZZJaqyQsvb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYfv+AAoJECTWi3JdVIfQDugIAIS5G/1gGYvXaHdnMlLN49k7
Qr37NzMenM7fQb7vRWfTNlW4tuXy+bVvd7jD5UZ9WD7iCocxuxRuSM2D+jAzeED2
P41l+OM+TnbjBdlEGLxn5T+DCYRljDbSdQA1rOSqpQQ2vNIPvC9A3/hxznbH/r2R
95S2/HPpTYLOQ6LZ/yAxr8C1X18SsE9eprr69nefdVIFlSYl+RlRCiPaM4cHPNtp
+Iqa8k/9FvzDD3rKmNmAshctqftc4AkAjfMVnDYjND0lGBdXpIV9wjdal8HQfANr
wudvpv2nQlGMAYvT//Cp2BYrS0zW8ZmGIlcaIDpVWMCtwlaxt3KjD0Sd2+qw1Ts=
=GV89
-----END PGP SIGNATURE-----

--94TgruZZJaqyQsvb--

--===============7289702195700340001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7289702195700340001==--
