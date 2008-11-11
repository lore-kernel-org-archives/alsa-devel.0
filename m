From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ALSA SOC driver for s3c24xx with uda1341
Date: Tue, 11 Nov 2008 10:39:32 +0000
Message-ID: <20081111103931.GA7019@sirena.org.uk>
References: <12261302352402-git-send-email-chripell@gmail.com>
	<20081110133451.GD12804@sirena.org.uk>
	<cabda6420811101104l823d519i8dca6feac86cfa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E95C91037F8
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 11:39:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <cabda6420811101104l823d519i8dca6feac86cfa@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: chri <chripell@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk, zdevai@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 10, 2008 at 08:04:49PM +0100, chri wrote:
> On Mon, Nov 10, 2008 at 2:34 PM, Mark Brown <broonie@sirena.org.uk> wrote:

> ack. I was tempted to use pr_debug (and even better dev_dbg) but I
> went for the old printk method for uniformity with the rest of the
> drivers.

If you work with current git you'll see that the other drivers have been
converted to pr_debug().

> >> +SOC_SINGLE("DAC Gain switch", UDA1341_STATUS1, 6, 1, 0),
> >> +SOC_SINGLE("ADC Gain switch", UDA1341_STATUS1, 5, 1, 0),

> > What exactly do these controls do?  "Gain switch" sounds wrong - I'd not
> > expect the gain to be a boolean.

> they turn on/off an amplifier with 6db gain in the record and playback
> respectively.

Should be "ADC +6dB Switch" or similar then.

> >> +static int s3c24xx_uda1341_hw_params(struct snd_pcm_substream *substream,
> >> +                                       struct snd_pcm_hw_params *params)
> >> +{

> > I can follow this function but it'd be nice to see more comments in
> > here.  It looks like you could clarify it by iterating over a table of
> > possible clock sources rather than writing each out in code.

> unfortunately the 2 clock sources are handled differently: PCLK can be
> divided, MPLL_in no. So I don't see much convenience in using a
> (complicated) table

A pointer to a table of dividers would handle it.  In any case, it needs
more comments.

> >> +     ret = cpu_dai->dai_ops.set_sysclk(cpu_dai, clk_source , clk,
> >> +                                             SND_SOC_CLOCK_IN);
> >> +     if (ret < 0)
> >> +             return ret;

> > You want to run this through scripts/checkpatch.pl.

> I already did it

I'd have expected checkpatch to catch the extra space you've got after
clk_source there...

> >> +static void s3c24xx_uda1341_power(int en)
> >> +{
> >> +     if (s3c24xx_uda1341_l3_pins->power)
> >> +             s3c24xx_uda1341_l3_pins->power(en);
> >> +}

> > This feels like it ought to be initialised conditionally rather than
> > having the check for the pin it.

> It's not clear to me what you mean here.

This function is going to be used in a vtable where IIRC it can be
optional but it needs to check the value of power in s3c24xx_uda1341_l3_pins.
It feels like you've got too many layers of indirection here and that,
for example, the l3_pins power should be assignable directly to the
vtable.
