From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Question on arm64 unaligned faults during playback
Date: Mon, 08 Dec 2014 09:49:37 +0100
Message-ID: <54856621.8090107@ladisch.de>
References: <CAM4voa=kiLsiLEzUbo3D+f1go5px78fXBSjSi7kGK4QCdnwPyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 57D41260430
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 09:49:41 +0100 (CET)
In-Reply-To: <CAM4voa=kiLsiLEzUbo3D+f1go5px78fXBSjSi7kGK4QCdnwPyQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Abhilash Kesavan <kesavan.abhilash@gmail.com>, b42378@freescale.com, lars@metafoo.de, tiwai@suse.de, perex@perex.cz, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, lgirdwood@gmail.com, p.zabel@pengutronix.de, padma.v@samsung.com
List-Id: alsa-devel@alsa-project.org

Abhilash Kesavan wrote:
> I am working on a 64-bit ARM SoC (Samsung's Exynos7) and have observed
> unaligned faults while testing certain sound streams with aplay.
>
> [   24.535661] snd_pcm_lib_write_transfer:sound/core/pcm_lib.c hwbuf is ffffff8000085624, runtime->dma_area is ffffff8000080000, hwoff is 5513, frames_to_bytes is 22052, frames is 5513
> [   24.551244] Unhandled fault: alignment fault (0x96000061) at 0xffffff8000085624
> [   24.579944] PC is at __copy_from_user+0x14/0x60
> [   24.584450] LR is at snd_pcm_lib_write_transfer+0xe4/0x104
> [   24.922054] Call trace:
> [   24.924488] [<ffffffc0002d4784>] __copy_from_user+0x14/0x60
> [   24.930040] [<ffffffc0004b7574>] snd_pcm_lib_write1+0x1fc/0x384
>
> We are using the internal sram available for sound, for DMA buffer
> allocation, using the generic SRAM driver. From the above log, the
> buffer address offset is not 8-byte aligned and as we are using the
> SRAM driver which maps the memory as device memory we are getting an
> unaligned fault. Is it incorrect to use the generic sram driver for
> arm64 or am I missing something ?

When you give the ALSA framework a memory buffer, it is assumed that it
is general-purpose memory, i.e., can be accessed with any alignment.

If your memory does not allow such accesses, you have to do all the
accesses in your driver, i.e., do everything in the .copy/.silence
callbacks.  (You also have to add constraints so that periods and buffer
are correctly aligned.)


Regards,
Clemens
