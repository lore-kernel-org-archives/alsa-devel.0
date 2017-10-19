From: Carlo Caione <carlo@endlessm.com>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: rt5651: Enable jack detection on JD1_1
Date: Thu, 19 Oct 2017 16:54:33 +0100
Message-ID: <CAL9uMOGu+enNVkRwC7=MG_Tg8wmOGaJTaNsCxj28JCFkYeRVaw@mail.gmail.com>
References: <20171019110323.23751-1-carlo@caione.org> <20171019110323.23751-2-carlo@caione.org>
 <d8041bdf-8fd1-1bf3-45e1-cd3fd1b57459@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d8041bdf-8fd1-1bf3-45e1-cd3fd1b57459@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Carlo Caione <carlo@caione.org>, Linux Upstreaming Team <linux@endlessm.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, Albert Chen <albertchen@realtek.com>, Edgar Shen <edgar_shen@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 19, 2017 at 4:47 PM, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 10/19/17 6:03 AM, Carlo Caione wrote:
>>
>> From: Carlo Caione <carlo@endlessm.com>
>>
>> Enable jack detection or the RT5651 codec on the JD1_1 pin.
>
> Nice, but the codec supports a second jack detection on JD1 and has a second
> JD2 pin. I will bet that some devices will have a different routing and I
> wonder if we could just add support for all options.

I can write support for that but I have no hardware to actually test
it, that's why I left those cases out.

>> The codec has no means to detect the type of the jack connected so we
>> assume that the jack is always an headset jack.
>
> that's odd, was this confirmed by Realtek?

The Realtek people are in CC :)
Probably there is way but in the datasheet there is nothing about that
(or did I miss it?)

>> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>> ---
>>   include/sound/rt5651.h    |  7 ++++
>>   sound/soc/codecs/rt5651.c | 91
>> +++++++++++++++++++++++++++++++++++++++++++++--
>>   sound/soc/codecs/rt5651.h |  3 ++
>>   3 files changed, 99 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/sound/rt5651.h b/include/sound/rt5651.h
>> index d35de758dfb5..c563383149c4 100644
>> --- a/include/sound/rt5651.h
>> +++ b/include/sound/rt5651.h
>> @@ -11,11 +11,18 @@
>>   #ifndef __LINUX_SND_RT5651_H
>>   #define __LINUX_SND_RT5651_H
>>   +enum rt5651_jd_src {
>> +       RT5651_JD_NULL,
>> +       RT5651_JD1_1,
>> +};
>> +
>>   struct rt5651_platform_data {
>>         /* IN2 can optionally be differential */
>>         bool in2_diff;
>>         bool dmic_en;
>> +
>> +       enum rt5651_jd_src jd_src;
>
>
> I don't see code that sets this platform data, is there a quirk or
> of_property missing in this patchset?

Yes, it is supposed to be enabled by a quirk. In general (personal
taste) I prefer to post the quirk enabling code after the base code
has been ACKed. If you feel like it I can post also the quirk code
together with the next respin of this patchset.

Thank you,

-- 
Carlo Caione  |  +39.340.80.30.096  |  Endless
