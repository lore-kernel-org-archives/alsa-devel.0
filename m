From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: davinci: fix DM365_EVM codec
	selection
Date: Thu, 29 Jan 2015 11:51:37 +0000
Message-ID: <20150129115137.GD21293@sirena.org.uk>
References: <12284641.mhX5PHEsR2@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0175849319728435238=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 83A2926042F
 for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2015 12:51:58 +0100 (CET)
In-Reply-To: <12284641.mhX5PHEsR2@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, alsa-devel@alsa-project.org, Sekhar Nori <nsekhar@ti.com>, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0175849319728435238==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DWBYAyGr87jzdy3M"
Content-Disposition: inline


--DWBYAyGr87jzdy3M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 28, 2015 at 10:30:01PM +0100, Arnd Bergmann wrote:
> An earlier bug fix of mine made the SND_DM365_VOICE_CODEC symbol
> tristate to avoid creating an undefined reference from the
> davinci-vcif.c driver to the davinci_soc_platform_register
> function that may be in a module.

Applied, thanks.

--DWBYAyGr87jzdy3M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUyh7JAAoJECTWi3JdVIfQX30H/Ant+O63V5csi9/YYDlLIji8
vfVUBohDjPdCoc4vj90mJAA70hAT7HjktDuRGCzZoqgNCj318l+3gkayQUxCP7Zm
fHSpKktqhYyAWMmFyPibIxhVjzSMChY6gG5iL6FCKWfmC7PTRfCFcN8EhK7NnXLZ
HqZXknmo5jbQouKk/wWxdl8Z3pJBhdc7klGpFgfvqAYcjpA0oS7vIMQvwzZuxkcu
R7VWfANXC0KqyLXWwcQo5sqhjkJYbsJZYcA28qNzAMN864WQ4Wz50XnQN5LA4K5N
JW89ZRNmCvff2IA4UfSKef2wzKw/+StWE/f+xmpGIROrKQJjZINhKkYjcW9lQgk=
=1taA
-----END PGP SIGNATURE-----

--DWBYAyGr87jzdy3M--

--===============0175849319728435238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0175849319728435238==--
