From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: period_time in slave definition
Date: Tue, 01 Mar 2011 10:44:41 +0100
Message-ID: <4D6CC009.9050501@ivitera.com>
References: <4D6B943E.4060302@ivitera.com>
	<alpine.LNX.2.00.1102281412520.7877@eeebox2.perex-int.cz>
	<4D6CB760.5070601@ivitera.com>
	<alpine.LNX.2.00.1103011020080.7877@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (upc-plzen.insite.cz [84.242.100.8])
	by alsa0.perex.cz (Postfix) with ESMTP id E11662479A
	for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2011 10:44:43 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.1103011020080.7877@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela napsal(a):
> On Tue, 1 Mar 2011, Pavel Hofman wrote:
> 
>> Jaroslav Kysela napsal(a):
>>>
>>> It's correct, pcm:plug does not support buffer modifiers. Look to
>>> "Automatic conversion plugin".
>>>
>>>> I checked the source code and the keywords seem to be ok
>>>>
>>>> pcm.c:
>>>> static const char *const names[SND_PCM_HW_PARAM_LAST_INTERVAL + 1] = {
>>>>     [SND_PCM_HW_PARAM_FORMAT] = "format",
>>>>     [SND_PCM_HW_PARAM_CHANNELS] = "channels",
>>>>     [SND_PCM_HW_PARAM_RATE] = "rate",
>>>>     [SND_PCM_HW_PARAM_PERIOD_TIME] = "period_time",
>>>>     [SND_PCM_HW_PARAM_PERIOD_SIZE] = "period_size",
>>>>     [SND_PCM_HW_PARAM_BUFFER_TIME] = "buffer_time",
>>>>     [SND_PCM_HW_PARAM_BUFFER_SIZE] = "buffer_size",
>>>>     [SND_PCM_HW_PARAM_PERIODS] = "periods"
>>>> };
>>>
>>> It's just a table to translate all possibilites between index and name.
>>> The plug plugins allow only this:
>>>
>>>     err = snd_pcm_slave_conf(root, slave, &sconf, 3,
>>>                  SND_PCM_HW_PARAM_FORMAT, SCONF_UNCHANGED, &sformat,
>>>                  SND_PCM_HW_PARAM_CHANNELS, SCONF_UNCHANGED, &schannels,
>>>                  SND_PCM_HW_PARAM_RATE, SCONF_UNCHANGED, &srate);
>>>
>>>                     Jaroslav
>>>
>>
>>
>> Well, still I do not understand why we are talking about the plug
>> plugin, when I am trying to redefine the slave via pcm_slave. The
>> documentation at
>> http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html says the
>> pcm_slave can define period_time and buffer_time, while a slightly
>> modified example from the wiki page fails:
>>
>> pcm_slave.slave_rate44100Hz {
>>        pcm "hw:0,0"
>>        rate 44100
>> --->    period_time 1024
>> }
>>
>> pcm.rate44100Hz {
>>        type plug
>>        slave slave_rate44100Hz
>> }
>>
>> How does the slave definition relate to the plug plugin? Sorry for these
>> basics but I am really trying to understand that, so far no success.
> 
> The above description is an universal description for all slaves.
> Unfortunately, not all plugins accept the whole range of parameters.
> You have to look to the snd_pcm_slave_conf() caller which parameters are
> accepted.
> 

Thanks a lot for your clarification. Would it make sense to add these
parameters to the plug plugin? I guess it would not be as simple as in
dshare.c:

	params.period_size = psize;
	params.buffer_size = bsize;

when opening the slave.

Or should I use dshare when I need to specify period and buffer
parameters outside of the application?

Thanks a lot,

Pavel.
