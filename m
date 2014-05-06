From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 3/4] ASoC: Intel: add the low level dsp
 driver for mrfld
Date: Tue, 6 May 2014 22:14:28 +0530
Message-ID: <20140506164428.GB28638@intel.com>
References: <1399312908-20744-1-git-send-email-vinod.koul@intel.com>
 <1399312908-20744-4-git-send-email-vinod.koul@intel.com>
 <1399391152.2814.40.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7901926179C
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 18:57:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1399391152.2814.40.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@intel.com>
Cc: jeeja.kp@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 06, 2014 at 04:45:52PM +0100, Liam Girdwood wrote:
> On Mon, 2014-05-05 at 23:31 +0530, Vinod Koul wrote:
> > This driver provides low level functions like sending and receiving IPCs, managing
> > power for DSP etc
> > 
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  sound/soc/intel/sst/Makefile            |    5 +
> >  sound/soc/intel/sst/sst.c               |  631 ++++++++++++++++++++
> >  sound/soc/intel/sst/sst.h               |  686 ++++++++++++++++++++++
> >  sound/soc/intel/sst/sst_drv_interface.c |  812 ++++++++++++++++++++++++++
> >  sound/soc/intel/sst/sst_ipc.c           |  388 +++++++++++++
> >  sound/soc/intel/sst/sst_loader.c        |  947 +++++++++++++++++++++++++++++++
> >  sound/soc/intel/sst/sst_pvt.c           |  203 +++++++
> >  sound/soc/intel/sst/sst_stream.c        |  529 +++++++++++++++++
> 
> We should rename the sst directory to avoid confusion with other sst
> drivers.
Sure, any suggestion :D

> > +struct intel_sst_drv *sst_drv_ctx;
> 
> static ?
yup!

> 
> > +static struct mutex drv_ctx_lock;
> > +
> 
> 
> > +
> > +static int sst_save_dsp_context_v2(struct intel_sst_drv *sst)
> 
> Is there a V1 somewhere ?
Yes that was used in mfld driver. I dont think we will get around to push those
bits

> 
> 
> > +static int intel_sst_suspend(struct device *dev)
> > +{
> > +
> 
> extra line ? Spotted this in a few places too.
> 
> Probably best to split this into several patches to make review easier.
Okay will do that

-- 
~Vinod
> 
> Liam
> 

-- 
