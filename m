From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: imx-spdif: Use snd-soc-dummy CODEC
 driver to link card
Date: Tue, 31 Dec 2013 16:34:22 +0000
Message-ID: <20131231163422.GJ31886@sirena.org.uk>
References: <1387790933-29232-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8386031984260151099=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B0DB9260307
 for <alsa-devel@alsa-project.org>; Tue, 31 Dec 2013 17:34:26 +0100 (CET)
In-Reply-To: <1387790933-29232-1-git-send-email-Guangyu.Chen@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux@arm.linux.org.uk, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8386031984260151099==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kJQbLzJV/QPBkXzU"
Content-Disposition: inline


--kJQbLzJV/QPBkXzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 23, 2013 at 05:28:53PM +0800, Nicolin Chen wrote:
> This is a quick fix for the below two issues when building spdif as modules.

Good thinking - this is a smart way of dealing with the issue.  It'll
mean that we don't have the application specific constraints but those
could be added back in the driver later or we could do an explicit
S/PDIF CODEC in the same style as dummy.  Applied, thanks.

--kJQbLzJV/QPBkXzU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwvIKAAoJELSic+t+oim9vWgP/2KDtjLV1j68l7xROw3ytx1T
yzvcHl2vwytfrICXJv8h6ecc+5QTazmbIzpz7ALJu7MOXdH6uE/n+oIDdiiaUoDw
Pn5fBPuPWfAdejtJpdXpX/O6UVLRILTk74r03nRnWopdJZRBl8LQ6bob/T5NPTf3
OSmx8PbrlZOGr0hqXuFAS8xqcf2VhWc1wYES7tUP/8dVr/qtuwLaLtGtMQ5CTgTf
Fx41kx1Aoi/TDWsO9BL+Vb7rSECPjeCY9ayY9nF068PqBsYQfdgLHAkyLCLnZaAe
q8vqgJIyxtvsrMZgXlV8mFCloRl9zllg2t3bKoKlJYD4UzqoWJsFys07oZKb8XFF
Ski0sv8vzMy9vnfKyfjxn8iQiBzTSteT79861icIHvWF/xjkjEJ5seVs2wbfHael
m4ayx+Hg4VsctHCf9PjzmYet7oopDHCIif03asJWQRr7XW/vjKKd6PFFQoy6l++x
jn2geh7Z0NjMyowH5cTi+m+vWDM1KHsIPRUyHP8So7W0Uwit0QFjfdsb4Gbxd3gT
0fcJTu6YtYT1P+E2TKAQqwT4eMWXoWpo30JTWafBoZvaaG5zg2TKuLyKfnU0L1Qd
imiloEIYnl4iO20OPQGsv6Aal697hAeMlpy8Y6Wgip72nGrLQoUHlKL5LrqdlpAI
HrKfxunDWR+PoCGIEO+K
=Mlds
-----END PGP SIGNATURE-----

--kJQbLzJV/QPBkXzU--

--===============8386031984260151099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8386031984260151099==--
