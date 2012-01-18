From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/2] ASoC: tlv320aic32x4: always enable
	dividers
Date: Wed, 18 Jan 2012 12:14:24 +0100
Message-ID: <20120118111424.GD2559@pengutronix.de>
References: <1326883739-8148-1-git-send-email-w.sang@pengutronix.de>
	<20120118105054.GE8732@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4067509688899564362=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id C447F1038AA
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 12:14:25 +0100 (CET)
In-Reply-To: <20120118105054.GE8732@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Javier Martin <javier.martin@vista-silicon.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4067509688899564362==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EP0wieDxd4TSJjHq"
Content-Disposition: inline


--EP0wieDxd4TSJjHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2012 at 10:50:54AM +0000, Mark Brown wrote:
> On Wed, Jan 18, 2012 at 11:48:58AM +0100, Wolfram Sang wrote:
>=20
> > +		/* Switch on PLL */
> > +		snd_soc_update_bits(codec, AIC32X4_PLLPR,
> > +				    AIC32X4_PLLEN, AIC32X4_PLLEN);
>=20
> Looking at this code it looks a lot like these ought to be supplies, not
> that that needs to be fixed right now.

A lot of things need to be fixed in that driver I think. I am still figuring
what incremental set of steps would make sense. Sadly, I am not an ASoC
expert and I won't have endless time for this task, but at least there
is another driver [1] as a working reference. I'll see what I can come
up with in that time, probably reg-caching is next.

Regards,

   Wolfram

[1] http://linux.derkeiler.com/Mailing-Lists/Kernel/2010-06/msg07236.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--EP0wieDxd4TSJjHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk8WqZAACgkQD27XaX1/VRudYQCgxUj5LOWkHCiA36i81YMKUowG
CuIAmwStz4d6aio3yF6aIPYFC/KRaeaC
=jHNJ
-----END PGP SIGNATURE-----

--EP0wieDxd4TSJjHq--

--===============4067509688899564362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4067509688899564362==--
