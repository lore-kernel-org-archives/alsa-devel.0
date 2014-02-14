From: Mark Brown <broonie@kernel.org>
Subject: Re: Regression caused by "ASoC: core: Rework
 SOC_DOUBLE_R_SX_TLV add SOC_SINGLE_SX_TLV"
Date: Fri, 14 Feb 2014 20:17:09 +0000
Message-ID: <20140214201709.GG4451@sirena.org.uk>
References: <20140130144807.5b102b28@skate>
 <alpine.DEB.2.10.1401300856050.10630@heelrod.ad.cirrus.com>
 <20140130160554.694a8a84@skate>
 <alpine.DEB.2.10.1401300922150.10630@heelrod.ad.cirrus.com>
 <alpine.DEB.2.10.1401300934340.10630@heelrod.ad.cirrus.com>
 <20140130175658.11469081@skate>
 <alpine.DEB.2.10.1401301108450.10630@heelrod.ad.cirrus.com>
 <20140130181607.6a694b8f@skate>
 <alpine.DEB.2.10.1401301122200.10630@heelrod.ad.cirrus.com>
 <20140210152244.19f9d647@skate>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4456133420236881615=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FA9A261AC7
 for <alsa-devel@alsa-project.org>; Sat, 15 Feb 2014 11:09:14 +0100 (CET)
In-Reply-To: <20140210152244.19f9d647@skate>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory =?iso-8859-1?Q?Cl=E9ment?= <gregory.clement@free-electrons.com>
List-Id: alsa-devel@alsa-project.org


--===============4456133420236881615==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OFj+1YLvsEfSXdCH"
Content-Disposition: inline


--OFj+1YLvsEfSXdCH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2014 at 03:22:44PM +0100, Thomas Petazzoni wrote:
> On Thu, 30 Jan 2014 11:23:57 -0600, Brian Austin wrote:

> > Once I get it figured out, I'll CC you on the submission for your revie=
w=20
> > and test.

> Any news about this volume control problem on cs42l51 ?

What does the datasheet say about these bitfields?  It should be
straightforward to figure out how to fix them, it seems clear that the
original code only worked by accident.

--OFj+1YLvsEfSXdCH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS/nm9AAoJELSic+t+oim9ofkQAIh0PNvp7SEyQEp6nCEIlDVv
+CWtKmLP1x7LyhcEwL5DGuilbWS6cg/iE1/z61pRyeI3cTMkFQsCdt6JBYcov8Ac
P1grE9oPIGkOZ5sWF/4oBZjcrE2RpApTszNX8RU1MVyHUmaTxvpUkgd5tWObhae5
vPX+CWCEp9vouWKsQvsriJDWE+tiwAXfcq2r3rtJX9ZmeB9gzh7AVBjzG/nwKiAE
7LvdoZ2tDKLjmC0ptNq+QfEZF9syS8KOoJremKk3bZU02JpN9dxQOKfZdXfXoMbt
zClC7f7S6zrCtQa1Hz2vO8P35oE5NBHR07apmRM7T3C/W1WtmY1wlbaw1L2WT54u
iSjt+MmG7PDN4YsWdowZOgwjidc8nn19iVCPn+zMzJUkzTCkIefpkMB1o9/eVsQV
JgiQ9gDcojAEFsP6r+Gj0UxrVS/l3hNowdMUykyRA8rx3QT2bPL9kmn7/gSwFIPY
iBQrNbyriBRNHYSi09qIcW8puXHD8Zi+vdaHsYSeSpqm3sDNQ2bEBzGtiE4Iy9WF
hM8W8lP90tkshvCCEVpHTSK087tW/pvzjAwSNmJ6mINGo6ABYvU/Hsx0iM8q/Hmk
/v1lkLmARnViEaRJLrlx6alMaY1nxFaOaUdrXWVORQncAlhV6c4og/ONdjXk/pDt
rAiz7pf0kRq9zLerznC1
=/COS
-----END PGP SIGNATURE-----

--OFj+1YLvsEfSXdCH--

--===============4456133420236881615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4456133420236881615==--
