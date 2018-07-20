From: Jorge <jorge.sanjuan@codethink.co.uk>
Subject: Re: [PATCH 0/4] usb-audio: Add UAC3 Power Domains
Date: Fri, 20 Jul 2018 10:08:49 +0100
Message-ID: <d045c5d5-0fb2-3d65-73db-037ed720f5b2@codethink.co.uk>
References: <20180719112215.4219-1-jorge.sanjuan@codethink.co.uk>
 <s5hlga78mmp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FC0826770A
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 11:08:50 +0200 (CEST)
Received: from [148.252.241.226] (helo=[10.35.4.103])
 by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
 id 1fgRP8-0006oP-Bb
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 10:08:50 +0100
In-Reply-To: <s5hlga78mmp.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
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

Sure. I think that could work. So the snd-usb driver would only attempt 
to drop a Power Domain from D0 to D1 only if (dev->power.runtime_auto == 
true)? Is there any clean way to check for that? I couldn't find any 
helper function.

The change to D2 state is already wrapped in runtime PM as usb_driver 
.suspend callback only gets called when runtime PM is enabled from sysfs.

Thanks,

Jorge

> 
> Need to read through your patchset at first...
> 
> 
> thanks,
> 
> Takashi
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
