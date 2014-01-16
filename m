From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/2] ASoC: DPCM: make some DPCM API calls
 non static for compressed usage
Date: Thu, 16 Jan 2014 20:19:40 +0530
Message-ID: <20140116144940.GH25466@intel.com>
References: <1389804717-5985-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <20140116123153.GP15567@sirena.org.uk>
 <20140116144042.GG25466@intel.com> <1389887263.2298.53.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F4082619F4
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 16:51:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1389887263.2298.53.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.jf.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 16, 2014 at 03:47:43PM +0000, Liam Girdwood wrote:
> On Thu, 2014-01-16 at 20:10 +0530, Vinod Koul wrote:
> > On Thu, Jan 16, 2014 at 12:31:53PM +0000, Mark Brown wrote:
> > > On Wed, Jan 15, 2014 at 04:51:56PM +0000, Liam Girdwood wrote:
> > > > The ASoC compressed code needs to call the internal DPCM APIs in order to
> > > > dynamically route compressed data to different DAIs.
> > > 
> > > Applied, thanks.  I'm holding off on the second patch for a little so
> > > Vinod has a chance to say something since it's compressed stuff.
> > Both look good to me, so
> > 
> > Acked-by: Vinod Koul <vinod.koul@intel.com>
> > 
> > The second patch still needs an update for properly copying the hw_params. This
> > was one of issue reported by qcom folks, but I don't want to hold these now. We
> > can fix that as it will impact systems not have fixup function for BEs.
> 
> I assume you have that fix ? If so, I can add it incrementally ?
Not yet! That's why dont want to hold off this series...

We cna update that a bit later :)

--
~Vinod
