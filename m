From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC:rt5645:Add JD function support
Date: Wed, 5 Nov 2014 14:51:59 +0000
Message-ID: <20141105145159.GB8509@sirena.org.uk>
References: <1415170928-29408-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8080141901612381255=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EE8852606BF
 for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2014 15:52:15 +0100 (CET)
In-Reply-To: <1415170928-29408-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, yang.a.fang@intel.com, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============8080141901612381255==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2014 at 03:02:08PM +0800, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> rt5645 codec support jack detection function. The patch will set
> related registers if JD function is used.

How will the jack actually be detected - I'm not seeing anything here
that looks for interrupts from the chip?

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWjmPAAoJECTWi3JdVIfQe20H/0joE5zjtakxdrLKQuQpAkur
qnqhYQFcmwujzqY5XN0MoVVLKSAFWcl7T3OybA6ECZRBtnaoihYvv52GE13pY7HK
61xEDIJHj4TQnMUDc1eTKfjr7YgfXAWzJIOHaPrNWSzMzuzRGVZzPphnYvbcK3qO
qjaLgeOAn29FMVfkMhuw5bUtqsmr9E3lDN/D7M77SQ0DrTJd/i6QgtqGSyOuLpn7
sQN/BlOff0XOdK9owCIY2UwwG3tHqk9RQGd2Pfa2fE7V4B2lWA6dWFCwDuQkX55F
4DnpI+go0ezQPxysILfpVA1JqjmcoYNbjW/x+W/jMPuDVevR+42zv8Pw0lHnIkE=
=AmH+
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--

--===============8080141901612381255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8080141901612381255==--
