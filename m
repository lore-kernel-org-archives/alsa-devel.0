From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: rt5677: Modify the behavior that
 updates the PLL parameter.
Date: Thu, 8 Jan 2015 18:35:39 +0000
Message-ID: <20150108183539.GY2634@sirena.org.uk>
References: <1420684267-19211-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1135599349823033364=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A6E272604D5
 for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2015 19:35:44 +0100 (CET)
In-Reply-To: <1420684267-19211-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, yang.a.fang@intel.com, lgirdwood@gmail.com, john.lin@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============1135599349823033364==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ahpomBHjrAwc2LGG"
Content-Disposition: inline


--ahpomBHjrAwc2LGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 08, 2015 at 10:31:05AM +0800, Oder Chiou wrote:
> The patch modified the behavior that updates the PLL parameter. It set the
> update bit before the PLL power up.

This looks like it's a bug fix?

--ahpomBHjrAwc2LGG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrs36AAoJECTWi3JdVIfQRdMH/19UDheT9jN8fcnXkzxrs76r
DWJ5oBgtgq15I1Il0Dv6hxnKYOQl8avd51CMOeqesN4Q5PsJOWGZTjbT7TaO0m3n
16R+kxDCzSLR0QnMBrMacKw1uoZ2ZpR/IU1Zr2KK1bNz0GKyY3ogOiipDw5DOJ/i
QwtHi7rtdXP2tG7x9buJHHfM20GEf/SF6R0kSkdi1UyvHr59U0j3+CFPJLaQshUZ
gHYBwCPZ1w6T1O8fzySSNQGM5lSm+jDig7sf1iTqzNeAj671i4LUPt+NJUw/go1N
puHhSdJ9TmE/0fyB4RRyvgq1a62AepDVtRz5nwVkD0jfNtQAK3qklOWcFplywMY=
=pHQI
-----END PGP SIGNATURE-----

--ahpomBHjrAwc2LGG--

--===============1135599349823033364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1135599349823033364==--
