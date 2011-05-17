From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ALSA: HDA: Add jack detection for HDMI
Date: Tue, 17 May 2011 14:42:24 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04986AAB5B@HQMAIL01.nvidia.com>
References: <4DD27C43.3050509@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04986AAA0D@HQMAIL01.nvidia.com>
	<s5haael5mzb.wl%tiwai@suse.de>
	<BANLkTi=H8sqtf-5TvsKjQF8RA1bxBAfEWA@mail.gmail.com>
	<s5hpqnh2pyu.wl%tiwai@suse.de>
	<BANLkTinbq_d45aMxk6c_+Akft-LyA4nTAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 84AC01037EC
	for <alsa-devel@alsa-project.org>;
	Tue, 17 May 2011 23:42:35 +0200 (CEST)
In-Reply-To: <BANLkTinbq_d45aMxk6c_+Akft-LyA4nTAA@mail.gmail.com>
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
To: pl bossart <bossart.nospam@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Henningsson <david.henningsson@canonical.com>, David@alsa-project.org
List-Id: alsa-devel@alsa-project.org

pl bossart wrote at Tuesday, May 17, 2011 2:51 PM:
> >> >> a) Is it possible to report more information alongside the plug eve=
nts,
> >> >> such as ELD/EDID content? Or, is the idea that the kernel sends a p=
lug
> >> >> event, and then user-space retrieves that information via some other
> >> >> API? I don't think there's an API to retrieve ELD information at pr=
esent
> >> >> though right? Although certainly it'd make sense for that to be a
> >> >> completely separate patch.
> >> >
> >> > A simple approach would be adding a control element containing
> >> > byte-array of ELD/EDID.
> >>
> >> Are there any examples of such controls? Or are we talking about a new
> >> kind of control?
> >
> > Look for SNDRV_CTL_ELEM_TYPE_BYTES. =A0Some codecs provide these.
> =

> Thanks for the pointer. looks simple enough to expose the ELD bytes.
> This type of element can store up to 512 bytes, enough to store the
> ELD header+baseline fields (260 bytes tops). I don't think userspace
> would want to muck with vendor-specific information?

Isn't the ELD limited to 256 bytes, since verb F2F has an 8-bit offset
parameter?

I think it'd be a good idea to just dump the entire ELD out to user-space
for future flexibility. It's trivial for user-space to ignore the vendor-
specific data (since it's always after the standardized data).

> we may need an array of ELD controls in case there are several
> monitors. Not sure how to represent which one is actually used. The
> ELD is linked to a specific nid (node id), we'd need to link this to
> the audio device #?

Perhaps the vendor-specific data space could be useful for matching audio
ports to X displays; there is a 64-bit Port_ID in the ELD that might be
used for that, or we could define X/Linux/Unix as the vendor, and specify
the format of the vendor-specific data in a way that defines this mapping.

That said, the internal APIs our graphics driver uses to write the ELD
is currently limited to 96 bytes (the size of the standardized section
of the ELD). I'm not sure yet if that's simply because 96 bytes was all
that was needed, or if that also ended up being encoded as a HW design
limitation.

-- =

nvpublic
