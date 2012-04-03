From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Fix warning due to the
 lack of REGULATOR_CHANGE_VOLTAGE
Date: Tue, 3 Apr 2012 21:44:57 +0100
Message-ID: <20120403204457.GC11910@opensource.wolfsonmicro.com>
References: <1333483353-12273-1-git-send-email-festevam@gmail.com>
	<20120403203746.GB11910@opensource.wolfsonmicro.com>
	<CAOMZO5AaqN8aXPwQQbQDopRsx3ndra8SQNkvmxH08HTyiKCORQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2145289199367773049=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CAFC4104339
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Apr 2012 22:44:59 +0200 (CEST)
In-Reply-To: <CAOMZO5AaqN8aXPwQQbQDopRsx3ndra8SQNkvmxH08HTyiKCORQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============2145289199367773049==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2012 at 05:43:20PM -0300, Fabio Estevam wrote:
> On Tue, Apr 3, 2012 at 5:37 PM, Mark Brown

> > Are you sure this is the best fix? =A0There's no set_voltage() call in =
the
> > driver.

> Sorry, I was not able to understand your last comment.

> How do you suggest me to fix this, please?

I was wondering if it might be better to remove the voltage range if the
driver doesn't ever actually set the voltage rather than adding an
unused permission to change it.

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPe2FCAAoJEBus8iNuMP3dhd8QAIlH6yqtil53/KE+E0dAY8bW
RR5JlO9AA+1vDZZ+f/cyp2hZ2wiBBH5yAHc3FqBiOphTMfZfd4DTUE3rdAhcC6Qe
G5MHOnSH7CWks642pmq+3wKqSZk6/nnRatsy7nQ6Dwm+LhrUaumNGbk6mzEbZu/4
jYUW0gZqhZ0vQiPmb8FyMvTegvDLAyOn38sza8eo6yOelvXsvaRstWpDnrnRX7un
DKA1VvP2HZQIGpWAdi/StSMWoqq1U5zDdrl5M+D3K7Ol0ixuy6uMd/sb9i/jzK8O
5Cxuc+/++7HcgDqgGx3iWn4QDrCW7RalwGOOrs7YHpTCc+NLE7KVCMdMebVze3DN
PCgalDaFCnM1Zssi+4zOeuDX8XdXfroAULAOYU2qY3m2DenCn47KKL4QRWBaL874
UgSeflDp0Yd6DDoYSlc5a7YgZ4lozZ7b/NH3MwxY5vLAE4UlN5hVgEmMZdH8JnoK
rnUUOt+O04+ro0gMziF2wG0LnJSGVR7clwRbDr5Hkj/dyZtSnT4PEUyV9w4LWg4F
aZcm+cE99nNCpJB+cg32P7jAkNKLKDySyDhKOYr0CB2gcnh12OWIyRc/KCPgXqXq
mo2Q78OwcRh4PRksTjGM5FGcyFM6GNxTMItf0MWlpXl3Y0NBhg/Z0qhuQR+RkQJF
3fIM0q+8k5tkIblYFFpS
=+FS4
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--

--===============2145289199367773049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2145289199367773049==--
