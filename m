From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/i915: Add private api for power well
 usage -- alignment between graphic team and audio team
Date: Sat, 27 Apr 2013 13:35:29 +0200
Message-ID: <20130427113529.GT6169@phenom.ffwll.local>
References: <1B1032E88FFFDA4898B04D530F28DEDB53CAB7@SHSMSX101.ccr.corp.intel.com>
	<CAKMK7uGZ1eK1MngbihR_+xUZZXsFQGEV3=NH1Ohjf7S0i9s2-g@mail.gmail.com>
	<1B1032E88FFFDA4898B04D530F28DEDB53CB7C@SHSMSX101.ccr.corp.intel.com>
	<20130426145708.GN6169@phenom.ffwll.local>
	<s5h61z91g2l.wl%tiwai@suse.de>
	<20130426154207.GP6169@phenom.ffwll.local>
	<s5hzjwlz46s.wl%tiwai@suse.de>
	<20130426171737.GR6169@phenom.ffwll.local>
	<46B810F6945F7C4788E11DCE57EC4890109D3608@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <46B810F6945F7C4788E11DCE57EC4890109D3608@SHSMSX102.ccr.corp.intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: "Wang, Xingchao" <xingchao.wang@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zanoni,
	Paulo R" <paulo.r.zanoni@intel.com>, Takashi Iwai <tiwai@suse.de>, Daniel Vetter <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Wang Xingchao <xingchao.wang@linux.intel.com>, "Girdwood,
	Liam R" <liam.r.girdwood@intel.com>, "Li,
	Jocelyn" <jocelyn.li@intel.com>, "Hindman,
	Gavin" <gavin.hindman@intel.com>, "Barnes,
	Jesse" <jesse.barnes@intel.com>, "Lin, Mengdong" <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 27, 2013 at 09:20:39AM +0000, Wang, Xingchao wrote:
> Let me throw a basic proposal on Audio driver side,  please give your comments freely.
> 
> it contains the power well control usage points:
> #1: audio request power well at boot up.
> I915 may shut down power well after bootup initialization, as there's no monitor connected outside or only eDP on pipe A.
> #2: audio request power on resume
> After exit from D3 mode, audio driver quest power on. This may happen at normal resume or runtime resume.
> #3: audio release power well control at suspend
> Audio driver will let i915 know it doensot need power well anymore as it's going to suspend. This may happened at normal suspend or runtime suspend point.
> #4: audio release power well when module unload
> Audio release power well at remove callback to let i915 know.

I miss the power well grab/dropping at runtime from the audio side. If the
audio driver forces the power well to be on the entire time it's loaded,
that's not good, since the power well stuff is very much for runtime PM.
We _must_ be able to switch off the power well whenever possible.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
