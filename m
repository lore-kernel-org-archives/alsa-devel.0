From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/6] ASoC: fsl: align mpc8610_hpcd with
 p1022_ds on getting codec node
Date: Tue, 28 Feb 2012 12:35:24 +0000
Message-ID: <20120228123524.GF3683@opensource.wolfsonmicro.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-3-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5986616134773434034=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 37D90103E79
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 13:35:26 +0100 (CET)
In-Reply-To: <1330092582-21180-3-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============5986616134773434034==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lIrNkN/7tmsD/ALM"
Content-Disposition: inline


--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 24, 2012 at 10:09:37PM +0800, Shawn Guo wrote:
> Align mpc8610_hpcd with p1022_ds on getting codec node by just calling
> of_parse_phandle.  The bonus point of doing that is we can save
> exporting get_node_by_phandle_name() when we consolidate the common
> bits between mpc8610_hpcd and p1022_ds into a module, which can be
> shared by more machine drivers added later.

Applied, thanks.

--lIrNkN/7tmsD/ALM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPTMoDAAoJEBus8iNuMP3dzuwP/18WCgwFNwWkzggLsXQUVy6A
lJ1RHpPSQnkewIZ41MfHJNm/ugBkW/CaFyRxkGZSOTaoktvMcVJyqWeOH8LrrIlf
iDzCHjm89TedvCES+zTr5ASqJPYqCPgWTbdztPSIFDzUVakc0I8WtiMrIUj1Yb8J
t5yaRb8GA/z1Swz9UnRjkc7iyY8KRQrAYHqQStg5PgiwKLp/Uq5eKEQ+TvYuEuE5
/lFFGZj5drqDW6n+NYeniB4d+GEUJ6f1ERtEv0TT+lXErfgEIz+4Ih8jAULjZIE2
1Oc6yJ7AOFeP279gA64LMLWLoptpG/C2YrmALRd8nXKOujyf0LPbmFP8uurhZa/I
32Qq/qUY/tq1+v7bXd3zuBCMOmMnfxqDWRboUKkaOHre5fTYfbCczm4XwtIhFAoF
ryTFaALCJ9kC7ly+QZKxOdxWqOP1+gzYBXMAF2nSdxgaaTCPbzrg5gAnNObeipva
oHaCAdfc67Yp3jHm+S8EmkdEkioZ+D24JF8x4xovZ9n4S7azBQGu5SET23n7ocUj
n44pYJZGVvT/U80aeOgoCmXcCU82wp5Vt6FaCEGg7SX3bERdXuVPnJwSDa0ITozT
i1pPtV2Kuj1TYaWMDEkD29AnJFjR6MO/WZX0EAJbg4AYxNyWyKQiFOAnlzspLxqS
KVQMMIrkSA64UxcM0XC3
=h5Lc
-----END PGP SIGNATURE-----

--lIrNkN/7tmsD/ALM--

--===============5986616134773434034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5986616134773434034==--
