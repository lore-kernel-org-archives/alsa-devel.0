From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [alsa-devel] [PATCH linux-next v2 9/9] ASoC: rsnd: add busif
 property to dai stream
Date: Thu, 4 Oct 2018 16:00:24 +0900
Message-ID: <a5712f6a-a61b-f6c4-4f3d-a6d4a60bcfab@mentor.com>
References: <20181003090136.4556-1-jiada_wang@mentor.com>
 <87va6ipkaz.wl-kuninori.morimoto.gx@renesas.com>
 <557e63d1-dbb7-4232-b53e-4a5499024180@mentor.com>
 <87pnwqpeni.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87pnwqpeni.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san


Thanks for your comments


On 2018/10/04 12:43, Kuninori Morimoto wrote:
> Hi Jiada
>
> Thank you for your feedback
>
>>>> in GEN3 SSI may use different BUSIF for data transfer,
>>>> this patch adds busif property to each dai stream,
>>>> to indicate the BUSIF used by playback/capture stream.
>>>>
>>>> Also adds rsnd_ssi_select_busif() to automatically select
>>>> BUSIF (currently only BUSIF0 is selected)
>>>>
>>>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>>>> ---
> (snip)
>>> And this patch selects it on runtime (= hw_param) ?
>> Because, in order to automatically determine BUSIF number,
>> information like SSI mode (non-Split/Split/Ex-Split), runtime channel,
>> are required
>> (in our internal implementation, SSI mode is selected by kctrl)
>> because of this, in this patch, BUSIF is selected on runtime
>>
>>> But, I think we can/should select it on probe timing from DT connection.
>>> Am I misunderstanding ?
>> with the above reasoning, BUSIF is selected on runtime.
>> what do you think?
> I have no objection that you are customizing your kernel locally.
> But, upstreaming kernel based on it is not acceptable for me.
> I'm not sure detail of your local implementation, but I don't think we
> need to select SSI mode by kctrl.
> If my understanding was correct, it can also be selected automatically somehow.
> Or, am I misunderstanding ?
SSI can work in following modes
1. Basic Mode: (channel 1, 2, 4, 6, 8, 16)
2. TDM Extended Mode: (channel 6, 8)
3. TDM Split Mode: (channel 1, 2)
4. TDM Ex-Split mode: (Channel 2, 4, 6, 8, 10)

for example user asks dai-link0 to playback 2ch audio stream,
driver can't determine which mode to work, as it can be Basic mode, 
Split mode or Ex-Split mode.

> I could understand what you want to do, and yes, I can agree that we want/need
> to have it on upstream. Thank you very much to indicating it to me.
> But we need to consider more how to implement it.
> Especially, it is related to DT bindings.
> As you already know, if it is implemented on upstream kernel, we need to keep
> compatibility in the future, and it is very difficult.
Yes, I agree with you, upstream need to consider lots of things
>
> So, my opinions for BUSIFn support are
> 	- SSI mode should be selected automatically
can you give me your idea, how to automatically determine working mode,
when user plays 2 channel stream on playback dai-link
> 	- BUSIFn connection should be selected on DT
since which BUSIFx is used during audio data transfer, is not 
consideration of user,
I think your previous suggestion, (automatically select BUSIFx) makes 
more sense

Thanks,
Jiada
> 	  (I think we don't want random sound output position ?)
> 	  - To select it, we need to have new "ssiu" DT seetings,
> 	    or parse sound card. Maybe adding ssiu is realistic.
>
>
> Best regards
> ---
> Kuninori Morimoto
