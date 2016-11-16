From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [RFC 0/4] ALSA controls management using
 index/device/sub-devices fields
Date: Wed, 16 Nov 2016 14:43:57 +0100
Message-ID: <d5c84110-3c72-dc8f-4839-134334cb448f@st.com>
References: <1478592675-23092-1-git-send-email-arnaud.pouliquen@st.com>
 <c28a3623-3cf1-5fc1-1ba8-e6785fb967ca@sakamocchi.jp>
 <cb9cf7f0-ae86-307b-c4d6-b4d3120d4e88@st.com>
 <a92aab32-03a1-5d89-0f3b-c080cc6bb938@sakamocchi.jp>
 <3c7b55b7-0b7f-fd55-9c30-745822a21d33@st.com>
 <44555039-d85f-2de6-ec04-0ecf214ca0e9@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id EB460266CAD
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2016 14:44:01 +0100 (CET)
In-Reply-To: <44555039-d85f-2de6-ec04-0ecf214ca0e9@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org



On 11/16/2016 10:34 AM, Takashi Sakamoto wrote:
> On Nov 14 2016 22:58, Arnaud Pouliquen wrote:
>>>> Issues:
>>>>      - use "device" in ASOC DAI driver means that driver needs to
>>>>        define a "virtual" PCM device value, not the PCM device.
>>>> 	=> this break the rule that mention that PCM control should be
>>>>         linked to a PCM device.
>>>
>>> Please show me where related codes and structures are. At least, I
>>> cannot understand what you said because it's really abstracted.
>> As example, here is my current implementation (correspond to the piece
>> of code i would like to rework):
>> http://www.lingrok.org/xref/linux-linus/sound/soc/sti/sti_uniperif.c#232
>> - "device" field is set to the instance ID of the DAI uniperiph player.
>> - "index" filed is also set but overwritten by ASoC core.
>>
>> In this implementation what i name "virtual device is the "device" value
>> uni->id
>> HDMI: uni->id = 0 ( PCM device associated is hw:0,0)
>> SPDIF: uni->id = 3 ( PCM device associated is hw:0,2)
>>
>> If i don't set the device value then i can not create both controls.
>> A better way should be to set device to PCM device.
>> This was the topic of [RFC 1/4] ASoC: core: allow PCM control binding to
>> PCM device (http://www.spinics.net/lists/alsa-devel/msg56482.html).
> 
> In below call graph, each module cannot directly indicate the 'device' 
> number because 'struct snd_soc_card.num_rtd' is incremented by ALSA SoC 
> core and the number is used as an argument for 'snd_pcm_new_internal()' 
> or 'snd_pcm_new()'.
> 
> (sound/soc/soc-core.c)
> snd_soc_register_card()
> ->snd_soc_instantiate_card()
>    ->soc_bind_dai_link() (each on card->num_links/dai_link_list)
>      ->soc_new_pcm_runtime()
>      ->soc_add_pcm_runtime()
>        list_add_tail(&card->rtd_list)
>        rtd->num = card->num_rtd
>        card->num_rtd++
>    ->soc_probe_link_dais() (each on card->rtd_list)
>      (sound/soc/soc-pcm.c)
>      ->soc_new_pcm(rtd, num = rtd->num)
>        ->snd_pcm_new_internal(num)
>        ->snd_pcm_new(num)
>        struct snd_soc_pcm_runtime.pcm = pcm
>    ->snd_card_regiser()
> 
> Thus, modules are forced to 'guess' the card structure in a point of PCM
> character devices. I think you expressed this as 'virtual'.
Yes. Or fix an arbitrary PCM device value if not possible to guess.
> 
> Well, as a glance of ALSA SoC core, we have a call of 'struct 
> snd_soc_card.late_probe()' just before 'snd_card_register()'. We can 
> probably add ad-hoc control element sets for each PCM character devices.
> 
> snd_soc_register_card()
> ->snd_soc_instantiate_card()
>    ->soc_bind_dai_link()
>    ->soc_probe_link_dais()
>    ->snd_soc_add_card_controls()
>    ->struct snd_soc_card.late_probe()
>    ->snd_card_register()
> 
> But it seems to be a bit cumbersome. I think it better to add a smart 
> framework for the PCM-related controls. In this point, I agree with your 
> direction.

Another point is that, at least in theory, a DAI driver can add a
control after card creation. In this case PCM control should also be
associated to PCM device. Late probe could not handle it.

If we are aligned on direction, what is your suggestion to continue
discussion?
Do you want to continue discussion based on [RFC 1/4] ASoC: core: allow
PCM control binding to PCM device?
Other?

> 
>>>>        Furthermore, this "virtual" value has to be aligned with the one
>>>>        defined in alsa-lib conf file(s).
>>>
>>> Ditto.
>> I have not upstreamed my card conf file but an example is available at
>> end of my mail.
>> Value of the device field must be aligned with ASoC driver device values:
>> HDMI: STI-B2120.pcm.hdmi.0.hooks.0.device=0
>> SPDIF: STI-B2120.pcm.iec958.0.hooks.0.device=3
>>
>> If these controls were associated to the PCM device, I should not have
>> to fix the value but I should be able to retrieve it.
> 
> As long as I know, 'pcm/iec958.conf' and 'pcm/hdmi.conf' use different 
> strategy to handle PCM-related control element set for IEC958 type. Your 
> configuration does not work well for pcm.iec958 plugin.
> 

Please could you detail?
HDMI supports more configurations than SPDIF (e.g HBRA). Furthermore
application can retrieve HDMI sinks capability with EDID. So full agree
that strategy can be different. That's why Two IEC controls are needed.
But focusing on 'pcm/iec958.conf' and 'pcm/hdmi.conf', they are almost
identical...

Thanks and Regards

Arnaud
