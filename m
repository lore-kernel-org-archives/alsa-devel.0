From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH 1/2] ASoC: soc-compress: add a config item
 for soc-compress
Date: Fri, 12 Jun 2015 13:33:25 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90554A26D@SHSMSX101.ccr.corp.intel.com>
References: <1434110356-23516-1-git-send-email-yang.jie@intel.com>
 <20150612121449.GS1921@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554A1FB@SHSMSX101.ccr.corp.intel.com>
 <20150612130002.GX1921@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E7F2260483
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 15:33:30 +0200 (CEST)
In-Reply-To: <20150612130002.GX1921@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: "ramesh.babu@linux.intel.com" <ramesh.babu@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "Zhang, Vivian" <vivian.zhang@intel.com>, "vinod.koul@linux.intel.com" <vinod.koul@linux.intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Friday, June 12, 2015 9:00 PM
> To: Jie, Yang
> Cc: tiwai@suse.de; alsa-devel@alsa-project.org; Girdwood, Liam R;
> vinod.koul@linux.intel.com; ramesh.babu@linux.intel.com; Zhang, Vivian
> Subject: Re: [PATCH 1/2] ASoC: soc-compress: add a config item for soc-
> compress
> 
> On Fri, Jun 12, 2015 at 12:31:25PM +0000, Jie, Yang wrote:
> 
> > > here to make the drivers that do use compressed support select this
> > > symbol
> 
> > As mentioned in commit message, we need add 'select
> SND_SOC_COMPRESS'
> > to driver  Kconfig(e.g. sound/soc/intel/Kconfig) when it is needed.
> >
> > > and since there's no config text there's no way for users to enable
> > > this on a per system basis so this breaks all existing compressed audio
> support.
> >
> > Do you mean I should add this message to 'Help' for this config item?
> > Per my understanding, no existing driver really uses this compressed
> > audio support currently, is that true?
> 
> Some of the existing Intel machine drivers have references to compressed
> audio, it certainly looks like they're trying to use it.  Are you saying that this is
> not actually the case?
 
Let me double confirm if the atom drivers are using it. Seems mfld platform is
using that.

~Keyon
