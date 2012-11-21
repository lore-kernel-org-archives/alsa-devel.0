From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/10] Kirkwood ASoC drivers fixes and
	improvements
Date: Wed, 21 Nov 2012 10:40:45 +0900
Message-ID: <20121121014043.GG4673@opensource.wolfsonmicro.com>
References: <20121120121726.GN3290@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6937220282983170173=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 84EDA261698
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 02:40:51 +0100 (CET)
In-Reply-To: <20121120121726.GN3290@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Rabeeh Khoury <rabeeh@solid-run.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============6937220282983170173==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eVzOFob/8UvintSX"
Content-Disposition: inline


--eVzOFob/8UvintSX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 20, 2012 at 12:17:26PM +0000, Russell King - ARM Linux wrote:
> The first five patches of this patch series fixes a number of problems
> with the Kirkwood audio driver, as seen on Dove platforms.  The biggest
> issue is that they can cause the kernel to lock up solidly, requiring
> a reset to recover.

Applied all, thanks.

--eVzOFob/8UvintSX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrDEVAAoJELSic+t+oim9iksP/2Jy9ULfzpPCBFCHjneeVWcs
IyGqsHiYI5yQ6THmCTZRmMmm7kBOR2grGo8dT/ehpH0HszYoTiPHOt6BQ0xjH9ax
OokyVOnuvvSYE1eYOnZNRAh2sVKEVh78rCFXi17tk4Y+KsrQIBrbK+cbeJVBdP77
5roFSHaiU1x8ft41FU4Cqq7PaUG04QY35n2Pte/iT1KEK536goToxOJlliSP4KVZ
EdI3ftx09r46xF4P8pUFduubVoo+01EVdcxof/I96dJ2h0EiB8xn8glm1oY5tA0Y
hlHX9KJot7ob2M06INhXbODm9yxrGJAixK806Is2Mt34wSII4DT2J75AC+4ilCnl
8bm1tBQfsNNxUpkzYopAqwrMNK6JpEs6JbBvlu8t798UGaLkACnTv6OgoUv6g7j7
VZRwsQ0mydX5YDeRyMKlF+VqOKN5zKrl5TgdF1Drsxe5cxB0sy+Rl/7SP6myFcqe
RMJJpRjpeA03+uvVdD6kLcQr7X+NDnxWKZaFDOaNP/Q7vY5akFWDDLNRVPN1xW8L
m7m5BRTgjnZZ8Oqjz8nXsSyY5vLsRisyaiDxY5Cz2I7DJ6joKMx4ZzHwcjRsPu06
lQ1LpawJqIv1mmezRhxDAUjlrJGJXUrZabyfVDlW3MpPQSKZbuo7BlEESi7nqBOt
hCP/f6pqT/Vvwm0XwG5M
=lTuV
-----END PGP SIGNATURE-----

--eVzOFob/8UvintSX--

--===============6937220282983170173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6937220282983170173==--
