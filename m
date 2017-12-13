From: "Anand, Jerome" <jerome.anand@intel.com>
Subject: RE: [Intel-gfx] [PATCH] drm/i915: Remove unused IRQ chip data of
 HDMI LPE audio
Date: Wed, 13 Dec 2017 02:15:48 +0000
Message-ID: <F6867404AABACB4D8EC371BF802A4B7C5790F9A8@fmsmsx101.amr.corp.intel.com>
References: <20171208093323.2212-1-augustine.chen@intel.com>
 <20171208114404.GN10981@intel.com>
 <alpine.DEB.2.20.1712082340400.2301@nanos>
 <F6867404AABACB4D8EC371BF802A4B7C5790D206@fmsmsx101.amr.corp.intel.com>
 <alpine.DEB.2.20.1712121804570.1794@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1712121804570.1794@nanos>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, "Chen, Augustine" <augustine.chen@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Bossart, Pierre-louis" <pierre-louis.bossart@intel.com>, "tiwai@suse.de" <tiwai@suse.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Jiang Liu <jiang.liu@linux.intel.com>, Juergen Gross <jgross@suse.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx@linutronix.de]
> Sent: Tuesday, December 12, 2017 10:37 PM
> To: Anand, Jerome <jerome.anand@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>; Chen, Augustine
> <augustine.chen@intel.com>; intel-gfx@lists.freedesktop.org; alsa-devel@alsa-
> project.org; Bossart, Pierre-louis <pierre-louis.bossart@intel.com>;
> tiwai@suse.de; Ingo Molnar <mingo@redhat.com>; H. Peter Anvin
> <hpa@zytor.com>; Jiang Liu <jiang.liu@linux.intel.com>; Juergen Gross
> <jgross@suse.com>; Dou Liyang <douly.fnst@cn.fujitsu.com>; linux-
> kernel@vger.kernel.org
> Subject: RE: [Intel-gfx] [PATCH] drm/i915: Remove unused IRQ chip data of
> HDMI LPE audio
> 
> On Mon, 11 Dec 2017, Anand, Jerome wrote:
> > > On Fri, 8 Dec 2017, Ville Syrjälä wrote:
> > >
> > > > On Fri, Dec 08, 2017 at 05:33:23PM +0800, Augustine.Chen wrote:
> > > > > The chip data of HDMI LPE audio is set to drm_i915_private which
> > > > > is not consistent with the expectation by x86 APIC driver.
> > > >
> > > > Hmm. Why is the apic code looking at data for an irq chip it
> > > > hasn't created?
> > > >
> >
> > apic code expects an irq domain to be place as generic approach.
> 
> APIC code does not even see that interrupt at all. It's completely disconnected.
> 

That's the problem - APIC just converts the chip data to its internal format and fails.

> > > > > In the case of not enabling CONFIG_CPUMASK_OFFSTACK, this would
> > > > > cause kernel panic while doing CPU hotplug.
> > >
> > > And why so? Surely not because you set irq_chip_data. That's really
> > > no explanation at all.
> > >
> >
> > Ideally, I feel there needs to be an irq domain for mapping the irq
> > numbers with hwirq.  It is not created as part of the hdmi lpe audio
> > bridge.  Since the logic to mask/unmask lpe audio interrupts is
> > removed, there is no need of the Chip data or creation of the domain now.
> 
> That still does not explain why this is broken with
> CONFIG_CPUMASK_OFFSTACK=n and cpu hotplug.
> 

If the config option is enabled, the address accessed by APIC is valid as shown below
else it tries to access locations which might or might not be valid based on the chip data set.
This is the reason why some drivers work and some don't.
I feel this needs to be fixed in APIC - not sure though !

#ifdef CONFIG_CPUMASK_OFFSTACK
typedef struct cpumask *cpumask_var_t;
...
#else
typedef struct cpumask cpumask_var_t[1];
...
#endif

> Thanks,
> 
> 	tglx
