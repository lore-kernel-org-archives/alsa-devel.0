From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Fix dai_link dereference.
Date: Mon, 30 Apr 2012 11:15:13 +0100
Message-ID: <20120430101513.GH3170@opensource.wolfsonmicro.com>
References: <1335780330-1157-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8572351267545623033=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0772B24426
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Apr 2012 12:15:16 +0200 (CEST)
In-Reply-To: <1335780330-1157-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8572351267545623033==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m972NQjnE83KvVa/"
Content-Disposition: inline


--m972NQjnE83KvVa/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 30, 2012 at 11:05:30AM +0100, Liam Girdwood wrote:
> We should check dailess before dereferencing.

Applied, thanks.

--m972NQjnE83KvVa/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPnmYRAAoJEBus8iNuMP3d/rYP/RglhYtLtZCprQPMUgdntQtl
QFG7vphcsGRndD7ffOd0vbytOznteQ7tYdtIgFhUS1BVntFC+AUjt1aO6DqH1eqz
xELtTm65TsbF1l+yn6scFHsXMtvJvKEwkU/IHns4P8JqGD6tbO1rte9m6aB8mwTm
9Ys+8TNDeKsCQR6fuNxyR6wmbY3bYa1FbcF+M9Z32CItaa91dCW9kkovIrpVM5RA
AOvnUPdsxMK+7m/T6TTzI45icGUJpxtZ/i9tP467zgX50REJxN0YtMMdgbjBDVev
PA/9K95+Y8qmAJulCsv9eBnxDuSUKuZdGbGMCGBwDRWVNibx6xrTL2ng4Eh98PEf
3CN4P4BJg+/mbj0V9Qm6Do9DBvxE/QBH48I7ctcJJyJ8an90DUpQLZKCyuvDTvN5
t+No3n60nWsPDINXoYLVIF+Mhj4nWxWnAR4ra8+0Sx9+C0wXGcsz/PCKEcWE1DTR
65D9qsRgEDVa+MnirY4Pgpr3jlMPmP9tgRlkaVQc+US7MPAwTr0QrQlaenF6Bzd5
QnISYHukpGu05EMcN5uRkaWN6E0VKy4FoB8/b8DeYc6OkASz7/y3DYonn0dsGctI
PHP9FS5rnYXN0vxrk5QmTuiShQz4td5HoGpmQlE9oRQ5XQTQw8DXJKhSdfdpCt9j
nzeY3wAt4T/06d0lPDsN
=7/MK
-----END PGP SIGNATURE-----

--m972NQjnE83KvVa/--

--===============8572351267545623033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8572351267545623033==--
