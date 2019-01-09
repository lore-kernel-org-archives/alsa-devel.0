From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 08/14] ASoC: SOF: Add DSP HW abstraction
	operations
Date: Wed, 9 Jan 2019 20:51:29 +0000
Message-ID: <20190109205129.GS10405@sirena.org.uk>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-9-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2325332061602177502=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181211212318.28644-9-pierre-louis.bossart@linux.intel.com>
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


--===============2325332061602177502==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ctZH5Gqgrl5HoVnD"
Content-Disposition: inline


--ctZH5Gqgrl5HoVnD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 11, 2018 at 03:23:12PM -0600, Pierre-Louis Bossart wrote:

> +int snd_sof_pci_update_bits_unlocked(struct snd_sof_dev *sdev, u32 offset,
> +				     u32 mask, u32 value)
> +{
> +	bool change;
> +	unsigned int old, new;
> +	u32 ret = ~0; /* explicit init to remove uninitialized use warnings */

This looks a lot like you want to write regmap_pci_config...

> +/* control */
> +static inline int snd_sof_dsp_run(struct snd_sof_dev *sdev)
> +{
> +	if (sdev->ops->run)
> +		return sdev->ops->run(sdev);
> +
> +	return 0;
> +}

Do we really want to return 0 for all these ops if they're not
implemented?  For some that seems sensible but there's others where it
seems like the caller might want to know they got ignored and an error
code like -ENOTSUPP might be better.

--ctZH5Gqgrl5HoVnD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw2XtAACgkQJNaLcl1U
h9DCgQf6AzfJ6mzPt0WCy3j4B3yhH9KSiBG57R5JBZyhixPhPjRZk0/VBRgbueDH
Ho3Iorv/xwLDtp/L5FG6c6etlms9F7qmv+jyJA3U+A2d5blkqv4FwJoEzCfVF1MV
laD3qjokEHmB9iR7A/yEf0rlY4xfm2nGciU93jPFCHQM+3dDnJXtLvGw4AAM2Dps
7O0jKuo/1/ehqpkto145Pq5i73M/Y2k9YhFCtVsqRQAXmx3CeK5CSiT4X0o0Ypc0
3+ZZosMoxoFPNOSWFpnsYuVAX+SG5k075aBoNHfD4gqixW4gbStH1SnfUpvySQ2D
b3DMMyJ6tXnee6JZb8DtHfrcmL3+9A==
=7HQw
-----END PGP SIGNATURE-----

--ctZH5Gqgrl5HoVnD--

--===============2325332061602177502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2325332061602177502==--
