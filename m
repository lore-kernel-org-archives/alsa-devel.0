From: Jorge <jorge.sanjuan@codethink.co.uk>
Subject: Re: [alsa-devel] [PATCH 0/4] usb-audio: Add UAC3 Power Domains
Date: Fri, 27 Jul 2018 11:44:18 +0100
Message-ID: <59bd0814-e41e-667d-62d1-78194e7a8127@codethink.co.uk>
References: <20180719112215.4219-1-jorge.sanjuan@codethink.co.uk>
 <s5hlga78mmp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hlga78mmp.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 19/07/18 12:56, Takashi Iwai wrote:
> On Thu, 19 Jul 2018 13:22:11 +0200,
> Jorge Sanjuan wrote:
>>
>> This patchset add support for UAC3 Power Domains. This feature
>> of the USB audio class 3 allows the host to notify the device
>> what it is making use of so power comsumption can be optimized.
>>
>> This proposal implements this feature for Power Domains
>> that include an Input/Output Terminal associated to an
>> audio Streaming interface. This is the main usage of this
>> feature according to the spec. For that reason, the logic
>> for the Power Domain state change has been implemented
>> within the ALSA PCMs logic and the suspend/resume callbacks
>> of the usb_driver. The behaviour would be as follows:
>>
>> * Power Domain State D0: A Power Domain will reach this state
>>    only when the audio substream associated to that domain is
>>    being used (i,e. Audio playback/capture is happening).
>> * Power Domain State D1: This is the Idle state where the driver
>>    is going to always want to be in order to reduce power
>>    consumption.
>> * Power Domain State D2: This state is only set when the usb driver
>>    asumes the device is not going to be used anymore and hence, it
>>    wont care about getting any interrupts from the device. This
>>    will only happen when power level is set to "auto" in sysfs
>>    so the usb driver gets suspended when the interfaces are not in use.
>>   
>> NOTE: The way this has been implemented will always try to put the
>> Power Domain in state D1 if the Power Domain exists so there is not a
>> way a user could disable this feature. It may be worth getting a control
>> exposed to userland that enables/disables this feature (?).
> 
> Can it be tied with runtime PM?
> 
> Need to read through your patchset at first...
> 
> 
> thanks,
> 
> Takashi

Hi,

I just realized I accidentally only replied to alsa-devel.. Sorry about 
that.

I think it should be possible to tie up the D1 state changes (low power 
but still interrupt capable) to runtime PM. Changes to D2 are already 
tied to PM in this patchset. Just need to find the way to cleanly access 
`dev->power.runtime_auto` before the driver attempts to set D1 state. We 
could also let the driver only do D2<->D0 changes for now.

I got some kbuild errors due to missing include. Should I re-send this 
patchset or try to go around getting it tied up to runtime PM first?

Regards,

Jorge

> 
> 
>> Power Domains affecting other units independently are required to be
>> bypassed via a Selector Unit first before the host can change the
>> power state. This sceneario is not covered in this patchset.
>>
>> based on next-20180719
>>
>> Jorge Sanjuan (4):
>>    ALSA: usb-audio: Initial Power Domain support
>>    ALSA: usb-audio: AudioStreaming Power Domain parsing
>>    ALSA: usb-audio: Operate UAC3 Power Domains in PCM callbacks
>>    ALSA: usb-audio: Add UAC3 Power Domains to suspend/resume
>>
>>   include/linux/usb/audio-v3.h |   4 ++
>>   sound/usb/Makefile           |   1 +
>>   sound/usb/card.c             |   9 ++++
>>   sound/usb/card.h             |   2 +
>>   sound/usb/pcm.c              |  64 +++++++++++++++++++++--
>>   sound/usb/pcm.h              |   2 +
>>   sound/usb/power.c            | 117 +++++++++++++++++++++++++++++++++++++++++++
>>   sound/usb/power.h            |  19 +++++++
>>   sound/usb/stream.c           |  70 +++++++++++++++++++++++---
>>   9 files changed, 277 insertions(+), 11 deletions(-)
>>   create mode 100644 sound/usb/power.c
>>
>> -- 
>> 2.11.0
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
