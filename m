From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch] tlv320aic3x: disable ADC/DAC
	while	changing clock
Date: Mon, 30 Mar 2009 13:51:47 +0100
Message-ID: <20090330125147.GD31781@sirena.org.uk>
References: <1238073706-23821-1-git-send-email-dg@emlix.com>
	<20090326134528.GC3771@sirena.org.uk> <49D0BF89.4050100@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 90A30103807
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Mar 2009 14:51:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <49D0BF89.4050100@emlix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Gl?ckner <dg@emlix.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 30, 2009 at 02:48:09PM +0200, Daniel Gl?ckner wrote:
> On 03/26/2009 02:45 PM, Mark Brown wrote:

> > Could you go into more detail on why you believe that this is the case?
> > The DACs and ADCs won't be operational when the bias is held at standby
> > which means that at most standby needs to wait for them to go idle.

> This is based on the fact that soc_pcm_prepare calls
> snd_soc_dapm_stream_event(..., SND_SOC_DAPM_STREAM_START) before
> snd_soc_dapm_set_bias_level(..., SND_SOC_BIAS_ON).

So enable the PLL on BIAS_PREPARE?  That's probably more correct anyway.

> In addition there is a block of code in tlv320aic3x.c that explicitly disables
> the ADC/DAC in SND_SOC_BIAS_OFF. It may be superfluous, though.

Yes, all that code is redundant - all the widgets will be powered down
before the bias is removed.

> >> +static u8 aic3x_power_codec(struct snd_soc_codec *codec, u8 new)
> >> +{

> > This really needs some comments explaining what it's doing; it's not
> > really clear what effect it's trying to achieve or how it interacts with
> > DAPM.

> This function takes a bitmask of the desired power state of the ADC/DAC blocks
> and configures the device accordingly. It returns a bitmask of the previous
> power state, suitable for input.

"Suitable for input"?  Like I say, there need to be way more comments in
the code.
