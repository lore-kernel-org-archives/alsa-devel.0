From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v6 3/4] ASoC: Intel - add makefile support
	for SKL driver
Date: Mon, 22 Jun 2015 11:03:37 +0530
Message-ID: <20150622053337.GT28601@localhost>
References: <1434546055-28866-1-git-send-email-vinod.koul@intel.com>
 <1434546055-28866-4-git-send-email-vinod.koul@intel.com>
 <20150619152748.GJ14071@sirena.org.uk>
 <20150619164824.GM28601@localhost>
 <20150620091535.GM14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 75DF0261583
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2015 07:32:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150620091535.GM14071@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 20, 2015 at 10:15:35AM +0100, Mark Brown wrote:
> On Fri, Jun 19, 2015 at 10:18:24PM +0530, Vinod Koul wrote:
> > On Fri, Jun 19, 2015 at 04:27:48PM +0100, Mark Brown wrote:
> 
> > > Should this be _SKYLAKE_HDA or something?  I may be confused on product
> > > naming and terminology but I thought these processors had both HDA and
> > > non-HDA support (possibly in the same silicon at times)?
> 
> > Unlike haswell or previous controllers, we dont have a separate HDA only
> > controller and a separate I2S based controller, it is integrated now :)
> 
> > So there will be only one Skylake controller :)
> 
> But this is specifically the HDA bits - I'd expect that there will be
> systems where people want Sky Lake support but don't need the HDA bits
> (possibly some of these more memory constrained ones)?
Nope, starting with SKL that is not possible. You get SKL HDA controller as
interface to subsystem. The BE can be either HDA (legacy/or with aDSP) or
I2S etc, but interface to subsystem is the HDA controller.

Thanks
-- 
~Vinod
