From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v4 1/2] ASoC: Intel: Add Cherrytrail &
 Braswell machine driver cht_bsw_rt5672
Date: Tue, 18 Nov 2014 04:57:31 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B73DDD6@SHSMSX101.ccr.corp.intel.com>
References: <c59847b1110e5302ec0a82700d4e318bef2a3f66.1414148860.git.mengdong.lin@intel.com>
 <59ead992379b0a224a2482888a6e6dc1ab611f36.1416216640.git.mengdong.lin@intel.com>
 <20141117153528.GA2074@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7ADF3261545
 for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2014 05:57:38 +0100 (CET)
In-Reply-To: <20141117153528.GA2074@intel.com>
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
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "Prusty,
 Subhransu S" <subhransu.s.prusty@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Koul, Vinod
> Sent: Monday, November 17, 2014 11:35 PM

> On Mon, Nov 17, 2014 at 05:34:09PM +0800, mengdong.lin@intel.com
> wrote:
> > From: Mengdong Lin <mengdong.lin@intel.com>
> >
> > Add machine driver for two Intel Cherryview-based platforms,
> > Cherrytrail and Braswell, with RT5672 codec.
> >
> > Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
> >
> > diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig index
> > a992e85..0a02d88 100644
> > --- a/sound/soc/intel/Kconfig
> > +++ b/sound/soc/intel/Kconfig
> > @@ -86,3 +86,17 @@ config SND_SOC_INTEL_BROADWELL_MACH
> >  	  Ultrabook platforms.
> >  	  Say Y if you have such a device
> >  	  If unsure select "N".
> > +
> > +config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
> > +        tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with
> RT5672 codec"
> > +        depends on X86_INTEL_LPSS
> > +        select SND_SOC_RT5670
> > +        select SND_SST_MFLD_PLATFORM
> > +        select SND_SOC_INTEL_SST
> This is not correct, it could have been SND_INTEL_IPC but that is selected by
> below entry so adding SND_SST_IPC_ACPI is enough.
> 
> > +        select SND_SST_IPC_ACPI
> 

I removed the SND_SOC_INTEL_SST and keep SND_SST_IPC_ACPI in v5 of this patch.
Thanks for pointing out this!

Mengdong
