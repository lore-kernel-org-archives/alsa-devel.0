From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ALSA: HDA: Add jack detection for HDMI
Date: Tue, 17 May 2011 16:14:41 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0498A4791C@HQMAIL01.nvidia.com>
References: <4DD27C43.3050509@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04986AAA0D@HQMAIL01.nvidia.com>
	<s5haael5mzb.wl%tiwai@suse.de>
	<BANLkTi=H8sqtf-5TvsKjQF8RA1bxBAfEWA@mail.gmail.com>
	<s5hpqnh2pyu.wl%tiwai@suse.de>
	<BANLkTinbq_d45aMxk6c_+Akft-LyA4nTAA@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04986AAB5B@HQMAIL01.nvidia.com>
	<BANLkTi=QKQ10m64bh8isDhuTWjXAYvNDWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FC8424337
	for <alsa-devel@alsa-project.org>;
	Wed, 18 May 2011 01:14:52 +0200 (CEST)
In-Reply-To: <BANLkTi=QKQ10m64bh8isDhuTWjXAYvNDWw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

pl bossart wrote at Tuesday, May 17, 2011 4:12 PM:
>...
> > Perhaps the vendor-specific data space could be useful for matching audio
> > ports to X displays; there is a 64-bit Port_ID in the ELD that might be
> > used for that, or we could define X/Linux/Unix as the vendor, and specify
> > the format of the vendor-specific data in a way that defines this mapping.
> 
> Sounds complicated...The spec says this PortID field is "a ""canned""
> field that would be populated through implementation specific mean of
> default programming before the graphic driver is loaded". Duh?

I'm pretty sure our HW doesn't initialize this to anything meaningful before
the video driver runs.

> The standard "Monitor Name String" may be easier to use...

Do you mean co-opt this field and store alternate data in it? The real
monitor name for both monitors in my dual-head setup are the same...

> > That said, the internal APIs our graphics driver uses to write the ELD
> > is currently limited to 96 bytes (the size of the standardized section
> > of the ELD). I'm not sure yet if that's simply because 96 bytes was all
> > that was needed, or if that also ended up being encoded as a HW design
> > limitation.
> 
> Looks like the max for ELDv2 is 80 bytes for the baseline+4 for the
> header.

Oh yeah; I'd calculated assuming SADs were 4 bytes but they're 3.

-- 
nvpublic
