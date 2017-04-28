From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/3] ASoC: Intel: Skylake: Fix
	uninitialized pointer usage
Date: Fri, 28 Apr 2017 08:00:13 +0530
Message-ID: <20170428023013.GK6263@localhost>
References: <e9ad51bf-2292-3cde-beca-4dd76cfe235b@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 86E30266C0A
 for <alsa-devel@alsa-project.org>; Fri, 28 Apr 2017 04:28:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <e9ad51bf-2292-3cde-beca-4dd76cfe235b@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Colin King <colin.king@canonical.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 28, 2017 at 07:46:27AM +0900, Takashi Sakamoto wrote:
> On Apr 27 2017 15:51, Vinod Koul wrote:
> > Due to recent code move, one instance dev_err() was passed a wrong
> > uninitialized pointer for the device, so fix it.
> > 
> > sound/soc/intel/skylake/bxt-sst.c: In function 'bxt_sst_dsp_init':
> > sound/soc/intel/skylake/bxt-sst.c:567:14: warning: 'skl' may be used uninitialized in this function [-Wmaybe-uninitialized]
> >    dev_err(skl->dev, "%s: no device\n", __func__);
> >               ^
> > 
> > Fixes: 9fe9c7119283 ("ASoC: Intel: Skylake: Move sst common initialization to a helper function")
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  sound/soc/intel/skylake/bxt-sst.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> 
> Dan and Colin were also going to fix this apparent bug. It's nice to add
> their contribution, I think.
> 
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Suggested-by: Colin King <colin.king@canonical.com>

you missed Arnd :)

So based on this rule we should also add:
Suggested-by: Arnd Bergmann <arnd@arndb.de>

> 
> http://mailman.alsa-project.org/pipermail/alsa-devel/2017-April/120225.html
> http://mailman.alsa-project.org/pipermail/alsa-devel/2017-April/120242.html
> 
> > diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
> > index fde4bc0f35b0..f5e7dbb1ba39 100644
> > --- a/sound/soc/intel/skylake/bxt-sst.c
> > +++ b/sound/soc/intel/skylake/bxt-sst.c
> > @@ -564,7 +564,7 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
> >  
> >  	ret = skl_sst_ctx_init(dev, irq, fw_name, dsp_ops, dsp, &skl_dev);
> >  	if (ret < 0) {
> > -		dev_err(skl->dev, "%s: no device\n", __func__);
> > +		dev_err(dev, "%s: no device\n", __func__);
> >  		return ret;
> >  	}
> 
> 
> Regards
> 
> Takashi Sakamoto

-- 
~Vinod
