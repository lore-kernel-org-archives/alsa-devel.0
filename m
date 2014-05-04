From: Delcypher <delcypher@gmail.com>
Subject: Re: Regression Intel Corporation Haswell-ULT HD Audio
	Controller
Date: Sun, 4 May 2014 12:45:03 +0100
Message-ID: <CANNJ_zj6=33FLQAJmWszn7JoCdMGPciqPwdqd3Wx-Ng+xB-shQ@mail.gmail.com>
References: <CANNJ_zh6HXT-pdkOV9XpDor3J1aFVbi3zbHLyDnpgisu7DdMdA@mail.gmail.com>
 <CAN8cciaBw0CZ7VhCs2XnRgKaE_KXZ-B7rLhLxG_Y7NfGUX6o1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f182.google.com (mail-ve0-f182.google.com
 [209.85.128.182])
 by alsa0.perex.cz (Postfix) with ESMTP id D7359261A28
 for <alsa-devel@alsa-project.org>; Sun,  4 May 2014 13:45:04 +0200 (CEST)
Received: by mail-ve0-f182.google.com with SMTP id sa20so1198246veb.13
 for <alsa-devel@alsa-project.org>; Sun, 04 May 2014 04:45:03 -0700 (PDT)
In-Reply-To: <CAN8cciaBw0CZ7VhCs2XnRgKaE_KXZ-B7rLhLxG_Y7NfGUX6o1g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 4 May 2014 04:09, Raymond Yau <superquad.vortex2@gmail.com> wrote:
>
>> I'm having an issue with " Intel Corporation Haswell-ULT HD Audio
>> Controller" card which is inside the Dell XPS13 9333 developer edition
>> [1].
>>
>> I've tried two different distributions
>>
>> * Arch Linux (kernel 3.14)
>> Output of alsa-utlils-alsa-info.sh [2]
>>
>> * Ubuntu 14.04 LTS (kernel 3.13)
>> Output of alsa-utlils-alsa-info.sh [3]
>>
>> The card behaves correctly under Ubuntu but under Arch Linux I've
>> observed the following issues.
>>
>> - The microphone does not work correctly. In alsamixer I select
>> "Internal Mic" as my capture device but when I do
>>
>
> how many audio jacks do your laptop have ?

I am only aware of one. I think it's one of these TRRS jack
connectors. Conceptually I should only have two inputs: Internal Mic
and headset jack. The alsamixer shows
the following channels that I can enable/disable CAPTURE on

- Headphone Mic
- Capture
- Headset Mic
- Internal Mic

which is pretty confusing. I don't know what the "Capture" channel is.
Also the names "Headphone Mic" and "Headset Mic" mean the same thing
to me. Although that link you sent me seems to suggest to me that

- Headset mic probably refers to plugging in a headset that uses a
TRRS jack so audio out and in go through the same jack
- Headphone mic probably refers to plugging in a TS jack into the the
Headset port (the only audio port on my system) and using that as a
microphone

Is that right?

> /sys/class/sound/hwC1D0/init_pin_configs:
> 0x12 0x90a60140
> 0x14 0x90170110
> 0x15 0x0321101f
> 0x16 0x40000000
> 0x18 0x411111f0
> 0x19 0x411111f0
> 0x1a 0x411111f0
> 0x1b 0x411111f0
> 0x1d 0x40d6832d
> 0x1e 0x411111f0
> 0x1f 0x411111f0
>
> /sys/class/sound/hwC1D0/driver_pin_configs:
> 0x19 0x03a1913d
> 0x1b 0x03a1113c
>
>
> seem driver assign sequence number c and d to some of the pin to indicate
> support of headset mic and headphone mic

Unfortunately without some explanation of the above pin mappings (I'm
not an ALSA developer) I cannot understand what the above means. I'm
guessing column1 is pin number and column2 is value? What is
init_pin_configs and what is driver_pin_configs?

> do your laptop specification support headset, headphone or mic if your
> laptop has only one jack ?

The icon next to the jack is the "headset" (headphones with attached
microphone) icon, but I have no idea. The specification refers to the
port as "headset (microphone and headphone combo) port". The specs can
be found at [1]

> http://voices.canonical.com/david.henningsson/2014/03/07/headset-jacks-on-newer-laptops/

I do not have a headset or external mic to test with unfortunately.
I'm only interested in using the internal mic.

[1] ftp://ftp.dell.com/Manuals/all-products/esuprt_laptop/esuprt_xps_laptop/xps-13-9333_Reference%20Guide_en-us.pdf

Thanks,
Dan.
