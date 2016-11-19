From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC 0/4] ALSA controls management using
 index/device/sub-devices fields
Date: Sat, 19 Nov 2016 15:48:34 +0900
Message-ID: <6ca1935a-76b1-ac19-0950-9eab14f35c25@sakamocchi.jp>
References: <1478592675-23092-1-git-send-email-arnaud.pouliquen@st.com>
 <c28a3623-3cf1-5fc1-1ba8-e6785fb967ca@sakamocchi.jp>
 <cb9cf7f0-ae86-307b-c4d6-b4d3120d4e88@st.com>
 <a92aab32-03a1-5d89-0f3b-c080cc6bb938@sakamocchi.jp>
 <3c7b55b7-0b7f-fd55-9c30-745822a21d33@st.com>
 <44555039-d85f-2de6-ec04-0ecf214ca0e9@sakamocchi.jp>
 <d5c84110-3c72-dc8f-4839-134334cb448f@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id B6B932657A6
 for <alsa-devel@alsa-project.org>; Sat, 19 Nov 2016 07:48:39 +0100 (CET)
In-Reply-To: <d5c84110-3c72-dc8f-4839-134334cb448f@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Nov 6 2016 22:43, Arnaud Pouliquen wrote:
>> Well, as a glance of ALSA SoC core, we have a call of 'struct
>> snd_soc_card.late_probe()' just before 'snd_card_register()'. We can
>> probably add ad-hoc control element sets for each PCM character devices.
>>
>> snd_soc_register_card()
>> ->snd_soc_instantiate_card()
>>    ->soc_bind_dai_link()
>>    ->soc_probe_link_dais()
>>    ->snd_soc_add_card_controls()
>>    ->struct snd_soc_card.late_probe()
>>    ->snd_card_register()
>>
>> But it seems to be a bit cumbersome. I think it better to add a smart
>> framework for the PCM-related controls. In this point, I agree with your
>> direction.
>
> Another point is that, at least in theory, a DAI driver can add a
> control after card creation. In this case PCM control should also be
> associated to PCM device. Late probe could not handle it.

I don't think so. But in your case, 'snd-soc-simple-card' is used to 
maintain own sound card instance, and this module has no handlers for 
the callback. So we don't utilize the callback for this aim unless 
integrating the module.

> If we are aligned on direction, what is your suggestion to continue
> discussion?
> Do you want to continue discussion based on [RFC 1/4] ASoC: core: allow
> PCM control binding to PCM device?
> Other?

If you focused on ALSA SoC part only, I'd not continue this discussion 
more. I'm not a developer for the part, and join in this discussion just 
for ALSA control interface.

>>> I have not upstreamed my card conf file but an example is available at
>>> end of my mail.
>>> Value of the device field must be aligned with ASoC driver device values:
>>> HDMI: STI-B2120.pcm.hdmi.0.hooks.0.device=0
>>> SPDIF: STI-B2120.pcm.iec958.0.hooks.0.device=3
>>>
>>> If these controls were associated to the PCM device, I should not have
>>> to fix the value but I should be able to retrieve it.
>>
>> As long as I know, 'pcm/iec958.conf' and 'pcm/hdmi.conf' use different
>> strategy to handle PCM-related control element set for IEC958 type. Your
>> configuration does not work well for pcm.iec958 plugin.
>>
>
> Please could you detail?
> HDMI supports more configurations than SPDIF (e.g HBRA). Furthermore
> application can retrieve HDMI sinks capability with EDID. So full agree
> that strategy can be different. That's why Two IEC controls are needed.
> But focusing on 'pcm/iec958.conf' and 'pcm/hdmi.conf', they are almost
> identical...

I prefer discuss after deciding your approach on kernel side. But in 
previous message I misunderstood that S/PDIF interface of your STI SoC 
in system side can handle IEC 60958 sub-frame. Actually, it seems not to 
be. In this case, usage of pcm hook for 'ctl_elems' type might be 
appropriate. I'm sorry to have confused you.


Regards

Takashi Sakamoto
