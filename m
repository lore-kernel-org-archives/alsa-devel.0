From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: pointer callback in pcm
Date: Sat, 11 Mar 2006 15:42:57 +0000
Message-ID: <4412F001.5020404@superbug.co.uk>
References: <1141942882.10937.5.camel@localhost.localdomain>	 <1141952015.13319.90.camel@mindpipe>	 <1142020261.9246.3.camel@localhost.localdomain>	 <4412B17F.7080200@superbug.co.uk> <1142076452.9496.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1142076452.9496.8.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Adrian McMenamin wrote:
> On Sat, 2006-03-11 at 11:16 +0000, James Courtier-Dutton wrote:
>   
>> Adrian,
>>
>> Here is a quick summary of what I think you have been saying.
>> 1) Your hardware has min and max periods set to 8.
>> 2) Your hardware can do DMA, but not periodic DMA.   <- This is really 
>> the crux of the problem.
>> 3) You wish to use DMA.
>>     
>
> I really need to because transfers between the sound memory and the main
> memory are very slow otherwise. When I wrote the OSS driver for this a
> few years ago I simply copied stuff over, but it would effectively lock
> the machine up at high sample rates.
>   
The "problem" is that the DMA is not periodic, DMA itself is not the 
problem.
>   
>> 4) Unknown:  What triggers the audio interrupt? It should be triggered 
>> once each period is completed.
>>     
>
>
> This is done by the ARM7 spu that controls the sound output. I write the
> "firmware" for that so I have written some code that puts an IRQ on the
> SH4 (main CPU) bus every time a period has been played out.
>   
Can you get the "firmware" to initiate the DMA transfer, and then only 
IRQ the SH4 when the DMA completes?
>   
>> Now, here is what the ALSA model assumes:
>> 1) hardware period sizes are exactly the same size as the memory mapped 
>> DMA pages.
>>     
>
> I wasn't aware of that but I think I've done that anyway (4k period
> size)
>
>   
>> 2) snd_period_ellapsed() is called at periodic intervals dependent on 
>> where the ADC is playing samples.
>> 3) If the copy callback is NULL, ALSA assumes the DMA has already completed.
>> 4) If the copy callback is not NULL, ALSA calls it, but when the copy 
>> callback returns, the copy has been completed.
>>     
>
> I haven't got a copy callback - should I write one?
>   
You have to write one, but the ack() callback is probably more suitable 
in your case, if the period_ellapsed is called without the audio samples 
already being in main memory. (i.e. after the DMA is complete)
>   
>> 5) The pointer callback is then called that should return the position 
>> of the ADC in frames (not bytes) within the audio buffer.
>>
>> So, if you wish to use DMA, you should be calling snd_period_ellapsed() 
>> only after the DMA has completed, alternatively, the copy() callback 
>> should only return after the DMA transaction has completed, but I don't 
>> know if delaying the copy() return is allowed.
>> Can you get it to interrupt on each DMA completion?
>>
>>     
>
> In theory yes, but nobody seems have managed to reverse that bit of the
> spu function effectively yet, so I'd have to use polling on the progress
> of the transfer.
>   
>
>   
>> I would recommend you trying to do the following:
>> 1) Discover when the ADC has played the entire period.
>> 2) start the DMA transfer.
>> 3) At the DMA transfer complete interrrupt, call period_ellapsed().
>>
>> So, the problem might be how to discover that the ADC has played the 
>> entire period.
>>     
>
> I've got that covered (see above).
>
> How do I start? I am copying over 8 periods via DMA on the trigger, is
> that ok? (These are all I ever hear getting played). What about the ack
> callback that was recommended to me yesterday?
>
>   
>> You might have to use some sort of timer based polling to discover this.
>>
>> James
>>     

Some questions:
1) How does the main CPU discover the hardware pointer of the current 
ADC position? Needed for the pointer() callback.
2) Can you start and stop the samples being played?

Initialisation:
1) Wait for the application to fill 8 periods.  (you can simulate other 
periods models later if you wish. e.g You could simulate 2 periods to 
the application, even though you have 8 in hardware.)
2) The application will then call trigger to start playing the samples 
in the buffer.

I would recommend you try the following in the audio interrupt:
1) receive audio interrupt
2) start DMA transfer of one period.
    Which period you copy is the important bit here. At this point the 
hardware will have played 1 period, so you replace the period that has 
just played, not the period that is about to be played.
3) call snd_period_elapsed()
4) poll for DMA complete in the ack() callback.
5) period_elapsed will in turn call the pointer() callback.

James




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
