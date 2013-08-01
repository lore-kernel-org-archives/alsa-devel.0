From: Felipe Ferreri Tonello <eu@felipetonello.com>
Subject: Re: [PATCH 4/4] ALSA: oxygen: Updating jack implementation according
 new ALSA Jacks
Date: Wed, 31 Jul 2013 20:51:43 -0700
Message-ID: <51F9DB4F.3070805@felipetonello.com>
References: <1374863133-6745-1-git-send-email-eu@felipetonello.com> <1374863133-6745-5-git-send-email-eu@felipetonello.com> <20130726185609.GY9858@sirena.org.uk> <CAGrhNMzaBcUb4GHLXr5uR2g4YNSD60vcDpDKQO=S9H2jAx6pgA@mail.gmail.com> <s5hehahftxx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hehahftxx.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, David Henningsson <david.henningsson@canonical.com>, Wang Xingchao <xingchao.wang@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On 07/29/2013 05:10 AM, Takashi Iwai wrote:
> At Fri, 26 Jul 2013 12:02:51 -0700,
> Felipe Tonello wrote:
>>
>> Hi Mark,
>>
>> On Fri, Jul 26, 2013 at 11:56 AM, Mark Brown <broonie@kernel.org> wrote:
>>> On Fri, Jul 26, 2013 at 11:25:33AM -0700, Felipe F. Tonello wrote:
>>>> From: "Felipe F. Tonello" <eu@felipetonello.com>
>>>>
>>>> ALSA standard jacks already are implemented using ALSA KControl.
>>>> So there is no need implement that itself or to use snd_jack
>>>> for input events only.
>>>
>>> Similar changlog comment as on the ASoC patch and...
>>
>> Ok.
>>
>>>
>>>>        snd_jack_new(chip->card, "Headphone",
>>>> -                  SND_JACK_HEADPHONE, &data->hp_jack);
>>>> +                  SND_JACK_HEADPHONE, 0, &data->hp_jack);
>>>>        xonar_ds_handle_hp_jack(chip);
>>>
>>> ...this really ought to be done as part of the commit that adds the
>>> parameter since it breaks the build until this patch is applied.
>>
>> But that's why is a patch series. But as you say, are you suggesting
>> me to propose this changes in one patch only?
>
> The basic rule of the patch series is:
> - they are split in a logical manner
> - each commit must not break the build
>
> The second rule is important especially for bisection and
> backporting.  You could have done in a different way (e.g. adding a
> new function like snd_jack_new_with_index() instead of changing
> snd_jack_new() itself).  Which way is better, depends on the
> implementation details.

In this case I think this will not solve the issue. Because the my 
propose is to make the control creation standard for jacks.

Felipe Tonello
