From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] drm/i915: Remove unused IRQ chip data of
 HDMI LPE audio
Date: Tue, 12 Dec 2017 18:06:41 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1712121804570.1794@nanos>
References: <20171208093323.2212-1-augustine.chen@intel.com>
 <20171208114404.GN10981@intel.com> <alpine.DEB.2.20.1712082340400.2301@nanos>
 <F6867404AABACB4D8EC371BF802A4B7C5790D206@fmsmsx101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-487738387-1513098402=:1794"
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <F6867404AABACB4D8EC371BF802A4B7C5790D206@fmsmsx101.amr.corp.intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: "Anand, Jerome" <jerome.anand@intel.com>
Cc: Juergen Gross <jgross@suse.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Jiang Liu <jiang.liu@linux.intel.com>, "Chen,
 Augustine" <augustine.chen@intel.com>, "Bossart,
 Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-487738387-1513098402=:1794
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 11 Dec 2017, Anand, Jerome wrote:
> > On Fri, 8 Dec 2017, Ville Syrjälä wrote:
> > 
> > > On Fri, Dec 08, 2017 at 05:33:23PM +0800, Augustine.Chen wrote:
> > > > The chip data of HDMI LPE audio is set to drm_i915_private which is
> > > > not consistent with the expectation by x86 APIC driver.
> > >
> > > Hmm. Why is the apic code looking at data for an irq chip it hasn't
> > > created?
> > >
> 
> apic code expects an irq domain to be place as generic approach.

APIC code does not even see that interrupt at all. It's completely
disconnected.

> > > > In the case of not enabling CONFIG_CPUMASK_OFFSTACK, this would
> > > > cause kernel panic while doing CPU hotplug.
> > 
> > And why so? Surely not because you set irq_chip_data. That's really no
> > explanation at all.
> > 
> 
> Ideally, I feel there needs to be an irq domain for mapping the irq
> numbers with hwirq.  It is not created as part of the hdmi lpe audio
> bridge.  Since the logic to mask/unmask lpe audio interrupts is removed,
> there is no need of the Chip data or creation of the domain now.

That still does not explain why this is broken with
CONFIG_CPUMASK_OFFSTACK=n and cpu hotplug.

Thanks,

	tglx


--8323329-487738387-1513098402=:1794
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--8323329-487738387-1513098402=:1794--
