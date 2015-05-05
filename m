From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 7/8] ASoC: wm8998: Initial WM8998 codec driver
Date: Tue, 5 May 2015 10:24:12 +0100
Message-ID: <20150505092411.GA15549@opensource.wolfsonmicro.com>
References: <1430493319-23808-1-git-send-email-rf@opensource.wolfsonmicro.com> <1430493319-23808-8-git-send-email-rf@opensource.wolfsonmicro.com> <20150504113943.GB15510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150504113943.GB15510@sirena.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lee.jones@linaro.org, linus.walleij@linaro.org, gnurou@gmail.com, cw00.choi@samsung.com, myungjoo.ham@samsung.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, May 04, 2015 at 12:39:43PM +0100, Mark Brown wrote:
> On Fri, May 01, 2015 at 04:15:18PM +0100, Richard Fitzgerald wrote:
> 
> > +	switch (event) {
> > +	case SND_SOC_DAPM_PRE_PMU:
> > +		val = snd_soc_read(codec, ARIZONA_ASRC_RATE1);
> > +		val &= ARIZONA_ASRC_RATE1_MASK;
> > +		val >>= ARIZONA_ASRC_RATE1_SHIFT;
> > +
> > +		val = snd_soc_read(codec, ARIZONA_SAMPLE_RATE_1 + val);
> > +		if (val >= 0x11)
> > +			dev_warn(codec->dev, "Unsupported ASRC rate1\n");
> 
> Shouldn't we be returning an error if the rate is unsupported?  It'd
> also be helpful to log what the invalid value that's been set is.
> 
> > +		val = snd_soc_read(codec, ARIZONA_ASRC_RATE2);
> > +		val &= ARIZONA_ASRC_RATE2_MASK;
> > +		val >>= ARIZONA_ASRC_RATE2_SHIFT;
> > +		val -= 0x8;
> 
> What if the value we read back is set (invalidly I guess) to less than
> 8?  We'll just read...

> 
> > +
> > +		val = snd_soc_read(codec, ARIZONA_ASYNC_SAMPLE_RATE_1 + val);
> > +		if (val >= 0x11)
> > +			dev_warn(codec->dev, "Unsupported ASRC rate2\n");
> 
> ...some random other register.

ARIZONA_ASRC_RATE2 register can only have the values 8 or 9 and we don't
provide a way to set it to illegal values.

> 
> > +static const char * const wm8998_inmux_texts[] = {
> > +	"A",
> > +	"B",
> > +};
> > +
> > +static const SOC_ENUM_SINGLE_DECL(wm8998_in1muxl_enum,
> > +				  ARIZONA_ADC_DIGITAL_VOLUME_1L,
> > +				  ARIZONA_IN1L_SRC_SHIFT,
> > +				  wm8998_inmux_texts);
> 
> Those are some fun input names...

... that's what the mux positions are called and it seems nice to have consistent
naming for all similar muxes across channels and across future codecs. Like for
example to switch both muxes of a stereo input you set them both to the same
position name (both "A" or both "B") is clearer, and quicker to spot in a dump
of ALSA control settings, than having the two muxes set to different enumeration
strings that actually mean the same mux position.


