From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH] drm/i915: Add private api for power well
 usage -- alignment between graphic team and audio team
Date: Fri, 3 May 2013 15:17:57 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC4890109D5D55@SHSMSX102.ccr.corp.intel.com>
References: <1B1032E88FFFDA4898B04D530F28DEDB53CAB7@SHSMSX101.ccr.corp.intel.com>
 <CAKMK7uGZ1eK1MngbihR_+xUZZXsFQGEV3=NH1Ohjf7S0i9s2-g@mail.gmail.com>
 <1B1032E88FFFDA4898B04D530F28DEDB53CB7C@SHSMSX101.ccr.corp.intel.com>
 <20130426145708.GN6169@phenom.ffwll.local>	<s5h61z91g2l.wl%tiwai@suse.de>
 <20130426154207.GP6169@phenom.ffwll.local>	<s5hzjwlz46s.wl%tiwai@suse.de>
 <20130426171737.GR6169@phenom.ffwll.local>
 <46B810F6945F7C4788E11DCE57EC4890109D3608@SHSMSX102.ccr.corp.intel.com>
 <20130427113529.GT6169@phenom.ffwll.local>
 <20130429080219.05108857@jbarnes-desktop> <s5hfvy4b0ls.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BD8F2608D6
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2013 17:18:06 +0200 (CEST)
In-Reply-To: <s5hfvy4b0ls.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, "Barnes, Jesse" <jesse.barnes@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zanoni,
 Paulo R" <paulo.r.zanoni@intel.com>, "Li, Jocelyn" <jocelyn.li@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Wysocki,
 Rafael J" <rafael.j.wysocki@intel.com>, Wang Xingchao <xingchao.wang@linux.intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Hindman,
 Gavin" <gavin.hindman@intel.com>, Daniel Vetter <daniel@ffwll.ch>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Friday, May 03, 2013 10:27 PM
> To: Barnes, Jesse
> Cc: Daniel Vetter; Wang, Xingchao; Li, Jocelyn; Daniel Vetter; Zanoni, Paulo R;
> ville.syrjala@linux.intel.com; Lin, Mengdong; Girdwood, Liam R;
> intel-gfx@lists.freedesktop.org; alsa-devel@alsa-project.org; Wang Xingchao;
> Wysocki, Rafael J; Hindman, Gavin
> Subject: Re: [PATCH] drm/i915: Add private api for power well usage --
> alignment between graphic team and audio team
> 
> At Mon, 29 Apr 2013 08:02:19 -0700,
> Jesse Barnes wrote:
> >
> > On Sat, 27 Apr 2013 13:35:29 +0200
> > Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > > On Sat, Apr 27, 2013 at 09:20:39AM +0000, Wang, Xingchao wrote:
> > > > Let me throw a basic proposal on Audio driver side,  please give your
> comments freely.
> > > >
> > > > it contains the power well control usage points:
> > > > #1: audio request power well at boot up.
> > > > I915 may shut down power well after bootup initialization, as there's no
> monitor connected outside or only eDP on pipe A.
> > > > #2: audio request power on resume
> > > > After exit from D3 mode, audio driver quest power on. This may happen at
> normal resume or runtime resume.
> > > > #3: audio release power well control at suspend Audio driver will
> > > > let i915 know it doensot need power well anymore as it's going to suspend.
> This may happened at normal suspend or runtime suspend point.
> > > > #4: audio release power well when module unload Audio release
> > > > power well at remove callback to let i915 know.
> > >
> > > I miss the power well grab/dropping at runtime from the audio side.
> > > If the audio driver forces the power well to be on the entire time
> > > it's loaded, that's not good, since the power well stuff is very much for
> runtime PM.
> > > We _must_ be able to switch off the power well whenever possible.
> >
> > Xingchao, I'm not an audio developer so I'm probably way off.
> >
> > But what we really need is a very small and targeted set of calls into
> > the i915 driver from say the HDMI driver in HDA.  It looks like the
> > prepare/cleanup pair in the pcm_ops structure might be the right place
> > to put things?  If that's too fine grained, you could do it at
> > open/close time I guess, but the danger there is that some app will
> > keep the device open even while it's not playing.
> 
> Well, the question is what impact the power well on/off has against the audio.
> Do we need to resume the HD-audio controller / codec fully from the scratch?
> I guess not, but I have no certain idea.

Both the display H-DA controller and codec are under control by power well.
When the power well is off, for H-DA controller, the MMIO space is off, the PCI
Registers are in on well. The codec could not access anymore.

> 
> If the impact of the change (i.e. the procedure needed to resume) is small,
> somehow limited to the targeted converter/pin, it can be implemented in the
> prepare/cleanup callback of the codec driver, yes.
> 
> Though, the easiest path would be to add i915_get/put_power_well() in the
> codec probe, suspend, resume, and free callbacks, as you pointed out below.

Yes, and Jesse should get the background that, even power well is requested at probe,
It will not take long time to waste power. The controller/codec will enter power save mode
If runtime pm enabled. 

Thanks
--xingchao
> 
> > If that won't work, maybe calling i915 from hda_power_work in the
> > higher level code would be better?
> >
> > For detecting whether to call i915 at all, you can filter on the PCI
> > IDs (just look for an Intel graphics device and if present, try to get
> > the i915 symbols for the power functions).
> >
> > --- a/sound/pci/hda/hda_codec.c
> > +++ b/sound/pci/hda/hda_codec.c
> > @@ -3860,6 +3860,8 @@ static unsigned int hda_call_codec_suspend(struct
> hda_code
> >                 codec->patch_ops.suspend(codec);
> >         hda_cleanup_all_streams(codec);
> >         state = hda_set_power_state(codec, AC_PWRST_D3);
> > +       if (i915_shared_power_well)
> > +               i915_put_power_well(codec->i915_data);
> >         /* Cancel delayed work if we aren't currently running from it. */
> >         if (!in_wq)
> >                 cancel_delayed_work_sync(&codec->power_work);
> > @@ -4807,6 +4809,9 @@ static void __snd_hda_power_up(struct
> hda_codec *codec, bo
> >                 return;
> >         spin_unlock(&codec->power_lock);
> >
> > +       if (i915_shared_power_well)
> > +               i915_get_power_well(codec->i915_data);
> > +
> >         cancel_delayed_work_sync(&codec->power_work);
> >
> >         spin_lock(&codec->power_lock);
> >
> > With some code at init time to get the i915 symbols you need to call
> > and whether or not the shared power well is present...
> >
> > Takashi, any other ideas?
> >
> > The high level goal here should be for the audio driver to call into
> > i915 with get/put power well around the sequences where it needs the
> > power to be up (reading/writing registers, playing audio), but not
> > across the whole time the driver is loaded, just like you already do
> > with the powersave work functions, e.g. hda_call_codec_suspend.
> 
> I guess controlling the suspend/resume path would be practically working well.
> If a system is really power-conscious, it should use a sound backend like
> PulseAudio, which closes the unused PCM devices frequently enough, and the
> power_save option should be changed by the power management tool on the
> fly.
> 
> If such mechanisms aren't used, it means that user doesn't care about power,
> after all.
> 
> 
> thanks,
> 
> Takashi
