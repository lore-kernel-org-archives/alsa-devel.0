From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: ALSA sample rate conversion and general performance
 improvements.
Date: Wed, 29 Mar 2006 11:03:44 +0100
Message-ID: <442A5B80.3010706@superbug.co.uk>
References: <4429C5A4.7@superbug.co.uk> <s5hirpx6256.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hirpx6256.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 29 Mar 2006 00:24:20 +0100,
> James Courtier-Dutton wrote:
>   
>> Hi,
>>
>> I have had some conversations with various people regarding some general
>> problems some audio developers have with the current ALSA sound model.
>> One of the biggest problems with the current ALSA model is the sample
>> rate converters. When discussing them here some time ago, the problem
>> centered around the need for a timer interrupt being needed for the
>> application period boundaries, where the hardware might be running at
>> 48000Hz, and the application is trying to play a 44100Hz PCM stream.
>> This is essentially needed so that the poll() calls work in the
>> application correctly.
>>
>> Here is an idea on how to fix it and also slightly improve performance.
>> Some general aims:
>> 1) any ioport access to the sound card is slow and should be avoided
>> whenever possible.
>> 2) where to get the 44100Hz timer from if the hardware is doing 48000Hz.
>>
>> What about doing the following?:
>> We implement a general timer in the alsa core based on something like
>> gettimeofday(). I.e A high resolution timer.
>> Each time a period interrupt happens, the current hw pointer is read,
>> and recorded along with the current value of the timer.
>> This could be used a bit like NTP to correct the generally timer rate.
>> This gives us a general high resolution timer corrected to mirror the
>> PCM clock on the sound card.
>> Then, from this high resolution timer, we could derive any rate
>> interrupt we need for really excellent sample rate conversion, and sub
>> sample accurate DAC/ADC positioning.
>> One could then read the DAC/ADC positioning really quickly by just
>> reading the high resolution timer, instead of accessing IO Ports on the
>> sound card hardware.
>> This would also be a fairly minor change, as none of the current kernel
>> sound card hw drivers would need changing. We would just have to
>> slightly modify the period_elapsed callback to do a gettimeofday() call
>> as well as it's current hw_pointer read.
>>
>> If we then made the correction factor for the high resolution timer
>> available to user space, user space would then not even need to read the
>> current hw position, as it could perfectly predict it itself using the
>> gettimeofday() and correction factor.
>>
>> This would reduce the amount of calls to the read_hw_pointer function in
>> the low level sound card hardware driver, and therefore improve performance.
>>
>> Any comments?
>>     
>
> I've had the very same idea about using the timer for the update
> source, especially for sample rate conversion although my point isn't
> the performance gain by avoiding IO read.
>
> My idea is to make the system choose arbitrary irq sources, e.g. the
> period irq, timer irq, etc.  The default is the period irq, or
> whatever the driver provides.  But, the app or alsa-lib can switch to
> a suitable one.
>
> In the case of timer irq, it's not necessarily a constant period.  You
> can tweak the period appropriately by adjusting the pace using a
> software PLL.  This would require read of hwptr as well as the normal
> update, but it's necessary to get the stream sync with the soundcard
> time.  If you don't refer to the hw ptrs, you'll get a significant
> drift in a long run.
>
>
> Takashi
>
>   

I agree, the irq source itself does not actually matter. just access the 
hw_ptr on each irq is all we need.
I think that accessing the hw_ptr once per period is perfectly Ok from a 
performance perspective, but any more than that is unnecessary. One 
could even do it once per buffer period without any serious loss of 
accuracy.
This approach would also reduce the amount of task switching because we 
could then have a userspace timer triggering events by simply using 
nanosleep().
The timer irqs would simply be for calculating the correction factor to 
gettimeofday() (get it in sync with the audio hardware clock), and could 
work asynchronously from the userspace timer triggering events.

James

 


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
