From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel Kconfig: add
 SND_SOC_INTEL_BOARDS option
Date: Fri, 19 Jun 2015 09:58:56 +0100
Message-ID: <1434704336.19885.8.camel@loki>
References: <1434657579-21581-1-git-send-email-michele.curti@gmail.com>
 <20150619080806.GJ28601@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A8A1260545
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 10:59:06 +0200 (CEST)
In-Reply-To: <20150619080806.GJ28601@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Michele Curti <michele.curti@gmail.com>, alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org, jarkko.nikula@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2015-06-19 at 13:38 +0530, Vinod Koul wrote:
> On Thu, Jun 18, 2015 at 09:59:39PM +0200, Michele Curti wrote:
> > Machine drivers under boards folder must be available for both
> > SND_SST_MFLD_PLATFORM and SND_SOC_INTEL_SST.  This patch adds a
> > new kernel option SND_SOC_INTEL_BOARD to permit this.
> 
> I dont think we need another config option, we should rather use SND_SOC :)
> 
> Also Liam, do we need a prompt for SND_SOC_INTEL_SST, i am thinking of
> removing that one and have it selected by respective machine drivers?

Yeah, lets simplify our Kconfig now that we have cleaned up the intel
directory.

Liam
