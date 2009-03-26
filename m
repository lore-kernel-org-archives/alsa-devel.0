From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch] tlv320aic3x: disable ADC/DAC
	while	changing clock
Date: Thu, 26 Mar 2009 13:45:29 +0000
Message-ID: <20090326134528.GC3771@sirena.org.uk>
References: <1238073706-23821-1-git-send-email-dg@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 09956103857
	for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2009 14:45:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1238073706-23821-1-git-send-email-dg@emlix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Gl??ckner <dg@emlix.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 26, 2009 at 02:21:46PM +0100, Daniel Gl??ckner wrote:
> While using a tlv320aic3101 as a clock master, it often happened that the
> clock lines got stuck while changing the sampling rate. In a discussion
> with TI technical support it was suggested to shut down the ADC and DAC
> while there are changes being made to the clock.

> Following that rule resolves the problem, but merely writing the
> registers to switch the ADC/DAC off is not enough. One needs to poll the
> power status registers to wait until they have completely shut down.

> The aforementioned rule implies that we can not disable the PLL in
> stand-by bias level.

Could you go into more detail on why you believe that this is the case?
The DACs and ADCs won't be operational when the bias is held at standby
which means that at most standby needs to wait for them to go idle.

In any case, it's looking more and more like the driver should just
implement a set_pll() operaton here...

> +static u8 aic3x_power_codec(struct snd_soc_codec *codec, u8 new)
> +{

This really needs some comments explaining what it's doing; it's not
really clear what effect it's trying to achieve or how it interacts with
DAPM.

> @@ -749,9 +800,11 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
>  	struct snd_soc_codec *codec = socdev->codec;
>  	struct aic3x_priv *aic3x = codec->private_data;
>  	int codec_clk = 0, bypass_pll = 0, fsref, last_clk = 0;
> -	u8 data, r, p, pll_q, pll_p = 1, pll_r = 1, pll_j = 1;
> +	u8 data, r, p, pll_q, pll_p = 1, pll_r = 1, pll_j = 1, state_saved;
>  	u16 pll_d = 1;
>  
> +	state_saved = aic3x_power_off_wait(codec);
> +

This appears to unconditionally power off the DAC and ADC when setting
parameters - I'd expect that to cause issues with simultaneous record
and playback, even for completely symmetric configurations where there's
no actual change in configuration being made.  It'd be better to check
to see if a change is being requested while the device is operational
and refuse to reconfigure if that is the case.

>  	if (last_clk == 0) {
>  		printk(KERN_ERR "%s(): unable to setup PLL\n", __func__);
> +		aic3x_power_codec(codec, state_saved);
>  		return -EINVAL;

This looks wrong - if the configuration is known broken then I'd expect
that it'd be safer to leave things powered off.
