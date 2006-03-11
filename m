From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: pointer callback in pcm
Date: Sat, 11 Mar 2006 19:15:53 +0000
Message-ID: <441321E9.1050503@superbug.co.uk>
References: <1141942882.10937.5.camel@localhost.localdomain>	 <1141952015.13319.90.camel@mindpipe>	 <1142020261.9246.3.camel@localhost.localdomain>	 <4412B17F.7080200@superbug.co.uk>	 <1142076452.9496.8.camel@localhost.localdomain>	 <4412F001.5020404@superbug.co.uk>	 <1142098225.9496.25.camel@localhost.localdomain>	 <44131B40.9080100@superbug.co.uk> <1142104084.9496.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1142104084.9496.34.camel@localhost.localdomain>
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
>> You will need to set the .buffer_bytes_min as well.
>>
>>     
>
> To what value? 1 or 32768?
>
>   
32768
>> 2)
>> static snd_pcm_uframes_t snd_aicapcm_pcm_pointer(snd_pcm_substream_t 
>> *substream)
>>
>> {
>> 	return readl(0xa0810004 + 4);
>> }
>>
>> What sort of values should this return during playback?
>> Add a printk to log some of them.
>> The value should be in "frames" and not "bytes"
>>     
>
> It should be doing all that anyway - it returns the numbers of samples
> (ie frames) played in the chosen (in ARM7 code) channel - and as all
> this is mono that ought to work unchanged for now, but I will check it
> as you suggest.
>   
Ok, that is not what is needed.
The value returned should be the position of the ADC in the hardware's 
ring buffer in units of frames.
Not the cumulative number of samples played.
E.g. If the buffer is 32768 frames long, the returned value should only 
have a value from 0 to 32767
Once it gets to 32767, it should then role over to 0 again.

James



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
