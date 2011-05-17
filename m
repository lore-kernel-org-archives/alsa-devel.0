From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [PATCH] ALSA: HDA: Add jack detection for HDMI
Date: Tue, 17 May 2011 17:11:49 -0500
Message-ID: <BANLkTi=QKQ10m64bh8isDhuTWjXAYvNDWw@mail.gmail.com>
References: <4DD27C43.3050509@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04986AAA0D@HQMAIL01.nvidia.com>
	<s5haael5mzb.wl%tiwai@suse.de>
	<BANLkTi=H8sqtf-5TvsKjQF8RA1bxBAfEWA@mail.gmail.com>
	<s5hpqnh2pyu.wl%tiwai@suse.de>
	<BANLkTinbq_d45aMxk6c_+Akft-LyA4nTAA@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04986AAB5B@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B39C103807
	for <alsa-devel@alsa-project.org>;
	Wed, 18 May 2011 00:11:50 +0200 (CEST)
Received: by eyg5 with SMTP id 5so301489eyg.38
	for <alsa-devel@alsa-project.org>; Tue, 17 May 2011 15:11:49 -0700 (PDT)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04986AAB5B@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

> Isn't the ELD limited to 256 bytes, since verb F2F has an 8-bit offset
> parameter?

I guess you are right. I saw some checks in the hda code where the ELD
size is gt PAGE_SIZE. Confusing really.

> I think it'd be a good idea to just dump the entire ELD out to user-space
> for future flexibility. It's trivial for user-space to ignore the vendor-
> specific data (since it's always after the standardized data).

Right, if this fits in 512 bytes no reason to drop anything.

> Perhaps the vendor-specific data space could be useful for matching audio
> ports to X displays; there is a 64-bit Port_ID in the ELD that might be
> used for that, or we could define X/Linux/Unix as the vendor, and specify
> the format of the vendor-specific data in a way that defines this mapping.

Sounds complicated...The spec says this PortID field is "a ""canned""
field that would be populated through implementation specific mean of
default programming before the graphic driver is loaded". Duh?
The standard "Monitor Name String" may be easier to use...

> That said, the internal APIs our graphics driver uses to write the ELD
> is currently limited to 96 bytes (the size of the standardized section
> of the ELD). I'm not sure yet if that's simply because 96 bytes was all
> that was needed, or if that also ended up being encoded as a HW design
> limitation.

Looks like the max for ELDv2 is 80 bytes for the baseline+4 for the header.
