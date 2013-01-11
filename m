From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/5] ASoC: twl6040: Prevent extra power
 transitions during resume
Date: Fri, 11 Jan 2013 11:52:07 +0000
Message-ID: <20130111115207.GW20956@opensource.wolfsonmicro.com>
References: <1357900355-5055-1-git-send-email-peter.ujfalusi@ti.com>
 <1357900355-5055-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4793644360975315430=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 10A52262607
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2013 12:52:09 +0100 (CET)
In-Reply-To: <1357900355-5055-3-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4793644360975315430==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lGQpFNrcSq0Rb43w"
Content-Disposition: inline


--lGQpFNrcSq0Rb43w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 11, 2013 at 11:32:32AM +0100, Peter Ujfalusi wrote:

> -	twl6040_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> -	twl6040_set_bias_level(codec, codec->dapm.suspend_bias_level);
> +	if (codec->dapm.bias_level != codec->dapm.suspend_bias_level) {
> +		twl6040_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +		twl6040_set_bias_level(codec, codec->dapm.suspend_bias_level);
> +	}

The device should always be in either _STANDBY or _OFF (depending on if
it supports idle_bias_off) before it tries to suspend so
suspend_bias_level ought to be redundant.  We should really get round to
killing it...

--lGQpFNrcSq0Rb43w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ7/zgAAoJELSic+t+oim9cs0P/3VXosNJitiuqYIv7D/TpYpM
rilhx5iG0gJ6+n57B85i7cC/Tq/O3RY23GbyRVyg/BSBfXQbWhmoUveIhm3L70Ss
zH/qxlklvUKJ5mjKPK5h23VjY0FYcn2I3iik3tyma5v0zwzadpDmazLJysX5PIDN
06qfKQ0mw1zOC/IuMcGq/1uJlBo1o/h6giB/aAF2vjZFPnfmVL7XIdUj55XZO4ez
7bDN0rTs90qlNyeQTlViScilhoktLQrch7tm9CdQChk/GK4QxPF1mo4VLcro+UQ6
tg6RnsZ2q1xyqL9p8TchA0EZ1rrbsoN7deKf98ek7QC6j9fB/aC4/aluv86a7LfQ
PrtlvdxUTDX33hdsf1TOfIk1xBQqjCNVkucJq3UaMypqpoaNsJxjq59XkecHYH4f
Baq3R9A9GJLI3Rj75/GzV9oLOHCO9DJaKDq442ubR8GrAZrJtE7qFpIl2L3kJMxr
T4eI9C1kl6GB9t/2GRWXAGwRgbmahmk1sjAnqArVplKCuRAQRMF+GV6sabRe8PbA
/FGYY+voMcGZcGqNix7HAp7AnTkne+OORQzG00+nt01d3/62wTwHkMF5TPW3HfGD
OIbIyrIlYfnDlSh95KnOCRo8knEg6eoCHMOI1SoK8qEYqLJt5Yoz1rEYVQgdNnbG
6KeuPJeILUjtmu7kIRsR
=2otB
-----END PGP SIGNATURE-----

--lGQpFNrcSq0Rb43w--

--===============4793644360975315430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4793644360975315430==--
