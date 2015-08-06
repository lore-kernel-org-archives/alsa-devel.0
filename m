From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/12] ASoC: AMD: add AMD ASoC ACP-I2S
	driver (v2)
Date: Thu, 6 Aug 2015 20:22:05 +0100
Message-ID: <20150806192205.GG20873@sirena.org.uk>
References: <1438871112-25946-1-git-send-email-alexander.deucher@amd.com>
 <1438871112-25946-10-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5350214694534219886=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A1242260560
 for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2015 21:22:18 +0200 (CEST)
In-Reply-To: <1438871112-25946-10-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alsa-devel@alsa-project.org, maruthi.bayyavarapu@amd.com, tiwai@suse.de, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, Vinod Koul <vinod.koul@intel.com>, airlied@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5350214694534219886==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ln7g2OyKfOVI4VSW"
Content-Disposition: inline


--ln7g2OyKfOVI4VSW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2015 at 10:25:10AM -0400, Alex Deucher wrote:
> From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
>=20
> ACP IP block consists of dedicated DMA and I2S blocks. The PCM driver
> provides the DMA and CPU DAI components to ALSA core. Machine driver
> provides the audio functionality together with the PCM driver and rt286
> codec driver.

Quite a few comments below, a lot of them fairly simple stylistic and
process ones but there seem to be some really big issues in the way the
machine driver is implemented and in particular with things being
manually registered rather than instantiated with ACPI.  I'm also
worried about the unusual licensing.

Please also coordinate with Intel on ACPI bindings for ASoC style audio
subsystems, I've CCed in Vinod who's been working on it (and Liam is
also at Intel).

>=20
> v2: squash in Kconfig fix

Please follow the patch submission process in SubmittingPatches: put any
versioning in the subject line inside the [] and put noise like inter
version changelogs after the ---.

> --- a/sound/soc/Makefile
> +++ b/sound/soc/Makefile
> @@ -41,3 +41,4 @@ obj-$(CONFIG_SND_SOC)	+=3D txx9/
>  obj-$(CONFIG_SND_SOC)	+=3D ux500/
>  obj-$(CONFIG_SND_SOC)	+=3D xtensa/
>  obj-$(CONFIG_SND_SOC)	+=3D zte/
> +obj-$(CONFIG_SND_SOC)   +=3D amd/

Please keep the Makefile sorted as well as the Kconfig.

> diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
> new file mode 100644
> index 0000000..07677de
> --- /dev/null
> +++ b/sound/soc/amd/Kconfig
> @@ -0,0 +1,13 @@
> + config SND_SOC_AMD_CZ_RT286_MACH
> +        tristate "AMD ASoC Audio driver for Carrizo with rt286 codec"
> +	select SND_SOC_RT286
> +	select SND_SOC_AMD_ACP
> +        depends on I2C_DESIGNWARE_PLATFORM
> +        help
> +           This option enables AMD I2S Audio support on Carrizo
> +	   with ALC288 codec.

It looks like you've got tab/space here.  You're also adding a machine
driver in the same patch as the base driver support, please don't do
that - send one patch per driver.

> new file mode 100644
> index 0000000..63b6f83
> --- /dev/null
> +++ b/sound/soc/amd/Makefile
> @@ -0,0 +1,11 @@
> +ccflags-y :=3D -Iinclude/drm -Idrivers/gpu/drm/amdsoc/
> +ccflags-y +=3D -Idrivers/gpu/drm/amdsoc/include/
> +ccflags-y +=3D -Idrivers/gpu/drm/amd/include/bus/
> +ccflags-y +=3D -Idrivers/gpu/drm/amd/acp/include
> +ccflags-y +=3D -Idrivers/gpu/drm/amd/include/
> +ccflags-y +=3D -Idrivers/gpu/drm/amd/include/asic_reg/acp

Eew, no - please put these headers in include.

> + * AMD ALSA SoC PCM Driver
> + *
> + * Copyright 2014-2015 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.

All the ASoC APIs are EXPORT_SYMBOL_GPL() and this doesn't explicitly
grant GPL rights.  Your MODULE_LICENSE() says

> +MODULE_LICENSE("GPL and additional rights");

but I'm not 100% sure that's the case - it looks like a separate MIT/BSD
license rather than a GPL grant.  This doesn't make me happy about the
licensing status.  The clearest thing would be either to just license
under the GPL, or to dual license.

> +	.fifo_size =3D 0,

No need to set static structures to 0.

> +static const struct snd_soc_component_driver dw_i2s_component =3D {
> +	.name =3D "dw-i2s.0",
> +};

=2E0?  What's going on here...

