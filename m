From: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Subject: Re: Question on arm64 unaligned faults during playback
Date: Tue, 9 Dec 2014 08:26:47 +0530
Message-ID: <CAM4voakyorp6r==7AfZiZbA1kTF1VN1SqJiauJRYptsFnG2ZLA@mail.gmail.com>
References: <CAM4voa=kiLsiLEzUbo3D+f1go5px78fXBSjSi7kGK4QCdnwPyQ@mail.gmail.com>
 <54856621.8090107@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f51.google.com (mail-qg0-f51.google.com
 [209.85.192.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B4582605B7
 for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2014 03:56:48 +0100 (CET)
Received: by mail-qg0-f51.google.com with SMTP id e89so3273564qgf.24
 for <alsa-devel@alsa-project.org>; Mon, 08 Dec 2014 18:56:47 -0800 (PST)
In-Reply-To: <54856621.8090107@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, padma.v@samsung.com, tiwai@suse.de, b42378@freescale.com, Liam Girdwood <lgirdwood@gmail.com>, broonie@kernel.org, p.zabel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

On Mon, Dec 8, 2014 at 2:19 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Abhilash Kesavan wrote:
>> I am working on a 64-bit ARM SoC (Samsung's Exynos7) and have observed
>> unaligned faults while testing certain sound streams with aplay.
>>
>> [   24.535661] snd_pcm_lib_write_transfer:sound/core/pcm_lib.c hwbuf is ffffff8000085624, runtime->dma_area is ffffff8000080000, hwoff is 5513, frames_to_bytes is 22052, frames is 5513
>> [   24.551244] Unhandled fault: alignment fault (0x96000061) at 0xffffff8000085624
>> [   24.579944] PC is at __copy_from_user+0x14/0x60
>> [   24.584450] LR is at snd_pcm_lib_write_transfer+0xe4/0x104
>> [   24.922054] Call trace:
>> [   24.924488] [<ffffffc0002d4784>] __copy_from_user+0x14/0x60
>> [   24.930040] [<ffffffc0004b7574>] snd_pcm_lib_write1+0x1fc/0x384
>>
>> We are using the internal sram available for sound, for DMA buffer
>> allocation, using the generic SRAM driver. From the above log, the
>> buffer address offset is not 8-byte aligned and as we are using the
>> SRAM driver which maps the memory as device memory we are getting an
>> unaligned fault. Is it incorrect to use the generic sram driver for
>> arm64 or am I missing something ?
>
> When you give the ALSA framework a memory buffer, it is assumed that it
> is general-purpose memory, i.e., can be accessed with any alignment.
>
> If your memory does not allow such accesses, you have to do all the
> accesses in your driver, i.e., do everything in the .copy/.silence
> callbacks.  (You also have to add constraints so that periods and buffer
> are correctly aligned.)

Thanks for the reply. Exynos7 is using generic dmaengine and the
default dmaengine_pcm_ops does not have the copy/silence call-backs
populated. Is the expectation that I should add the  copy call-back
for my platform even though it uses the generic dmaengine framework ?

Regards,
Abhilash
>
>
> Regards,
> Clemens
