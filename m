From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: fsl: Fix sound on mx31moboard
Date: Thu, 3 Oct 2013 17:00:44 +0100
Message-ID: <20131003160044.GW27287@sirena.org.uk>
References: <1380630971-11431-1-git-send-email-philippe.retornaz@epfl.ch>
 <1380630971-11431-2-git-send-email-philippe.retornaz@epfl.ch>
 <1380630971-11431-3-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0049520833985276670=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AD3A265585
 for <alsa-devel@alsa-project.org>; Thu,  3 Oct 2013 18:00:50 +0200 (CEST)
In-Reply-To: <1380630971-11431-3-git-send-email-philippe.retornaz@epfl.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Cc: fabio.estevam@freescale.com, s.hauer@pengutronix.de, shawn.guo@linaro.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0049520833985276670==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="50RDeE14MEV4qpyy"
Content-Disposition: inline


--50RDeE14MEV4qpyy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2013 at 02:36:11PM +0200, Philippe R=E9tornaz wrote:
> Commit 42810d (ASoC: imx-mc13783: Add audmux settings for mx27pdk) broke
> the sound on mx31moboard. Restore back the audmux setting on such boards.

Applied, thanks.

--50RDeE14MEV4qpyy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSTZSpAAoJELSic+t+oim9IV4P/0KMACLFlY36989hQ4q1W10V
tDSjP658ZLjpNSPCXGE0LbqP0VaHfrQI/Q9YBTBpg6PfCZlAwK+Bsawppx10wyqu
ZoprWE42EzJ+DaHCWk/dBEIhFr9qDX2rawpLrFpBpP4MtepAzGzWH0rPlD9cuvKu
Z5DMLlGhPUyb+r7GXFjKaUGjl5HiebGKbm/HybTbINGZy9feTfCUPDmIw/joTcsw
FWwMJlhwtutQJrZWQLP2nGJQKiOjZiOS+amSFnis5My4DFe6gCngxmZig09dmLI3
7x/D0TmIFzZPS+80lk7Ykz9p2b25yAsnDlsEp1I9QtFAtUF4SCi+eSeApJ2QxKRQ
SbjthrCpvfBjjTxg45DJg7WendFBiI0h+d+dve7F5QORT+6bUQIyyVfto8pTOgGP
RfP7vPgvQEXeAC81B64WJwvL/ZdCIp9knPgcnZ70ywzlSCcgyPLYzohcnTFCp2mH
daq0W2QZyxhYFcIfuMi4gP9/4SkMXq8NjeNkDTplll0WehMD1ti2hgTzDsThwjyo
IEF0dBcXphfyMrciTqDW/VdFtbjwFj80POp0XJiIABxBszDFSxEIti3M4cK00CUJ
+FwjNF9MMK5WifWmoAVJquIPHwC6t/jQzYVBBvr8WkUCd6um1GE6Tb8yKSfI+/Ib
1oDDY1PRU5dy44e71X04
=GlhR
-----END PGP SIGNATURE-----

--50RDeE14MEV4qpyy--

--===============0049520833985276670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0049520833985276670==--
