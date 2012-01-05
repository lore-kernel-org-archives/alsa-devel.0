From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add support for TI LM49453 Audio
	codec
Date: Thu, 5 Jan 2012 06:17:13 +0000
Message-ID: <20120105061713.GH11867@opensource.wolfsonmicro.com>
References: <290463D19D2E064191F1F96ECA480A89434A67486B@EXMAIL02.scwf.nsc.com>
	<20120103211748.GA6832@opensource.wolfsonmicro.com>
	<290463D19D2E064191F1F96ECA480A89434A7595BC@EXMAIL02.scwf.nsc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2F5A91039C7
	for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2012 07:17:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <290463D19D2E064191F1F96ECA480A89434A7595BC@EXMAIL02.scwf.nsc.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Reddy, MR Swami" <MR.Swami.Reddy@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 04, 2012 at 03:11:03AM -0800, Reddy, MR Swami wrote:
> On Wednesday, January 04, 2012 2:48 AM, Mark Brown wrote:

Your mail client appears to be very broken, it's reflowed all my text to
remove line breaks which does nothing for legibility.

> >> +       SND_SOC_DAPM_OUT_DRV("Sidetone DAC HPR Playback",
> >> +                             LM49453_P0_STN_SEL_REG, 1, 0, NULL, 0),

> >What exactly do these register bits do?  The use of OUT_DRV widgets looks very suspicious for a sidetone, an output driver would usually be a power
> >amplifier or transducer driver so I suspect the power sequencing will be all wrong.  It looks like these are mixer input controls which wouldn't
> >normally be widgets at all.

> The above selects the Sidetone onto left and right HP DAC output. Sidetone is not a mixer control.

What makes you say that the sidetone is not a mixer?  That's generally
exactly what a sidetone is - mixing an input into an output, usually
with a lot of attenuation.  What you're describing above just sounds
like a normal sidetone, why have you done these as output driver widgets?

> >> +       { "AMIC1Bias", NULL, "AMIC1"},
> >> +       { "Mic1_Input Capture Route", "MIC1", "AMIC1Bias"},

> >Your CODEC driver should not be connecting the microphone biases, the connections are board specific.

> The above Micbias is internal to codec. Please advice.

You're saying that the CODEC has a MEMS microphone built into it?

> >That memset is just going to mask warnings, it shouldn't be needed.

> OK.

Generally it's OK to just make updates in new versions without
explicitly commenting on each one, this makes it much easier to see
areas of your reply that are signifigant.

> >> +       snd_soc_write(codec, LM49453_P0_ADC_CLK_DIV_REG, val);
> >> +       snd_soc_write(codec, LM49453_P0_DAC_OT_CLK_DIV_REG, val);
> >> +       snd_soc_write(codec, LM49453_P0_DAC_HP_CLK_DIV_REG, val);

> >...and frankly I've no idea what this code is doing, I'd expect a clock divider configuration to vary depending on the >input clock as well as the sample rate.

> The 'val' is the clock divider value based on the sampling rate.

If these are clock dividers shouldn't they also depend on the input
clock?

> >> +       case 19000000:
> >> +               val = 0;
> >> +               break;
> >> +       case 48000:
> >> +       case 32576:
> >> +               val = 1;
> >> +               break;
> >> +       default:
> >> +               return -EINVAL;
> >> +       }

> >> +       snd_soc_update_bits(codec, LM49453_P0_PMC_SETUP_REG, BIT(4),
> >> + val);

> >I don't think this does what you think it does, your mask and value don't overlap at all.

> In the above _update_bits(), the LM49453_P0_PMC_SETUP_REG register's  4th bit is set, based on the 'val'. Please let me know, if something wrong there.

Please read what I wrote above.

> >> +       snd_soc_update_bits(dai->codec, LM49453_P0_DAC_DSP_REG, BIT(0),
> >> +                           (!!mute << 0));
> >> +       snd_soc_update_bits(dai->codec, LM49453_P0_DAC_DSP_REG, BIT(1),
> >> +                           (!!mute << 1));

> >Why are there two separate update bits operations here?

> For muting the HP left and right channels using BIT(0) and BIT(1).

That doesn't answer my question, my question was why there are two
*separate* update_bits() operations.
