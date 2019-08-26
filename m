From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: Re: [PATCH] ASoC: es8316: limit headphone mixer volume
Date: Tue, 27 Aug 2019 00:25:07 +0900
Message-ID: <9574e5f4-e9db-1876-73f7-19a79fb1209e@katsuster.net>
References: <20190824210426.16218-1-katsuhiro@katsuster.net>
 <943932bf-2042-2a69-c705-b8e090e96377@redhat.com>
 <CAD8Lp44_uAC4phZ9NbvM_LKNUoiNUqAnFsq4h-bJiQn6byjzGw@mail.gmail.com>
 <eeee149c-4d9b-8b2e-780b-a41e2c87ec02@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <eeee149c-4d9b-8b2e-780b-a41e2c87ec02@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Daniel Drake <drake@endlessm.com>
Cc: Mark Brown <broonie@kernel.org>, David Yang <yangxiaohua@everest-semi.com>, alsa-devel@alsa-project.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hello Hans, Daniel,

Thank you for reviewing and comment.

On 2019/08/26 18:09, Hans de Goede wrote:
> Hi,
> 
> On 26-08-19 04:53, Daniel Drake wrote:
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
> 
> IIRC garbled sound.
> 
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
>> So perhaps we can fix the kernel to follow this table and then use UCM
>> to limit the volume if its too high on a given platform?
> 
> Yes that sounds like the right thing to do. Katsuhiro can you confirm that
> using this table allows using the full scale ? note that the full scale now
> has 9 steps rather then 8.
> 

I've finished testing this table on my board (RockPro64).
Every values work well without garbled sound.

I checked address 0x16 register via /sys/kernel/debug/regmap too.
The register values and dB (get from alsamixer) are the following if
I increase headphone volume to max from min.

   reg   dB
   0x16  scale
   ------------
   0x00  -12.00
   0x11  -10.50
   0x22  -9.00
   0x33  -7.50
   0x44  -6.00
   0x88  -4.50
   0x99  -3.00
   0xaa  -1.50
   0xbb  0.00


And I found other problem, current code is inverted L/R volume.
It's only in Headphone "mixer" volume. It seems Headphone "master"
volume works correctly.

I'll fix these problems and send V2 patch set.


> Regards,
> 
> Hans
> 
> 

Best Regards,
Katsuhiro Suzuki
