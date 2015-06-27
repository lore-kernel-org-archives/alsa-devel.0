From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Sat, 27 Jun 2015 19:15:59 +0200
Message-ID: <558EDA4F.5030309@ladisch.de>
References: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>	<557E86DD.8020709@metafoo.de>
 <558EC138.8090906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 0BCC12619BE
 for <alsa-devel@alsa-project.org>; Sat, 27 Jun 2015 19:17:11 +0200 (CEST)
In-Reply-To: <558EC138.8090906@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Arun Raghavan <arun@accosted.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Alexander E. Patrakov wrote:
> 15.06.2015 13:03, Lars-Peter Clausen wrote:
>> So SNDRV_PCM_INFO_BLOCK_TRANSFER is mainly important for rewind handling
>> and devices with that flag set might need additional headroom since the
>> data up to one period after the pointer position has already been copied
>> to the dedicated memory and hence can no longer be overwritten.
>
> In kernel sources, sound/pci/hda/hda_controller.c mentions
> SNDRV_PCM_INFO_BLOCK_TRANSFER. However, sub-period rewinds work fine
> on this driver, and the avail granularity is something like 64 bytes.

HDA is a very typical PCI controller; if this flag were correct here,
pretty much _every_ driver would need it.

Some (older) HDA controllers have problems with position reporting
(with workarounds in the drivers), but those problems are with the
timing, not with the granularity.

As far as I can see, snd-hda-intel should just drop this flag.


Regards,
Clemens
