From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [RFC PATCH 1/3] drm/915: Add private api for power
 well usage
Date: Thu, 9 May 2013 11:53:15 -0700
Message-ID: <20130509115315.601598f6@jbarnes-desktop>
References: <1368082842-2537-1-git-send-email-xingchao.wang@linux.intel.com>
	<46B810F6945F7C4788E11DCE57EC489010E584A7@SHSMSX102.ccr.corp.intel.com>
	<CAKMK7uEftD9H65oxDhs1RxmjTQR+k0on1t86Ok6ZXmUJ40eYAQ@mail.gmail.com>
	<s5ha9o4xebz.wl%tiwai@suse.de>
	<20130509113001.7e7ff1d6@jbarnes-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <20130509113001.7e7ff1d6@jbarnes-desktop>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Jesse Barnes <jesse.barnes@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zanoni,
	Paulo R" <paulo.r.zanoni@intel.com>, Takashi Iwai <tiwai@suse.de>, "Lin,
	Mengdong" <mengdong.lin@intel.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, Wang Xingchao <xingchao.wang@linux.intel.com>, "Li,
	Jocelyn" <jocelyn.li@intel.com>, "Girdwood,
	Liam R" <liam.r.girdwood@intel.com>, "david.henningsson@canonical.com" <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 9 May 2013 11:30:01 -0700
Jesse Barnes <jesse.barnes@intel.com> wrote:

> > The question is in which level we need power_well_*() controls.
> > If the initialization of HD-audio controller (e.g. PCI registers)
> > requires the power well on, hda_intel.c requires the calls, as this
> > patch does.  OTOH, if it's only about the HD-audio verbs, basically we
> > can push the power well calls into the codec driver,
> > i.e. patch_hdmi.c.  In the latter case, as David once suggested, we
> > can split the Haswell codec driver from patch_hdmi.c so that only the
> > new driver depends on i915.  
> 
> I think it's needed for the HDMI related MMIO regs as well, but I don't
> have a platform to test and make sure.

Sorry, HD regs, not HDMI (though the power well is needed for those
too :).  AFAIK all the registers for interacting with HDMI audio on the
graphics device require the power well to be up in order to be accessed.

-- 
Jesse Barnes, Intel Open Source Technology Center
