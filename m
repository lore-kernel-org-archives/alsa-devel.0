From: Ola LILJA2 <ola.o.lilja@stericsson.com>
Subject: Re: [PATCH 3/3] ASoC: Ux500: Add driver for
 Ux500/AB8500 platform/codec
Date: Tue, 13 Mar 2012 15:56:20 +0100
Message-ID: <AC3CA153830A24419D7BF22D87B39D0557F2EC71DA@EXDCVYMBSTM006.EQ1STM.local>
References: <1327933110-22229-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120130172214.GM4882@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog105.obsmtp.com (eu1sys200aog105.obsmtp.com
	[207.126.144.119])
	by alsa0.perex.cz (Postfix) with ESMTP id B057C104312
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 15:57:18 +0100 (CET)
In-Reply-To: <20120130172214.GM4882@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

Answers inline.

PS. New patch-set uploaded.

BR,
Ola

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: den 30 januari 2012 18:22
> To: Ola LILJA2
> Cc: Liam Girdwood; alsa-devel@alsa-project.org; Linus Walleij
> Subject: Re: [PATCH 3/3] ASoC: Ux500: Add driver for Ux500/AB8500
> platform/codec
> 
> On Mon, Jan 30, 2012 at 03:18:30PM +0100, Ola Lilja wrote:
> > Add the ST-Ericsson Ux500 ASoC platform-driver, AB8500 codec-driver
> > and machine-driver for U8500 hardware.
> 
> This *needs* to be split up for review, there's a *lot* of only
> tangentally related things in here and...
> 
> >  26 files changed, 8519 insertions(+), 9 deletions(-)
> 
> ...an over 8000 line patch is not easy to review at the best of times.
> 
> I'm going to comment on a few things but this is really not a detailed
> review.  From the brief look I've had (most of my comments are on the
> CODEC driver but I did at least glance at most of the code) my overall
> comment is that the code doesn't look like ASoC code at a structural
> level.  The fact that it's all submitted in one patch seems indicative
> of this, and for example what looks like it's supposed to be a machine
> driver is peering into the CODEC power management directly rather than
> letting the CODEC driver get on with things.
> 
> Please make much more of an effort to work with the framework, you
> should have a series of isolated drivers for the various components of
> the system and they should all be using framework features where
> possible.

OK, we have done some serious rewriting of the patch-set. And it now consists
of several patches, one for each platform-driver and a few more. Generic code
is put in specific generic-patches.
All code outside the ASoC-driver has been moved to seperate patches and are
upstreamed by Linus Walleij.

The driver basically consists of:

codec-driver (for AB8500):
sound/soc/codecs/ab8500_audio.c
sound/soc/codecs/ab8500_audio.h

platform-driver (DMA, PCM):
sound/soc/ux500/ux500_pcm.c
sound/soc/ux500/ux500_pcm.h

platform-driver (I2S):
sound/soc/ux500/ux500_msp_dai.c
sound/soc/ux500/ux500_msp_dai.h
sound/soc/ux500/ux500_msp_i2s.c
sound/soc/ux500/ux500_msp_i2s.h

machine-driver:
sound/soc/ux500/u8500.c
sound/soc/ux500/ux500_ab8500.c

> 
> In terms of ths split:
> 
> >  arch/arm/mach-ux500/board-mop500-msp.c        |  195 ++
> >  arch/arm/mach-ux500/board-mop500-regulators.c |   28 +
> >  arch/arm/mach-ux500/board-mop500.c            |    7 +-
> >  arch/arm/mach-ux500/board-mop500.h            |    1 +
> 
> This adds machine support for a particular board on the ARM side.
> 
> >  arch/arm/mach-ux500/clock.c                   |    8 +-
> >  arch/arm/mach-ux500/devices-common.h          |    2 +-
> >  arch/arm/mach-ux500/include/mach/msp.h        | 1030 +++++++++
> 
> This looks like some random CPU core stuff.
> 
> >  include/sound/ux500_ab8500.h                  |   36 +
> >  sound/soc/Kconfig                             |    1 +
> >  sound/soc/Makefile                            |    1 +
> 
> This should be a separate patch on the end of the series which enables
> the build.
> 
> >  sound/soc/codecs/Kconfig                      |    4 +
> >  sound/soc/codecs/Makefile                     |    6 +
> >  sound/soc/codecs/Makefile.rej                 |   10 +
> >  sound/soc/codecs/ab8500_audio.c               | 2928
> +++++++++++++++++++++++++
> >  sound/soc/codecs/ab8500_audio.h               |  673 ++++++
> 
> This adds the CODEC driver and should be done separately and you
> shouldn't be sending .rej files as part of your patch.
> 
> >  sound/soc/ux500/Kconfig                       |   33 +
> >  sound/soc/ux500/Makefile                      |   25 +
> >  sound/soc/ux500/u8500.c                       |  150 ++
> >  sound/soc/ux500/ux500_ab8500.c                |  790 +++++++
> 
> One of these is a machine driver, again should be separate.
> 
> >  sound/soc/ux500/ux500_msp_dai.c               |  998 +++++++++
> >  sound/soc/ux500/ux500_msp_dai.h               |   83 +
> >  sound/soc/ux500/ux500_msp_i2s.c               | 1004 +++++++++
> >  sound/soc/ux500/ux500_msp_i2s.h               |   40 +
> 
> Not sure what the split is here but this looks like the I2S controller
> and can go as a separate patch.

