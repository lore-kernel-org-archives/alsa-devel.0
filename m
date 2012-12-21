From: "Liu, Chuansheng" <chuansheng.liu@intel.com>
Subject: RE: [PATCH] ASoC: dapm: Fix the unpaired runtime_get/put cases
Date: Fri, 21 Dec 2012 01:34:45 +0000
Message-ID: <27240C0AC20F114CBF8149A2696CBE4A1F48F8@SHSMSX101.ccr.corp.intel.com>
References: <1355913397.17896.10.camel@cliu38-desktop-build>
 <20121219091127.GL4985@opensource.wolfsonmicro.com>
 <27240C0AC20F114CBF8149A2696CBE4A1F3CA7@SHSMSX101.ccr.corp.intel.com>
 <20121220135104.GB4985@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121220135104.GB4985@opensource.wolfsonmicro.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "lrg@ti.com" <lrg@ti.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Thursday, December 20, 2012 9:51 PM
> To: Liu, Chuansheng
> Cc: lrg@ti.com; perex@perex.cz; tiwai@suse.de; alsa-devel@alsa-project.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ASoC: dapm: Fix the unpaired runtime_get/put cases
> 
> On Thu, Dec 20, 2012 at 06:37:26AM +0000, Liu, Chuansheng wrote:
> 
> > Meanwhile, is it useful to add one warning there for that case?
> > After all, in probing, set the bias to _STANDBY even idle_bias_off == 1, and
> calling get_runtime_sync(), it
> > will let the code more obscure. So giving a warning there to indicate the
> driver:
> > it is not suggested that in probing, set the bias to _STANDBY even
> idle_bias_off == 1.
> 
> Probably, send a patch please.  Like I say it is possible to start off
> in _STANDBY providing the driver grabs the runtime PM reference too but
> I can't think of any reason for doing that so the warning seems sensible.
The patch https://lkml.org/lkml/2012/12/20/506 has been sent for giving warning
in that case. Thanks your reviewing.
