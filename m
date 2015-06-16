From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/2] ASoC: soc-compress: add a config item
 for soc-compress
Date: Tue, 16 Jun 2015 13:43:36 +0530
Message-ID: <20150616081336.GV28601@localhost>
References: <1434110356-23516-1-git-send-email-yang.jie@intel.com>
 <20150612121449.GS1921@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554A1FB@SHSMSX101.ccr.corp.intel.com>
 <20150612130002.GX1921@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554A26D@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 34F422619FA
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 10:12:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A90554A26D@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Jie, Yang" <yang.jie@intel.com>
Cc: "ramesh.babu@linux.intel.com" <ramesh.babu@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "Zhang, Vivian" <vivian.zhang@intel.com>, "vinod.koul@linux.intel.com" <vinod.koul@linux.intel.com>, Mark Brown <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 12, 2015 at 01:33:25PM +0000, Jie, Yang wrote:
> > -----Original Message-----
> > From: Mark Brown [mailto:broonie@kernel.org]
> > Sent: Friday, June 12, 2015 9:00 PM
> > To: Jie, Yang
> > Cc: tiwai@suse.de; alsa-devel@alsa-project.org; Girdwood, Liam R;
> > vinod.koul@linux.intel.com; ramesh.babu@linux.intel.com; Zhang, Vivian
> > Subject: Re: [PATCH 1/2] ASoC: soc-compress: add a config item for soc-
> > compress
Okay didnt realise that its posted to alsa :( I need to remove all ref to
@linux id as am not using that anymore

> > 
> > On Fri, Jun 12, 2015 at 12:31:25PM +0000, Jie, Yang wrote:
> > 
> > > > here to make the drivers that do use compressed support select this
> > > > symbol
> > 
> > > As mentioned in commit message, we need add 'select
> > SND_SOC_COMPRESS'
> > > to driver  Kconfig(e.g. sound/soc/intel/Kconfig) when it is needed.
> > >
> > > > and since there's no config text there's no way for users to enable
> > > > this on a per system basis so this breaks all existing compressed audio
> > support.
> > >
> > > Do you mean I should add this message to 'Help' for this config item?
> > > Per my understanding, no existing driver really uses this compressed
> > > audio support currently, is that true?
> > 
> > Some of the existing Intel machine drivers have references to compressed
> > audio, it certainly looks like they're trying to use it.  Are you saying that this is
> > not actually the case?
>  
> Let me double confirm if the atom drivers are using it. Seems mfld platform is
> using that.
Yes and we will get runtime errors on all mfld-atom based drivers so please
add that on all atom machines

Since the dummy symbols are present so we wont get build errors. If a driver is
using the compressed API maybe we should not add dummy so that we catch ones
which are not including this config option, so for that point I would say
removal of dummay handlers looks best to me.

-- 
~Vinod
