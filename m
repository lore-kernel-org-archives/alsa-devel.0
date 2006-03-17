From: Carlos Munoz <carlos@kenati.com>
Subject: Re: Couple of questions
Date: Thu, 16 Mar 2006 16:10:04 -0800
Message-ID: <4419FE5C.6080903@kenati.com>
References: <1142467271.9298.7.camel@localhost.localdomain>	 <s5hirqer7r5.wl%tiwai@suse.de> <1142543316.9236.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 360001BB
	for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2006 01:04:44 +0100 (MET)
Received: from mail.kenati.com (unknown [69.90.147.196])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id 7017A993DE
	for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2006 01:04:43 +0100 (MET)
In-Reply-To: <1142543316.9236.1.camel@localhost.localdomain>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adrian McMenamin wrote:

>On Thu, 2006-03-16 at 11:42 +0100, Takashi Iwai wrote:
>  
>
>>At Thu, 16 Mar 2006 00:01:11 +0000,
>>Adrian McMenamin wrote:
>>    
>>
>>>If my driver declares this:
>>>
>>>	.info = (SNDRV_PCM_INFO_NONINTERLEAVED),
>>>
>>>Can I expect samples to come in all left followed by all right, or how?
>>>      
>>>
>>Yes.  It's the non-interleaved format (LLLLLLLL....RRRRRR.....).
>>
>>    
>>
>>>And will cat somefile.wav > /dev/dsp using oss emulation respect that?
>>>      
>>>
>>Yes.
>>
>>    
>>
>>>And what default frequency can I expect cat to use in the above?
>>>      
>>>
>>ALSA has no default frequency.  OSS assumes 8kHz for /dev/audio.
>>/dev/dsp has no default, IIRC, but practically 44.1kHz.
>>
>>So "cat some > /dev/dsp" is not a good way for testing at all...
>>It's usable for checking that "something" works at least, but not for
>>checking the detailed functionality.
>>    
>>
>
>
>Thanks. My problem is I cannot get the alsa utilities to compile/work
>(they compile but seg fault on use). Is there a good OSS only app I can
>use to test the basic play stuff?
>
>
>  
>
Hi Adrian,

Unfortunately, I can't offer any help. I am doing exactly what you are 
doing to test my alsa driver. I'm also using /dev/dsp. However, what I 
noticed when cat'ing a wav file to /dev/dsp is that the 
snd_xxx_playback_pointer() function only gets called for a short while 
and then it's no called any more. The dma buffer is only partially 
filled. The driver is not aware of this and just wraps around the buffer 
repeating the sound data over and over. I compiled aplay with no X 
support (command line only) but can't get it to work. So now I'm in the 
middle of writing a light alsa application to test the driver. I hope to 
have something by tomorrow at the latest. If I ever get it to work I can 
send it to you if you are interested.

Thanks,


Carlos


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
