From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/6 v3] ASoC: AMD: Add machine driver for cz rt5650
Date: Thu, 31 Aug 2017 12:38:02 +0100
Message-ID: <20170831113802.x75watdrylvjivkl@sirena.org.uk>
References: <1503079830-16072-1-git-send-email-alexander.deucher@amd.com>
 <1503079830-16072-7-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1340287793=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1503079830-16072-7-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, rajeevkumar.linux@gmail.com, amd-gfx@lists.freedesktop.org, Vijendar.Mukunda@amd.com, Alex Deucher <alexander.deucher@amd.com>, perex@perex.cz, Akshu Agrawal <akshu.agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org


--===============1340287793==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dnjdc4dixqcdcuhz"
Content-Disposition: inline


--dnjdc4dixqcdcuhz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 18, 2017 at 02:10:30PM -0400, Alex Deucher wrote:

> +++ b/sound/soc/amd/Kconfig
> @@ -2,3 +2,10 @@ config SND_SOC_AMD_ACP
>  	tristate "AMD Audio Coprocessor support"
>  	help
>  	 This option enables ACP DMA support on AMD platform.
> +config SND_SOC_AMD_CZ_RT5645_MACH
> +	tristate "AMD CZ support for RT5645"

Missing blank line between the stanzas.

> +	select SND_SOC_RT5645
> +	select SND_SOC_AMD_ACP
> +	depends on I2C_DESIGNWARE_PLATFORM

No system dependencies of any kind?  Looking at this I'd expect at least
CONFIG_ACPI || COMPILE_TEST.  It's also unclear to me how the DesignWare
device is going to be instantiated here or if that should be a direct
depenency at all here.

> +	ret = snd_soc_register_card(card);

devm_snd_soc_register_card() and then you don't need the remove
function.

> +static const struct acpi_device_id cz_audio_acpi_match[] = {
> +	{ "AMDI1002", 0 },
> +	{},
> +};
> +

Missing MODULE_DEVICE_TABLE().

--dnjdc4dixqcdcuhz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmn9RkACgkQJNaLcl1U
h9AaiQf7BCnOCHyg/cG8zLQjVhg6uvoa60zVKgDdQ8CvCG9Ii9jPZpBP98U2IkVk
rutX+rj/f3m7/klKG1MCLSonIcmAve+eEKKPygmFr/DtRIPq4AprmKzx2ua81W6o
pCTF+x9t8PNQFTFspmrsBS+oougRYqKinzzb7XypMcljNn/1iK5SWhQrL8ipLLAU
vhVX+9aQxUko713DTuIhV5q4bKCQ6ixRBrYqGHt2crUd76BbEaNhw29NZNtRTgZX
TTRs4LphvEPVlmBFPXCvWOfoNob6M4AAI6ceroXQquK06bUn/XcbEvHqrKRuW43o
Jb+JjE0UBzhdATeYbtnnPXe0poj15Q==
=/ZCT
-----END PGP SIGNATURE-----

--dnjdc4dixqcdcuhz--

--===============1340287793==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1340287793==--
