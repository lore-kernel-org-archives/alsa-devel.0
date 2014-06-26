From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 00/19]: add mrfld DSP support
Date: Thu, 26 Jun 2014 16:01:47 +0530
Message-ID: <20140626103147.GW22053@intel.com>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
 <53A3EB23.4050302@metafoo.de> <20140620082041.GG22053@intel.com>
 <53A3F775.80303@metafoo.de> <20140623100957.GX24291@sirena.org.uk>
 <53AA4FC0.5010202@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 0649C2610C1
 for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2014 12:32:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <53AA4FC0.5010202@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 25, 2014 at 06:27:44AM +0200, Lars-Peter Clausen wrote:
> On 06/23/2014 12:09 PM, Mark Brown wrote:
> >On Fri, Jun 20, 2014 at 10:57:25AM +0200, Lars-Peter Clausen wrote:
> >
> >>The idea is to get rid of the IO abstraction layer inside ASoC and only rely
> >>on regmap for this. This is a process this has been going on ever since the
> >>regmap framework was added to the kernel and we are almost there now. The
> >>best is to implement a regmap bus or a bus-less regmap instance that
> >>implements the IPC for the DSP. If the IPC does not map nicely onto a
> >>register map, we need to come up with something better. It's basically the
> >>same problem that that HDA CODEC by RT has.
No the register file _does_ not map to IPCs, as I have explained previosuly. The
file is just to store the informationa nd dpam widget handling triggers IPCs.

Since we are NOT writing to device, I still dont think regmap will help

> >Well, it depends.  If the device looks like it has a register map that's
> >sensible but if it looks nothing like that then we should be
> >implementing the widgets differently.  It may be that we need to be
> >constructing and destructing objects on the DSP for example.
> 
> What do you mean by 'constructing/destructing on the DSP'?
I think Mark refers to modules and processing elements on DSP. Since this is DSP
(firmware) we can tell it to create a link b/w FE and BE, throw in another link
etc. Unlike codec, everything is driver controlled and instances created and
destroyed dynamically.

yes upating this to latest dapm (thanks to Lars for that), will help in moving
code away from driver

-- 
~Vinod
