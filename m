From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 03/14] ASoC: SOF: Add driver debug
	support.
Date: Wed, 9 Jan 2019 19:40:20 +0000
Message-ID: <20190109194020.GP10405@sirena.org.uk>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3536622530829625958=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181211212318.28644-4-pierre-louis.bossart@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, andriy.shevchenko@intel.com, tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3536622530829625958==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aC33ObtQAkNdOZ6b"
Content-Disposition: inline


--aC33ObtQAkNdOZ6b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 11, 2018 at 03:23:07PM -0600, Pierre-Louis Bossart wrote:

> +	/* copy from DSP MMIO */
> +	pm_runtime_get_noresume(sdev->dev);

Why are we doing a _get_noresume() here?  It won't actually do anything
to the device...

> +
> +	memcpy_fromio(buf,  dfse->buf + pos, size);

Extra space?

> +	/*
> +	 * TODO: revisit to check if we need mark_last_busy, or if we
> +	 * should change to use xxx_put_sync[_suspend]().
> +	 */
> +	ret = pm_runtime_put_sync_autosuspend(sdev->dev);
> +	if (ret < 0)
> +		dev_warn(sdev->dev, "warn: debugFS failed to autosuspend %zd\n",
> +			 ret);

It rather depends what you're doing...  I'm definitely confused as to
why you need a _sync operation - if you're doing autosuspend stuff
presumably you don't care so much if the device gets powered down
immediately, and I can't in general see why that'd be important.

> +	dfse->dfsentry = debugfs_create_file(name, 0444, sdev->debugfs_root,
> +					     dfse, &sof_dfs_fops);
> +	if (!dfse->dfsentry) {
> +		dev_err(sdev->dev, "error: cannot create debugfs entry.\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(snd_sof_debugfs_io_create_item);

debugfs uses EXPORT_SYMBOL_GPL().

--aC33ObtQAkNdOZ6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw2TiMACgkQJNaLcl1U
h9BlIAf+NqYxPCIzIi5JTK340ggjTl7ku+WGgiqpxSBgIvZ4h11MYsZjj2xv6fvr
WPNQM94Kj5mdgIIfbiJ73y3DRP4bES1t+p5FJYpgqubsG0u0mw6igQQcppT1q4Af
iE0C8Tfu1q4M4Ba/ZKKpTqhqfnJQRwUAB3AEPRfyaPUkMK+6fcL2zZ/bE4Ns8UDb
7xl8cdekiMCpvyrT9a25S53VMALak+aR3LMwIUV2n7Xln5ybaeEwXCtjQW/aNvNK
5vN59bllzHXHZzlTPINvtxoaQIX6cUqqayNIOC36g5I/UpJlxK92y4+HVLhK07E1
jigUDDdOdfZT1IpkT6L8wDgxUpKBmw==
=Hxyg
-----END PGP SIGNATURE-----

--aC33ObtQAkNdOZ6b--

--===============3536622530829625958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3536622530829625958==--
