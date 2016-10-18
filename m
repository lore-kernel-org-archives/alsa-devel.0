From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] ALSA: hda - allow 40 bit DMA mask for NVidia devices
Date: Tue, 18 Oct 2016 11:26:42 +0100
Message-ID: <CAKv+Gu_CVwb_Vbaj1j55c3nERzv6YR=STjJTqE7+v2T+Kh4RnA@mail.gmail.com>
References: <1476721439-29519-1-git-send-email-ard.biesheuvel@linaro.org> <s5hmvi254yx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hmvi254yx.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, perex@perex.cz, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mike Travis <travis@sgi.com>
List-Id: alsa-devel@alsa-project.org

On 18 October 2016 at 11:25, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 17 Oct 2016 18:23:59 +0200,
> Ard Biesheuvel wrote:
>>
>> Commit 49d9e77e72cf ("ALSA: hda - Fix system panic when DMA > 40 bits
>> for Nvidia audio controllers") simply disabled any DMA exceeding 32
>> bits for NVidia devices, even though they are capable of performing
>> DMA up to 40 bits. On some architectures (such as arm64), system memory
>> is not guaranteed to be 32-bit addressable by PCI devices, and so this
>> change prevents NVidia devices from working on platforms such as AMD
>> Seattle.
>>
>> Since the original commit already mentioned that up to 40 bits of DMA
>> is supported, and given that the code has been updated in the meantime
>> to support a 40 bit DMA mask on other devices, revert commit 49d9e77e72cf
>> and explicitly set the DMA mask to 40 bits for NVidia devices.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Thanks, applied.  Since this seems causing a real problem, I added Cc
> to stable.
>

Thanks!
