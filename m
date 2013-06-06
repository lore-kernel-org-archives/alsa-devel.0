From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH V2] ASoC: fsl: add imx-wm8962 machine driver
Date: Thu, 6 Jun 2013 12:39:20 +0800
Message-ID: <20130606043920.GA19094@MrMyself>
References: <1370420501-8410-1-git-send-email-b42378@freescale.com>
 <20130605115544.GX31367@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 by alsa0.perex.cz (Postfix) with ESMTP id CDE5F265505
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 06:57:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130605115544.GX31367@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: grant.likely@linaro.org, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Thanks you for the review. I'll revise the patch and send a [V3]

But please see my reply at some points.

On Wed, Jun 05, 2013 at 12:55:44PM +0100, Mark Brown wrote:
> > +- hp-det-gpios : The gpio port of Headphone detection.
> > +- mic-det-gpios: The gpio port of Micphone detection.
> 
> I'd say a bit more about these - obviously the CODEC has its own
> accessory detection here, and I rather suspect that in fact the HP
> detection you have there is really jack detection.
[Nic]: i.MX6 SabreSD board uses these two extra pins for jack detection.
You're exactly right that CODEC already has this function. But the hardware
guy of Freescale, who put the extra pins here, has his own reason that
Android needs not codec driver but machine driver to handle the detection and
use an event to report pin status to Android system. Well this event code
hasn't been included in this patch though. So since hardware has pins here,
I think it's better to put in the binding doc as well. But I guess it'd be
better to put it into OPTIONAL area?

> > +static int check_hw_params(struct snd_pcm_substream *substream,
> > +		snd_pcm_format_t sample_format, unsigned int sample_rate)
> > +{
> > +	struct imx_priv *priv = &card_priv;
> > +	struct device *dev = substream->pcm->card->dev;
> > +
> > +	substream->runtime->sample_bits =
> > +		snd_pcm_format_physical_width(sample_format);
> > +	substream->runtime->rate = sample_rate;
> > +	substream->runtime->format = sample_format;
> > +
> > +	if (!priv->first_stream) {
> > +		priv->first_stream = substream;
> > +	} else {
> > +		priv->second_stream = substream;
> > +
> > +		if (priv->first_stream->runtime->rate !=
> > +				priv->second_stream->runtime->rate) {
> > +			dev_err(dev, "KEEP THE SAME SAMPLE RATE: %d!\n",
> > +					priv->first_stream->runtime->rate);
> > +			return -EINVAL;
> > +		}
> > +		if (priv->first_stream->runtime->sample_bits !=
> > +				priv->second_stream->runtime->sample_bits) {
> > +			snd_pcm_format_t first_format =
> > +				priv->first_stream->runtime->format;
> > +
> > +			dev_err(dev, "KEEP THE SAME FORMAT: %s!\n",
> > +					snd_pcm_format_name(first_format));
> > +			return -EINVAL;
> > +		}
> > +	}
> 
> The sample rate checking can be done with the symmmetric_rates feature
> in the core.  The sample_bits check can't be but it's something that a
> lot of systems probably ought to have so it ought to be factored out
> into the core too rather than open coded in the driver.
[Nic:] fsl_ssi.c uses symmmetric_rates, but last time I traced soc-pcm.c
and found the core only cares about symmmetric_rates during pcm_open(),
which means the startup() in dai/machine driver, while what I'm considering
is something like "arecord -Dhw:0 -r 44100 | aplay -Dhw:0 -r 48000":
The two startup() would run almost at the same time and each of them would
be earlier than hw_param() -- the exact point we can get the sample rate
from application, but before this point no sample-rate actually be set to
make hw_constraint(). Then the two hw_param() would continue their code and
successively call set_fll() twice with different sample rates.
But I agree that it's kinda ugly to put code here. So I think maybe I need
to drop this part of code and to think about another patch for the core?


> > +		ret = snd_soc_dai_set_sysclk(codec_dai, WM8962_SYSCLK_MCLK,
> > +				data->clk_frequency, SND_SOC_CLOCK_IN);
> > +		if (ret < 0) {
> > +			dev_err(dev, "Failed to set SYSCLK: %d\n", ret);
> > +			return ret;
> > +		}
> > +
> > +		/* Disable FLL and let codec do pm_runtime_put() */
> > +		ret = snd_soc_dai_set_pll(codec_dai, WM8962_FLL, 0, 0, 0);
> > +		if (ret < 0) {
> > +			dev_err(dev, "Failed to disable FLL: %d\n", ret);
> > +			return ret;
> 
> You're enabling and disabling the CODEC only while there's an audio
> stream active.  This means that it's not possible to support analogue
> bypass paths (which the device can do) - you should probably also
> support enabling the FLL via set_bias_level() and use set_bias_level()
> to turn it off (which works in all cases).
[Nic] I've seen and tested set_bias_level() way as samsung/tobermory.c does.
But I find a flaw to the method that if I play two and more wav files like
'aplay -Dhw:0 audio44Khz.wav audio48Khz.wav audio22Khz.wav', which needs to
set_fll() before each playback and to keep SYSCLK valid by changing its source
to MCLK after the playback, but I only found that hw_param() and hw_free()
are symmetrically called before/after each playback in this case.
