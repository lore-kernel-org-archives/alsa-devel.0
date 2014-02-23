From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 045/102] ASoC: twl6040: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:30:40 +0900
Message-ID: <20140223023040.GK25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-18-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7382452713657963000=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 37503264EFF
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:31:13 +0100 (CET)
In-Reply-To: <1392723517-12772-18-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7382452713657963000==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wSq95SjGPZBE6hCW"
Content-Disposition: inline


--wSq95SjGPZBE6hCW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:01PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.
> Also, use ARRAY_SIZE() in some ASOC_ENUM_SINGLE() lines.

Applied, thanks.

--wSq95SjGPZBE6hCW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCV1NAAoJELSic+t+oim98r4P/15ZWPndVhlz7PFZproUvVF3
G6tNrzyG75lT0eKALNk2q8UIABXQPrYiQmBGbI4RCH0MbP4UlUs47N+jpVDsE3HF
E62SJyagGG/6gzrlMHiVVyHTMe6/EISg8X+lmkYhMpOtjyqPowN2Et+hedrcqR4N
el7NtA6KwtY5Dg4o3JzNwmUd7bf9IJNJmlxQNSgkpr4fpQhUGwDLw9X2HbGBnS3w
fGBSnpSQ6kHsxCZ8bUZb0k4FeijPL/il49GJZXGjDRacRnJETtwaXMjbi87eUvhR
gBZjWCEi1SjYzPtBXbVcqrpW9v4OmPgPXzisWTYM3+JgSjsdXFxLA2XSplbhISbj
EIQA1Baf6cVQLTcBkp7I6MMCaW7o39ig+myoNp+k2Oc0VSr18KNWoPFRfSe/sCi7
TOoI9NiZWiIzw5i1D8M+hguiqCYy2hAaMUsDGivPdwh+LdNKo+oNSFIctlcPUr/K
dr0Wv4CACZCC0WC0xWxEaC8fO6aRYcZ1ED64t6SbEoFJEjpwmaTjkcINF+4a3ZrT
H8xTiH7dfUlVdtMZxnVY/HKEusHH2e5hI0Sh922dI+p4yKqFjtVV4+I446Th//LL
OLjb6Tlqd45U9NamR1FZ0Vn9wkeABAUVZBvpd0AmNjhAqXbnMB2oE+xxaOW0u35T
SeDtHD28fC2e8hZhldDN
=7MOx
-----END PGP SIGNATURE-----

--wSq95SjGPZBE6hCW--

--===============7382452713657963000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7382452713657963000==--
