From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 10/11] ASoC: codecs: Add AB8500 codec-driver
Date: Tue, 8 May 2012 19:27:52 +0100
Message-ID: <20120508182751.GJ15893@opensource.wolfsonmicro.com>
References: <1336485450-27405-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5251209677635894484=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 964B31044A2
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 20:27:55 +0200 (CEST)
In-Reply-To: <1336485450-27405-1-git-send-email-ola.o.lilja@stericsson.com>
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


--===============5251209677635894484==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UBYeLQbK9sqbzZRV"
Content-Disposition: inline


--UBYeLQbK9sqbzZRV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 08, 2012 at 03:57:30PM +0200, Ola Lilja wrote:

> +static void show_regulator_status(struct snd_soc_dapm_context *dapm)
> +{
> +	struct device *dev = dapm->dev;
> +
> +	dev_dbg(dev, "%s: Regulator-status:\n", __func__);
> +	dev_dbg(dev, "%s:     V-AUD: %s\n", __func__,
> +		(snd_soc_dapm_get_regulator_status(dapm, "V-AUD") > 0) ?
> +			"On" : "Off");

So, you were adding this just for debug...  Let's not do that.  There's
already diagnostic infrastructure in the regulator API and at the DAPM
level too.  If we need this sort of stuff it's probably not device
specific so we should probably improve the core if it's not easy enough
to figure out what's going on already.

> +static void show_clock_status(struct snd_soc_dapm_context *dapm)
> +{
> +	struct device *dev = dapm->dev;

Similarly here (though the clock API diagnostics are probably a bit
weaker).

> +	SND_SOC_DAPM_ADC("ADC", "ab8500_0c", SND_SOC_NOPM, 0, 0),
> +
> +	SND_SOC_DAPM_DAC("DAC", "ab8500_0p", SND_SOC_NOPM, 0, 0),

Please convert all these to use DAPM to hook up the streams to their
audio interfaces rather than having a stream attached to the widget.

> +	/* LineIn */
> +	{"LINL Mute", NULL, "LineIn Left"},
> +	{"LINR Enable", NULL, "LineIn Right"},
> +
> +	{"LINL Enable", NULL, "LINL Mute"},
> +	{"LINR Enable", NULL, "LineIn Right"},

This looks *really* odd, especially with the lack of symmetry.

> +	{"Mic 1a or 1b Select", "Mic 1a", "MIC1A V-AMICx Enable"},
> +	{"Mic 1a or 1b Select", "Mic 1b", "MIC1B V-AMICx Enable"},

This also looks very odd...  is this the micbias stuff again?

> +static int mclk_input_control_get(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(codec->dev);
> +
> +	ucontrol->value.enumerated.item[0] = drvdata->mclk_sel;
> +
> +	return 0;
> +}

Same as last time this should be configured by the machine driver.

> +static struct snd_kcontrol_new ab8500_ctrls[] = {
> +	/* Charge pump */
> +	SOC_ENUM("Charge Pump High Threshold For Low Voltage",
> +		soc_enum_envdeththre),
> +	SOC_ENUM("Charge Pump Low Threshold For Low Voltage",
> +		soc_enum_envdetlthre),
> +	SOC_ENUM("Charge Pump Envelope Detection", soc_enum_envdetcpen),
> +	SOC_ENUM("Charge Pump Envelope Detection Decay Time",
> +		soc_enum_envdettime),

Again, why is this all exposed to userspace?

> +	/* Mic 1, Mic 2, LineIn */
> +	SOC_DOUBLE_R_TLV("Mic Master Gain",
> +		AB8500_ADDIGGAIN3, AB8500_ADDIGGAIN4,
> +		0, AB8500_ADDIGGAINX_ADXGAIN_MAX, 1, adx_dig_gain_tlv),

All volume controls should be "...Volume".

> +	SOC_ENUM("Digital Interface 0 Bit-clock Switch", soc_enum_fsbitclk0),
> +	SOC_ENUM("Digital Interface 1 Bit-clock Switch", soc_enum_fsbitclk1),

Hrm?

> +	/* Digital interface - Burst FIFO */
> +	SOC_ENUM("Digital Interface 0 FIFO Enable Switch", soc_enum_if0fifoen),

If this is a "...Switch" it shouldn't be an enum.

> +	/* Attach regulators to AMic DAPM-paths */
> +	dev_dbg(codec->dev, "%s: Mic 1a regulator: %s\n", __func__,
> +		amic_micbias_str(amics->mic1a_micbias));
> +	route = &ab8500_dapm_routes_mic1a_vamicx[amics->mic1a_micbias];
> +	status = snd_soc_dapm_add_routes(&codec->dapm, route, 1);
> +	dev_dbg(codec->dev, "%s: Mic 1b regulator: %s\n", __func__,
> +		amic_micbias_str(amics->mic1b_micbias));
> +	route = &ab8500_dapm_routes_mic1b_vamicx[amics->mic1b_micbias];
> +	status |= snd_soc_dapm_add_routes(&codec->dapm, route, 1);
> +	dev_dbg(codec->dev, "%s: Mic 2 regulator: %s\n", __func__,
> +		amic_micbias_str(amics->mic2_micbias));
> +	route = &ab8500_dapm_routes_mic2_vamicx[amics->mic2_micbias];
> +	status |= snd_soc_dapm_add_routes(&codec->dapm, route, 1);

This is fairly impenetrable and would usually be done in hte machine
driver.  Machines might not use the chip biases for some or all of the
mics but it looks like this code assumes they do.

> +int ab8500_audio_setup_if1(struct snd_soc_codec *codec,
> +			unsigned int fmt,
> +			unsigned int wl,
> +			unsigned int delay)

Why is this not static?

> +static int ab8500_codec_pcm_hw_params(struct snd_pcm_substream *substream,
> +		struct snd_pcm_hw_params *hw_params, struct snd_soc_dai *dai)
> +{
> +	dev_dbg(dai->codec->dev, "%s Enter.\n", __func__);
> +
> +	return 0;

Remove empty functions.

--UBYeLQbK9sqbzZRV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqWWcAAoJEBus8iNuMP3dwtIP/3V8OUM0sIl/BNu1mwYwunRz
rKioM3KGher59shadSbXtxM37T3WqoVDuAGKWM6ihSJWjEOEP9iBmFz3P00RUn2X
zle8ZsIIpistMZVWQy0C0ae7eXYmi+Sq6KEniNq60Wv5XFiMtpwkKWyeBZ8JXQIR
yFpVtnPnY9jWnpkqiY8PHm1GKpP3md9tPa/nnYla8DY4JB45EwPA6Pvu31fjiDpw
iK2gZmlkkJb+4RwWlq2V4h6xuxLhl6ljBTQ28vN2D+yXwabNezvHgMLrmPb4D1RZ
tDDEjN3gdHFJ1iajiZadv1Ewk55hapO8FbibK0hrftVqW4JM11A8C+gdBGP6F0QC
4NIR4wUybBRR9JH+DVg0PJ5cn4mc7Bc4oD/D6Of5Vsls2HNBsFRVvGmXFkszwRYs
0pnO7ueuHjPADaolGVS3i05v7U+XiZWXHO7KeJeEUeEeRkxCCWs58X1Sc1p1mu2R
RR5dvy06dcCL5+u456HUdOw7ALtbdGpx10pvK3631PXgiJGwBEeGs+zHHv7k+Yow
P4BKkIMJmd51T/Fs0+JpwvOrh/GznBLwCQ35LpdXerXch5EJAUuqIe7pocS0nP0L
RDtKuDK9bILrunsHKMDnSpRlftAqu3x1aupSQtVM+uAOjv4dDNXEuDSTynt/rt9+
KmL9SqfRV9nWn9pBmCzJ
=iPso
-----END PGP SIGNATURE-----

--UBYeLQbK9sqbzZRV--

--===============5251209677635894484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5251209677635894484==--