Done.

> 
> >  sound/soc/ux500/ux500_pcm.c                   |  428 ++++
> >  sound/soc/ux500/ux500_pcm.h                   |   44 +
> 
> The DMA controller should also be split.

Done.

> 
> > +/*** Sample Frequencies ***/
> > +/* These are no longer required, frequencies in Hz can be used
> > +directly */
> 
> If they are not required then remove them.

Done.

> 
> > +#ifndef UX500_AB8500_H
> > +#define UX500_AB8500_H
> > +
> > +extern struct snd_soc_ops ux500_ab8500_ops[];
> > +
> > +struct snd_soc_pcm_runtime;
> > +
> > +int ux500_ab8500_startup(struct snd_pcm_substream *substream);
> > +
> > +void ux500_ab8500_shutdown(struct snd_pcm_substream *substream);
> > +
> > +int ux500_ab8500_hw_params(struct snd_pcm_substream *substream,
> > +			struct snd_pcm_hw_params *params);
> > +
> > +int ux500_ab8500_soc_machine_drv_init(void);
> > +
> > +void ux500_ab8500_soc_machine_drv_cleanup(void);
> > +
> > +int ux500_ab8500_machine_codec_init(struct snd_soc_pcm_runtime
> > +*runtime);
> > +
> > +extern void ux500_ab8500_jack_report(int);
> > +
> 
> Nothing in this header looks like it should be exported, I've not
> actually looked at any of the code to see what this stuff is doing but
> it all looks like it should be private to the relevant drivers.

The machine-driver is split up in a main machine-driver and several
sub-machine-drivers (one for each platform<->codec), so this inteface is
just so that the main machine-file can call reach the functions implemented
in the sub-machine-driver-file. It is not meant for the world outside our
driver.

> 
> > --- a/sound/soc/Kconfig
> > +++ b/sound/soc/Kconfig
> > @@ -45,6 +45,7 @@ source "sound/soc/s6000/Kconfig"
> >  source "sound/soc/sh/Kconfig"
> >  source "sound/soc/tegra/Kconfig"
> >  source "sound/soc/txx9/Kconfig"
> > +source "sound/soc/ux500/Kconfig"
> >
> >  # Supported codecs
> >  source "sound/soc/codecs/Kconfig"
> 
> Keep Kconfig and Makefiles sorted.

Aren't they?!

> 
> > index 7c205e7..a02b2c3 100644
> > --- a/sound/soc/codecs/Kconfig
> > +++ b/sound/soc/codecs/Kconfig
> > @@ -12,6 +12,7 @@ config SND_SOC_ALL_CODECS
> >  	tristate "Build all ASoC CODEC drivers"
> >  	select SND_SOC_88PM860X if MFD_88PM860X
> >  	select SND_SOC_L3
> > +	select SND_SOC_AB8500
> >  	select SND_SOC_AC97_CODEC if SND_SOC_AC97_BUS
> >  	select SND_SOC_AD1836 if SPI_MASTER
> >  	select SND_SOC_AD193X if SND_SOC_I2C_AND_SPI
> 
> Only if the MFD is there or it won't build.
> 
> > @@ -201,3 +203,7 @@ obj-$(CONFIG_SND_SOC_WM_HUBS)	+= snd-soc-wm-
> hubs.o
> >  # Amp
> >  obj-$(CONFIG_SND_SOC_MAX9877)	+= snd-soc-max9877.o
> >  obj-$(CONFIG_SND_SOC_TPA6130A2)	+= snd-soc-tpa6130a2.o
> > +
> > +ifdef CONFIG_SND_SOC_UX500_DEBUG
> > +CFLAGS_ab8500_audio.o := -DDEBUG
> > +endif
> 
> No other driver has this.  Why does your driver have it?

