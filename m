From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] ALSA: hda - allow 40 bit DMA mask for NVidia devices
Date: Tue, 18 Oct 2016 13:49:09 +0100
Message-ID: <CAKv+Gu9xTbnt+qoDjj3CHMbFTf_TWsF-QdCZnAS3dKZ+EBfOpQ@mail.gmail.com>
References: <1476721439-29519-1-git-send-email-ard.biesheuvel@linaro.org>
 <s5hmvi254yx.wl-tiwai@suse.de> <fd423738-3b5a-6d04-682e-8c93dd16f6ec@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fd423738-3b5a-6d04-682e-8c93dd16f6ec@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Travis <travis@sgi.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, perex@perex.cz, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 18 October 2016 at 13:46, Mike Travis <travis@sgi.com> wrote:
>
> Have you tested this change on a system which has physical
> addressing > 40 bits to insure that addresses > 40 bits are
> not simply truncated to an incorrect (mod 40) address?

The device should never see addresses > 40 bits, given that the DMA
mask is set to 40 bits not 64.

> By not restricting the addresses to 32 bits you are not
> restricting the device to the DMA32 zone.
>
> This is what caused the original panic on UV systems.
>
> Btw, the newest nVidia GPUs have > 40 bits of DMA address bits.
>

Thanks,
Ard.
