From: Jason Fox <jfox@gai-tronics.com>
Subject: Channel swapping problem on Atmel SSC audio
Date: Thu, 17 Feb 2011 08:45:20 -0500
Message-ID: <1297950320.7194.57.camel@alice.bigman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exprod7og106.obsmtp.com (exprod7og106.obsmtp.com [64.18.2.165])
	by alsa0.perex.cz (Postfix) with SMTP id 0D841103918
	for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2011 14:47:13 +0100 (CET)
In-Reply-To: 16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE331@EXGMBX01.sasken.com
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
List-Id: alsa-devel@alsa-project.org

Hi Everyone,

This seems to be very similar to a problem I wrote about this morning
and i am wondering if a solution was found?

Thank you,
Jason Fox
GAI-Tronics
Reading PA

On 11/12/2010 10:52 PM, Irfan Shaikh wrote:
> I had faced the similar issue on IMx31. The cause there was reversal of LRCK clock {180 degree phase shift}.
> probing the LRCK clock may help you to find the problem
> 
> ________________________________________
> From: alsa-devel-bounces at alsa-project.org [alsa-devel-bounces at alsa-project.org] On Behalf Of Patrick Ziegler [patrick.ziegler at fh-kl.de]
> Sent: Friday, November 12, 2010 1:36 PM
> To: alsa-devel at alsa-project.org
> Cc: Ryan Mallon
> Subject: Re: [alsa-devel] Channel swapping problem on Atmel SSC audio
> 
> Am 11.11.2010 13:27, schrieb Alan Horstmann:
>> On Wednesday 10 November 2010 22:49, Ryan Mallon wrote:
>>
>>> I'm working on a custom board using the AT91SAM9G45 processor and a
>>> TLV320AIC26 SPI attached audio codec using I2S format audio. When doing
>>> audio playback on the board the left and right channels are occasionally
>>> flipped.
>>>
>> <snip>
>>
>>
>>> Has anybody else had this problem, or does anybody have any AT91/Atmel
>>> hardware that they could test to see if it occurs on other hardware also?
>>>
>> I have worked with the AT91SAM9260 on a project which is currently suspended
>> (other priorities), where we had a simiar problem, with a codec on SPI.
>> Every time audio was started (capture or playback) the channels could be
>> swapped.  Solving that issue remains TODO when we restart.
>>
>> There was a thread on alsa-devel last month 'Soc Atmel SSC stereo problem'
>> with some suggestions.

Okay, so it's not just me.

>>
> In the thread mentioned, Alan proposed me amongst other things to test
> the LRCK level before starting the SSC. This works well for me. Maybe it
> should be implemented in a more generic way but the following
> modification does the trick for me.
> 
> in function  atmel_pcm_trigger inside file sound/soc/atmel/atmel-pcm.c :
> 
> case SNDRV_PCM_TRIGGER_START:
> +while(!at91_get_gpio_value(AT91_PIN_PB12));
> +while(at91_get_gpio_value(AT91_PIN_PB12));
> 
> case SNDRV_PCM_TRIGGER_RESUME:
> +while(!at91_get_gpio_value(AT91_PIN_PB12));
> +while(at91_get_gpio_value(AT91_PIN_PB12));

This appears to work, or at least makes the problem much more rare. I'm
trying to understand if the problem is a silicon bug in the AT91
hardware, or if the DMA start code in the Atmel SoC driver is buggy.

I'm running with the CPU as the master (generating LRCLK and BCLK) and
testing with playback (so CPU is clocking the data out). The TCMR
register has the CKS field set to 0x4 (start on falling edge of LRCLK),
so the above loops should not be necessary. I suspect that the above fix
only makes the problem occur much less frequently, rather than fixing it
correctly?

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
*******************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom
they are addressed. If you have received this email in error please
notify the system manager. This footnote also confirms that this
email message has been swept for the presence of computer viruses.
www.Hubbell.com - Hubbell Incorporated**
