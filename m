From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/5] ASoC: intel: log an error on double
 free
Date: Mon, 20 Oct 2014 18:44:13 +0530
Message-ID: <20141020131413.GF28745@intel.com>
References: <1413799148-6368-1-git-send-email-vinod.koul@intel.com>
 <1413799148-6368-3-git-send-email-vinod.koul@intel.com>
 <s5hzjcrkmgy.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 677C3264F2F
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 15:51:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hzjcrkmgy.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 20, 2014 at 01:30:05PM +0200, Takashi Iwai wrote:
> At Mon, 20 Oct 2014 15:29:05 +0530,
> Vinod Koul wrote:
> > 
> > the stream context should be freed only once on stream cleanup. If we ever
> > hit a chance that stream context is getting double freed, though not an
> > cause of panic as memory allocator can deal with this, we should still log
> > this to help in finding issues and debugging
> > 
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  sound/soc/intel/sst/sst_drv_interface.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/sound/soc/intel/sst/sst_drv_interface.c b/sound/soc/intel/sst/sst_drv_interface.c
> > index aadb0db..423c5ff 100644
> > --- a/sound/soc/intel/sst/sst_drv_interface.c
> > +++ b/sound/soc/intel/sst/sst_drv_interface.c
> > @@ -55,6 +55,8 @@ int free_stream_context(struct intel_sst_drv *ctx, unsigned int str_id)
> >  		if (ret)
> >  			sst_clean_stream(&ctx->streams[str_id]);
> >  		return ret;
> > +	} else {
> > +		dev_err(ctx->dev, "we tried to free stream context %d which was freed!!!", str_id);
> 
> Missing line feed at the end of the string.
Thanks for pointing :)

-- 
~Vinod

> 
> 
> Takashi
> 
> 
> >  	}
> >  	return ret;
> >  }
> > -- 
> > 1.7.0.4
> > 
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > 

-- 
