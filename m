From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] ASoC: Add ADAU1361/ADAU1761 audio
	CODEC support
Date: Wed, 28 Aug 2013 18:24:00 +0100
Message-ID: <20130828172400.GM10783@sirena.org.uk>
References: <1377703214-23234-1-git-send-email-lars@metafoo.de>
 <1377703214-23234-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4942131414880090624=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6561926109C
 for <alsa-devel@alsa-project.org>; Wed, 28 Aug 2013 19:24:04 +0200 (CEST)
In-Reply-To: <1377703214-23234-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4942131414880090624==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SvPICi00/oKz9jF1"
Content-Disposition: inline


--SvPICi00/oKz9jF1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 28, 2013 at 05:20:10PM +0200, Lars-Peter Clausen wrote:

> +static const char * const adau1761_bias_select_text[] = {
> +	"Normal operation", "Enhanced performance", "Power saving",
> +};
> +
> +static const char * const adau1761_bias_select_extreme_text[] = {
> +	"Normal operation", "Extreme power saving", "Enhanced performance",
> +	"Power saving",
> +};

Not a requirement and perhaps it has no effect but these seem like they
ought to integrate with the bias level configuration - since only the
clocks seem to be managed by set_bias_level() the driver could
presumably save a bit of power by dropping down to the minimal power
consumption bias while the device is idle.  This is what the STANDBY to
ON transition is all about.

> +static const struct snd_kcontrol_new adau1761_jack_detect_controls[] = {
> +	SOC_SINGLE("Jack Detect Switch", ADAU1761_DIGMIC_JACKDETECT, 4, 1, 0),
> +};

Why is this a user visible control and not using the jack detection
framework support?

--SvPICi00/oKz9jF1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSHjItAAoJELSic+t+oim9xfwQAJVHhoPl3XHj2sbHOcco0KlN
s5B3mWCIaUoEc7KIXS55vJ6TN62zeyO0gUu0QesM5GzcK/gJ1A+jT5kAwiVwHke3
zPGQ3l8dL4H9qzZVI47iE40wtv2MhrYPpRflwaGlsYLywDRPIozxeXLZ67UJxQMp
vMBzde9fNHt0xKhGahAB9cHjnJqVB5VQbacA3vPXs+Ye23Gj+o9FMc/dHBEsFoIm
nr6vOEE0N+xYZnuTY2RU+/6gZ4/7cpKmQBryT1nWjrr4LDW1K+lR0lPDfZpc9ZfN
+cO7D1U7i2gCKVDTv8qreAxXpCi0EMjNWBPR5eps1Mc6gsjfjK+QiFZ/F15pI1tY
1oEazfmcJmBu0VE9ugfVXQreN8VrraQ3Dcy0MblQ2KFP2q/zpyBW+5+oQ7VLZ57W
A0PtgqIJQnzXfNOYMG3dOSw8fbQKN0ex3G51dn9hCneInx9jd0zqCR6AgKBHi+9o
uFfLms2OynDxHZd0/DomlekiRzdtdKVlUExj6uTayySwCiedgxsdMBp+QWR+1yyS
e1pNCqAJx2gVk2cvqHGZgYqk7nPXc92yiJ4qkQ2VfkcLsbfrVuzhm0gVHus1Qow6
tflRXKgIQ/DwjvwOUVriIyy+zd1fK5eEHqmiYQccBeuDPCL9iWOegsBVEfLnvkia
Uzf73jdXFVERxL99zr3E
=cTZO
-----END PGP SIGNATURE-----

--SvPICi00/oKz9jF1--

--===============4942131414880090624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4942131414880090624==--
