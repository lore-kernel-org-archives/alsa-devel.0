From: Rongjun Ying <Rongjun.Ying@csr.com>
Subject: Re: [PATCH v4-resend 1/7] ASoC: sirf: Add SiRF
 internal audio codec driver
Date: Fri, 28 Feb 2014 01:52:32 +0000
Message-ID: <86130EF012BDF348AA0D464A4F449478012AE51755@SHAASIEXM01.ASIA.ROOT.PRI>
References: <1393399342-31177-1-git-send-email-rongjun.ying@csr.com>
 <1393399342-31177-2-git-send-email-rongjun.ying@csr.com>
 <20140227053339.GU9383@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cluster-g.mailcontrol.com (cluster-g.mailcontrol.com
 [208.87.233.190])
 by alsa0.perex.cz (Postfix) with ESMTP id A44872658FC
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 02:52:41 +0100 (CET)
In-Reply-To: <20140227053339.GU9383@sirena.org.uk>
Content-Language: zh-CN
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, RongJun Ying <rjying@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, DL-SHA-WorkGroupLinux <DL-SHA-WorkGroupLinux@internal.csr.com>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Thursday, February 27, 2014 1:34 PM
> To: RongJun Ying
> Cc: Liam Girdwood; Jaroslav Kysela; Takashi Iwai; alsa-devel@alsa-
> project.org; DL-SHA-WorkGroupLinux; Rongjun Ying
> Subject: Re: [PATCH v4-resend 1/7] ASoC: sirf: Add SiRF internal audio
> codec driver
> 
> On Wed, Feb 26, 2014 at 03:22:16PM +0800, RongJun Ying wrote:
> 
> Overall looks fairly good, a few issues below but they're quite small.
> 
> > +static struct sirf_audio_codec_reg_bits
> sirf_audio_codec_reg_bits_prima2 = {
> > +	.dig_mic_en_bits = 20,
> > +	.dig_mic_freq_bits = 21,
> > +	.adc14b_12_bits = 22,
> > +	.firdac_hsl_en_bits = 23,
> > +	.firdac_hsr_en_bits = 24,
> > +	.firdac_lout_en_bits = 25,
> > +	.por_bits = 26,
> > +	.codec_clk_en_bits = 27,
> > +};
> 
> This looks like the sort of thing that the regmap_field layer was
> supposed to hide?
> 

Do you mean I need use the regmap_field_read/write to hide these?

> > +static int adc_event(struct snd_soc_dapm_widget *w,
> > +		struct snd_kcontrol *kcontrol, int event) {
> > +	struct snd_soc_codec *codec = w->codec;
> > +	struct sirf_audio_codec *sirf_audio_codec =
> dev_get_drvdata(codec->dev);
> > +	u32 val;
> > +
> > +	val = sirfsoc_rtc_iobrg_readl(sirf_audio_codec->sys_pwrc_reg_base
> +
> > +			PWRC_PDN_CTRL_OFFSET);
> > +	switch (event) {
> > +	case SND_SOC_DAPM_POST_PMU:
> > +		/* Enable capture power of codec*/
> > +		val |= (1 << AUDIO_POWER_EN_BIT);
> > +		break;
> 
> Looking at this code (and many of the other controls) I can't help but
> feel that there's some room for more abstraction here.  The controls
> are all setting two bits rather than just one but for example...
> 
> > +	case SND_SOC_DAPM_PRE_PMU:
> > +		val = (1 << sirf_audio_codec->reg_bits->firdac_hsl_en_bits);
> > +		break;
> 
> ...this looks like a supply widget could be used to manage the bits
> controlled by the pre and post PMU events?  The same is true for most
> of the events.
> 

Ok, I will use supply widget.

> > +	dn = of_find_compatible_node(dn, NULL, "sirf,prima2-pwrc");
> > +	if (!dn) {
> > +		dev_err(&pdev->dev, "Failed to get sirf,prima2-pwrc
> node!\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	ret = of_property_read_u32(dn, "reg", &sirf_audio_codec-
> >sys_pwrc_reg_base);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "Failed tp get pwrc register base
> address\n");
> > +		return -EINVAL;
> > +	}
> 
> Should prima2-pwrc be a syscon?  Not a blocker for merging this.
> 
> > +#ifdef CONFIG_PM_RUNTIME
> > +static int sirf_audio_codec_runtime_suspend(struct device *dev) {
> > +	struct sirf_audio_codec *sirf_audio_codec = dev_get_drvdata(dev);
> > +	regmap_update_bits(sirf_audio_codec->regmap, AUDIO_IC_CODEC_CTRL1,
> > +		(1 << sirf_audio_codec->reg_bits->codec_clk_en_bits),
> > +		0);
> > +	return 0;
> > +}
> 
> Can you disable the clock in the clock API as well?  This might allow
> further supply clocks to be disabled and is genarally good practice.
> 

This is a workaround. The capture ADC and touch ADC use a same power supply,
The codec ADC's change pump set or clear will impact touch ADC unstable.
So It's need enable codec clock and set change pump when the Audio driver init.

Thanks
RongJun Ying

> > +static int sirf_audio_codec_suspend(struct device *dev) {
> > +	struct sirf_audio_codec *sirf_audio_codec = dev_get_drvdata(dev);
> > +
> > +	regmap_read(sirf_audio_codec->regmap, AUDIO_IC_CODEC_CTRL0,
> > +		&sirf_audio_codec->reg_ctrl0);
> > +	regmap_read(sirf_audio_codec->regmap, AUDIO_IC_CODEC_CTRL1,
> > +		&sirf_audio_codec->reg_ctrl1);
> > +	sirf_audio_codec_runtime_suspend(dev);
> 
> Have you seen the series Ulf has been posting regarding the integration
> of runtime PM and system suspend?  There's all sorts of nasty cases
> with this stuff unfortunately.  Not sure it should be a blocker for
> merging though since we haven't really figured out how this stuff is
> supposed to work.


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
