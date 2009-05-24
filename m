From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V2 5/9] Main rewite of the mpc5200 audio DMA code
Date: Sun, 24 May 2009 22:35:07 +0200
Message-ID: <20090524203507.GA13491@pengutronix.de>
References: <20090523231148.17919.46103.stgit@terra>
	<20090523231305.17919.12239.stgit@terra>
	<20090524185509.GA3561@pengutronix.de>
	<9e4733910905241310n59952fd2oaafd7f1363db324@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0332467715=="
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <9e4733910905241310n59952fd2oaafd7f1363db324@mail.gmail.com>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Mime-version: 1.0
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org


--===============0332467715==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2009 at 04:10:52PM -0400, Jon Smirl wrote:
> On Sun, May 24, 2009 at 2:55 PM, Wolfram Sang <w.sang@pengutronix.de> wro=
te:
> >> Rewrite the mpc5200 audio DMA code to support both I2S and AC97. Make =
it more robust.
> >
> > Why is it more robust?
>=20
> I've implemented retries for when the AC97 hardware doesn't reset on
> first try. About 10% of the time both the Efika and pcm030 AC97 codecs
> don't reset on first try and need to be poked multiple times.  Failure
> is indicated by not having the link clock start ticking. Every once in
> a while even five pokes won't get the link started and I have to power
> cycle.
>=20
> I don't have an oscilloscope, after I get these basic drivers in maybe
> someone can put a scope on this and figure out why reset is failing.
> I've read the various datasheets and I believe my reset pulses have
> the correct timings.

That's good to know. In fact, I think a summary of this should go into the
patch description.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoZr3sACgkQD27XaX1/VRthugCgyMk6m3VXlus5di2EBlMApObO
y1QAn1fvipzt6UkqglM5xC1JMll/iGbV
=7EUQ
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--

--===============0332467715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
--===============0332467715==--