Can't answer to why other people don't have it =) I found it convenient
to be able to turn on the debug-prints in our driver by just using a flag
in menuncofig rather than modifying Makefiles every time.
It is easier to tell our customer to just activate this flag.
Do you want me to remove it?

> 
> > +/* Macros to simplify implementation of register write sequences and
> > +error handling */ #define AB8500_SET_BIT_LOCKED(xreg, xbit, xerr,
> xerr_hdl) { \
> > +	xerr = snd_soc_update_bits_locked(ab8500_codec, xreg,
> REG_MASK_NONE, BMASK(xbit)); \
> > +	if (xerr < 0) \
> > +		goto xerr_hdl; }
> > +#define AB8500_CLEAR_BIT_LOCKED(xreg, xbit, xerr, xerr_hdl) { \
> > +	xerr = snd_soc_update_bits_locked(ab8500_codec, xreg,
> BMASK(xbit), REG_MASK_NONE); \
> > +	if (xerr < 0) \
> > +		goto xerr_hdl; }
> > +#define AB8500_WRITE(xreg, xvalue, xerr, xerr_hdl) { \
> > +	xerr = snd_soc_write(ab8500_codec, xreg, xvalue); \
> > +	if (xerr < 0) \
> > +		goto xerr_hdl; }
> 
> This just obscures the code.

Yes, indeed. Removed.

