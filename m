From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/i915: Add private api for power well
 usage -- alignment between graphic team and audio team
Date: Fri, 26 Apr 2013 17:42:07 +0200
Message-ID: <20130426154207.GP6169@phenom.ffwll.local>
References: <1B1032E88FFFDA4898B04D530F28DEDB53CAB7@SHSMSX101.ccr.corp.intel.com>
	<CAKMK7uGZ1eK1MngbihR_+xUZZXsFQGEV3=NH1Ohjf7S0i9s2-g@mail.gmail.com>
	<1B1032E88FFFDA4898B04D530F28DEDB53CB7C@SHSMSX101.ccr.corp.intel.com>
	<20130426145708.GN6169@phenom.ffwll.local>
	<s5h61z91g2l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <s5h61z91g2l.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zanoni,
	Paulo R" <paulo.r.zanoni@intel.com>, "Li, Jocelyn" <jocelyn.li@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Wang Xingchao <xingchao.wang@linux.intel.com>, "Girdwood,
	Liam R" <liam.r.girdwood@intel.com>, "Hindman,
	Gavin" <gavin.hindman@intel.com>, "Barnes,
	Jesse" <jesse.barnes@intel.com>, "Lin, Mengdong" <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 26, 2013 at 05:12:34PM +0200, Takashi Iwai wrote:
> At Fri, 26 Apr 2013 16:57:08 +0200,
> Daniel Vetter wrote:
> > 
> > On Fri, Apr 26, 2013 at 07:53:41AM +0000, Li, Jocelyn wrote:
> > > -----Original Message-----
> > > From: Daniel Vetter [mailto:daniel.vetter@ffwll.ch] 
> > > Sent: Friday, April 26, 2013 3:25 PM
> > > To: Li, Jocelyn
> > > Cc: Wang, Xingchao; Zanoni, Paulo R; ville.syrjala@linux.intel.com; Lin, Mengdong; Girdwood, Liam R; intel-gfx@lists.freedesktop.org; alsa-devel@alsa-project.org; Wang Xingchao; Takashi Iwai; Barnes, Jesse; Wysocki, Rafael J; Hindman, Gavin
> > > Subject: Re: [PATCH] drm/i915: Add private api for power well usage -- alignment between graphic team and audio team
> > > Once we've figured out what needs to be changed in the audio driver we
> > > can look at the entire patch series and the interface to i915.ko.
> > > That's also why I didn't comment on Xingchao's patch right away, but
> > > only once he specifically asked for feedback, since doing a real review
> > > of the interface doesn't make sense until we have all the pieces (and a
> > > working audio driver).
> > > 
> > > [Jocelyn] I think you have made constructive comments on Xingchao's
> > > patch yesterday. Next, shall we have Xingchao improve his patch? Or we
> > > just have Xingchao wait till you have completed your pieces. Sorry, I am
> > > a little confused :)
> > 
> > I think the next step is to use Xinchao's patch as-is and get the audio
> > side going. Once we have that fixed up, we can revisit the interface and
> > make it solid. But for now trying to polish this relatively simple part
> > seems like wasted time.
> > 
> > Also, reviewing an interface is much easier if we have both the i915
> > pieces (already here) and the audio pieces (which I haven't seen yet)
> > avaialble.
> 
> I haven't checked the patch properly yet, but the patch pasted in the
> post looks like i915 driver exports the functions to control power
> well, and let audio driver calling them.  If so, the big mess in such
> a case is the dependency between driver modules.
> 
> A simple workaround would be to split this function and the relevant
> instance out of i915 and snd-hda-intel and put into an individual
> module (e.g. i915-powerwell-ctl).

Yeah, the current patch doesn't work for loading i915/snd-hda-intel in any
order. But it should be good enough to fix the hw interactions.

> Also, it would be feasible to implement some PM governor over both
> graphics and audio, that is, it gives the proper serialization of
> power up for audio controller, for example.

Yeah, I think once we have the hw interaction/sequence and stuff all
figured out we need to figure out what kind of interface would suit best
here. One of the options we've talked about a bit is a full runtime PM
governor on a special device. Then only the device needs to be
instantiated first, the audio driver could just grab runtime pm references
and i915 could implement the PM backend.

But like I've said, those considerations should be a second step once we
have something working with a quickly hacked-together interface.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
