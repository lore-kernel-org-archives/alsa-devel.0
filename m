From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] cs4231-lib: replace common delay loop by
 function
Date: Wed, 05 Sep 2007 00:37:01 +0200
Message-ID: <46DDDE0D.7070904@gmail.com>
References: <20070904184927.0bb3bc7c.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 515EB24472
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Sep 2007 00:43:25 +0200 (CEST)
In-Reply-To: <20070904184927.0bb3bc7c.krzysztof.h1@wp.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/04/2007 06:49 PM, Krzysztof Helt wrote:

> +static void snd_cs4231_ready(struct snd_cs4231 *chip)
>  {
>  	int timeout;
> -	unsigned char tmp;
>  
>  	for (timeout = 250;
>  	     timeout > 0 && (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT);
>  	     timeout--)
>  	     	udelay(100);
> +}
> +

Would you terribly mind calling this snd_cs4231_wait() or something close?

> +static void snd_cs4231_outm(struct snd_cs4231 *chip, unsigned char reg,
> +			    unsigned char mask, unsigned char value)
> +{
> +	unsigned char tmp = (chip->image[reg] & mask) | value;
> +
> +	snd_cs4231_ready(chip);
>  #ifdef CONFIG_SND_DEBUG
>  	if (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
>  		snd_printk("outm: auto calibration time out - reg = 0x%x, value = 0x%x\n", reg, value);
>  #endif
> -	if (chip->calibrate_mute) {
> -		chip->image[reg] &= mask;
> -		chip->image[reg] |= value;
> -	} else {
> +	if (!chip->calibrate_mute) {
>  		cs4231_outb(chip, CS4231P(REGSEL), chip->mce_bit | reg);
> -		mb();
> -		tmp = (chip->image[reg] & mask) | value;
> +		wmb();
>  		cs4231_outb(chip, CS4231P(REG), tmp);
> -		chip->image[reg] = tmp;
>  		mb();
>  	}
> +	chip->image[reg] = tmp;
>  }

Mmm, for the ! case, the chip->image[reg] = tmp is now after the mb() -- but 
that's okay right?

Rene
