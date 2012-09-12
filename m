From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH] ASoC: codecs: Add DA9055 codec driver
Date: Wed, 12 Sep 2012 18:26:18 +0530
Message-ID: <1347454578.23366.305.camel@matrix>
References: <1347375823.12329.14.camel@matrix>
 <20120912025709.GD9162@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 78901261694
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 14:46:05 +0200 (CEST)
In-Reply-To: <20120912025709.GD9162@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, David Dajun Chen <david.chen@diasemi.com>, lrg <lrg@ti.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-09-12 at 10:57 +0800, Mark Brown wrote:
> > +/* Digital MIC clock rate select */
> > +static const char * const da9055_dmic_clk_rate_txt[] = {
> > +	"3MHz", "1.5MHz"
> > +};
> > +
> > +static const struct soc_enum da9055_dmic_clk_rate =
> > +	SOC_ENUM_SINGLE(DA9055_MIC_CONFIG, 2, 2, da9055_dmic_clk_rate_txt);
> > +
> > +/* Digital MIC sample phase select */
> > +static const char * const da9055_dmic_phase_txt[] = {
> > +	"Sample on DMICCLK edges", "Sample between DMICCLK edges"
> > +};
> > +
> > +static const struct soc_enum da9055_dmic_phase =
> > +	SOC_ENUM_SINGLE(DA9055_MIC_CONFIG, 1, 2, da9055_dmic_phase_txt);
> > +
> > +/* Digital MIC channel select */
> > +static const char * const da9055_dmic_channel_select_txt[] = {
> > +	"Rising Left Falling Right", "Falling Left Rising Right"
> > +};
> 
> Why is any of this being exposed to userspace?  If this should be
> configured I'd expect it to be static platform data, not something that
> gets changed at runtime.
> 

These parameters are exposed considering the fact that DMIC itself is
not part of the codec. Codec only provides DMIC interface using which an
external DMIC can be attached. These parameters depend on the actual
DMIC hardware and hence kept configurable to allow runtime plug in of
any DMIC hardware. Doesn't it make sense to keep them runtime
configurable?


> 
> > +	/* In slave mode, there is only one set of divisors */
> > +	if (!da9055->master)
> > +		fout = 2822400;
> 
> Should check the user supplied this value

Can you explain which value / user supplied value you are referring to?
It is not quite clear to me.

>  - also, what happens if the
> user sets the device to slave mode after setting up the PLL?

Will add required checks in set_fmt().

> > +	/* Enable Mic Bias */
> > +	snd_soc_write(codec, DA9055_MIC_BIAS_CTRL, DA9055_MIC_BIAS_EN);
> 
> DAPM for this and most of the rest of this funciton.

I guess here a DAPM_SUPPLY widget should be used and its routing should
be part of machine driver instead of this codec driver, right?

For other things like input mixers, Headphone and Lineouts, DAPM is
already used to control power specific bits. The confusion is because
there are two separate control bits for these blocks. One bit is for
"Enabling" that block and other is for "Enabling Amplifier" of that
block.
e.g for headphone, one bit is for "output enable" while other is for
"output amplifier enable".

Chip designers have confirmed that "Amplifier Enable" bits are ones
which should be used for power management. This is the reason why
"Enable" bits are being set in probe() and "Amplifier Enable" bits are
being taken care by DAPM. May be I need to put enough comments in code
to clarify this.
