From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ASoC: es8316: limit headphone mixer volume
Date: Mon, 26 Aug 2019 11:09:24 +0200
Message-ID: <eeee149c-4d9b-8b2e-780b-a41e2c87ec02@redhat.com>
References: <20190824210426.16218-1-katsuhiro@katsuster.net>
 <943932bf-2042-2a69-c705-b8e090e96377@redhat.com>
 <CAD8Lp44_uAC4phZ9NbvM_LKNUoiNUqAnFsq4h-bJiQn6byjzGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD8Lp44_uAC4phZ9NbvM_LKNUoiNUqAnFsq4h-bJiQn6byjzGw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: Katsuhiro Suzuki <katsuhiro@katsuster.net>, Mark Brown <broonie@kernel.org>, David Yang <yangxiaohua@everest-semi.com>, alsa-devel@alsa-project.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On 26-08-19 04:53, Daniel Drake wrote:
> On Mon, Aug 26, 2019 at 1:38 AM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 24-08-19 23:04, Katsuhiro Suzuki wrote:
>>> This patch limits Headphone mixer volume to 4 from 7.
>>> Because output sound suddenly becomes very loudly with many noise if
>>> set volume over 4.
> 
> That sounds like something that should be limited in UCM.
> 
>> Higher then 4 not working matches my experience, see this comment from
>> the UCM file: alsa-lib/src/conf/ucm/codecs/es8316/EnableSeq.conf :
>>
>> # Set HP mixer vol to -6 dB (4/7) louder does not work
>> cset "name='Headphone Mixer Volume' 4"
> 
> What does "does not work" mean more precisely?

IIRC garbled sound.

> I checked the spec, there is indeed something wrong in the kernel driver here.
> The db scale is not a simple scale as the kernel source suggests.
> 
> Instead it is:
> 0000 – -12dB
> 0001 – -10.5dB
> 0010 – -9dB
> 0011 – -7.5dB
> 0100 – -6dB
> 1000 – -4.5dB
> 1001 – -3dB
> 1010 – -1.5dB
> 1011 – 0dB
> 
> So perhaps we can fix the kernel to follow this table and then use UCM
> to limit the volume if its too high on a given platform?

Yes that sounds like the right thing to do. Katsuhiro can you confirm that
using this table allows using the full scale ? note that the full scale now
has 9 steps rather then 8.

Regards,

Hans
