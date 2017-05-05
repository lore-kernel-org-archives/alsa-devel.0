From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoc: cht_bsw_max98090_ti: Fix jack
 initialization
Date: Fri, 5 May 2017 11:14:13 -0500
Message-ID: <5482944e-a2bb-45f7-3448-8e44a5777868@linux.intel.com>
References: <1493719869-16100-1-git-send-email-thierry.escande@collabora.com>
 <1493719869-16100-2-git-send-email-thierry.escande@collabora.com>
 <4d672855-bb4a-088e-250b-b0fecfd8bb68@linux.intel.com>
 <987e2725-5242-c9d0-8063-452d9c893600@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <987e2725-5242-c9d0-8063-452d9c893600@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Escande <thierry.escande@collabora.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 5/5/17 7:37 AM, Thierry Escande wrote:
> Hi,
>
> On 04/05/2017 19:01, Pierre-Louis Bossart wrote:
>> On 05/02/2017 05:11 AM, Thierry Escande wrote:
>>
>>> If the ts3a227e audio accessory detection hardware is present and its
>>> driver probed, the jack needs to be created before enabling jack
>>> detection in the ts3a227e driver. With this patch, the jack is
>>> instantiated in the max98090 headset init function if the ts3a227e is
>>> present. This fixes a null pointer dereference as the jack detection
>>> enabling function in the ts3a driver was called before the jack is
>>> created.
>> is this in any way related to
>> https://bugzilla.kernel.org/show_bug.cgi?id=151521
>> " Sound not working on Acer Chromebook R11 (CYAN) braswell / cherryview
>> / cherry trail"
>>
>> I provided a similar patch and didn't see any followup.
>> https://bugzilla.kernel.org/attachment.cgi?id=254867
>> Thanks
>> -Pierre
>
> That's the exact same issue.
>
> I fixed it by creating the jack in the aux_dev .init() function since
> it's how this is done in the rockchip max98090 driver.

ok, so do you get sound on Cyan chromebooks with these two fixes?
it'd be worth adding a reference to the bugzilla # in the commit message.

>
> Regards,
>  Thierry
>
>>
>>>
>>> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
>>> ---
>>>   sound/soc/intel/boards/cht_bsw_max98090_ti.c | 50
>>> +++++++++++++++++-----------
>>>   1 file changed, 30 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
>>> b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
>>> index 742bc0d..f17e474 100644
>>> --- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
>>> +++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
>>> @@ -128,30 +128,21 @@ static int cht_codec_init(struct
>>> snd_soc_pcm_runtime *runtime)
>>>       struct cht_mc_private *ctx =
>>> snd_soc_card_get_drvdata(runtime->card);
>>>       struct snd_soc_jack *jack = &ctx->jack;
>>>   -    /**
>>> -    * TI supports 4 butons headset detection
>>> -    * KEY_MEDIA
>>> -    * KEY_VOICECOMMAND
>>> -    * KEY_VOLUMEUP
>>> -    * KEY_VOLUMEDOWN
>>> -    */
>>> -    if (ctx->ts3a227e_present)
>>> -        jack_type = SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
>>> -                    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
>>> -                    SND_JACK_BTN_2 | SND_JACK_BTN_3;
>>> -    else
>>> -        jack_type = SND_JACK_HEADPHONE | SND_JACK_MICROPHONE;
>>> +    if (ctx->ts3a227e_present) {
>>> +        /*
>>> +         * The jack has already been created in the
>>> +         * cht_max98090_headset_init() function.
>>> +         */
>>> +        snd_soc_jack_notifier_register(jack, &cht_jack_nb);
>>> +        return 0;
>>> +    }
>>> +
>>> +    jack_type = SND_JACK_HEADPHONE | SND_JACK_MICROPHONE;
>>>         ret = snd_soc_card_jack_new(runtime->card, "Headset Jack",
>>>                       jack_type, jack, NULL, 0);
>>> -
>>> -    if (ret) {
>>> +    if (ret)
>>>           dev_err(runtime->dev, "Headset Jack creation failed %d\n",
>>> ret);
>>> -        return ret;
>>> -    }
>>> -
>>> -    if (ctx->ts3a227e_present)
>>> -        snd_soc_jack_notifier_register(jack, &cht_jack_nb);
>>>         return ret;
>>>   }
>>> @@ -200,6 +191,25 @@ static int cht_max98090_headset_init(struct
>>> snd_soc_component *component)
>>>   {
>>>       struct snd_soc_card *card = component->card;
>>>       struct cht_mc_private *ctx = snd_soc_card_get_drvdata(card);
>>> +    struct snd_soc_jack *jack = &ctx->jack;
>>> +    int jack_type;
>>> +    int ret;
>>> +
>>> +    /*
>>> +     * TI supports 4 butons headset detection
>>> +     * KEY_MEDIA
>>> +     * KEY_VOICECOMMAND
>>> +     * KEY_VOLUMEUP
>>> +     * KEY_VOLUMEDOWN
>>> +     */
>>> +    jack_type = SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
>>> +            SND_JACK_BTN_0 | SND_JACK_BTN_1 |
>>> +            SND_JACK_BTN_2 | SND_JACK_BTN_3;
>>> +
>>> +    ret = snd_soc_card_jack_new(card, "Headset Jack", jack_type,
>>> +                    jack, NULL, 0);
>>> +    if (ret)
>>> +        return ret;
>>>         return ts3a227e_enable_jack_detect(component, &ctx->jack);
>>>   }
>>
