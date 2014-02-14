From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 5/5] ASoC: Intel: Add build support for
 Intel	SST DSP core.
Date: Fri, 14 Feb 2014 09:40:16 +0000
Message-ID: <1392370816.2300.8.camel@loki>
References: <1392318930-8771-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1392318930-8771-5-git-send-email-liam.r.girdwood@linux.intel.com>
 <s5hwqgyhy1z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A9962652C5
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2014 10:40:20 +0100 (CET)
In-Reply-To: <s5hwqgyhy1z.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Benson Leung <bleung@google.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2014-02-14 at 09:56 +0100, Takashi Iwai wrote:
> At Thu, 13 Feb 2014 19:15:30 +0000,
> Liam Girdwood wrote:
> > 
> > This adds kernel build support for Intel SST core audio.
> > 
> > Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> > ---
> >  sound/soc/intel/Kconfig  | 14 ++++++++++++++
> >  sound/soc/intel/Makefile |  7 +++++++
> >  2 files changed, 21 insertions(+)
> > 
> > diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> > index 4d9d0a5..0b51451 100644
> > --- a/sound/soc/intel/Kconfig
> > +++ b/sound/soc/intel/Kconfig
> > @@ -11,3 +11,17 @@ config SND_MFLD_MACHINE
> >  
> >  config SND_SST_MFLD_PLATFORM
> >  	tristate
> > +
> > +config SND_SOC_INTEL_SST
> > +	tristate "ASoC support for Intel(R) Smart Sound Technology"
> > +	select SND_SOC_INTEL_SST_ACPI if ACPI
> > +	help
> > +          This adds support for Intel(R) Smart Sound Technology (SST).
> > +          Say Y if you have such a device
> > +          If unsure select "N".
> > +
> > +config SND_SOC_INTEL_SST_ACPI
> > +	tristate
> > +
> > +config SND_SOC_INTEL_HASWELL
> > +	tristate
> 
> I guess the last one is superfluous?  It's used nowhere else.
> 
> 

Yeap, for this series. It's actually part of the Haswell support (next
patch series). I had just chopped things down into a smaller patch
series for easier review.

Liam
