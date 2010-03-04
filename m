From: Wei Ni <wni@nvidia.com>
Subject: RE: [alsa-devel] [PATCH]Support MCP89 and GT21x hdmi audio
Date: Thu, 4 Mar 2010 10:21:39 +0800
Message-ID: <6B4D417B830BC44B8026029FD256F7F1C16B1AD54C@HKMAIL01.nvidia.com>
References: <6B4D417B830BC44B8026029FD256F7F1C068B2BA8B@HKMAIL01.nvidia.com>
	<s5hmxyrp311.wl%tiwai@suse.de>
	<6B4D417B830BC44B8026029FD256F7F1C068B2BA8C@HKMAIL01.nvidia.com>
	<s5heik3ujy0.wl%tiwai@suse.de>
	<6B4D417B830BC44B8026029FD256F7F1C16A89A118@HKMAIL01.nvidia.com>
	<6B4D417B830BC44B8026029FD256F7F1C16A89A11A@HKMAIL01.nvidia.com>
	<s5haaupoqew.wl%tiwai@suse.de>
	<6B4D417B830BC44B8026029FD256F7F1C16A89A11C@HKMAIL01.nvidia.com>
 <s5htysxm5yo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5htysxm5yo.wl%tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: 'Pavel Hofman' <pavel.hofman@insite.cz>, 'alsa-devel' <alsa-devel@alsa-project.org>, 'linux-kernel' <linux-kernel@vger.kernel.org>, 'akpm' <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

Hi, Takashi
1. Yes, it can works for all Nvidia controller.
2. The hda_eld.o doesn't export any symbols.
I tried to put hda_eld.o to snd-had-codec-*, and remove had_eldo.o
from snd-had-codec-intelhdmi-objs, but it will build error. It need
to modify hda_eld.c to export symbols, it will add many changes.

Thanks
Wei.
nvpublic

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Thursday, March 04, 2010 5:49 AM
To: Wei Ni
Cc: 'Pavel Hofman'; 'alsa-devel'; 'linux-kernel'; 'akpm'
Subject: Re: [alsa-devel] [PATCH]Support MCP89 and GT21x hdmi audio

At Wed, 3 Mar 2010 15:21:12 +0800,
Wei Ni wrote:
> 
> Hi, Takashi
> I generate the new patch file, please check it.

Thanks.  Review comments below:

> @@ -1367,6 +1368,7 @@ static void azx_bus_reset(struct hda_bus *bus)
>  
>  /* number of codec slots for each chipset: 0 = default slots (i.e. 4) */
>  static unsigned int azx_max_codecs[AZX_NUM_DRIVERS] __devinitdata = {
> +	[AZX_DRIVER_NVIDIA] = 8,

Are you sure that this works for all Nvidia controller chips including
the old nForce chipset?

 
> diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
> index 315a1c4..199f440 100644
> --- a/sound/pci/hda/Makefile
> +++ b/sound/pci/hda/Makefile
> @@ -17,7 +17,7 @@ snd-hda-codec-cirrus-objs :=	patch_cirrus.o
>  snd-hda-codec-ca0110-objs :=	patch_ca0110.o
>  snd-hda-codec-conexant-objs :=	patch_conexant.o
>  snd-hda-codec-via-objs :=	patch_via.o
> -snd-hda-codec-nvhdmi-objs :=	patch_nvhdmi.o
> +snd-hda-codec-nvhdmi-objs :=	patch_nvhdmi.o hda_eld.o
>  snd-hda-codec-intelhdmi-objs :=	patch_intelhdmi.o hda_eld.o

This is buggy.  You cannot create multiple modules containing the
same *.o file that exports symbols.

Instead, put hda_eld.o to snd-hda-codec-* (currently commented out),
and remove hda_eld.o from snd-hda-codec-intelhdmi-objs.


Takashi
