From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH] drm/i915: Add private api for power well
 usage -- alignment between graphic team and audio team
Date: Sat, 27 Apr 2013 09:20:39 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC4890109D3608@SHSMSX102.ccr.corp.intel.com>
References: <1B1032E88FFFDA4898B04D530F28DEDB53CAB7@SHSMSX101.ccr.corp.intel.com>
	<CAKMK7uGZ1eK1MngbihR_+xUZZXsFQGEV3=NH1Ohjf7S0i9s2-g@mail.gmail.com>
	<1B1032E88FFFDA4898B04D530F28DEDB53CB7C@SHSMSX101.ccr.corp.intel.com>
	<20130426145708.GN6169@phenom.ffwll.local>
	<s5h61z91g2l.wl%tiwai@suse.de>
	<20130426154207.GP6169@phenom.ffwll.local>
	<s5hzjwlz46s.wl%tiwai@suse.de>
	<20130426171737.GR6169@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <20130426171737.GR6169@phenom.ffwll.local>
Content-Language: en-US
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Daniel Vetter <daniel@ffwll.ch>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zanoni,
	Paulo R" <paulo.r.zanoni@intel.com>, "Li, Jocelyn" <jocelyn.li@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Wang Xingchao <xingchao.wang@linux.intel.com>, "Hindman,
	Gavin" <gavin.hindman@intel.com>, "Barnes,
	Jesse" <jesse.barnes@intel.com>, "Girdwood,
	Liam R" <liam.r.girdwood@intel.com>, "Lin,
	Mengdong" <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Daniel/Takashi,

> -----Original Message-----
> From: Daniel Vetter [mailto:daniel.vetter@ffwll.ch] On Behalf Of Daniel Vetter
> Sent: Saturday, April 27, 2013 1:18 AM
> To: Takashi Iwai
> Cc: Daniel Vetter; Li, Jocelyn; Daniel Vetter; Wang, Xingchao; Zanoni, Paulo R;
> ville.syrjala@linux.intel.com; Lin, Mengdong; Girdwood, Liam R;
> intel-gfx@lists.freedesktop.org; alsa-devel@alsa-project.org; Wang Xingchao;
> Barnes, Jesse; Wysocki, Rafael J; Hindman, Gavin
> Subject: Re: [PATCH] drm/i915: Add private api for power well usage --
> alignment between graphic team and audio team
> 
> On Fri, Apr 26, 2013 at 05:45:15PM +0200, Takashi Iwai wrote:
> > At Fri, 26 Apr 2013 17:42:07 +0200,
> > Daniel Vetter wrote:
> > >
> > > On Fri, Apr 26, 2013 at 05:12:34PM +0200, Takashi Iwai wrote:
> > > > At Fri, 26 Apr 2013 16:57:08 +0200, Daniel Vetter wrote:
> > > > >
> > > > > On Fri, Apr 26, 2013 at 07:53:41AM +0000, Li, Jocelyn wrote:
> > > > > > -----Original Message-----
> > > > > > From: Daniel Vetter [mailto:daniel.vetter@ffwll.ch]
> > > > > > Sent: Friday, April 26, 2013 3:25 PM
> > > > > > To: Li, Jocelyn
> > > > > > Cc: Wang, Xingchao; Zanoni, Paulo R;
> > > > > > ville.syrjala@linux.intel.com; Lin, Mengdong; Girdwood, Liam
> > > > > > R; intel-gfx@lists.freedesktop.org;
> > > > > > alsa-devel@alsa-project.org; Wang Xingchao; Takashi Iwai;
> > > > > > Barnes, Jesse; Wysocki, Rafael J; Hindman, Gavin
> > > > > > Subject: Re: [PATCH] drm/i915: Add private api for power well
> > > > > > usage -- alignment between graphic team and audio team Once
> > > > > > we've figured out what needs to be changed in the audio driver we can
> look at the entire patch series and the interface to i915.ko.
> > > > > > That's also why I didn't comment on Xingchao's patch right
> > > > > > away, but only once he specifically asked for feedback, since
> > > > > > doing a real review of the interface doesn't make sense until
> > > > > > we have all the pieces (and a working audio driver).
> > > > > >
> > > > > > [Jocelyn] I think you have made constructive comments on
> > > > > > Xingchao's patch yesterday. Next, shall we have Xingchao
> > > > > > improve his patch? Or we just have Xingchao wait till you have
> > > > > > completed your pieces. Sorry, I am a little confused :)
> > > > >
> > > > > I think the next step is to use Xinchao's patch as-is and get
> > > > > the audio side going. Once we have that fixed up, we can revisit
> > > > > the interface and make it solid. But for now trying to polish
> > > > > this relatively simple part seems like wasted time.
> > > > >
> > > > > Also, reviewing an interface is much easier if we have both the
> > > > > i915 pieces (already here) and the audio pieces (which I haven't
> > > > > seen yet) avaialble.
> > > >
> > > > I haven't checked the patch properly yet, but the patch pasted in
> > > > the post looks like i915 driver exports the functions to control
> > > > power well, and let audio driver calling them.  If so, the big
> > > > mess in such a case is the dependency between driver modules.
> > > >
> > > > A simple workaround would be to split this function and the
> > > > relevant instance out of i915 and snd-hda-intel and put into an
> > > > individual module (e.g. i915-powerwell-ctl).
> > >
> > > Yeah, the current patch doesn't work for loading i915/snd-hda-intel
> > > in any order. But it should be good enough to fix the hw interactions.
> >
> > Well, my current concern is that the call is built into snd-hda-intel
> > module and this will lead to load i915 module no matter whether it's
> > used or not.  snd-hda-intel is used for any HD-audio controllers
> > (despite its name).  Loading i915 on a pure AMD system will annoy some
> > non-Intel people :)
> >
> > Even if we built the code via ifdef CONFIG_DRM_I915 or such, it's
> > still hardcoded, thus the problem above will occur with distro
> > kernels.
> 
> Sure, the current patch won't cut it for upstreaming. But it should be good
> enough to figure out what exactly we need (which to still be a bit unclear). Or at
> least where exactly we need it and what kind of other changes in snd-hda-intel
> are required to get things going.

