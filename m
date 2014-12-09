From: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Subject: Re: Question on arm64 unaligned faults during playback
Date: Tue, 9 Dec 2014 08:26:52 +0530
Message-ID: <CAM4voanE_P-P=4q+ctL2gwa++FOOSrXYcoUN936wuMscBKF6jg@mail.gmail.com>
References: <CAM4voa=kiLsiLEzUbo3D+f1go5px78fXBSjSi7kGK4QCdnwPyQ@mail.gmail.com>
 <54856621.8090107@ladisch.de> <s5hppbumnis.wl-tiwai@suse.de>
 <54858868.70708@metafoo.de> <20141208113119.GL27367@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f54.google.com (mail-qa0-f54.google.com
 [209.85.216.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 715FB2605D7
 for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2014 03:56:53 +0100 (CET)
Received: by mail-qa0-f54.google.com with SMTP id i13so4204752qae.41
 for <alsa-devel@alsa-project.org>; Mon, 08 Dec 2014 18:56:52 -0800 (PST)
In-Reply-To: <20141208113119.GL27367@arm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Will Deacon <will.deacon@arm.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, "padma.v@samsung.com" <padma.v@samsung.com>, Takashi Iwai <tiwai@suse.de>, Catalin Marinas <Catalin.Marinas@arm.com>, "b42378@freescale.com" <b42378@freescale.com>, Clemens Ladisch <clemens@ladisch.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi Will,

On Mon, Dec 8, 2014 at 5:01 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Dec 08, 2014 at 11:15:52AM +0000, Lars-Peter Clausen wrote:
>> Added ARM64 folks to Cc.
>>
>> On 12/08/2014 11:41 AM, Takashi Iwai wrote:
>> > At Mon, 08 Dec 2014 09:49:37 +0100,
>> > Clemens Ladisch wrote:
>> >>
>> >> Abhilash Kesavan wrote:
>> >>> I am working on a 64-bit ARM SoC (Samsung's Exynos7) and have observed
>> >>> unaligned faults while testing certain sound streams with aplay.
>> >>>
>> >>> [   24.535661] snd_pcm_lib_write_transfer:sound/core/pcm_lib.c hwbuf is ffffff8000085624, runtime->dma_area is ffffff8000080000, hwoff is 5513, frames_to_bytes is 22052, frames is 5513
>> >>> [   24.551244] Unhandled fault: alignment fault (0x96000061) at 0xffffff8000085624
>> >>> [   24.579944] PC is at __copy_from_user+0x14/0x60
>> >>> [   24.584450] LR is at snd_pcm_lib_write_transfer+0xe4/0x104
>> >>> [   24.922054] Call trace:
>> >>> [   24.924488] [<ffffffc0002d4784>] __copy_from_user+0x14/0x60
>> >>> [   24.930040] [<ffffffc0004b7574>] snd_pcm_lib_write1+0x1fc/0x384
>> >>>
>> >>> We are using the internal sram available for sound, for DMA buffer
>> >>> allocation, using the generic SRAM driver. From the above log, the
>> >>> buffer address offset is not 8-byte aligned and as we are using the
>> >>> SRAM driver which maps the memory as device memory we are getting an
>> >>> unaligned fault. Is it incorrect to use the generic sram driver for
>> >>> arm64 or am I missing something ?
>> >>
>> >> When you give the ALSA framework a memory buffer, it is assumed that it
>> >> is general-purpose memory, i.e., can be accessed with any alignment.
>> >>
>> >> If your memory does not allow such accesses, you have to do all the
>> >> accesses in your driver, i.e., do everything in the .copy/.silence
>> >> callbacks.  (You also have to add constraints so that periods and buffer
>> >> are correctly aligned.)
>> >
>> > You can set runtime->min_align in the own hw_params callback so that
>> > the PCM core handle it well, at least, for non-mmap mode.
>> >
>> > But this feature has been rarely used (currently no driver sets it
>> > explicitly), so there might be still some bugs there, too :)
>>
>> As far as I can see min_align only aligns the hardware pointer, but not the
>> application pointer. The later causes the issue here.
>>
>> E.g. if a application writes a unaligned amount of bytes the next write will
>> start at an unaligned buffer address.
>>
>> How safe is it in general to use IO mapped memory as general purpose memory
>> on ARM64? Are there maybe even more constraints than just that access has to
>> be aligned? Maybe the driver should rather use copy_from_user_toio() instead
>> of copy_from_user() to make sure that things work correctly.
>
> If you're simply mapping RAM as device memory, then you need to ensure:
>
>   - Naturally aligned access
>   - No exclusive instructions (e.g atomics, locks, semaphores ...)
>
> Out of interest, why are you using device mappings for memory? By design,
> they prohibit speculation (and, depending on the subtype, re-ordering,
> gathering and early write response) and will be significantly slower than
> normal memory accesses.

Thanks for the comments.

We are using the generic SRAM allocation driver (drivers/misc/sram.c)
to use the internal audio SRAM for buffer allocation. The generic
driver ioremaps the sram and exposes the obtained pool via the
genalloc API to other drivers such as audio. There already exists
support for internal sram in the audio framework. The specific use
case is in an Exynos7 low power state where the DRAM cannot be used.

>
> Could you use something like ioremap_wc, which will give you normal,
> non-cacheable memory instead?

Modifying ioremap to ioremap_wc gets rid of the crash. Do you think
the sram driver ioremap usage should be modified to use ioremap_wc ?

Regards,
Abhilash
>
> Will
