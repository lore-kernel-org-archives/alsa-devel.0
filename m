From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aix31xx: Add ACPI match for
 Lenovo 100S
Date: Tue, 19 Apr 2016 19:43:23 +0100
Message-ID: <20160419184323.GF3217@sirena.org.uk>
References: <1461081620-23378-1-git-send-email-hadess@hadess.net>
 <20160419164107.GY3217@sirena.org.uk>
 <57167194.2030803@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6049616928665861109=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EA30C26262A
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 20:43:32 +0200 (CEST)
In-Reply-To: <57167194.2030803@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Bastien Nocera <hadess@hadess.net>
List-Id: alsa-devel@alsa-project.org


--===============6049616928665861109==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FO0yZLwVDWUwTKck"
Content-Disposition: inline


--FO0yZLwVDWUwTKck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 19, 2016 at 12:57:40PM -0500, Pierre-Louis Bossart wrote:
> On 04/19/2016 11:41 AM, Mark Brown wrote:
> >On Tue, Apr 19, 2016 at 06:00:20PM +0200, Bastien Nocera wrote:

> >>+static const struct acpi_device_id aic31xx_acpi_match[] = {
> >>+	{ "10TI3100", 0 },

> >An ACPI identifier that actually bears some resemblance to the name of
> >the part, will wonders never cease!  :)

> It's not a legit ACPI id but at least it's consistent with other BIOS. I see
> the same in a couple of DSDT I extracted. it'd be curious to see the
> schematics if you have them to help progress with Baytrail-CR support.

It's in the right form at least, dunno if TI actually registered 10TI
properly or not though.

--FO0yZLwVDWUwTKck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFnxIAAoJECTWi3JdVIfQxGYH+wfYWoMthBPYCI7m2vXflPIc
gpYHNtDqr/TsoQpU+iQ/CQHSiA7kuV18Q7MamlxMPzyFD0WCsDRpZG8t3T6U/mwN
F9ebwVP8RVgdZawHnpLNlfA2HWGEQjsJhySQ+Z21vsdE3px7VU8ObI2OmYsAvuv8
pb7pc8USmfe0EvBVATlDbIldgelGZCIf0DGYupG2Cyz5pOAvxYQPFQTeQnZtgEB9
0putG4oBfi+SdUWOi4D1omn9D5ELKKi5EJ4vV4IZOzbpxQNLodr3f9v3ohhWf9Qq
mwZ5itCOeII8A+TUsVsdtm4Ra7dFNf+EaSYIeYgW4TEOgo2uvFv2HOTjOX8eD2w=
=hQle
-----END PGP SIGNATURE-----

--FO0yZLwVDWUwTKck--

--===============6049616928665861109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6049616928665861109==--