> 
> > +/*
> > + * AB8500 register cache & default register settings  */ static
> const
> > +u8 ab8500_reg_cache[AB8500_CACHEREGNUM] = {
> 
> Hrm, I would say the core ought to be converted over to regmap but it
> looks like the "I2C" I/O actually goes via some magic "prcmu" interface
> and not I2C.  I'd really like to try to avoid adding new cache users
> but this does look like a valid use.
> 
> > +static struct snd_soc_codec *ab8500_codec;
> 
> If you need this something is seriously wrong.

We don't =) Fixed in the new patch-set.

> 
> > +/* ANC FIR- & IIR-coeff caches */
> > +static int ab8500_anc_fir_coeff_cache[REG_ANC_FIR_COEFFS];
> > +static int ab8500_anc_iir_coeff_cache[REG_ANC_IIR_COEFFS];
> 
> No global static data, store it per device.

Done.

> 
> > +static int ab8500_codec_read_reg(struct snd_soc_codec *codec,
> unsigned int bank,
> > +		unsigned int reg)
> > +{
> > +	u8 value;
> > +	int status = abx500_get_register_interruptible(
> > +		codec->dev, bank, reg, &value);
> 
> Non-interruptible I/O please.  The user killing their application
> shouldn't cause us to fail to shut down the audio path.

This is actually not interruptible anymore, and it is only the name that
is still dwelling around.
Linus Walleij is working on a patch to replace the naming.

> 
> > +	if (status < 0) {
> > +		pr_err("%s: Register (%02x:%02x) read failed
> (%d).\n",
> > +			__func__, (u8)bank, (u8)reg, status);
> > +	} else {
> > +		pr_debug("Read 0x%02x from register %02x:%02x\n",
> > +			(u8)value, (u8)bank, (u8)reg);
> > +		status = value;
> 
> We have plenty of diagnsotic support in the core for basic stuff like
> register I/O.  When you are logging use dev_ variants.

All pr_xxx rewritten to use dev_xxx.

> 
> > +static unsigned int ab8500_codec_read_reg_audio(struct snd_soc_codec
> *codec,
> > +		unsigned int reg)
> > +{
> > +	u8 *cache = codec->reg_cache;
> > +	return cache[reg];
> > +}
> 
> Absolutely no open coded cache implementations, use the soc-cache
> facilities.

Removed.

> 
> > +static inline void ab8500_codec_dump_all_reg(struct snd_soc_codec
> > +*codec) {
> > +	int i;
> > +
> > +	pr_debug("%s Enter.\n", __func__);
> > +
> > +	for (i = AB8500_FIRST_REG; i <= AB8500_LAST_REG; i++)
> > +		ab8500_codec_read_reg_audio_nocache(codec, i); }
> 
> We have support for this in the core.

Removed.

> 
> > +/* Updates an audio register.
> > + */
> > +static inline int ab8500_codec_update_reg_audio(struct snd_soc_codec
> *codec,
> > +		unsigned int reg, unsigned int clr, unsigned int
> ins) {
> > +	unsigned int new, old;
> > +
> > +	old = ab8500_codec_read_reg_audio(codec, reg);
> > +	new = (old & ~clr) | ins;
> > +	if (old == new)
> > +		return 0;
> > +
> > +	return ab8500_codec_write_reg_audio(codec, reg, new); }
> 
> Ditto for this.
> 
> > +/* Generic soc info for signed register controls. */ int
> > +snd_soc_info_s(struct snd_kcontrol *kcontrol,
> > +	struct snd_ctl_elem_info *uinfo)
> 
> If this is generic (and it looks like it is) then what is it doing in a
> particular driver?

Moved to generic code (separate patches).

> 
> > +static int st_fir_value_control_get(struct snd_kcontrol *kcontrol,
> > +			   struct snd_ctl_elem_value
> *ucontrol) {
> > +	return 0;
> > +}
> 
> This looks obviously buggy.

These are FIR-coeffecients and can (by HW-design) not be read. So there is nothing to
do here.

> 
> > +/* Controls - DAPM */
> 
> > +/* Inverted order - Ascending/Descending */ enum control_inversion {
> > +	NORMAL = 0,
> > +	INVERT = 1
> > +};
> 
> Seriously?

No. removed.

> 
> > +	case SND_SOC_DAIFMT_CBS_CFM: /* codec clk slave & FRM master
> */
> > +	case SND_SOC_DAIFMT_CBM_CFS: /* codec clk master & frame
> slave */
> > +		pr_err("%s: ERROR: The device is either a master
> or a slave.\n",
> > +			__func__);
> > +	default:
> > +		pr_err("%s: ERROR: Unsupporter master mask
> 0x%x\n",
> > +			__func__,
> > +			fmt & SND_SOC_DAIFMT_MASTER_MASK);
> > +		return -EINVAL;
> > +	}
> 
> All those three cases do the same thinng.

Rewritten.

> 
> > +static int ab8500_codec_set_bit_delay_if1(struct snd_soc_codec
> > +*codec, unsigned int delay) {
> > +	unsigned int clear_mask, set_mask;
> > +
> > +	clear_mask = BMASK(REG_DIGIFCONF4_IF1DEL);
> > +	set_mask = 0;
> > +
> > +	switch (delay) {
> > +	case 0:
> > +		break;
> > +	case 1:
> > +		set_mask |= BMASK(REG_DIGIFCONF4_IF1DEL);
> > +		break;
> > +	default:
> > +		pr_err("%s: ERROR: Unsupported bit-delay
> (0x%x)!\n", __func__, delay);
> > +		return -EINVAL;
> > +	}
> 
> Eh?  Why is this done separately to the configuration of the AIF mode?

Removed. Now assume 1-bit delay for DSP_A-mode.

> 
> > +	data = ab8500_codec_read_reg(codec, AB8500_MISC,
> AB8500_GPIO_DIR4_REG);
> > +	data |= GPIO27_DIR_OUTPUT | GPIO29_DIR_OUTPUT |
> GPIO31_DIR_OUTPUT;
> > +	ab8500_codec_write_reg(codec, AB8500_MISC,
> AB8500_GPIO_DIR4_REG,
> > +data);
> 
> This loooks like platform data...

Well, this is actually GPIO on the codec-chip and not the base-chip.

> 
> > +void ab8500_audio_power_control(bool power_on) {
> > +	if (ab8500_codec == NULL) {
> > +		pr_err("%s: ERROR: AB8500 ASoC-driver not yet
> probed!\n", __func__);
> > +		return;
> > +	}
> 
> Use the framework features for power management, we've got enough ways
> for your driver to get told when to power up and down none of which
> require a global pointer to a device.

This is called as an effect of a DAPM-chain so it is using the ASoC-framework.
The reason for having this like it is, is due to the fact that we need to call
this funtion not only from the DAPM-chain, but also from another kernel-driver
(our vibra-driver). I would love to see this extra way into the audio-driver but
as the design of our platform require this, we are stuck with this solution.
