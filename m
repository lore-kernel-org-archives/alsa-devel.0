From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Sat, 27 Jun 2015 22:58:42 +0500
Message-ID: <558EE452.4010501@gmail.com>
References: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>
 <557E86DD.8020709@metafoo.de> <558EC138.8090906@gmail.com>
 <558EDA4F.5030309@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id D83FB2619FB
 for <alsa-devel@alsa-project.org>; Sat, 27 Jun 2015 19:58:45 +0200 (CEST)
Received: by wgqq4 with SMTP id q4so111155742wgq.1
 for <alsa-devel@alsa-project.org>; Sat, 27 Jun 2015 10:58:45 -0700 (PDT)
In-Reply-To: <558EDA4F.5030309@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Lars-Peter Clausen <lars@metafoo.de>, Arun Raghavan <arun@accosted.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

27.06.2015 22:15, Clemens Ladisch wrote:
> Alexander E. Patrakov wrote:
>> 15.06.2015 13:03, Lars-Peter Clausen wrote:
>>> So SNDRV_PCM_INFO_BLOCK_TRANSFER is mainly important for rewind handling
>>> and devices with that flag set might need additional headroom since the
>>> data up to one period after the pointer position has already been copied
>>> to the dedicated memory and hence can no longer be overwritten.
>>
>> In kernel sources, sound/pci/hda/hda_controller.c mentions
>> SNDRV_PCM_INFO_BLOCK_TRANSFER. However, sub-period rewinds work fine
>> on this driver, and the avail granularity is something like 64 bytes.
>
> HDA is a very typical PCI controller; if this flag were correct here,
> pretty much _every_ driver would need it.

Well, there are more PCI drivers with this flag than without it. So it 
looks like a "typical error".

aep@aep-haswell /usr/src/linux/sound $ grep -l 
SNDRV_PCM_INFO_BLOCK_TRANSFER `grep -rl SNDRV_PCM_INFO_MMAP_VALID pci` | 
wc -l
48
aep@aep-haswell /usr/src/linux/sound $ grep -L 
SNDRV_PCM_INFO_BLOCK_TRANSFER `grep -rl SNDRV_PCM_INFO_MMAP_VALID pci` | 
wc -l
15


I guess I should write a program that tests sub-period rewinds and post 
it to the list.

> Some (older) HDA controllers have problems with position reporting
> (with workarounds in the drivers), but those problems are with the
> timing, not with the granularity.
>
> As far as I can see, snd-hda-intel should just drop this flag.

-- 
Alexander E. Patrakov
