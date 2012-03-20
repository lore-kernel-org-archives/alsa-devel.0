From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/8] sound:asoc: Add support for SPEAr ASoC
 machine driver.
Date: Tue, 20 Mar 2012 16:00:18 +0000
Message-ID: <20120320160017.GH3445@opensource.wolfsonmicro.com>
References: <cover.1332242166.git.rajeev-dlh.kumar@st.com>
	<4a7df1383ee0cf347e0c33e38d8e1171db28ee6d.1332242166.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6754488693925499906=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C82571042D2
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 17:00:22 +0100 (CET)
In-Reply-To: <4a7df1383ee0cf347e0c33e38d8e1171db28ee6d.1332242166.git.rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, spear-devel@list.st.com
List-Id: alsa-devel@alsa-project.org


--===============6754488693925499906==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RwGu8mu1E+uYXPWP"
Content-Disposition: inline


--RwGu8mu1E+uYXPWP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 20, 2012 at 05:03:50PM +0530, Rajeev Kumar wrote:
> The patch add support for SPEAr ASoC machine driver.

This is the support for some particular board rather than for the SoC.

> +	if (cpu_is_spear1340()) {
> +#ifdef CONFIG_CPU_SPEAR1340
> +		u32 mode = 0;
> +		u32 val = readl(VA_SPEAR1340_PERIP_CFG);

Ick, no!  This should be in a driver for the SoC somewhere, not in the
board.  I've not really read most of the rest of the driver.

> +static int __init spear_audio_init(void)
> +{
> +	int ret;
> +	struct snd_soc_card *spear_soc_card;
> +
> +	if (machine_is_spear1340_lcad())
> +		spear_soc_card = &lcad_snd_card;
> +	else if (cpu_is_spear1340())
> +		spear_soc_card = &spear1340_snd_card;
> +	else if (cpu_is_spear320())
> +		spear_soc_card = &spear320s_snd_card;
> +	else
> +		spear_soc_card = &spear_snd_card;

Use snd_soc_register_card().

> +#if defined(CONFIG_CPU_SPEAR1340)
> +	if (cpu_is_spear1340()) {
> +		/* Create and register spdif platform devices */
> +		spdif_dit_device = platform_device_alloc("spdif-dit", -1);
> +		if (!spdif_dit_device) {
> +			printk(KERN_ERR "spdif transceiver " \
> +					"platform_device_alloc fails\n");
> +			return -ENOMEM;
> +		}

Absolutely no, all this setup of the devices for the SoC should be in
your arch/arm code somewhere.  This should only be a driver for the
board.

--RwGu8mu1E+uYXPWP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPaKmLAAoJEBus8iNuMP3doMYP/24+m207EBRHeAv6qtzyvBF9
ZzJFcTox+n/CBnjORG7upcyoJyf2sB11IK0ZE40t93hzLsI/AaYh3MsIME5qjE5x
KhAWhJDuBNq1czL890FMSxJ726oLIZGFS2f58wSV4PlMNTHtVFl8jc6zf2aP4eHt
HU5AAR5JCy7Pphl15xQHGYr0YLSD4lZjigVSIxEsr3ngsVyxa6EYrXvMk2r2PawS
9q0A0hPXSIUfCkwIc54JrYXIsBhiDKHMxz4i2OvQ71j6n0fVQA6tt53e59RvCiLp
o152BtQUaRHRcr2fzk+0ScXIDhdAXsi0V17ztfoncNb50WLMmwX7HEBXib5GuIbH
7mqHlDkQbfpYS+dGT7dQ6PUvt2t+TTQx+aHyvBC/PECuFiFZLI9sBIY12DFerP84
iUHJhAvg4ybweUAiygviY40yWS5xSDIsTVG8WofaZsAd5RAo5qN/OeTjKkbV1rq/
gadDAO6kWlD4NttzZem5+Bx8E89t9fO7v4wLf+3X2lTEByJ8bNr5cSwPEPqJGqqQ
pgDxLIvnV7R8fY5xH2X2lUteyhZVi23G7ihUWOitXv2V93yke9QAbVLplGTTSgFB
GJTwudlbP411+USDpkkfYXtiENYei71xzH7YN2S43kLkmIVuwDKAb0nxuszAF3Ob
mxXa5tENpRqx7PsKwyxF
=cMIN
-----END PGP SIGNATURE-----

--RwGu8mu1E+uYXPWP--

--===============6754488693925499906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6754488693925499906==--
