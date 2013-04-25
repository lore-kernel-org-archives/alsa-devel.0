From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH] drm/i915: Add private api for power well
	usage
Date: Thu, 25 Apr 2013 08:38:42 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC4890109D267C@SHSMSX102.ccr.corp.intel.com>
References: <1398349210-15099-1-git-send-email-xingchao.wang@linux.intel.com>
 <46B810F6945F7C4788E11DCE57EC4890109D2387@SHSMSX102.ccr.corp.intel.com>
 <CAKMK7uH_0bL1b0iu_8abuL1DwDY_8fZ0W5nA4c-BFq=DuZ1+2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 97C2A2651C2
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2013 10:39:09 +0200 (CEST)
In-Reply-To: <CAKMK7uH_0bL1b0iu_8abuL1DwDY_8fZ0W5nA4c-BFq=DuZ1+2Q@mail.gmail.com>
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
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zanoni,
 Paulo R" <paulo.r.zanoni@intel.com>, "Li, Jocelyn" <jocelyn.li@intel.com>, "Lin, Mengdong" <mengdong.lin@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Wysocki,
 Rafael J" <rafael.j.wysocki@intel.com>, Wang Xingchao <xingchao.wang@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "Barnes,
 Jesse" <jesse.barnes@intel.com>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>, "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

> -----Original Message-----
> From: Daniel Vetter [mailto:daniel.vetter@ffwll.ch]
> Sent: Thursday, April 25, 2013 3:52 PM
> To: Wang, Xingchao
> Cc: Zanoni, Paulo R; ville.syrjala@linux.intel.com; Lin, Mengdong; Girdwood,
> Liam R; Li, Jocelyn; intel-gfx@lists.freedesktop.org;
> alsa-devel@alsa-project.org; Wang Xingchao; Takashi Iwai; Barnes, Jesse;
> Wysocki, Rafael J
> Subject: Re: [PATCH] drm/i915: Add private api for power well usage
> 
> On Thu, Apr 25, 2013 at 4:36 AM, Wang, Xingchao <xingchao.wang@intel.com>
> wrote:
> > Hi Daniel/Paulo,
> >
> > Any comments on this?
> > Add Jesse and Rafael in loop.
> 
> Well I've figured we want to get the power well integration working before we
> waste time reviewing an interface which might or might not quite work. 

Well it's good news you have plan to add power well API support in graphic side, then
it's easy for audio driver to use. I donot know much background about your idea and current status
of the power well integration status there so it's better to avoid duplicated work.


> But if
> you want, I can drop two quick comments:
> - I think the functions needs some prefix like i915_
> - Imo the power well should just be reference counted (the current interface
> name suggests it's generally useable, but actually can only cope with one
> request from the audio driver).

Indeed it was my initial idea to use reference counter to track "power well" users. A second thinking is
It become complex as i915 did not call intel_set_power_well(enable/disable) symmetrically. It may enable
Power well several times but disable it only once. That's why I just use a basic logic to track the "power well" usage.

> - Is the spin_lock (irq-disabling even) really required for the audio driver to work?
> power well enabling can take up to 20ms, so this won't work as-is. Can't we
> just use a mutex?
> - I'd need to see the audio driver side of this to check how this works for coping
> with arbitrary module load ordering.

Thanks your review, i will change it in next versioin patch.

Thanks
--xingchao 
