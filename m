From: Carlos Munoz <carlos@kenati.com>
Subject: Re: snd_pcm_hw_params_get_period_size() returning 0
Date: Fri, 31 Mar 2006 18:20:42 -0800
Message-ID: <442DE37A.9070405@kenati.com>
References: <442DD097.40901@kenati.com> <1143856796.2885.4.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1143856796.2885.4.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:

>On Fri, 2006-03-31 at 17:00 -0800, Carlos Munoz wrote:
>  
>
>>Does 
>>any one know why
>>snd_pcm_hw_params_get_period_size() would be returning 0 ? Is it 
>>something the driver did/didn't do ?
>>
>>    
>>
>
>Argh, please disregard last message, that's not how the hw_params
>callback works :-(
>
>Lee
>
>  
>
Hi Lee,

I digged further and this is what I found.

snd_pcm_hw_params_get_period_size(...., int *val) does retrieve the 
correct period size and updates val with it. However, val does not match 
the address passed to it. I mean the caller of 
snd_pcm_hw_params_get_period_size(.... 0x41becc) passes the address of 
where the period size is to be stored as 0x41becc but 
snd_pcm_hw_params_get_period_size() gets 0x7b83c0d8 and that's where it 
puts the period size.

This is on the Renesas SH7343 processor. alsa-lib is a dynamic library. 
Should I expect the variable address be the same ?

Thanks,


Carlos


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
