From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] drm/i915: Add private api for power well
 usage -- alignment between graphic team and audio team
Date: Thu, 2 May 2013 03:17:06 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F839B1DC@SHSMSX101.ccr.corp.intel.com>
References: <1B1032E88FFFDA4898B04D530F28DEDB53CAB7@SHSMSX101.ccr.corp.intel.com>
 <CAKMK7uGZ1eK1MngbihR_+xUZZXsFQGEV3=NH1Ohjf7S0i9s2-g@mail.gmail.com>
 <1B1032E88FFFDA4898B04D530F28DEDB53CB7C@SHSMSX101.ccr.corp.intel.com>
 <20130426145708.GN6169@phenom.ffwll.local>	<s5h61z91g2l.wl%tiwai@suse.de>
 <20130426154207.GP6169@phenom.ffwll.local>	<s5hzjwlz46s.wl%tiwai@suse.de>
 <20130426171737.GR6169@phenom.ffwll.local>
 <46B810F6945F7C4788E11DCE57EC4890109D3608@SHSMSX102.ccr.corp.intel.com>
 <20130427113529.GT6169@phenom.ffwll.local>
 <20130429080219.05108857@jbarnes-desktop>	<517F9D11.3020905@canonical.com>
 <20130430073802.02a677c2@jbarnes-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D703726087E
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2013 05:17:12 +0200 (CEST)
In-Reply-To: <20130430073802.02a677c2@jbarnes-desktop>
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
To: Daniel Vetter <daniel@ffwll.ch>, "Barnes, Jesse" <jesse.barnes@intel.com>, David Henningsson <david.henningsson@canonical.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zanoni,
 Paulo R" <paulo.r.zanoni@intel.com>, Takashi Iwai <tiwai@suse.de>, Daniel Vetter <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Wysocki,
 Rafael J" <rafael.j.wysocki@intel.com>, Wang Xingchao <xingchao.wang@linux.intel.com>, "Wang,
 Xingchao" <xingchao.wang@intel.com>, "Li, Jocelyn" <jocelyn.li@intel.com>, "Hindman, Gavin" <gavin.hindman@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

> > On 04/29/2013 05:02 PM, Jesse Barnes wrote:
> > > On Sat, 27 Apr 2013 13:35:29 +0200
> > > Daniel Vetter <daniel@ffwll.ch> wrote:
> > > The high level goal here should be for the audio driver to call into
> > > i915 with get/put power well around the sequences where it needs the
> > > power to be up (reading/writing registers, playing audio), but not
> > > across the whole time the driver is loaded, just like you already do
> > > with the powersave work functions, e.g. hda_call_codec_suspend.

Hi Daniel,

We can modify the patch so that the audio driver will not request the power well across the whole time the HD-A driver is loaded, but request/release the power well at runtime.

The HD-Audio driver can support runtime PM. When the codec is idle, it can suspend the codec and further suspend the controller, thus the power well is no longer needed. 
So we can add haswell-specific code to release the power well in HD-A runtime suspend callback azx_suspend(), and request the power well in audio runtime resume callback azx_resume().

Thanks
Mengdong
