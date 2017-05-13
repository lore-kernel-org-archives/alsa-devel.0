From: Paulo Sergio <pstglia@gmail.com>
Subject: Re: WM5102 - Help to make baytrail machine driver work
Date: Sat, 13 May 2017 02:11:31 -0300
Message-ID: <CAJcYhpatsrYyC0CRu-0quA0=NYOObMC2nro5sDE-2ssTTu83rA@mail.gmail.com>
References: <CAJcYhpZU-6_AO_Gye1VttuvOP0Z2=wLuWGCOP7tBWc6DsuLU1g@mail.gmail.com>
 <20160505091122.GE1646@localhost.localdomain>
 <CAJcYhpbdr-3qBSdaLX-=MCSGX7VC0XGz6tKbzJ3K3RHeGMhs7g@mail.gmail.com>
 <CAJcYhpZ1NRUa_7nu5kT6yJ_NTbDxRtK5Uy0H1fxMBEHhvA1fxw@mail.gmail.com>
 <20160509142210.GH1646@localhost.localdomain>
 <CAJcYhpa8OrxyFxL1L4VQJL=WSEhrKhvfcdLeUj40Hb=N2kDUUQ@mail.gmail.com>
 <20160513114136.GM1646@localhost.localdomain>
 <CAJcYhpYJcTE0qBwYAHtGF9tbNCKXAVaLP3RnS5CF5=Z1LBijmA@mail.gmail.com>
 <20160515101308.GN1646@localhost.localdomain>
 <CAJcYhpaFiDrMYmbS1cUWL=ix-L2crjnNekpCXjjdHVThwp2Xag@mail.gmail.com>
 <20170508082422.GJ1594@localhost.localdomain>
 <CAJcYhpb0amzyug01nN3TUWBFSgGWfZcfOVfMgV01rxgTnbNnHg@mail.gmail.com>
 <7c35cd21-35a4-726d-71b5-1ef9f096fbee@linux.intel.com>
 <CAJcYhpb9yOJjDwG6ZGEYFQTiLXtkHNgmVkmF2ssQp6QPOX0ueA@mail.gmail.com>
 <6615d589-9124-5f71-0d6d-e634caf2fdaa@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f174.google.com (mail-pf0-f174.google.com
 [209.85.192.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 6321B266943
 for <alsa-devel@alsa-project.org>; Sat, 13 May 2017 07:11:35 +0200 (CEST)
Received: by mail-pf0-f174.google.com with SMTP id n23so34113689pfb.2
 for <alsa-devel@alsa-project.org>; Fri, 12 May 2017 22:11:35 -0700 (PDT)
In-Reply-To: <6615d589-9124-5f71-0d6d-e634caf2fdaa@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, broonie@opensource.wolfsonmicro.com, Android-x86 development <android-x86-devel@googlegroups.com>, Chih-Wei Huang <cwhuang@android-x86.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, mika.westerberg@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi everybody

>>>> Note: Based on Lenovo code, I concluded this device uses ssp0, so I'm
>>>> using a fw file "fw_sst_0f28_ssp0.bin" posted another thread.
>>>> Could use the hacks used on kernel 4.11, but as I'm still testing with
>>>> kernel 4.4, using this fw would make things easier
>>>
>>>
>>>
>>> nope. I don't know how many issues we've fixed since 4.4 but it's not a
>>> matter of just swapping out one firmware with another. You'll have better
>>> luck with plain vanilla 4.11 + regular firmware and restarting modifying
>>> one
>>> of the latest machine drivers.
>>
>>
>> Ok, I'll use 4.11 and post the results later
>>
>> Should I have any special care about I2S other than setting the format
>> um backend DAI?
>> Some module should be loaded?
>
>
> Things to look for
> - SSP routing: has to be SSP0 on baytrail-CR
> - number of slots: 2 or 4. if 4 then use DSP mode
> - DAI format
> - MCLK

Hi, I'd like to share a feedback:

I switched to kernel 4.11, applied some previous changes (made with
kernel 4.4) and started a new machine driver using bytcr_rt5640 as
base.

After some adjustments and a temp fix (see remarks bellow) I was able
to route sound using headphones
Routing to speaker doesn't give any audio (Lenovo code seems to uses
GPIO to power/enable speakers on probe before setting routes...)

Remarks:

* setting pll/fll using snd_soc_dai_set_pll didn't work. I had to map
the codec member from snd_soc_dai struct and use
   snd_soc_codec_set_pll instead (used the same constants used on
Lenovo source code)

 - Had also to set sysclk to  codecs, not only to dai's using
snd_soc_codec_set_sysclk

* This device (Lenovo Yoga 2 1051F) is a bytcr device. However bios
status returned by iosf_mbi_read is
    1000000001000000000000101000000 (bits 26:27 disabled).
   Had to force  bytcr flag to be true  in order to apply correct MCLK
frequency (25Mhz) and use SSP0

* Used commands from rt5640 UCM file, removing 5640 specifics and
using Wolfson ones (thanks to Charles for point this out previously):
cset name='HPOUT1L Input 1' AIF1RX1
cset name='HPOUT1R Input 1' AIF1RX2
cset name='HPOUT1 Digital Switch' on


cset name='Headphone Switch'  on

* Used some patches to enable wm5102 ACPI detection (credits to
Christian Hartmann)

* Added a voltage supplier needed to wm5102 (added to arizona-ldo
directly - Lenovo and rpi register a platform with these)
* hardcoded ldoena, reset and irq_gpio on arizona-core (tried to get
those from gpio, but they didn't give me the correct values. Lack of
knowledge... )

* The codec chip uses SPI, not IC2 like 5640 (don't know if this is
relevant for machine driver code)

I've pushed these to github  in case you want to check it [A]

Also, this is the Android-x86 testing image generated with these changes [B]

Many thanks for the support!

Regards,
Pstglia

[A] - https://github.com/pstglia/linux/tree/lenovo_yoga2_returns-4.11
[B] - https://drive.google.com/file/d/0BxO6THtB865fQ3VhRUZoc1BMNkE/view?usp=sharing
