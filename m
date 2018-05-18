From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ASoC: ssm2305: Add amplifier driver
Date: Fri, 18 May 2018 09:57:54 +0100
Message-ID: <20180518085754.GC24209@sirena.org.uk>
References: <20180518085242.23635-1-m.felsch@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1363344064472924962=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 459EE267623
 for <alsa-devel@alsa-project.org>; Fri, 18 May 2018 10:57:58 +0200 (CEST)
In-Reply-To: <20180518085242.23635-1-m.felsch@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, robh+dt@kernel.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============1363344064472924962==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZmUaFz6apKcXQszQ"
Content-Disposition: inline


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 18, 2018 at 10:52:42AM +0200, Marco Felsch wrote:
> The ssm2305 is a simple Class-D audio amplifier. A application can
> turn on/off the device by a gpio. It's also possible to hardwire the
> shutdown pin.

Please don't resubmit patches that have already been applied, you should
submit patches against current code in the tree you're expecting things
to be applied to.  If any updates are needed to a patch that's already
been applied you should submit incremental patches which make those
updates.  This avoids having to change published git commits which could
cause problems for people working against git.

--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr+lZEACgkQJNaLcl1U
h9CCFgf/SbQb28kzbt1/gKPCVO3Zx6MDy/FopaHvvXkk9LouHtDidwEYAS8LJQfe
oA+NzaeGHK043SPNY6ED7DUQhQ0R/LDT+d2JReXvGR3BYMqXzaLBKQlsodcHzo3r
uCvsNfUVUblon/p/fFBiLqX7/mPf3b9Qp32PSCRtaVz0IIWbb4i9wyg2WSMTTO8O
JbJdHzzCwQo2mJ1rc577jnYT0qZIOKpd2q2eZjR5aIMg7ih10xQBn97UiLReGwFH
UJXdZ0YrdYy6YedG4ieCus0K7n6u4qsptSdLz3WOJ73RKpUDiJVWxsl7X4VOQLPp
RCwrIBzbZ9gYXrLrLlw04awRp3bXVQ==
=GJDb
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--

--===============1363344064472924962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1363344064472924962==--
