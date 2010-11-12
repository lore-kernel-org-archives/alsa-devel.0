From: Patrick Ziegler <patrick.ziegler@fh-kl.de>
Subject: Re: Channel swapping problem on Atmel SSC audio
Date: Fri, 12 Nov 2010 09:06:10 +0100
Message-ID: <4CDCF572.9050808@fh-kl.de>
References: <4CDB217E.2030906@bluewatersys.com>
	<201011111227.09633.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from post.fh-kl.de (post.fh-kl.de [143.93.17.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E4891038DF
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 09:06:17 +0100 (CET)
In-Reply-To: <201011111227.09633.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Ryan Mallon <ryan@bluewatersys.com>
List-Id: alsa-devel@alsa-project.org



Am 11.11.2010 13:27, schrieb Alan Horstmann:
> On Wednesday 10 November 2010 22:49, Ryan Mallon wrote:
>    
>> I'm working on a custom board using the AT91SAM9G45 processor and a
>> TLV320AIC26 SPI attached audio codec using I2S format audio. When doing
>> audio playback on the board the left and right channels are occasionally
>> flipped.
>>      
> <snip>
>
>    
>> Has anybody else had this problem, or does anybody have any AT91/Atmel
>> hardware that they could test to see if it occurs on other hardware also?
>>      
> I have worked with the AT91SAM9260 on a project which is currently suspended
> (other priorities), where we had a simiar problem, with a codec on SPI.
> Every time audio was started (capture or playback) the channels could be
> swapped.  Solving that issue remains TODO when we restart.
>
> There was a thread on alsa-devel last month 'Soc Atmel SSC stereo problem'
> with some suggestions.
>
>    
In the thread mentioned, Alan proposed me amongst other things to test 
the LRCK level before starting the SSC. This works well for me. Maybe it 
should be implemented in a more generic way but the following 
modification does the trick for me.

in function  atmel_pcm_trigger inside file sound/soc/atmel/atmel-pcm.c :

case SNDRV_PCM_TRIGGER_START:
+while(!at91_get_gpio_value(AT91_PIN_PB12));
+while(at91_get_gpio_value(AT91_PIN_PB12));

case SNDRV_PCM_TRIGGER_RESUME:
+while(!at91_get_gpio_value(AT91_PIN_PB12));
+while(at91_get_gpio_value(AT91_PIN_PB12));

Patrick

-- 

Dipl.-Inf. (FH) Patrick Ziegler

University Of Applied Sciences
Kaiserslautern

Amerikastrasse 1
D-66482 Zweibruecken
Germany

Phone:	+49 631 3724 5526
Mail:	patrick.ziegler@fh-kl.de

http://www.fh-kl.de
http://www.fh-kl.de/fachbereiche/imst/iuk-knowhow.html
