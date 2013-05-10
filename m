From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [RFC PATCH 1/3] drm/915: Add private api for power
	well usage
Date: Fri, 10 May 2013 05:02:52 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC489010E5B2D1@SHSMSX102.ccr.corp.intel.com>
References: <1368082842-2537-1-git-send-email-xingchao.wang@linux.intel.com>
 <46B810F6945F7C4788E11DCE57EC489010E584A7@SHSMSX102.ccr.corp.intel.com>
 <CAKMK7uEftD9H65oxDhs1RxmjTQR+k0on1t86Ok6ZXmUJ40eYAQ@mail.gmail.com>
 <s5ha9o4xebz.wl%tiwai@suse.de> <20130509113001.7e7ff1d6@jbarnes-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D66B2610A0
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 07:03:14 +0200 (CEST)
In-Reply-To: <20130509113001.7e7ff1d6@jbarnes-desktop>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Barnes, Jesse" <jesse.barnes@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zanoni,
 Paulo R" <paulo.r.zanoni@intel.com>, "Li, Jocelyn" <jocelyn.li@intel.com>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, Wang Xingchao <xingchao.wang@linux.intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, Daniel Vetter <daniel@ffwll.ch>, "david.henningsson@canonical.com" <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi Jesse,


> -----Original Message-----
> From: Barnes, Jesse
> Sent: Friday, May 10, 2013 2:30 AM
> To: Takashi Iwai
> Cc: Daniel Vetter; Wang, Xingchao; david.henningsson@canonical.com;
> Girdwood, Liam R; Li, Jocelyn; Lin, Mengdong; Zanoni, Paulo R; Wang Xingchao;
> intel-gfx; alsa-devel@alsa-project.org
> Subject: Re: [RFC PATCH 1/3] drm/915: Add private api for power well usage
> 
> On Thu, 9 May 2013 19:17:36 +0200
> Takashi Iwai <tiwai@suse.de> wrote:
> 
> > At Thu, 9 May 2013 11:23:21 +0200,
> > Daniel Vetter wrote:
> > >
> > > 2. On a quick read of the hda driver stuff I don't think the power
> > > well enable/disable places are at the right spot: We force the power
> > > well on whenever the hda codec is used, but we must only do that
> > > when we want to output audio to external screens. And since that
> > > state transition can only really happen due to a modeset change on
> > > the gfx side I don't think we need any autosuspend delays either.
> > >
> > > The use-case I'm thinking of is media playback with just the panel
> > > enabled: In that case we can switch off the power well on the
> > > display side, and I don't think the power well is required for audio
> > > play back on the integrated speakerrs/headphone-jack either.
> >
> > Well, in the case of Haswell, the audio controller/codec is dedicated
> > to only HDMI audio, and in the audio driver level, the power saving of
> > each codec/controller chip is managed individually.  So, it's not that
> > bad to handle power well on/off at that point.  A sane power-conscious
> > OS would open/close the audio device file in a fine grained way.
> 
> So hda_intel and the azx_suspend/resume functions will only be called for
> HDMI audio on HSW?  If so, then I guess this patch has the calls in the right
> places.

Well not, hda_intel and azx_suspend/resume is more generic call. But it has no impact for non-HSW platform.
Since power-well requirement must be done at very early stage for HD-audio controller, so it happened at very high level.
For non-HSW platform, the external module should no built in at first. Given it could call into gfx side, no power-well change happen there.

> 
> If it's going to force the power well on for non-HDMI audio, then I think we'll
> need some additional changes.
For non-HDMI audio, it's in non HSW HD-Audio controller, so it should be safe.

So the patchset intend to work only for Haswell HD-audio controller and codecs.

> 
> >
> > > 3. The moduel depencies seem to still not work out dynamically, at
> > > least I think we still have a hard chain between hda-intel and
> > > i915.ko (just with one thing in between now).
> >
> > True.
> >
> > The question is in which level we need power_well_*() controls.
> > If the initialization of HD-audio controller (e.g. PCI registers)
> > requires the power well on, hda_intel.c requires the calls, as this
> > patch does.  OTOH, if it's only about the HD-audio verbs, basically we
> > can push the power well calls into the codec driver, i.e.
> > patch_hdmi.c.  In the latter case, as David once suggested, we can
> > split the Haswell codec driver from patch_hdmi.c so that only the new
> > driver depends on i915.
> 
> I think it's needed for the HDMI related MMIO regs as well, but I don't have a
> platform to test and make sure.

That's true. The probing sound card would fail if there's no power-well enabled, we say in such case:
Boot up with no hdmi cable connected  -->  gfx disable power-well  --> haswell audio probe fail.

Thanks
--xingchao
