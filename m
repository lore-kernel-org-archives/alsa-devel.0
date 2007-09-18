From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: Re: [PATCH] ad1838/cs4231 -- fix MCE timeout upon
 initial load
Date: Tue, 18 Sep 2007 10:02:46 +0200
Message-ID: <20070918100246.6cd37e1b.krzysztof.h1@gmail.com>
References: <46E58D01.9080809@gmail.com>
	<Pine.LNX.4.58.0709170325380.27377@shell4.speakeasy.net>
	<46EF18FF.7070906@gmail.com>
	<Pine.LNX.4.58.0709171757500.27377@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DFB224462
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 09:55:23 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id b21so1193419nfd
	for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2007 00:55:22 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.58.0709171757500.27377@shell4.speakeasy.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: Takashi Iwai <tiwai@suse.de>, devel <alsa-devel@alsa-project.org>, ALSA@alsa-project.org, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 17 Sep 2007 19:32:11 -0700 (PDT)
Trent Piepho <xyzzy@speakeasy.org> wrote:

> 
> The polling loop to check for ACI to go down was more convoluted than it
> needed to be.  New loop should be more efficient and it is a lot simpler.  The
> old loop checked for a timeout before checking for ACI down, which could
> result in an erroneous timeout.  It's only a failure if the timeout expires
> _and_ ACI is still high.  There is nothing wrong with the timeout expiring
> while the task is sleeping if ACI went low.
> 

This was already fixed by Rene's patch. You only simplified it.

> A polling loop to check for the device to leaving INIT mode is removed.  The
> device must have already left init for the previous ACI loop to have finished.
> 
> Signed-off-by: Trent Piepho <xyzzy@speakeasy.org>
> 
> diff -r ec96283a273f isa/ad1848/ad1848_lib.c
> --- a/isa/ad1848/ad1848_lib.c	Mon Sep 17 19:20:48 2007 -0700
> +++ b/isa/ad1848/ad1848_lib.c	Mon Sep 17 19:22:36 2007 -0700
> @@ -203,9 +203,8 @@ static void snd_ad1848_mce_up(struct snd
>  
>  static void snd_ad1848_mce_down(struct snd_ad1848 *chip)
>  {
> -	unsigned long flags;
> -	int timeout;
> -	unsigned long end_time;
> +	unsigned long flags, timeout;
> +	int regsel;
>  
>  	spin_lock_irqsave(&chip->reg_lock, flags);
>  	for (timeout = 5; timeout > 0; timeout--)
> @@ -222,50 +221,34 @@ static void snd_ad1848_mce_down(struct s
>  #endif
>  
>  	chip->mce_bit &= ~AD1848_MCE;
> -	timeout = inb(AD1848P(chip, REGSEL));
> -	outb(chip->mce_bit | (timeout & 0x1f), AD1848P(chip, REGSEL));
> -	if (timeout == 0x80)
> +	regsel = inb(AD1848P(chip, REGSEL));
> +	outb(chip->mce_bit | (regsel & 0x1f), AD1848P(chip, REGSEL));
> +	if (regsel == 0x80)
>  		snd_printk(KERN_WARNING "mce_down [0x%lx]: serious init problem - codec still busy\n", chip->port);
> -	if ((timeout & AD1848_MCE) == 0) {
> +	if ((regsel & AD1848_MCE) == 0) {
>  		spin_unlock_irqrestore(&chip->reg_lock, flags);
>  		return;
>  	}
>  
>  	/*
> -	 * Wait for (possible -- during init auto-calibration may not be set)
> -	 * calibration process to start. Needs upto 5 sample periods on AD1848
> -	 * which at the slowest possible rate of 5.5125 kHz means 907 us.
> +	 * Wait for auto-calibration (AC) process to finish, i.e. ACI to go low.
> +	 * It may take up to 5 sample periods (at most 907 us @ 5.5125 kHz) for
> +	 * the process to _start_, so it is important to wait at least that long
> +	 * before checking.  Otherwise we might think AC has finished when it
> +	 * has in fact not begun.  It should take 128 (no AC) or 384 (AC) cycles
> +	 * for ACI to drop.  This gives a wait of at most 70 ms with a more
> +	 * typical value of 3-9 ms.
>  	 */
> -	spin_unlock_irqrestore(&chip->reg_lock, flags);
> -	msleep(1);
> -	spin_lock_irqsave(&chip->reg_lock, flags);
> -
> -	snd_printdd("(2) jiffies = %lu\n", jiffies);
> -
> -	end_time = jiffies + msecs_to_jiffies(250);
> -	while (snd_ad1848_in(chip, AD1848_TEST_INIT) & AD1848_CALIB_IN_PROGRESS) {
> +	timeout = jiffies + msecs_to_jiffies(250);
> +	do {
>  		spin_unlock_irqrestore(&chip->reg_lock, flags);
> -		if (time_after(jiffies, end_time)) {
> -			snd_printk(KERN_ERR "mce_down - auto calibration time out (2)\n");
> -			return;
> -		}
>  		msleep(1);
>  		spin_lock_irqsave(&chip->reg_lock, flags);
> -	}
> -
> -	snd_printdd("(3) jiffies = %lu\n", jiffies);
> -
> -	end_time = jiffies + msecs_to_jiffies(100);
> -	while (inb(AD1848P(chip, REGSEL)) & AD1848_INIT) {
> -		spin_unlock_irqrestore(&chip->reg_lock, flags);
> -		if (time_after(jiffies, end_time)) {
> -			snd_printk(KERN_ERR "mce_down - auto calibration time out (3)\n");
> -			return;
> -		}
> -		msleep(1);
> -		spin_lock_irqsave(&chip->reg_lock, flags);
> -	}
> -	spin_unlock_irqrestore(&chip->reg_lock, flags);
> +		regsel = snd_ad1848_in(chip, AD1848_TEST_INIT);
> +	} while ((regsel & AD1848_CALIB_IN_PROGRESS) && time_before(jiffies, timeout));

Break this long line. You may calculate "regsel & AD1848_CALIB_IN_PROGRESS"
inside the loop and use it in the condition outside the loop too.

Regards,
Krzysztof
