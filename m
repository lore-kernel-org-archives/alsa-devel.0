From: lokowich <lokowich@acdstar.com>
Subject: Re: MPC5200 I2S driver for ASoC
Date: Wed, 01 Aug 2007 14:16:23 -0500
Message-ID: <46B0DC07.4050000@acdstar.com>
References: <46B0C3EE.5020401@acdstar.com> <46B0C89D.50704@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sentry.acdstar.com (mail.acdstar.com [209.98.244.9])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F713103826
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Aug 2007 21:28:50 +0200 (CEST)
Received: from MailerDaemon by sentry.acdstar.com with local-bsmtp (Exim 4.63)
	(envelope-from <lokowich@acdstar.com>) id 1IGJsH-0005Te-6n
	for alsa-devel@alsa-project.org; Wed, 01 Aug 2007 14:28:49 -0500
Received: from [192.168.2.3] (port=48158 helo=mail.acdstar.com)
	by sentry.acdstar.com with esmtp (Exim 4.63)
	(envelope-from <lokowich@acdstar.com>) id 1IGJsE-0005TV-7z
	for alsa-devel@alsa-project.org; Wed, 01 Aug 2007 14:28:46 -0500
In-Reply-To: <46B0C89D.50704@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



Timur Tabi wrote:
> lokowich wrote:
>   
>> I'm integrating a ALSA driver for an MPC5200 into the ASoC layer, 
>> similar to my successful effort for a PXA255 board.  
>>     
>
> Can you provide your code?  I'm working on ASoC support for another MPC SOC, so we need to 
> synchronize our development.
>   

    Yes, I presume you mean using git into the ALSA branch.  I need to
    get more familiar with git, and follow the appropriate coding
    conventions before it's ready.  Any guidance will be appreciated.

> I'm modeling the 
> DMA and ALSA interfaces per ac97mgt driver found in the Lite5200B BSP, 
> rather than the BestComm API example in the 2.4 kernel.  The 
> speaker-test with 400Hz sine wave is working, but has a slight audible 
> jitter.  A wav file output using aplay produces white noise.  
>   
>
> What kind of audio samples are you trying to play?  Since the MPC5200 is typically 
> big-endian, you probably can only play S16_BE samples instead of S16_LE samples.
>
>   

    Yes!  I had enabled the S16_BE format in my codec/i2s/pcm driver,
    but naively thought ALSA would handle the rest.  Converted my test
    file to S16_BE and it sounds much closer to the original.  Thanks!
    Found the "jitter" is due to a FIFO overflow.  I'm using same alarm
    (0x120) and granularity (4) common to 2.4 I2S and ac97 drivers.  Is
    there a more appropriate setting for 16-bit, 2-channel, 44.1kHz audio?

    Also, can we chat about SDRAM problems on 5200B outside of this forum?


This email was Anti Virus checked by Astaro Security Gateway. http://www.astaro.com
