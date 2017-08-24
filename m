From: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v2] ASoC: Add a sanity check before using dai driver name
Date: Thu, 24 Aug 2017 12:44:12 +0800
Message-ID: <599E599C.1060308@rock-chips.com>
References: <20170824033411.5788-1-jeffy.chen@rock-chips.com> <CAErzpmvnDs-WBRVCn+wdQw2cxiT+h0gdBci5UqPXEvffRtBmMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAErzpmvnDs-WBRVCn+wdQw2cxiT+h0gdBci5UqPXEvffRtBmMw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, tiwai@suse.de, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Dong,

Thanks for noticing, will send new patch soon :)

On 08/24/2017 11:46 AM, Donglin Peng wrote:
> On Thu, Aug 24, 2017 at 11:34 AM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
>>                  list_for_each_entry(dai, &component->dai_list, list) {
>>                          if (dlc->dai_name && strcmp(dai->name, dlc->dai_name)
>> -                           && strcmp(dai->driver->name, dlc->dai_name))
>> +                           && (!dai->driver->name
>> +                               || !strcmp(dai->driver->name, dlc->dai_name))
>>                                  continue;
>
> If the dai->driver->name is match with the dlc->dai_name, does it need
> to continue?

hmm, sorry, i did this in a hurry, should setup my board and test it..
>
>>
>>                          return dai;
>
>
>
