From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Sun, 28 Jun 2015 10:09:24 +0800
Message-ID: <CAN8ccibUWamJ6LX87rf+Byr=pdwN9HFX0WpoQ7_KUpQbZvwK8Q@mail.gmail.com>
References: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>
 <557E86DD.8020709@metafoo.de> <558EC138.8090906@gmail.com>
 <558EDA4F.5030309@ladisch.de> <558EE452.4010501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f170.google.com (mail-ob0-f170.google.com
 [209.85.214.170])
 by alsa0.perex.cz (Postfix) with ESMTP id ECC422605E1
 for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2015 04:09:25 +0200 (CEST)
Received: by obbop1 with SMTP id op1so86767284obb.2
 for <alsa-devel@alsa-project.org>; Sat, 27 Jun 2015 19:09:25 -0700 (PDT)
In-Reply-To: <558EE452.4010501@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Arun Raghavan <arun@accosted.net>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

>>>>
>>>> So SNDRV_PCM_INFO_BLOCK_TRANSFER is mainly important for rewind
handling
>>>> and devices with that flag set might need additional headroom since the
>>>> data up to one period after the pointer position has already been
copied
>>>> to the dedicated memory and hence can no longer be overwritten.
>>>
>>>
>>> In kernel sources, sound/pci/hda/hda_controller.c mentions
>>> SNDRV_PCM_INFO_BLOCK_TRANSFER. However, sub-period rewinds work fine
>>> on this driver, and the avail granularity is something like 64 bytes.

This is hardware specific feature which is essential for timer based
scheduling.

Even snd-usb-audio use a default number of packets for larger period size,
it is still need to change to use small period size for lowest latency

snd-hda-intel also set has .periods_max=32 which force driver not to use
small period size when application use maximum buffer size , it still
cannot adjust latency dynamically

>>
>>
>> HDA is a very typical PCI controller; if this flag were correct here,
>> pretty much _every_ driver would need it.
>
>
> Well, there are more PCI drivers with this flag than without it. So it
looks like a "typical error".
>
> aep@aep-haswell /usr/src/linux/sound $ grep -l
SNDRV_PCM_INFO_BLOCK_TRANSFER `grep -rl SNDRV_PCM_INFO_MMAP_VALID pci` | wc
-l
> 48
> aep@aep-haswell /usr/src/linux/sound $ grep -L
SNDRV_PCM_INFO_BLOCK_TRANSFER `grep -rl SNDRV_PCM_INFO_MMAP_VALID pci` | wc
-l
> 15
>
>
> I guess I should write a program that tests sub-period rewinds and post
it to the list.

>
>
>> Some (older) HDA controllers have problems with position reporting
>> (with workarounds in the drivers), but those problems are with the
>> timing, not with the granularity.
>>
>> As far as I can see, snd-hda-intel should just drop this flag.
>
>

http://lxr.free-electrons.com/ident?i=SNDRV_PCM_INFO_BLOCK_TRANSFER

SNDRV_PCM_INFO_BLOCK_TRANSFER is not present in those ISA sound cards which
use io ports to transfer data

Why do alsa-time-test.c use

if (cap == 0)
      r = snd_pcm_sw_params_set_avail_min(pcm, swparams, 1);
    else
      r = snd_pcm_sw_params_set_avail_min(pcm, swparams, 0);
    assert(r == 0);

What is oss wakeup point ?

snd_pcm_sw_params_set_avail_min

This is similar to setting an OSS wakeup point. The valid values for 'val'
are determined by the specific hardware. Most PC sound cards can only
accept power of 2 frame counts (i.e. 512, 1024, 2048).

Why sw_params use hardhware specific value ?

Can this value set to grsnularity which is smaller than period size since
the function silently force avail_min not less than period size ?
