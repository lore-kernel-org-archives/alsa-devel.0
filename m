From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 03/14] ASoC: SOF: Add driver debug
	support.
Date: Fri, 19 Apr 2019 16:54:58 +0100
Message-ID: <20190419155458.GV2803@sirena.org.uk>
References: <20190412160519.30207-1-pierre-louis.bossart@linux.intel.com>
 <20190412160519.30207-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2956632986270053541=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190412160519.30207-4-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Dragos Tarcatu <dragos_tarcatu@mentor.com>, alsa-devel@alsa-project.org, Alan Cox <alan@linux.intel.com>, tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>, Daniel Baluta <daniel.baluta@gmail.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, andriy.shevchenko@linux.intel.com, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2956632986270053541==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FZIkiClxIZ9JeWSb"
Content-Disposition: inline


--FZIkiClxIZ9JeWSb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 12, 2019 at 11:05:08AM -0500, Pierre-Louis Bossart wrote:

> +		if (pm_runtime_active(sdev->dev) ||
> +		    dfse->access_type == SOF_DEBUGFS_ACCESS_ALWAYS) {
> +			memcpy_fromio(buf, dfse->io_mem + pos, size);
> +		} else {
> +			dev_info(sdev->dev,
> +				 "Copying cached debugfs data\n");
> +			memcpy(buf, dfse->cache_buf + pos, size);
> +		}

Might this get a bit noisy if we start hitting the info case?

--FZIkiClxIZ9JeWSb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly571EACgkQJNaLcl1U
h9CrCAf/bEmNoGNaWLqNaUBGSzl+sUQAucI5jJRk60/ZqEiGCOV9B/ZRTC5yQthw
Wu23KQSxljBYMnZhq0XYJfGz9xtrBcWb0LJ7a9gNII4Gusglg7tFEcqb1svcXg4m
kGxm7+jv3kcFecEqzoL8XWFyezutQXdtCVb3fklySkh86qGsD6oPuHJX95cIk2B9
PTJy+S1bjR7xPQ0PfArFR/0hubF+c3rUCrzDW7YxiJp63w73zPTIj9BwuLqjihZ/
lqZvrsEhqMqemuUiG97mncXdWH/JRPJKrJ8WHPwvQTyeCG3zHkltJO+BjW1s3VU+
h/Z7Hiji9ZZki4go/MMucBxawlt9Cg==
=JOM/
-----END PGP SIGNATURE-----

--FZIkiClxIZ9JeWSb--

--===============2956632986270053541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2956632986270053541==--
