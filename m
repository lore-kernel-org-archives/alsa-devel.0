From: Simon Ho <simon.ho.cnxt@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: Add driver for CX2092X I2S Audio
	DSP
Date: Mon, 20 Feb 2017 10:33:32 +0800
Message-ID: <20170220023332.GB24076@GMAIL.COM>
References: <1487427991-18174-3-git-send-email-simon.ho@conexant.com>
 <20170219162717.kwbeapezjjpcp6br@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B293266AD4
 for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2017 03:33:37 +0100 (CET)
Received: by mail-pg0-f66.google.com with SMTP id a123so8145407pgc.3
 for <alsa-devel@alsa-project.org>; Sun, 19 Feb 2017 18:33:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170219162717.kwbeapezjjpcp6br@sirena.org.uk>
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
Cc: Simon Ho <simon.ho@conexant.com>, alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 19, 2017 at 04:27:17PM +0000, Mark Brown wrote:
> On Sat, Feb 18, 2017 at 10:26:31PM +0800, simon.ho.cnxt@gmail.com wrote:
> 
> > +static const struct snd_kcontrol_new cx2092x_snd_controls[] = {
> > +	CX2092X_CONTROL("SendCmd", cmd_info, cmd_get, cmd_put,
> > +		SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_WRITE|
> > +		SNDRV_CTL_ELEM_ACCESS_VOLATILE),
> 
> This is just tunnels commands from some magic userspace application
> straight through to the device, taking all the control out of standard
> Linux.  What are these controls doing and why aren't we managing them
> through standard interfaces?  This tends to end up creating problems
> with things like power management as for example userspace might not
> figure out that things like suspend and resume are happening.
> 

This device is designed for virtual assisant application need to be always
open, listening for users to summon it. There is no any power saving mode 
support on this device. The processed voice data will be sent to automatic 
speech recognition (ASR) application for further processing and the
processed voice data will be optimized for ASR rather than a human being.
So such as mute and volume gain control are not necessary. These tunnels 
commands are actucally for debugging purpose only, they won't be used on
normal operation.  

> > +static int cx2092x_reset(struct snd_soc_codec *codec)
> > +{
> > +	struct cx2092x_priv *cx2092x = snd_soc_codec_get_drvdata(codec);
> > +
> > +	if (gpio_is_valid(cx2092x->gpio_reset)) {
> > +		gpio_set_value(cx2092x->gpio_reset, 0);
> > +		mdelay(10);
> > +		gpio_set_value(cx2092x->gpio_reset, 1);
> 
> Use the _cansleep() versions unless you've got a good reason not to,
> that way GPIOs on slow buses can be used.
> 

Thanks for input, I changed it to _cansleep() version.

> > +	if (of_match_device(cx2092x_dt_ids, dev))
> > +		cx2092x->gpio_reset =
> > +			of_get_named_gpio(dev->of_node, "reset-gpio", 0);
> 
> Why do we care if we managed to match the device ID?  The GPIO is
> optional anyway.  It's also better to use the gpiod_ APIs if you can,
> that's more modern and removes the need to special case DT.
> 

No, we don't need to care the deivce ID. Remved.

Learned, will use gpiod_ APIs instead.

> > +	if (gpio_is_valid(cx2092x->gpio_reset)) {
> > +		int ret;
> 
> Don't declare variables in the middle of functions.

Understood. corrected it.
