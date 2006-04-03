From: Carlos Munoz <carlos@kenati.com>
Subject: Re: snd_pcm_hw_params_get_period_size() returning 0
Date: Mon, 03 Apr 2006 12:37:27 -0700
Message-ID: <44317977.2060007@kenati.com>
References: <442DD097.40901@kenati.com> <1143856796.2885.4.camel@mindpipe> <442DE37A.9070405@kenati.com> <s5hwte7arhb.wl%tiwai@suse.de> <44315F7A.7060208@kenati.com> <s5hy7ym8q73.wl%tiwai@suse.de> <Pine.LNX.4.61.0604032036240.9509@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0604032036240.9509@tm8103.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Lee Revell <rlrevell@joe-job.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:

>On Mon, 3 Apr 2006, Takashi Iwai wrote:
>
>  
>
>>At Mon, 03 Apr 2006 10:46:34 -0700,
>>Carlos Munoz wrote:
>>    
>>
>>>Takashi Iwai wrote:
>>>
>>>      
>>>
>>>>At Fri, 31 Mar 2006 18:20:42 -0800,
>>>>Carlos Munoz wrote:
>>>> 
>>>>
>>>>        
>>>>
>>>>>Lee Revell wrote:
>>>>>
>>>>>   
>>>>>
>>>>>          
>>>>>
>>>>>>On Fri, 2006-03-31 at 17:00 -0800, Carlos Munoz wrote:
>>>>>>
>>>>>>
>>>>>>     
>>>>>>
>>>>>>            
>>>>>>
>>>>>>>Does 
>>>>>>>any one know why
>>>>>>>snd_pcm_hw_params_get_period_size() would be returning 0 ? Is it 
>>>>>>>something the driver did/didn't do ?
>>>>>>>
>>>>>>>  
>>>>>>>
>>>>>>>       
>>>>>>>
>>>>>>>              
>>>>>>>
>>>>>>Argh, please disregard last message, that's not how the hw_params
>>>>>>callback works :-(
>>>>>>
>>>>>>Lee
>>>>>>
>>>>>>
>>>>>>
>>>>>>     
>>>>>>
>>>>>>            
>>>>>>
>>>>>Hi Lee,
>>>>>
>>>>>I digged further and this is what I found.
>>>>>
>>>>>snd_pcm_hw_params_get_period_size(...., int *val) does retrieve the 
>>>>>correct period size and updates val with it. However, val does not match 
>>>>>the address passed to it. I mean the caller of 
>>>>>snd_pcm_hw_params_get_period_size(.... 0x41becc) passes the address of 
>>>>>where the period size is to be stored as 0x41becc but 
>>>>>snd_pcm_hw_params_get_period_size() gets 0x7b83c0d8 and that's where it 
>>>>>puts the period size.
>>>>>
>>>>>This is on the Renesas SH7343 processor. alsa-lib is a dynamic library. 
>>>>>Should I expect the variable address be the same ?
>>>>>   
>>>>>
>>>>>          
>>>>>
>>>>No.  They must be different.  The value is stored to the original
>>>>address only when no error returns.  Unless that, a temporary variable
>>>>is used.  That's why you see two distinct addresses.
>>>>
>>>>
>>>>Takashi
>>>>
>>>>
>>>> 
>>>>
>>>>        
>>>>
>>>Hi Takashi,
>>>
>>>I understand what you are saying. However, this is not the case here. 
>>>The original address is wrong. I print the value of val (not _val) 
>>>passed to snd_pcm_hw_params_get_period_size() and it is wrong. See the code:
>>>
>>>#ifndef DOXYGEN
>>>int INTERNAL(snd_pcm_hw_params_get_period_size)(const 
>>>snd_pcm_hw_params_t *params, snd_pcm_uframes_t *val, int *dir)
>>>#else
>>>int snd_pcm_hw_params_get_period_size(const snd_pcm_hw_params_t *params, 
>>>snd_pcm_uframes_t *val, int *dir)
>>>#endif
>>>{
>>>    unsigned int _val;
>>>    printf("alsa-lib:snd_pcm_hw_params_get_period_size() - params=%p 
>>>val=%p dir=%p\n",
>>>           params, val, dir);
>>>    int err = snd_pcm_hw_param_get(params, SND_PCM_HW_PARAM_PERIOD_SIZE, 
>>>&_val, dir);
>>>    if (err >= 0)
>>>        *val = _val;
>>>
>>>    return err;
>>>}
>>>
>>>
>>>This printf shows val has an incorrect value (dir is also incorrect). I 
>>>don't think it's related to the alsa-lib but maybe a problem with our 
>>>build tool chain.
>>>      
>>>
>>OK, let me know if it turnes out to be a bug in alsa-lib :)
>>    
>>
>
>Or binutils. What does 'nm aplay | grep snd_pcm_hw_params_get_period_size' 
>show? Also, you might try to configure alsa-lib with --with-versioned=no .
>
>  
>
Hi Jaroslav,

Yes, using --with-versioned=no solved the problem. Now everything works. 
What does --with-versioned=no do ?

By the way the output of nm is the same for alsa-lib built  with and 
without the --with-versioned=no switch.

nm aplay | grep snd_pcm_hw_params_get_period_size
         U snd_pcm_hw_params_get_period_size@@ALSA_0.9.0rc4

Thanks,


Carlos


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
