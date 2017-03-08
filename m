From: Matthias Reichl <hias@horus.com>
Subject: Re: [PATCH] ASoC: bcm_2835: Simplify mono guard by
 returning error on mono
Date: Wed, 8 Mar 2017 12:33:28 +0100
Message-ID: <20170308113328.GA2545@delle.lan>
References: <1488970734-6596-1-git-send-email-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.horus.com (mail.horus.com [78.46.148.228])
 by alsa0.perex.cz (Postfix) with ESMTP id 1530026690D
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 12:33:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1488970734-6596-1-git-send-email-flatmax@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: alsa-devel@alsa-project.org, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Ray Jui <rjui@broadcom.com>, Lee Jones <lee@kernel.org>, phil@raspberrypi.org, Liam Girdwood <lgirdwood@gmail.com>, Eric Anholt <eric@anholt.net>, florian.kauer@koalo.de, broonie@kernel.org, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel@lists.infradead.org, Martin Sperl <kernel@martin.sperl.org>, ckeepax@opensource.wolfsonmicro.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 08, 2017 at 09:58:54PM +1100, Matt Flax wrote:
> This patch simplifies the bcm2835_i2s.c code when the driver returns
> error on mono channel requests. It does this by testing for mono
> instead of using a switch statement to test for stereo.
> 
> The bcm2835_i2s driver can only work in stereo mode. Whilst leaving
> the driver entirel compliant with the I2S protocol, it simplifies the
> code by removing a few redundant lines of code.
> 
> Signed-off-by: Matt Flax <flatmax@flatmax.org>

I'm against this, it removes the semantics that I2S can only do 2
channels from the code part. Without looking at the rest of the code
one could get the impression that bcm2835-i2s could support all
layouts except 1 channel.

so long,

Hias

> ---
>  sound/soc/bcm/bcm2835-i2s.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
> index 6ba2049..1e6a1da 100644
> --- a/sound/soc/bcm/bcm2835-i2s.c
> +++ b/sound/soc/bcm/bcm2835-i2s.c
> @@ -310,15 +310,16 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
>  	ch1pos = data_delay;
>  	ch2pos = bclk_ratio / 2 + data_delay;
>  
> -	switch (params_channels(params)) {
> -	case 2:
> -		format = BCM2835_I2S_CH1(format) | BCM2835_I2S_CH2(format);
> -		format |= BCM2835_I2S_CH1(BCM2835_I2S_CHPOS(ch1pos));
> -		format |= BCM2835_I2S_CH2(BCM2835_I2S_CHPOS(ch2pos));
> -		break;
> -	default:
> +	/* C
> +	 * Check we aren't setting channel 2 on a mono stream.
> +	 * We currently only support stereo
> +	 */
> +	if (params_channels(params) == 1)
>  		return -EINVAL;
> -	}
> +
> +	format = BCM2835_I2S_CH1(format) | BCM2835_I2S_CH2(format);
> +	format |= BCM2835_I2S_CH1(BCM2835_I2S_CHPOS(ch1pos));
> +	format |= BCM2835_I2S_CH2(BCM2835_I2S_CHPOS(ch2pos));
>  
>  	/*
>  	 * Set format for both streams.
> -- 
> 2.7.4
> 
