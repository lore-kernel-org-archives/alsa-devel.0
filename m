From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] drm/i915: Remove unused IRQ chip data of
 HDMI LPE audio
Date: Fri, 8 Dec 2017 23:51:35 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1712082340400.2301@nanos>
References: <20171208093323.2212-1-augustine.chen@intel.com>
 <20171208114404.GN10981@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-852617733-1512773495=:2301"
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20171208114404.GN10981@intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Juergen Gross <jgross@suse.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>, alsa-devel@alsa-project.org, tiwai@suse.de, intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Jiang Liu <jiang.liu@linux.intel.com>, "Augustine.Chen" <augustine.chen@intel.com>, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-852617733-1512773495=:2301
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 8 Dec 2017, Ville Syrjälä wrote:

> On Fri, Dec 08, 2017 at 05:33:23PM +0800, Augustine.Chen wrote:
> > The chip data of HDMI LPE audio is set to drm_i915_private which is not
> > consistent with the expectation by x86 APIC driver.
> 
> Hmm. Why is the apic code looking at data for an irq chip it
> hasn't created?
> 
> Do we need something like
> - dev_priv->lpe_audio.irq = irq_alloc_desc(0);
> + dev_priv->lpe_audio.irq = irq_alloc_desc(-1);

#define irq_alloc_desc(node)

So instead of handing in node 0 you hand in node -1 which is NUMA_NO_NODE

> That *looks* more correct to me based on a cursory glance at the x86
> code, but I didn't trawl very deeply.

The x86 core cares not at all about interrupt chips which are created in a
driver and not connected to an actual apic/ioapic/msi interrupt. This
interrupt chip is its own thing as we have others in GPIO etc.

> > In the case of not enabling CONFIG_CPUMASK_OFFSTACK, this would cause
> > kernel panic while doing CPU hotplug.

And why so? Surely not because you set irq_chip_data. That's really no
explanation at all.

Curing the symptom is never a good approach.

Thanks,

	tglx
--8323329-852617733-1512773495=:2301
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--8323329-852617733-1512773495=:2301--
