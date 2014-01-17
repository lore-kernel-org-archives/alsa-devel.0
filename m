From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] ASoC: tlv320aic32x4: DT support
Date: Fri, 17 Jan 2014 18:43:48 +0000
Message-ID: <20140117184348.GF17314@sirena.org.uk>
References: <1389886227-876-1-git-send-email-mpa@pengutronix.de>
 <1389886227-876-4-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2167305565598713380=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 983232615B9
 for <alsa-devel@alsa-project.org>; Fri, 17 Jan 2014 19:43:58 +0100 (CET)
In-Reply-To: <1389886227-876-4-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--===============2167305565598713380==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Mjcb6KWfk+dITC8b"
Content-Disposition: inline


--Mjcb6KWfk+dITC8b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 16, 2014 at 04:30:26PM +0100, Markus Pargmann wrote:

> +Optional properties:
> + - ti,ldo-enable: Bool, has to be set when the codec is powered only through the
> +   LDOIN pin.

This seems very odd.  Should the regulator bindings not be being used
for this, either having a regulator in the device that's bound via the
DT or using regulator_get_optional() to check for the other supplies
that might be used being provided?

> + - gpio-reset - gpio pin number used for codec reset

This should be a standard GPIO specifier.

--Mjcb6KWfk+dITC8b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS2XnhAAoJELSic+t+oim95goP/A9f/mzHh9RLOKFNKAVjZmJx
PM4vaz85byEeMpO8Dytd3VkJmWN8/x3JGKLJgBRG/m9XNbvmTUtDw35q8cOlskbv
dQAhEw3HgOHwGR1dsG+6xx8LIsrXcCMOCSh6LLQOleC5bxDTaud9z65HWFw8fSz3
4hC9V2ciEGJPy4vpcZEIUnHSULSfNBcW/X8vG+H5ta80hZfQ6azqCOw5UJoTlaA6
dGSPBDm+2GXAbIukicdJpIzBMi3qG17f2ZZXDCGN2oY2/2bTWDvOJoOIErMYshRX
uxFe9wAIJHMfjbr+EnHfi3dPXnUrLWkqkRXFqFxbIlUjSAdtY50i/Z3FT6O1tq8I
cJ6Lnsb8oHWSSyVFMeJKk54NlQMtDDOsUe/W3OhB310H/uY99b3IAJQMu8YQ7cgJ
pn85uiosKpQPmzPOe2vyE/93QZZiWUGS1Psf4fCW49lG5/n4moUbpE6HVKAnKtpp
7R0Zc2LhpnzpD4AlFQtghVlHeaaIKIzLHYT8lTVUi1yYQaMg/jh+9rqjj4AMzwEN
Doitssfwv7GSC0WbTubyYl6rZAfj/z/qAV4pKQVhj89tuBeMI0rSTI/o6qDoRO+6
7B3BcBZzfTUCYkc/j4o1QVhFvIvPc0d2JzwLY5B0lHEWaaE/tA4Jc1Qomx6pqLMQ
AM5sNlR4joojSaIuP1C6
=5fIa
-----END PGP SIGNATURE-----

--Mjcb6KWfk+dITC8b--

--===============2167305565598713380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2167305565598713380==--
