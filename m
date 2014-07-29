From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Add merrifield machine driver
Date: Tue, 29 Jul 2014 20:50:43 +0100
Message-ID: <20140729195043.GM17528@sirena.org.uk>
References: <1405599225-31538-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2013209539975916944=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4803A2652F1
 for <alsa-devel@alsa-project.org>; Tue, 29 Jul 2014 21:50:51 +0200 (CEST)
In-Reply-To: <1405599225-31538-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2013209539975916944==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WUuc4+55fuBjY5Vl"
Content-Disposition: inline


--WUuc4+55fuBjY5Vl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 17, 2014 at 05:43:45PM +0530, Subhransu S. Prusty wrote:

> +	default n

This is the standard Kconfig behaviour - no need to specify it (other
drivers don't...).

> +static int mrfld_8958_hw_params(struct snd_pcm_substream *substream,
> +			   struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +
> +	if (!strcmp(codec_dai->name, "wm8994-aif1"))
> +		return mrfld_wm8958_set_clk(codec_dai);
> +	return 0;
> +}

It's much clearer to define separate operations for each DAI, there's no
need for the string matching (especially given that there's nothing to
do for other DAIs).

> +	/*
> +	 * Machine uses 2 DMICs, other configs may use more so change below
> +	 * accordingly
> +	 */
> +	{ "DMIC1DAT", NULL, "DMIC" },
> +	{ "DMIC2DAT", NULL, "DMIC" },
> +	/*{ "DMIC3DAT", NULL, "DMIC" },*/
> +	/*{ "DMIC4DAT", NULL, "DMIC" },*/

Remove commented out code.

> +	/* Force enable VMID to avoid cold latency constraints */
> +	snd_soc_dapm_force_enable_pin(&card->dapm, "VMID");
> +	snd_soc_dapm_sync(&card->dapm);

This looks like you're open coding a version of wm8994_vmid_mode().
Though that might need some tuning for systems that really have no
single ended outputs.

> +	/*
> +	 * Micbias1 is always off, so for pm optimizations make sure the micbias1
> +	 * discharge bit is set to floating to avoid discharge in disable state
> +	 */
> +	snd_soc_update_bits(codec, WM8958_MICBIAS1, WM8958_MICB1_DISCH, 0);

Don't write directly to CODEC registers, provide a way of configuring
this in the CODEC either via platform data or some API.  That way
nothing else is writing to the CODEC register map without the driver for
the CODEC knowing about it.

> +static void snd_mrfld_8958_complete(struct device *dev)
> +{
> +	struct snd_soc_card *card = dev_get_drvdata(dev);
> +	struct snd_soc_codec *codec = card->rtd[CODEC_BE].codec;
> +	struct snd_soc_dapm_context *dapm;
> +
> +	pr_debug("In %s\n", __func__);
> +
> +	pr_debug("found codec %s\n", codec->component.name);
> +	dapm = &codec->dapm;
> +
> +	snd_soc_dapm_force_enable_pin(dapm, "VMID");
> +	snd_soc_dapm_sync(dapm);
> +
> +	snd_soc_resume(dev);
> +}

Doing the manual fiddling before rather than after resuming the core
seems...  concerning, I'd expect this to be done either in one of the
ASoC suspend/resume callbacks or at least after calling snd_soc_resume()
- doing it before seems likely to trigger or cause bugs.

> +static int snd_mrfld_8958_poweroff(struct device *dev)
> +{
> +	pr_debug("In %s\n", __func__);
> +	snd_soc_poweroff(dev);
> +	return 0;
> +}

Remove this, just use the core function directly.

> +	platform_set_drvdata(pdev, &snd_soc_card_mrfld);
> +	pr_info("%s successful\n", __func__);

This print has no content, remove it or at the very least downgrade it
to debug level.

--WUuc4+55fuBjY5Vl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT1/sPAAoJELSic+t+oim9jHAP+gN7JOC2Bm7Ybjba1thjfxYu
Yjrss08lASvpbF1VOUQJzieCutzl90+RfXSJplRl+3qDeH5wH04V960BmpfgcUg6
CAlMErsTbh8fElHyX2VKRSHh/ejznC5dObJloY2TdhPsQdAbRxCFqwBM0iqYkZQt
8XSoZbHKIHwEm2RYeQW0ymYXmUu5wlxH0Eh+21lR0T2iaPUktsB8vkyKbNQwIF8A
brpvqy3Ok3BX7vbEsQyvMhfZbE6ChIgfszhpgHqeO8PYZ0Mxcphfslj0NFoLNek5
LGh3oaxBKnj1gBc9G8MDSN4xQ6WhehJ0pVmJfHUkwZ1dxGNre4mA5/8c8enSSnw4
Fp+xB2MOxa5RohUfWwNKT/TPCP9OfeqLakasxsDR2TIO4B5d9W+EcgefPReeW2/4
/lDLTcOV7mjPEmT0VW6M8JN7mtW5Fa1E44ZqhREXPtUV02bgCFAC2w0vu5fhAI2z
8jDUqFhi6OfwAT0ccKxp+Uce/f3mpijp+MKMrUS3N/o6UsFm5crd3UBuShHwVHsi
MBQ7aHzJQiPtYi1S3p54ckiTyEoQO6t1Qwzipd0dn1e3HfGUe6uBU4lYzNyL2QDX
46vEsfUmLDUMpc6HY49aYTeoh52HwRclhrsLU8jk9USYsIjb91E4O9i6Wfk5j3DA
lkjFbqlt/7F0mf1iOzC9
=rouE
-----END PGP SIGNATURE-----

--WUuc4+55fuBjY5Vl--

--===============2013209539975916944==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2013209539975916944==--
