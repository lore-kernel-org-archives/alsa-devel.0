From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 03/11] ASoC: core: Add widget
	SND_SOC_DAPM_CLOCK_SUPPLY
Date: Tue, 8 May 2012 16:40:28 +0100
Message-ID: <20120508154027.GY15893@opensource.wolfsonmicro.com>
References: <1336485400-27150-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1533401690012260866=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 87DC9243D5
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 17:40:33 +0200 (CEST)
In-Reply-To: <1336485400-27150-1-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============1533401690012260866==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="22hJjvOmZW2O/jbw"
Content-Disposition: inline


--22hJjvOmZW2O/jbw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 08, 2012 at 03:56:40PM +0200, Ola Lilja wrote:

> +{
> +	if (SND_SOC_DAPM_EVENT_ON(event))
> +		return clk_enable(w->priv);
> +	else {
> +		clk_disable(w->priv);
> +		return 0;

Coding style - you need more { }.   This also all needs to be
conditionally complied for the many platforms that don't provide the
clock API.


> +	case snd_soc_dapm_clock_supply:
> +		w->priv = (w->shift) ? clk_get_sys(w->name, NULL) :
> +				clk_get(dapm->dev, w->name);

I don't think supporting clk_get_sys() is a particularly good idea
here...  Also, I think Liam was wanting to add per-user data to the
widget rather than reuse the priv pointer.

> + /**
> + * snd_soc_dapm_get_power_status - get widget power status
> + * @dapm: DAPM context
> + * @pin: Widget name
> + *
> + * Get widget power status - Enabled or disabled.
> + *
> + * Returns -1 for failure.
> + * Returns 0 if disabled.
> + * Returns 1 if enabled.
> + */
> +int snd_soc_dapm_get_power_status(struct snd_soc_dapm_context *dapm,
> +				const char *pin)

This appears to be *nothing* to do with the rest of the patch!  It's
also not clear what it's for.

--22hJjvOmZW2O/jbw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqT5KAAoJEBus8iNuMP3dE0AQAJACfbTpCZWhhrjmz1hUDn5m
pGBKviQPVCjQjrpJL4EarW6Zo2NaIiR7gePfGBquJleyDreWWeZNJKkh6m9+jPSA
r1TsTstas3CkxyEUCf912icKU8kv3K5wYfHiQ65AnZMnEMi1snljKnKEkmKLiAoC
Ge0HQVsEtwVgQOxWfpJ3JHpnQ6RYsS7NTvdfpKYw+TRNSbf6ur/7D+l8p0vCM4UF
ErRfD52krQWBig648cAU3LMrD2PN/V9ncUDG7wXN0R3318FV8pJEKTg0kn1W0hx2
svLZM968MOk2AdLXRqQilQhSWjDsOdWI895XhHGTWnPGjXuni6UzUVYFELOcuimy
Z2PevCB6JcApdh1A2CXVgRsk30t91Gqi3B/XLbQQZsiHqX8JIwInn4OSNG57v9XX
+fNanBTikekFzsr1gh2DPjyqbLrBK1rLEDJrAcu2XBAaxqbTKd/7Eadqag072guY
N4g6ePJ0XUxtZTfaAcLeseiHuKQQKq/QCtfV5vU+heOy1AihlyeK0R+7/tqqHQqQ
RPbHvRt8P1VV5+8JSeDneN7prvTe9Bnpkapwn6x/bWEHG+qFzkzQmSdoJxzGnfXe
2WaYBvmATQBiB2jyBGEKUf6bD2Mec7eerZkZ3axIiedQFFv8/QYvJlAZn4dQhS81
HahgU0ImzaUdR8S08YaX
=KNo+
-----END PGP SIGNATURE-----

--22hJjvOmZW2O/jbw--

--===============1533401690012260866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1533401690012260866==--
