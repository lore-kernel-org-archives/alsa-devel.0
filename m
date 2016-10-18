From: Mike Travis <travis@sgi.com>
Subject: Re: [PATCH] ALSA: hda - allow 40 bit DMA mask for NVidia devices
Date: Tue, 18 Oct 2016 05:46:29 -0700
Message-ID: <fd423738-3b5a-6d04-682e-8c93dd16f6ec@sgi.com>
References: <1476721439-29519-1-git-send-email-ard.biesheuvel@linaro.org>
 <s5hmvi254yx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hmvi254yx.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: alsa-devel@alsa-project.org, perex@perex.cz, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


Have you tested this change on a system which has physical
addressing > 40 bits to insure that addresses > 40 bits are
not simply truncated to an incorrect (mod 40) address?
By not restricting the addresses to 32 bits you are not
restricting the device to the DMA32 zone.

This is what caused the original panic on UV systems.

Btw, the newest nVidia GPUs have > 40 bits of DMA address bits.

On 10/18/2016 3:25 AM, Takashi Iwai wrote:
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
> 
> Takashi
> 
> 
>> ---
>>  sound/pci/hda/hda_intel.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> index c3469f756ec2..c64d986009a9 100644
>> --- a/sound/pci/hda/hda_intel.c
>> +++ b/sound/pci/hda/hda_intel.c
>> @@ -341,8 +341,7 @@ enum {
>>  
>>  /* quirks for Nvidia */
>>  #define AZX_DCAPS_PRESET_NVIDIA \
>> -	(AZX_DCAPS_NO_MSI | /*AZX_DCAPS_ALIGN_BUFSIZE |*/ \
>> -	 AZX_DCAPS_NO_64BIT | AZX_DCAPS_CORBRP_SELF_CLEAR |\
>> +	(AZX_DCAPS_NO_MSI | AZX_DCAPS_CORBRP_SELF_CLEAR |\
>>  	 AZX_DCAPS_SNOOP_TYPE(NVIDIA))
>>  
>>  #define AZX_DCAPS_PRESET_CTHDA \
>> @@ -1716,6 +1715,10 @@ static int azx_first_init(struct azx *chip)
>>  		}
>>  	}
>>  
>> +	/* NVidia hardware normally only supports up to 40 bits of DMA */
>> +	if (chip->pci->vendor == PCI_VENDOR_ID_NVIDIA)
>> +		dma_bits = 40;
>> +
>>  	/* disable 64bit DMA address on some devices */
>>  	if (chip->driver_caps & AZX_DCAPS_NO_64BIT) {
>>  		dev_dbg(card->dev, "Disabling 64bit DMA\n");
>> -- 
>> 2.7.4
>>
>>