> +static void acp_pcm_period_elapsed(struct device *dev, u16 play_intr,
> +							u16 capture_intr)
> +{
> +	struct snd_pcm_substream *substream;
> +	struct audio_drv_data *irq_data =3D
> +	    (struct audio_drv_data *)dev_get_drvdata(dev);

No need to cast away from void.

> +
> +	/* Inform ALSA about the period elapsed (one out of two periods) */
> +	if (play_intr)
> +		substream =3D irq_data->play_stream;
> +	else if (capture_intr)
> +		substream =3D irq_data->capture_stream;
> +
> +	if (substream->runtime && snd_pcm_running(substream))

What if both play_intr and capture_intr or set, or if neither of them is
set?

> +	adata->dma_config =3D
> +			kzalloc(sizeof(struct acp_dma_config), GFP_KERNEL);
> +	if (adata->dma_config =3D=3D NULL) {
> +		kfree(adata);
> +		return -ENOMEM;
> +	}

Why are all these structs allocated separately and not just embedded
into adata?

> +	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> +		runtime->hw =3D acp_pcm_hardware_playback;
> +	else if (substream->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE)
> +		runtime->hw =3D acp_pcm_hardware_capture;
> +	else {
> +		pr_err("Error in stream type\n");
> +		return -EINVAL;
> +	}

You should have { } on all branches of an if statement if you need it on
one.  The usual idiom for this check is just to do "if (playback)" and
not have the third error case.

> +	ret =3D snd_pcm_hw_constraint_integer(runtime,
> +					    SNDRV_PCM_HW_PARAM_PERIODS);
> +	if (ret < 0) {
> +		pr_err("snd_pcm_hw_constraint_integer failed\n");

Please use dev_ prints so people can tell more easily what the source of
the message is.

> +	if (WARN_ON(!substream))
> +		return -EINVAL;

The subsystem will check this for you.

> +	memset(substream->runtime->dma_area, 0, params_buffer_bytes(params));
> +	pg =3D virt_to_page(substream->dma_buffer.area);
> +
> +	if (NULL !=3D pg) {
> +		/* Save for runtime private data */
> +		rtd->pg =3D pg;
> +		rtd->order =3D get_order(size);
> +
> +		/*Let ACP know the Allocated memory */
> +		num_of_pages =3D PAGE_ALIGN(size) >> PAGE_SHIFT;

Spaces in the comments.

> +		/* Fill ACP SRAM with zeros from System RAM which is zero-ed
> +		 * in hw_params */
> +		ret =3D acp_dev->dma_start(rtd->acp_dev,
> +						SYSRAM_TO_ACP_CH_NUM, false);
> +		if (ret < 0)
> +			ret =3D -EFAULT;
> +
> +		/* Now configure DMA to transfer only first half of System RAM
> +		 * buffer before playback is triggered. This will overwrite
> +		 * zero-ed second half of SRAM buffer */
> +		acp_dev->config_dma_channel(acp_dev, SYSRAM_TO_ACP_CH_NUM,
> +					PLAYBACK_START_DMA_DESCR_CH12,
> +					1, 0);

Why?  The comments describe what's happening but it's not clear why it's
happening.

> +static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
> +{
> +	struct snd_pcm_runtime *runtime =3D substream->runtime;
> +	struct audio_substream_data *rtd =3D runtime->private_data;
> +	struct amd_acp_device *acp_dev =3D rtd->acp_dev;
> +
> +	int ret =3D -EIO;

This means the compiler won't be able to spot missing initialisation
problems - do we need to do it?  Also I notice you've got a *lot* of
blocks of variable declarations separated by spaces which is really
unusual for the kernel.

> +	if (!rtd)
> +		return -EINVAL;
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
> +			ret =3D acp_dev->dma_start(rtd->acp_dev,
> +						SYSRAM_TO_ACP_CH_NUM, false);
> +			if (ret < 0)
> +				ret =3D -EFAULT;

Don't ignore the error code you got, pass it back.

> +	default:
> +		dev_err(dev, "designware-i2s: unsuppted PCM fmt");
> +		return -EINVAL;

This doesn't appear to be a designware-i2s driver, we already have one
of those?  It's also better to print out the value that we're erroring
on, it can help people figure out problems.

> +static int acp_alsa_register(struct device *dev, struct amd_acp_device *=
acp_dev,
> +				struct amd_gnb_bus_dev *adev)
> +{
> +	int status;
> +
> +	status =3D snd_soc_register_platform(dev, &acp_asoc_platform);
> +	if (STATUS_SUCCESS !=3D status) {

STATUS_SUCCESS!?  It's also very unusual to have the variable and the
constant this way round in the kernel - I am noticing a lot of style
issues in here.

> +static void __exit amdsoc_bus_acp_dma_driver_exit(void)
> +{
> +	pr_info("ACP: PCM driver exit\n");

Don't include noise like this in the kernel logs, it's not adding
anything.

> +	amd_gnb_bus_unregister_driver(&acp_dma_driver);
> +}
> +
> +module_init(amdsoc_bus_acp_dma_driver_init);
> +module_exit(amdsoc_bus_acp_dma_driver_exit);
> +
> +MODULE_AUTHOR("Maruthi.Bayyavarapu@amd.com");
> +MODULE_DESCRIPTION("AMD ACP PCM Driver");
> +MODULE_LICENSE("GPL and additional rights");

How will this module get autoloaded?

> +#include "../codecs/rt286.h"
> +
> +#ifdef CONFIG_PINCTRL_AMD
> +
> +#define CZ_HPJACK_GPIO  7

Hard coded system wide magic numbers?  Please don't do this.

> +	err =3D snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
> +				SND_SOC_DAIFMT_NB_NF |
> +				SND_SOC_DAIFMT_CBM_CFM);
> +	if (err < 0) {
> +		dev_err(card->dev, "unable to set codec dai format\n");
> +		return err;
> +	}

Set this in the dai_link.

> +	err =3D snd_soc_dai_set_sysclk(codec_dai, RT286_SCLK_S_PLL, 24000000,
> +					SND_SOC_CLOCK_OUT);
> +	if (err < 0) {
> +		dev_err(card->dev, "unable to set codec dai clock\n");
> +		return err;
> +	}

Set this in the link init function, no need to reset it each time we
configure since it never changes.

> +static int carrizo_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	/* TODO: check whether dapm widgets needs to be
> +	 * dsiconnected initially. */

They don't.

> +static struct snd_soc_dai_link carrizo_dai_rt286 =3D {
> +	.name =3D "amd-rt286",
> +	.stream_name =3D "RT286_AIF1",
> +	.platform_name =3D "acp_pcm_dev",
> +	.cpu_dai_name =3D "acp_pcm_dev",
> +	.codec_dai_name =3D "rt286-aif1",
> +	.codec_name =3D "rt286.3-001c",
> +	.dai_fmt =3D SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
> +			| SND_SOC_DAIFMT_CBM_CFM,

Oh, you did initialise this in the dai_link :(

> +	.ignore_suspend =3D 1,

Why is this being set - this doesn't look like it's a CODEC<->CODEC
link?

> +	ret =3D snd_soc_register_card(card);
> +	if (ret) {

devm_snd_soc_register_card()

> +static const struct acpi_device_id cz_audio_acpi_match[] =3D {
> +	{ "I2SC1002", 0 },
> +	{},
> +};

ACPI has bindings for GPIOs, you should be able to use those to discover=20
the detection GPIO.

> +static int __init cz_audio_init(void)
> +{
> +	int ret;
> +	struct i2c_adapter *adapter;
> +	struct i2c_board_info cz_board_info;
> +	const char *codec_acpi_name =3D "rt288";
> +
> +	adapter =3D i2c_get_adapter(CZ_CODEC_I2C_ADAPTER_ID);
> +	if (!adapter)
> +		return -ENODEV;
> +
> +	memset(&cz_board_info, 0, sizeof(struct i2c_board_info));
> +	cz_board_info.addr =3D CZ_CODEC_I2C_ADDR;
> +	strlcpy(cz_board_info.type, codec_acpi_name, I2C_NAME_SIZE);
> +
> +#ifdef CONFIG_PINCTRL_AMD
> +	if (gpio_is_valid(CZ_HPJACK_GPIO)) {
> +		ret =3D gpio_request_one(CZ_HPJACK_GPIO, GPIOF_DIR_IN |
> +						GPIOF_EXPORT, "hp-gpio");
> +		if (ret !=3D 0)
> +			pr_err("gpio_request_one failed : err %d\n", ret);

As well as the whole thing with getting this from ACPI rather than
defining magic numbers this should be done in the card init not in the
module init (like other card drivers do).  This then means you don't
need any global variables.

> +#endif
> +	i2c_client =3D i2c_new_device(adapter, &cz_board_info);
> +	i2c_put_adapter(adapter);
> +	if (!i2c_client)
> +		return -ENODEV;

No, definitely not - ACPI has perfectly good bindings for instantiating
I2C devices (indeed the laptop I'm typing this on actually uses them to
instantiate exactly the same RT286 audio CODEC you're using here),
please use them.

--ln7g2OyKfOVI4VSW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVw7PdAAoJECTWi3JdVIfQuP8H/2wEQZiAuwb0slaOlgPVjYBd
aGbxCIQpo/LcFfM1MUbWvIL0j12Vz0ocgwI0ZQzrAiBTLXbU1H5O6a151SnP4oLn
N4houO5l3I3QgxK/OqG0LAaDEdUqpcoXlbjuha/5OZyqASVmjuJRc+6FGR/Uf/YQ
xZzY9TGBC8rmqgR8m2Fta/baMtUo7O+ve3kATF0NB73HHcNERBSF6PEurKYoRbTC
TTEtGT1n+hwXswfi/Oc2bO2Qx77jSoEeTukVYf3jMAZp7f1sAPatRWydDTwyhAnt
wMCXomiap/kqNUpvRae2qM3yH/wkVoS5Nih1zrelOA+/zyEwbqBTcsPdq3c3fg8=
=NZo1
-----END PGP SIGNATURE-----

--ln7g2OyKfOVI4VSW--

--===============5350214694534219886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5350214694534219886==--
