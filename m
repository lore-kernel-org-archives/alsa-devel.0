From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: 2 speakers are assigned to the same DAC,
 this can't support 4.0/2.1 channles
Date: Wed, 10 Jun 2015 09:30:50 +0800
Message-ID: <CAN8cciYSHi8oxzK=-JteeBfhyQNywGXO0Wjpz6Y+UEdxwoHFNw@mail.gmail.com>
References: <5576B419.5010505@canonical.com>
 <CAN8cciZLkpzNYRcKDxExX7WpaQJ1QVNnEecnYLLN4MqK=orKcA@mail.gmail.com>
 <5576E81F.9070703@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f173.google.com (mail-ob0-f173.google.com
 [209.85.214.173])
 by alsa0.perex.cz (Postfix) with ESMTP id E0690265846
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 03:30:51 +0200 (CEST)
Received: by obbqz1 with SMTP id qz1so24808156obb.3
 for <alsa-devel@alsa-project.org>; Tue, 09 Jun 2015 18:30:51 -0700 (PDT)
In-Reply-To: <5576E81F.9070703@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hui Wang <hui.wang@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

>>>
>>> I am trying to enable the subwoofer speaker on a HP laptop, on this
>>> machine, there are two speakers and one headphone, but the BIOS verb
>>> only enabled one speaker(nid 0xd) and one headphone(nid 0xb), I need
>>> to use quirk in the kernel driver to configure the second speaker
>>> (subwoofer speaker, nid 0x10). Under current alsa driver, the
>>> headphone will be assigned a dac (nid 0x13) and the 2 speakers will
>>> be assigned a dac (nid 0x14), this assignment is not good since 2
>>> speakers share the same dac, this means 2 speakers can't work
>>> at the same time to support 4.0/2.1 channels.
>>>
>>> On another Dell machine with realtek codec, there are also 2 speakers,
>>> 1 headphone and 2 dacs, on this machine, 1 speaker and 1 headphone are
>>
>> assigned
>>>
>>> 1 dac, and the other speaker is assigned another dac, so there is no
>>> problem for this machine to support 4.0/2.1 channels.
>>>
>>> Through debugging, I found on Dell machine, the speaker nid only has
>>> one connection to dac (hardwired), so when driver assign dac to it, the
>>> map_single() can successfully assign the each dac to the 2 speakers
>>
>> respectively.
>>>
>>> But on that HP machine, the speaker has multiple connections for dac,
the
>>> map_single() can't work for this machine.
>>>
>>>
>>> The alsa-info.txt for that HP machine is at
>>
>> http://pastebin.ubuntu.com/11667947/
>>
>> Refer to 92HD91, you don't need 4 channel when there is band pass filter
>> for the subwoofer at the mono pin
>
> Yes, you are right.
>
>>
>> 2.2. Mono Output
>> The Mono Out port source selection, power state, and mute characteristics
>> are all independently
>> controlled by the mono output port controls. EQ does not apply to this
>> path. An internal 2nd order band-pass filter is provided to restrict the
>> output frequencies when using mono out to drive an exter-
>> nal amplified sub-woofer
>
> Where did you find this text? Does it mean there is a hardware low
frequency pass filter inside the codec?

http://www.temposemi.com/products/pclaptop-hd/92hd91/

2.3. Mono output Band-Pass Filter
For many applications, the primary speakers are incapable of reproducing
low frequency audio. Therefore it is desirable to implement a woofer or
sub-woofer speaker. The mono output is ideal for this task. However, the
frequency response should be restricted to prevent interference with the
primary speakers. Typically an external filter, known as a cross-over
filter, is used. The mono processing path includes a band-pass filter with
programmable high and low cut-off frequencies to eliminate the need for an
external filter.

2.3.1. Mixer Filter Description The band-pass filter is derived from the
common biquadratic filter and provides a 12dB/octave roll-off. The filter
may be programmed for a -3dB lower band edge of: 63Hz, 80Hz, 100Hz, 120Hz,
150Hz, 200Hz, 315Hz, or 400Hz.

The filter may be programmed for a -3dB upper band edge of: 150Hz, 200Hz,
250Hz, 315Hz, 400Hz, 500Hz, 630Hz, or 800Hz.

The band-pass filter is enabled by default with a cut-off frequencies at
120Hz and 250Hz. The filter may be bypassed using the associated verb
(processing state verb
