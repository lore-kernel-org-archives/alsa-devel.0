From: Tyson Whitehead <twhitehe@uwo.ca>
Subject: Re: [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Tue, 18 Mar 2008 10:16:58 -0400
Message-ID: <47DFCEDA.2020307@uwo.ca>
References: <20080314131344.62A59DBA2@gherkin.frus.com>
	<200803142118.31974.twhitehe@uwo.ca> <s5hskypnwp8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from uwo.ca (v320-147-lb.its.uwo.ca [129.100.74.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D36D10386F
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 15:16:40 +0100 (CET)
Received: from zeppo.mail.uwo.pri (salk.mail.uwo.pri [172.29.32.41])
	by zeppo.mail.uwo.pri
	(Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007;
	32bit)) with ESMTP id <0JXX00H5TJNRY900@zeppo.mail.uwo.pri> for
	alsa-devel@alsa-project.org; Tue, 18 Mar 2008 10:16:39 -0400 (EDT)
Received: from [192.168.1.103] ([129.100.171.21])
	by zeppo.mail.uwo.pri (Sun Java(tm) System Messaging Server 6.3-3.01
	(built Jul 12 2007;
	32bit)) with ESMTPSA id <0JXX00H4KJNQPV20@zeppo.mail.uwo.pri> for
	alsa-devel@alsa-project.org; Tue, 18 Mar 2008 10:16:39 -0400 (EDT)
In-reply-to: <s5hskypnwp8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Michael Cree <mcree@orcon.net.nz>, Krzysztof Helt <krzysztof.h1@wp.pl>, Rene Herman <rene.herman@keyaccess.nl>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Fri, 14 Mar 2008 21:18:19 -0400,
> 
>>  Even 
>> then, though, I believe it still only works in 8bit mode.
> 
> Maybe the problem is in a different place, then...

It certainly doesn't work at all without it.  It is definetly not 
managing to figure out that the generated interupt is for itself.

> ---
> 
> diff -r 82e6201fc907 sound/isa/es18xx.c
> --- a/sound/isa/es18xx.c	Mon Mar 17 14:36:24 2008 +0100
> +++ b/sound/isa/es18xx.c	Mon Mar 17 17:32:59 2008 +0100
> @@ -765,9 +765,10 @@ static irqreturn_t snd_es18xx_interrupt(
>  		/* Read Interrupt status */
>  		status = snd_es18xx_mixer_read(chip, 0x7f) >> 4;
>  	}
> -#if 0
> -	else {
> -		status = 0;
> +
> +#ifdef CONFIG_ALPHA
> +	if (!(status & (AUDIO1_IRQ | AUDIO2_IRQ))) {
> +		/* status = 0; */
>  		if (inb(chip->port + 0x0C) & 0x01)
>  			status |= AUDIO1_IRQ;
>  		if (snd_es18xx_mixer_read(chip, 0x7A) & 0x80)
> @@ -777,7 +778,6 @@ static irqreturn_t snd_es18xx_interrupt(
>  			status |= HWV_IRQ;
>  	}
>  #endif
> -
>  	/* Audio 1 & Audio 2 */
>          if (status & AUDIO2_IRQ) {
>                  if (chip->active & DAC2)

This looks like it should accomplish the same thing (assuming not bits 
get set in status on the initial attempt to read it), without affecting 
other platforms and possible the alpha if anyone has a card that just 
works for whatever reason.  A better patch all around.  : )

Cheers!  -Tyson

PS:  I've managed to recover my disks, and the machine is compiling 
2.25-rc5 even as I write.
