From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 2/2] ASoC: compress: Add suport for DPCM
 into compressed audio
Date: Thu, 16 Jan 2014 18:12:08 +0000
Message-ID: <1389895928.2298.77.camel@loki>
References: <1389804717-5985-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1389804717-5985-2-git-send-email-liam.r.girdwood@linux.intel.com>
 <20140116180115.GK17314@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 3446C2619FB
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 19:12:11 +0100 (CET)
In-Reply-To: <20140116180115.GK17314@sirena.org.uk>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2014-01-16 at 18:01 +0000, Mark Brown wrote:
> On Wed, Jan 15, 2014 at 04:51:57PM +0000, Liam Girdwood wrote:
> > Currently compressed audio streams are statically routed from the /dev
> > to the DAI link. Some DSPs can route compressed data to multiple BE DAIs
> > like they do for PCM data.
> 
> Applied both, thanks.

I have a fix for this, I guess you want it incrementally ?

Thanks

Liam
