From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 002/002] ASoC: Replace max98090 Device
	Driver
Date: Fri, 25 Jan 2013 15:21:38 +0800
Message-ID: <20130125072131.GA6403@opensource.wolfsonmicro.com>
References: <A453F1AE3B5DC14DB19666C506CE75A7108684F403@ITSVLEX06.it.maxim-ic.internal>
 <A453F1AE3B5DC14DB19666C506CE75A7108684F4C7@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 45A8F26159D
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2013 08:27:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <A453F1AE3B5DC14DB19666C506CE75A7108684F4C7@ITSVLEX06.it.maxim-ic.internal>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerry Wong <Jerry.Wong@maximintegrated.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "jwong@jwassociates.com" <jwong@jwassociates.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 24, 2013 at 03:28:54PM -0800, Jerry Wong wrote:

> This is an odd control that is a combination of an enum and a power
> management widget. The 0 value of the enum  turns power off.
> Not sure what is another choice. The enum value needs to be
> saved so it can be restored when DAPM turns the control on.

That doesn't appear to be what your control actually does - what happens
if someone writes ot the control while the widget is powered down?

> > +static const struct snd_kcontrol_new max98090_snd_controls[] = {
> > +       SOC_SINGLE("MIC Bias VCM Bandgap", M98090_REG_BIAS_CNTL,
> > +               M98090_VCM_MODE_SHIFT, M98090_VCM_MODE_NUM - 1, 0),

> > Why is this a user visible control?

> It is not controlled by DAPM. The low power function is taken care of by
> /SHDN\, so this retains the user choice of bandgap or divider reference.

Why would the user want this choice?

> > +static int max98090_runtime_resume(struct device *dev)
> > +{
> > +       struct max98090_priv *max98090 = dev_get_drvdata(dev);
> > +
> > +       regcache_cache_only(max98090->regmap, false);
> > +
> > +       max98090_reset(max98090);
> > +
> > +       regcache_sync(max98090->regmap);

> > Do you really need to reset the device here?  If anything I'd expect it
> > on suspend since the reset state is probably the lowest power state.

> Yes, for a soft reset where the device is not power cycled, DAPM has
> the device go in and out of the low power /SHDN\ state, and the old
> register values are retained. Without this, we would need to specify
> that the PMIC power cycle the chip.

This doesn't really answer my questions.  Why would it matter if the
PMIC has power cycled the chip, and if you do need to do this why is
resume the time to do it?
