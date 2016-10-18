From: Mike Travis <travis@sgi.com>
Subject: Re: [PATCH] ALSA: hda - allow 40 bit DMA mask for NVidia devices
Date: Tue, 18 Oct 2016 06:04:31 -0700
Message-ID: <40321a07-bff4-4293-d85b-bddba31d1c33@sgi.com>
References: <1476721439-29519-1-git-send-email-ard.biesheuvel@linaro.org>
 <s5hmvi254yx.wl-tiwai@suse.de> <fd423738-3b5a-6d04-682e-8c93dd16f6ec@sgi.com>
 <CAKv+Gu9xTbnt+qoDjj3CHMbFTf_TWsF-QdCZnAS3dKZ+EBfOpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKv+Gu9xTbnt+qoDjj3CHMbFTf_TWsF-QdCZnAS3dKZ+EBfOpQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, perex@perex.cz, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org



On 10/18/2016 5:49 AM, Ard Biesheuvel wrote:
> On 18 October 2016 at 13:46, Mike Travis <travis@sgi.com> wrote:
>>
>> Have you tested this change on a system which has physical
>> addressing > 40 bits to insure that addresses > 40 bits are
>> not simply truncated to an incorrect (mod 40) address?
> 
> The device should never see addresses > 40 bits, given that the DMA
> mask is set to 40 bits not 64.

I agree that the device should never see that.  But how is that
restriction imposed?  If a user presents an buffer address > 40 bits
how would that be converted to useful buffer at <= 40 bits?

I believe I tried this (at the time the kernel was at version 2.6)
and it did not work.  Since audio I/O was such a low (relative)
bandwidth, it was not worth the effort to rework the audio code
to allow buffers > 32 bits but <= 40 bits.  It may have changed
since then?

> 
>> By not restricting the addresses to 32 bits you are not
>> restricting the device to the DMA32 zone.
>>
>> This is what caused the original panic on UV systems.
>>
>> Btw, the newest nVidia GPUs have > 40 bits of DMA address bits.
>>
> 
> Thanks,
> Ard.
> 
