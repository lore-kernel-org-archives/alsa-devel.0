From: "Jie, Yang" <yang.jie@intel.com>
Subject: RE: [PATCH v3 1/2] ALSA: Kconfig: add config item SND_PROC_FS for
 expert
Date: Wed, 27 May 2015 11:10:53 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90553B0EE@SHSMSX101.ccr.corp.intel.com>
References: <1432717818-4685-1-git-send-email-yang.jie@intel.com>
	<1432717818-4685-2-git-send-email-yang.jie@intel.com>
 <s5hd21mbazo.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hd21mbazo.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>, "Zhang, Vivian" <vivian.zhang@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Wednesday, May 27, 2015 5:56 PM
> To: Jie, Yang
> Cc: broonie@kernel.org; alsa-devel@alsa-project.org; linux-
> kernel@vger.kernel.org; Girdwood, Liam R; Zhang, Vivian
> Subject: Re: [PATCH v3 1/2] ALSA: Kconfig: add config item SND_PROC_FS for
> expert
> 
> At Wed, 27 May 2015 17:10:17 +0800,
> Jie Yang wrote:
> >
> > For some embedded devices, we need reduce code size and data footprint
> > as much as possible, e.g. disabling procfs, hw/sw params refinement,
> > mmap, dpcm, dapm, compressed API...
> >
> > Here add SND_PROC_FS item for expert, we can unselect it to disable
> > sound proc FS and reduce memory footprint.
> >
> > Signed-off-by: Jie Yang <yang.jie@intel.com>
> > ---
> >  sound/core/Kconfig | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/sound/core/Kconfig b/sound/core/Kconfig index
> > 63cc2e9..4542554 100644
> > --- a/sound/core/Kconfig
> > +++ b/sound/core/Kconfig
> > @@ -225,4 +225,13 @@ config SND_DMA_SGBUF
> >  	def_bool y
> >  	depends on X86
> >
> > +config SND_PROC_FS
> > +        bool "Sound Proc FS Support" if EXPERT
> > +        depends on PROC_FS
> > +        default y
> > +        help
> > +          Say 'N' to disable Sound proc FS, which may reduce code size about
> > +          9KB on x86_64 platform.
> > +          If unsure say Y.
> > +
> >  source "sound/core/seq/Kconfig"
> 
> There is SND_VERBOSE_PROCFS that also depends on PROC_FS.
> You should change it as well to depend on SND_PROC_FS.
 
OK, will change it also.

~Keyon

> 
> 
> Takashi
