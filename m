From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 2/2] ASoC: Add MICFIL SoC Digital Audio
	Interface driver.
Date: Wed, 12 Dec 2018 18:14:14 +0000
Message-ID: <20181212181414.GE6920@sirena.org.uk>
References: <1544433661-32496-1-git-send-email-cosmin.samoila@nxp.com>
 <1544433661-32496-3-git-send-email-cosmin.samoila@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9051674029748310174=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F803267C1D
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2018 19:14:15 +0100 (CET)
In-Reply-To: <1544433661-32496-3-git-send-email-cosmin.samoila@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cosmin Samoila <cosmin.samoila@nxp.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "robh@kernel.org" <robh@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, "gabrielcsmo@gmail.com" <gabrielcsmo@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9051674029748310174==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h56sxpGKRmy85csR"
Content-Disposition: inline


--h56sxpGKRmy85csR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 10, 2018 at 09:21:15AM +0000, Cosmin Samoila wrote:

> +static char *envp[] = {
> +		"EVENT=PDM_VOICE_DETECT",
> +		NULL,
> +	};

The indentation here is weird.

> +static const char * const micfil_hwvad_zcd_enable[] = {
> +	"OFF", "ON",
> +};

Simple on/off switches should just be regular controls with "Switch" at
the end of their name so userspace can handle them.

> +static const char * const micfil_hwvad_noise_decimation[] = {
> +	"Disabled", "Enabled",
> +};

Same here.

> +/* when adding new rate text, also add it to the
> + * micfil_hwvad_rate_ints
> + */
> +static const char * const micfil_hwvad_rate[] = {
> +	"48KHz", "44.1KHz",
> +};
> +
> +static const int micfil_hwvad_rate_ints[] = {
> +	48000, 44100,
> +};

Can the driver not determine this automatically from sample rates?

> +static const char * const micfil_clk_src_texts[] = {
> +	"Auto", "AudioPLL1", "AudioPLL2", "ExtClk3",
> +};

Is this something that should be user selectable or is it going to be
controlled by the board design?

> +static int hwvad_put_hpf(struct snd_kcontrol *kcontrol,
> +			 struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *comp = snd_kcontrol_chip(kcontrol);
> +	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
> +	unsigned int *item = ucontrol->value.enumerated.item;
> +	struct fsl_micfil *micfil = snd_soc_component_get_drvdata(comp);
> +	int val = snd_soc_enum_item_to_val(e, item[0]);
> +
> +	/* 00 - HPF Bypass
> +	 * 01 - Cut-off frequency 1750Hz
> +	 * 10 - Cut-off frequency 215Hz
> +	 * 11 - Cut-off frequency 102Hz
> +	 */
> +	micfil->vad_hpf = val;
> +
> +	return 0;
> +}

What happens if this gets changed while a stream is active - the user
will think they changed the configuration but it won't take effect until
the next stream is started AFAICT?

> +	/* a value remapping must be done since the gain field have
> +	 * the following meaning:
> +	 * * 0 : no gain
> +	 * * 1 - 7 : +1 to +7 bits gain
> +	 * * 8 - 15 : -8 to -1 bits gain
> +	 * After the remapp, the scale should start from -8 to +7
> +	 */

This looks like a signed value so one of the _S_VALUE macros should
handle things I think?

