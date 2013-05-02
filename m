From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH]: x86_64, audio: Fix system panic when DMA > 40 bits
Date: Thu, 02 May 2013 08:20:25 +0200
Message-ID: <518205A9.1050409@canonical.com>
References: <1367435048-66137-1-git-send-email-travis@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1367435048-66137-1-git-send-email-travis@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Travis <travis@sgi.com>, Stephen Warren <swarren@nvidia.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Russ Anderson <rja@sgi.com>
List-Id: alsa-devel@alsa-project.org

On 05/01/2013 09:04 PM, Mike Travis wrote:
> The audio driver mistakenly allows 64 bit addresses to be created for
> the audio driver on Nvidia GPUs.  Unfortunately, the hardware normally
> only supports up to 40 bits of DMA.  This can cause system panics as
> well as misdirected data when the address is > 40 bits as the upper
> part the address is truncated.

Thanks for this patch. Stephen Warren, is this something you can 
confirm/deny, and do you know what range of hardware this actually 
applies to?

>
> Signed-off-by: Mike Travis <travis@sgi.com>
> Reviewed-by: Mike Habeck <habeck@sgi.com>
> ---
>   sound/pci/hda/hda_intel.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index bcd40ee..45eb165 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -615,7 +615,7 @@ enum {
>   /* quirks for Nvidia */
>   #define AZX_DCAPS_PRESET_NVIDIA \
>   	(AZX_DCAPS_NVIDIA_SNOOP | AZX_DCAPS_RIRB_DELAY | AZX_DCAPS_NO_MSI |\
> -	 AZX_DCAPS_ALIGN_BUFSIZE)
> +	 AZX_DCAPS_ALIGN_BUFSIZE | AZX_DCAPS_NO_64BIT)
>
>   #define AZX_DCAPS_PRESET_CTHDA \
>   	(AZX_DCAPS_NO_MSI | AZX_DCAPS_POSFIX_LPIB | AZX_DCAPS_4K_BDLE_BOUNDARY)
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
