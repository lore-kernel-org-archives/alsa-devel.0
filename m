From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH 2/2] ALSA: hda: Allow HDA to be runtime suspended when
 dGPU is not bound
Date: Tue, 27 Aug 2019 22:50:03 +0800
Message-ID: <97D68761-4152-4D77-B222-14EA892503DB@canonical.com>
References: <20190827134756.10807-1-kai.heng.feng@canonical.com>
 <20190827134756.10807-2-kai.heng.feng@canonical.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827134756.10807-2-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, tiwai@suse.com
Cc: linux-pci@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

at 21:47, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:

> It's a common practice to let dGPU unbound and use PCI port PM to
> disable its power through _PR3. When the dGPU comes with an HDA
> function, the HDA won't be suspended if the dGPU is unbound, so the dGPU
> power can't be disabled.
>
> Commit 37a3a98ef601 ("ALSA: hda - Enable runtime PM only for
> discrete GPU") only allows HDA to be runtime-suspended once GPU is
> bound, to keep APU's HDA working.
>
> However, HDA on dGPU isn't that useful if dGPU is unbound. So let relax
> the runtime suspend requirement for dGPU's HDA function, to save lots of
> power.
>
> BugLink: https://bugs.launchpad.net/bugs/1840835
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> —

Forgot to mention that for some platforms this issue happen after commit  
b516ea586d71 ("PCI: Enable NVIDIA HDA controllers”) which starts to unhide  
the “hidden” HDA.

Kai-Heng

>  sound/pci/hda/hda_intel.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 99fc0917339b..d4ee070e1a29 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1285,7 +1285,8 @@ static void init_vga_switcheroo(struct azx *chip)
>  		dev_info(chip->card->dev,
>  			 "Handle vga_switcheroo audio client\n");
>  		hda->use_vga_switcheroo = 1;
> -		hda->need_eld_notify_link = 1; /* cleared in gpu_bound op */
> +		/* cleared in gpu_bound op */
> +		hda->need_eld_notify_link = !pci_pr3_present(p);
>  		chip->driver_caps |= AZX_DCAPS_PM_RUNTIME;
>  		pci_dev_put(p);
>  	}
> -- 
> 2.17.1
