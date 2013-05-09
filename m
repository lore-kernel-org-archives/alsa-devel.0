From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: [RFC PATCH 1/3] drm/915: Add private api for power
	well usage
Date: Thu, 9 May 2013 11:30:01 -0700
Message-ID: <20130509113001.7e7ff1d6@jbarnes-desktop>
References: <1368082842-2537-1-git-send-email-xingchao.wang@linux.intel.com>
	<46B810F6945F7C4788E11DCE57EC489010E584A7@SHSMSX102.ccr.corp.intel.com>
	<CAKMK7uEftD9H65oxDhs1RxmjTQR+k0on1t86Ok6ZXmUJ40eYAQ@mail.gmail.com>
	<s5ha9o4xebz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <s5ha9o4xebz.wl%tiwai@suse.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Li,
	Jocelyn" <jocelyn.li@intel.com>, "Lin, Mengdong" <mengdong.lin@intel.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, Wang Xingchao <xingchao.wang@linux.intel.com>, "Girdwood,
	Liam R" <liam.r.girdwood@intel.com>, "david.henningsson@canonical.com" <david.henningsson@canonical.com>, "Zanoni, Paulo R" <paulo.r.zanoni@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 9 May 2013 19:17:36 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 9 May 2013 11:23:21 +0200,
> Daniel Vetter wrote:
> > 
> > 2. On a quick read of the hda driver stuff I don't think the power
> > well enable/disable places are at the right spot: We force the power
> > well on whenever the hda codec is used, but we must only do that when
> > we want to output audio to external screens. And since that state
> > transition can only really happen due to a modeset change on the gfx
> > side I don't think we need any autosuspend delays either.
> > 
> > The use-case I'm thinking of is media playback with just the panel
> > enabled: In that case we can switch off the power well on the display
> > side, and I don't think the power well is required for audio play back
> > on the integrated speakerrs/headphone-jack either.
> 
> Well, in the case of Haswell, the audio controller/codec is dedicated
> to only HDMI audio, and in the audio driver level, the power saving of
> each codec/controller chip is managed individually.  So, it's not that
> bad to handle power well on/off at that point.  A sane power-conscious
> OS would open/close the audio device file in a fine grained way.

So hda_intel and the azx_suspend/resume functions will only be called
for HDMI audio on HSW?  If so, then I guess this patch has the calls
in the right places.

If it's going to force the power well on for non-HDMI audio, then I
think we'll need some additional changes.

> 
> > 3. The moduel depencies seem to still not work out dynamically, at
> > least I think we still have a hard chain between hda-intel and i915.ko
> > (just with one thing in between now).
> 
> True.
> 
> The question is in which level we need power_well_*() controls.
> If the initialization of HD-audio controller (e.g. PCI registers)
> requires the power well on, hda_intel.c requires the calls, as this
> patch does.  OTOH, if it's only about the HD-audio verbs, basically we
> can push the power well calls into the codec driver,
> i.e. patch_hdmi.c.  In the latter case, as David once suggested, we
> can split the Haswell codec driver from patch_hdmi.c so that only the
> new driver depends on i915.

I think it's needed for the HDMI related MMIO regs as well, but I don't
have a platform to test and make sure.

Jesse