Let me throw a basic proposal on Audio driver side,  please give your comments freely.

it contains the power well control usage points:
#1: audio request power well at boot up.
I915 may shut down power well after bootup initialization, as there's no monitor connected outside or only eDP on pipe A.
#2: audio request power on resume
After exit from D3 mode, audio driver quest power on. This may happen at normal resume or runtime resume.
#3: audio release power well control at suspend
Audio driver will let i915 know it doensot need power well anymore as it's going to suspend. This may happened at normal suspend or runtime suspend point.
#4: audio release power well when module unload
Audio release power well at remove callback to let i915 know.

1/2 should have API like i915_request_power_well(). 3/4 should be i915_release_power_well().

Also there're some dependencies:
#1: I915 driver not loaded yet, it will be loaded soon.
This may happen at bootup, the audio driver module was initialized at first. 
We may follow Takashi's suggestion to move things into single module.
#2: i915 driver not loaded.
It's a BUG obviourly, audio drvier will not work in this case. The API should do nothing and should be no error output.
#3: i915 suspend early and resume later
This brings another dependency. Audio driver maybe the first user to request power on or
the last user to release power well, power well should be enabled/disabled by audio actively?
Is it okay to gave audio driver an chance to open/close power well?

Thanks
--xingchao
> 
> > > > Also, it would be feasible to implement some PM governor over both
> > > > graphics and audio, that is, it gives the proper serialization of
> > > > power up for audio controller, for example.
> > >
> > > Yeah, I think once we have the hw interaction/sequence and stuff all
> > > figured out we need to figure out what kind of interface would suit
> > > best here. One of the options we've talked about a bit is a full
> > > runtime PM governor on a special device. Then only the device needs
> > > to be instantiated first, the audio driver could just grab runtime
> > > pm references and i915 could implement the PM backend.
> > >
> > > But like I've said, those considerations should be a second step
> > > once we have something working with a quickly hacked-together interface.
> >
> > Yep, I agree that we'll need a quick fix at this stage.
> 
> power well stuff is disabled by default, 3.10 is kinda done already and we still
> have plenty of time to hit anything for 3.11. So I don't think we should rush the
> solution for upstream before it's clear what snd-hda-intel precisely needs.
> -Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