> +static const struct snd_kcontrol_new fsl_micfil_snd_controls[] = {
> +	SOC_SINGLE_RANGE_EXT_TLV("CH0 Gain", -1, MICFIL_OUTGAIN_CHX_SHIFT(0),
> +				 0x0, 0xF, 0,
> +				 get_channel_gain, put_channel_gain, gain_tlv),

All volume controls should have names ending in Volume so userspace
knows how to handle them.

> +/* Hardware Voice Active Detection: The HWVAD takes data from the input
> + * of a selected PDM microphone to detect if there is any
> + * voice activity. When a voice activity is detected, an interrupt could
> + * be delivered to the system. Initialization in section 8.4:
> + * Can work in two modes:
> + *  -> Eneveope-based mode (section 8.4.1)
> + *  -> Energy-based mode (section 8.4.2)
> + *
> + * It is important to remark that the HWVAD detector could be enabled
> + * or reset only when the MICFIL isn't running i.e. when the BSY_FIL
> + * bit in STAT register is cleared
> + */
> +static int __maybe_unused init_hwvad(struct device *dev)

Why is this annotated __maybey_unused?

> +static int fsl_micfil_hw_free(struct snd_pcm_substream *substream,
> +			      struct snd_soc_dai *dai)
> +{
> +	struct fsl_micfil *micfil = snd_soc_dai_get_drvdata(dai);
> +
> +	atomic_set(&micfil->recording_state, MICFIL_RECORDING_OFF);
> +
> +	return 0;
> +}

Are you *sure* you need to and want to use atomic_set() here and that
there's no race conditions resulting from trying to use an atomic
variable?  It's much simpler and clearer to use mutexes, if for some
reason atomic variables make sense then the reasoning needs to be
clearly documented as they're quite tricky and easy to break or
misunderstand.

> +static int fsl_micfil_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> +{
> +	struct fsl_micfil *micfil = snd_soc_dai_get_drvdata(dai);
> +
> +	/* DAI MODE */
> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

Is this actually an I2S controller?  It looks like a PDM controller to
me and that's what your cover letter said.  Just omit this entirely if
the DAI format isn't configurable in the hardware.

> +	/* set default gain to max_gain */
> +	regmap_write(micfil->regmap, REG_MICFIL_OUT_CTRL, 0x77777777);
> +	for (i = 0; i < 8; i++)
> +		micfil->channel_gain[i] = 0xF;

I'm assuming the hardware has no defaults here but if we've got to pick
a gain wouldn't a low gain be less likely to blast out someone's
eardrums than a maximum gain?

> +static irqreturn_t voice_detected_fn(int irq, void *devid)
> +{
> +	struct fsl_micfil *micfil = (struct fsl_micfil *)devid;
> +	struct device *dev = &micfil->pdev->dev;
> +	int ret;
> +
> +	/* disable hwvad */
> +	ret = disable_hwvad(dev, true);
> +	if (ret)
> +		dev_err(dev, "Failed to disable HWVAD module\n");
> +
> +	/* notify userspace that voice was detected */
> +	kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, envp);
> +
> +	return IRQ_HANDLED;
> +}

So, this looks like it's intended to be used for keyword detection type
applications (though without the offload DSP that those tend to have).
What the other implementations I've seen have ended up doing is using a
compressed audio stream to return the audio data to userspace, allowing
the audion stream to be paused when no audio is detected.  Your approach
here is a bit more manual and may be more sensible for systems without
the offload DSP however the decision to go outside ALSA and use a
kobject needs to be thought about a bit, we'd want to ensure that
there's a standard way of handling hardware like this so applications
can work as consistently as possible with them.

It's probably best to split all this VAD handling code out into a
separate patch so that the basic support can get merged and this can be
reviewed separately.  The rest of the driver has some minor issues but
it looks like all the complexity is in this VAD code.

> +static irqreturn_t micfil_err_isr(int irq, void *devid)
> +{
> +	struct fsl_micfil *micfil = (struct fsl_micfil *)devid;
> +	struct platform_device *pdev = micfil->pdev;
> +	u32 stat_reg;
> +
> +	regmap_read(micfil->regmap, REG_MICFIL_STAT, &stat_reg);
> +
> +	if (stat_reg & MICFIL_STAT_BSY_FIL_MASK)
> +		dev_dbg(&pdev->dev, "isr: Decimation Filter is running\n");
> +
> +	if (stat_reg & MICFIL_STAT_FIR_RDY_MASK)
> +		dev_dbg(&pdev->dev, "isr: FIR Filter Data ready\n");
> +
> +	if (stat_reg & MICFIL_STAT_LOWFREQF_MASK) {
> +		dev_dbg(&pdev->dev, "isr: ipg_clk_app is too low\n");
> +		regmap_write_bits(micfil->regmap, REG_MICFIL_STAT,
> +				  MICFIL_STAT_LOWFREQF_MASK, 1);
> +	}
> +
> +	return IRQ_HANDLED;
> +}

This will uncondtionally report the interrupt as handled but if it sees
an error it doesn't recognize it won't log anything - that seems not
ideal, it'd be better to log the value we read in case there's something
else goes wrong to aid debug.

> +static int enable_hwvad(struct device *dev, bool sync)
> +{
> +	struct fsl_micfil *micfil = dev_get_drvdata(dev);
> +	int ret;
> +	int rate;
> +	u32 state;
> +
> +	if (sync)
> +		pm_runtime_get_sync(dev);
> +
> +	state = atomic_cmpxchg(&micfil->hwvad_state,
> +			       MICFIL_HWVAD_OFF,
> +			       MICFIL_HWVAD_ON);

This *really* needs some documentation about what's going on for
concurrency here.

--h56sxpGKRmy85csR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwRT/UACgkQJNaLcl1U
h9CXAAf/TLvrTCqAhSUC6kR5+PB1LKLprsCdNJUOQgq2U4WIJ14/Rx83WdjAXzXy
zTVrn0jJkeoxpqB2KH5dFOO2FfIynSG1JWcyneOd1eoC7NknmkJKfOsbMMpJpSI7
7LNKbk4DP4erZfo7oi6B7BxTDK7+qTNCUS4KnHV0lpytg0ifAUHkUYYnCU1pidPu
6apqgxR9RvAVtUlXTadUdR42dJ1DCpRrE8X3EEFqlT8mckPVqDaGS71MogimaLwG
V1pdVroWELVSlo5GkpucBnQnTaY9WO2IAbaKS/P1kE5O42/bKJXPXuTzEUJI32/U
QS8/EVgCwl4DKI8qiYFoSYiqbKZypw==
=M5wL
-----END PGP SIGNATURE-----

--h56sxpGKRmy85csR--

--===============9051674029748310174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9051674029748310174==--
