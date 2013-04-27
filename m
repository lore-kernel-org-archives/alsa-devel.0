From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH] drm/i915: Add private api for power well
 usage -- alignment between graphic team and audio team
Date: Sat, 27 Apr 2013 08:46:08 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC4890109D35D6@SHSMSX102.ccr.corp.intel.com>
References: <1B1032E88FFFDA4898B04D530F28DEDB53CAB7@SHSMSX101.ccr.corp.intel.com>
	<CAKMK7uGZ1eK1MngbihR_+xUZZXsFQGEV3=NH1Ohjf7S0i9s2-g@mail.gmail.com>
	<1B1032E88FFFDA4898B04D530F28DEDB53CB7C@SHSMSX101.ccr.corp.intel.com>
	<20130426145708.GN6169@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <20130426145708.GN6169@phenom.ffwll.local>
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
To: Daniel Vetter <daniel@ffwll.ch>, "Li, Jocelyn" <jocelyn.li@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zanoni,
	Paulo R" <paulo.r.zanoni@intel.com>, Takashi Iwai <tiwai@suse.de>, Daniel Vetter <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Wang Xingchao <xingchao.wang@linux.intel.com>, "Hindman,
	Gavin" <gavin.hindman@intel.com>, "Barnes,
	Jesse" <jesse.barnes@intel.com>, "Girdwood,
	Liam R" <liam.r.girdwood@intel.com>, "Lin,
	Mengdong" <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

> -----Original Message-----
> From: Daniel Vetter [mailto:daniel.vetter@ffwll.ch] On Behalf Of Daniel Vetter
> Sent: Friday, April 26, 2013 10:57 PM
> To: Li, Jocelyn
> Cc: Daniel Vetter; Wang, Xingchao; Zanoni, Paulo R;
> ville.syrjala@linux.intel.com; Lin, Mengdong; Girdwood, Liam R;
> intel-gfx@lists.freedesktop.org; alsa-devel@alsa-project.org; Wang Xingchao;
> Takashi Iwai; Barnes, Jesse; Wysocki, Rafael J; Hindman, Gavin
> Subject: Re: [PATCH] drm/i915: Add private api for power well usage --
> alignment between graphic team and audio team
> 
> On Fri, Apr 26, 2013 at 07:53:41AM +0000, Li, Jocelyn wrote:
> > -----Original Message-----
> > From: Daniel Vetter [mailto:daniel.vetter@ffwll.ch]
> > Sent: Friday, April 26, 2013 3:25 PM
> > To: Li, Jocelyn
> > Cc: Wang, Xingchao; Zanoni, Paulo R; ville.syrjala@linux.intel.com;
> > Lin, Mengdong; Girdwood, Liam R; intel-gfx@lists.freedesktop.org;
> > alsa-devel@alsa-project.org; Wang Xingchao; Takashi Iwai; Barnes,
> > Jesse; Wysocki, Rafael J; Hindman, Gavin
> > Subject: Re: [PATCH] drm/i915: Add private api for power well usage --
> > alignment between graphic team and audio team Once we've figured out
> > what needs to be changed in the audio driver we can look at the entire patch
> series and the interface to i915.ko.
> > That's also why I didn't comment on Xingchao's patch right away, but
> > only once he specifically asked for feedback, since doing a real
> > review of the interface doesn't make sense until we have all the
> > pieces (and a working audio driver).
> >
> > [Jocelyn] I think you have made constructive comments on Xingchao's
> > patch yesterday. Next, shall we have Xingchao improve his patch? Or we
> > just have Xingchao wait till you have completed your pieces. Sorry, I
> > am a little confused :)
> 
> I think the next step is to use Xinchao's patch as-is and get the audio side going.

If you mean the audio working with this patch while power well feature enabled, I say yes.
Please see my reply after sending this patch:
http://lists.freedesktop.org/archives/intel-gfx/2013-April/027157.html

The patch could prevent power well losing, thus audio driver could keep its power on.
Without this patch, audio codec info will become unavailable if the power well is shut down by graphic side.

> Once we have that fixed up, we can revisit the interface and make it solid. But
> for now trying to polish this relatively simple part seems like wasted time.
> 
> Also, reviewing an interface is much easier if we have both the i915 pieces
> (already here) and the audio pieces (which I haven't seen yet) avaialble.

It's good idea to list audio driver's usage pieces, I will prepare for that in another email later.

Thanks
--xingchao 
