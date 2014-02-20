From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 006/102] ASoC: lm49453: Remove superfluous
	const
Date: Thu, 20 Feb 2014 10:56:01 +0900
Message-ID: <20140220015601.GU2669@sirena.org.uk>
References: <1392723148-12597-1-git-send-email-tiwai@suse.de>
 <1392723148-12597-4-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0519330674353007184=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id AE779265464
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 03:20:34 +0100 (CET)
In-Reply-To: <1392723148-12597-4-git-send-email-tiwai@suse.de>
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


--===============0519330674353007184==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LX6jtR8+ieQJxFRP"
Content-Disposition: inline


--LX6jtR8+ieQJxFRP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:32:18PM +0100, Takashi Iwai wrote:
> As SOC_ENUM_SINGLE_DECL() itself contains const modifier now, we can
> reduce const from its users.

Applied, thanks.

--LX6jtR8+ieQJxFRP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWCtAAoJELSic+t+oim9LuQP/jH/1pYhHnBn3zzqH6IyFWHD
by2c1lR0ExSiOCKEft+sGs24Mr5438RshdsveFuzsetxvU/CEgRaidJFjXHKj5tg
rjGc+GFNFtCHGeitzSWcFSBs8JIgp9XyTvzeeHsa7JvXMKJyBuuaA6HXoWl7m6vW
HNEL5uIJVIKz6hh5h3HsEbSHxnde8Gbjq0pk7XOIwaFlQBlkSr94iinYmYmn9ijk
OMv3yMSh48rzYIxBNSOeTsZwzLioK0gFoxefTv02/xHKOOo3W1uZhiGGLJSm7Z7Z
IhuJlEvnL0TxD/kZf7uL9kisJNrwWwcL2I6mfAiPHerYzRUjrEccXFmY9dHNgvbz
YQX68YQtTMxPMhyFpvJuQIfccWPqLZ2gVXMsUMquQlZUWeta8l1qBDF8ZhAU3Y5s
DqAsGbF4o0j2arBDWT4Lk6kmymVzcAySsoBrGoJJpi+VOimWpT4xUgXocUQgrMgS
tPw4f5Utjzs1qBVGy+MSO/6jiqk3uaU/erXO5lV4sJjetGu2ACftNP7sMl1x+79I
Y0oZEI/qH0rvLiU2b6Cb9jVGO8asJCTTUPVGb+57axCdjVQl7AdslEuS1B04KZfB
xAP6R+OLBHsSb5j/1HbXEzO2IjD2j6Vaq0Ca0TZbMTFod/VtDHR/p6aVI4C4PVN9
sXeDq4eYNvCmNL8m1T0q
=M2tE
-----END PGP SIGNATURE-----

--LX6jtR8+ieQJxFRP--

--===============0519330674353007184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0519330674353007184==--
