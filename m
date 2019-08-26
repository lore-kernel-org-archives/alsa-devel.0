From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: Re: [PATCH] ASoC: es8316: limit headphone mixer volume
Date: Mon, 26 Aug 2019 18:00:56 +0900
Message-ID: <bf9bebb7-9c6d-3a56-d144-3466cd00d5eb@katsuster.net>
References: <20190824210426.16218-1-katsuhiro@katsuster.net>
 <943932bf-2042-2a69-c705-b8e090e96377@redhat.com>
 <CAD8Lp44_uAC4phZ9NbvM_LKNUoiNUqAnFsq4h-bJiQn6byjzGw@mail.gmail.com>
 <f3096961-6b26-1ccf-47f2-978ae3648031@katsuster.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f3096961-6b26-1ccf-47f2-978ae3648031@katsuster.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Mark Brown <broonie@kernel.org>, David Yang <yangxiaohua@everest-semi.com>, alsa-devel@alsa-project.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hello,

Oops... I got mistake,

 >      SOC_DOUBLE_TLV("Headphone Mixer Volume", ES8316_HPMIX_VOL,
 >                 0, 4, 15, 0, hpmixer_gain_tlv),

is wrong,

 >      SOC_DOUBLE_TLV("Headphone Mixer Volume", ES8316_HPMIX_VOL,
 >                 0, 4, 11, 0, hpmixer_gain_tlv),

is correct.

Best Regards,
Katsuhiro Suzuki


On 2019/08/26 17:41, Katsuhiro Suzuki wrote:
> Hello Daniel,
> 
> On 2019/08/26 11:53, Daniel Drake wrote:
>> On Mon, Aug 26, 2019 at 1:38 AM Hans de Goede <hdegoede@redhat.com> 
>> wrote:
>>> On 24-08-19 23:04, Katsuhiro Suzuki wrote:
>>>> This patch limits Headphone mixer volume to 4 from 7.
>>>> Because output sound suddenly becomes very loudly with many noise if
>>>> set volume over 4.
>>
>> That sounds like something that should be limited in UCM.
>>
>>> Higher then 4 not working matches my experience, see this comment from
>>> the UCM file: alsa-lib/src/conf/ucm/codecs/es8316/EnableSeq.conf :
>>>
>>> # Set HP mixer vol to -6 dB (4/7) louder does not work
>>> cset "name='Headphone Mixer Volume' 4"
>>
>> What does "does not work" mean more precisely?
>>
>> I checked the spec, there is indeed something wrong in the kernel 
>> driver here.
>> The db scale is not a simple scale as the kernel source suggests.
>>
>> Instead it is:
>> 0000 – -12dB
>> 0001 – -10.5dB
>> 0010 – -9dB
>> 0011 – -7.5dB
>> 0100 – -6dB
>> 1000 – -4.5dB
>> 1001 – -3dB
>> 1010 – -1.5dB
>> 1011 – 0dB
>>
>  > So perhaps we can fix the kernel to follow this table and then use UCM
>  > to limit the volume if its too high on a given platform?
>  >
> 
> Thank you very important information. So you mean value 5, 6, 7 are
> illegal settings for ES8316. Correct codes are
> 
> static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(hpmixer_gain_tlv,
>      0, 4, TLV_DB_SCALE_ITEM(-1200, 150, 0),
>      8, 11, TLV_DB_SCALE_ITEM(-450, 150, 0),
> );
> 
> and...
> 
>      SOC_DOUBLE_TLV("Headphone Mixer Volume", ES8316_HPMIX_VOL,
>                 0, 4, 15, 0, hpmixer_gain_tlv),
> 
> Is my understanding correct? If so I'll test it on my board
> (RockPro64) and re-send patch.
> 
> BTW, do you know how to get ES8316 I2C registers spec?
> I want to see it for understanding current code, but I cannot find...
> 
> 
>> Thanks
>> Daniel
>>
>>
> 
> Best Regards,
> Katsuhiro Suzuki
> 
