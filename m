From: Wei Ni <wni@nvidia.com>
Subject: RE: [alsa-devel] [PATCH]Support MCP89 and GT21x hdmi audio
Date: Thu, 4 Mar 2010 19:09:29 +0800
Message-ID: <6B4D417B830BC44B8026029FD256F7F1C16B1AD555@HKMAIL01.nvidia.com>
References: <6B4D417B830BC44B8026029FD256F7F1C068B2BA8B@HKMAIL01.nvidia.com>
	<s5hmxyrp311.wl%tiwai@suse.de>
	<6B4D417B830BC44B8026029FD256F7F1C068B2BA8C@HKMAIL01.nvidia.com>
	<s5heik3ujy0.wl%tiwai@suse.de>
	<6B4D417B830BC44B8026029FD256F7F1C16A89A118@HKMAIL01.nvidia.com>
	<6B4D417B830BC44B8026029FD256F7F1C16A89A11A@HKMAIL01.nvidia.com>
	<s5haaupoqew.wl%tiwai@suse.de>
	<6B4D417B830BC44B8026029FD256F7F1C16A89A11C@HKMAIL01.nvidia.com>
	<s5htysxm5yo.wl%tiwai@suse.de>
	<6B4D417B830BC44B8026029FD256F7F1C16B1AD54C@HKMAIL01.nvidia.com>
	<s5hzl2ol8qu.wl%tiwai@suse.de>
	<6B4D417B830BC44B8026029FD256F7F1C16B1AD554@HKMAIL01.nvidia.com>
 <s5h1vg0qrrr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h1vg0qrrr.wl%tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: 'Pavel Hofman' <pavel.hofman@insite.cz>, 'alsa-devel' <alsa-devel@alsa-project.org>, 'linux-kernel' <linux-kernel@vger.kernel.org>, 'akpm' <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

Hi, Takashi
I test my patch, it build successful when CONFIG_SND_HDA_*=y.
Could you give me your build error messages?

Thanks
Wei.
nvpublic

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Thursday, March 04, 2010 6:57 PM
To: Wei Ni
Cc: 'Pavel Hofman'; 'alsa-devel'; 'linux-kernel'; 'akpm'
Subject: Re: [alsa-devel] [PATCH]Support MCP89 and GT21x hdmi audio

At Thu, 4 Mar 2010 18:46:59 +0800,
Wei Ni wrote:
> 
> Hi, Takashi
> I think we can submit my patch first,

But your patch breaks the build when CONFIG_SND_HDA_*=y.
So, it should be fixed in your patch.


thanks,

Takashi

> then generate another patch
> to add EXPORT_SYMBOL() in hda_eld.c, and change Makefile to remove
> hda_eld.o from snd-hda-codec-xxhdmi-objs.
> 
> Thanks
> Wei.
> nvpublic
> 
> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de] 
> Sent: Thursday, March 04, 2010 5:47 PM
> To: Wei Ni
> Cc: 'Pavel Hofman'; 'alsa-devel'; 'linux-kernel'; 'akpm'
> Subject: Re: [alsa-devel] [PATCH]Support MCP89 and GT21x hdmi audio
> 
> At Thu, 4 Mar 2010 10:21:39 +0800,
> Wei Ni wrote:
> > 
> > Hi, Takashi
> > 1. Yes, it can works for all Nvidia controller.
> 
> OK.
> 
> > 2. The hda_eld.o doesn't export any symbols.
> > I tried to put hda_eld.o to snd-had-codec-*, and remove had_eldo.o
> > from snd-had-codec-intelhdmi-objs, but it will build error. It need
> > to modify hda_eld.c to export symbols, it will add many changes.
> 
> Yes, this is unavoidable.  Please add EXPORT_SYMBOL()'s
> appropriately.
> 
> We can reduce them again once after all HDMI stuff is merged into
> one.
> 
> 
> thanks,
> 
> Takashi
> 
