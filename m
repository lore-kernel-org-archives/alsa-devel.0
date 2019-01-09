From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 09/14] ASoC: SOF: Add firmware loader
	support
Date: Wed, 9 Jan 2019 21:02:33 +0000
Message-ID: <20190109210233.GU10405@sirena.org.uk>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-10-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3934598204623361485=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181211212318.28644-10-pierre-louis.bossart@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, andriy.shevchenko@intel.com, tiwai@suse.de, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3934598204623361485==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E75mJrUy8lRi9cGN"
Content-Disposition: inline


--E75mJrUy8lRi9cGN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 11, 2018 at 03:23:13PM -0600, Pierre-Louis Bossart wrote:

> +int snd_sof_load_firmware_memcpy(struct snd_sof_dev *sdev)
> +{
> +	struct snd_sof_pdata *plat_data = dev_get_platdata(sdev->dev);
> +	const char *fw_filename;
> +	int ret;

This never actually calls the load_firmware() operation for the DSP
AFAICT?

> +	ret = request_firmware(&plat_data->fw, fw_filename, sdev->dev);
> +
> +	if (ret < 0) {
> +		dev_err(sdev->dev, "error: request firmware failed err: %d\n",
> +			ret);
> +		return ret;
> +	}

I'd suggest logging the name of the firmware we tried to load, users
will thank you.

> +	/* create fw_version debugfs to store boot version info */
> +	if (sdev->first_boot) {
> +		ret = snd_sof_debugfs_buf_create_item(sdev, &sdev->fw_version,
> +						      sizeof(sdev->fw_version),
> +						      "fw_version");
> +
> +		if (ret < 0) {
> +			dev_err(sdev->dev, "error: cannot create debugfs for fw_version\n");
> +			return ret;
> +		}
> +	}

As Andy said elsewhere debugfs stuff like that probably shouldn't be
fatal.

--E75mJrUy8lRi9cGN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw2YWkACgkQJNaLcl1U
h9Bh2gf+JXawxJpNAuZT7Suop3EBvkfU614oQvTsV4Ty41GEuAecCSQRrvLzLtyT
WHC4v2Ct3W4RRLZT51c2k5jqRpP7ZsCo328pL5aSdi5YfGeYMW5EnPeCMBKIUxaU
UjagLeRRORxtDdgMyG6utXnNov24aBsIH9n16lLLRsEQDeS3XtIFtyBWeRvQeLGj
eNk+VocA+HhrSNkhxvZDPNNmKZ1mBE9FyMGG0o/pXDGcRVwknlE/Pyxoy7otzQmc
98vgQ9PDj5dLbEeoHT2OewzkgoiyBLmf1mmxV4K9yyX7gO2Ls509tW9vnYAYLaXC
sf/FPhjLy4lZweYb3BFeiq1+RIvAHw==
=FxZN
-----END PGP SIGNATURE-----

--E75mJrUy8lRi9cGN--

--===============3934598204623361485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3934598204623361485==--
