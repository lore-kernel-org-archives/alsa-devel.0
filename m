From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: sst: Remove unused function
 sst_restore_shim64()
Date: Fri, 9 Jun 2017 09:10:04 +0530
Message-ID: <20170609034004.GR2885@localhost>
References: <20170523001258.81618-1-mka@chromium.org>
 <s5hshjb329o.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 68349267339
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 05:37:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hshjb329o.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 07, 2017 at 11:40:19PM +0200, Takashi Iwai wrote:
> On Tue, 23 May 2017 02:12:58 +0200,
> Matthias Kaehlcke wrote:
> > 
> > Looks like the function has never been used since it was added by commit
> > b0d94acd634a ("ASoC: Intel: mrfld - add shim save restore"). Removing it
> > fixes the following warning when building with clang:
> > 
> > sound/soc/intel/atom/sst/sst.c:360:20: error: unused function
> >     'sst_restore_shim64' [-Werror,-Wunused-function]
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> Hmm, although this patch was already merged, I now think this is
> rather a bug.  If the restore is never executed, why the counterpart,
> sst_save_shim64() is required at all at runtime suspend?
> 
> Vinod?

It was supposed to be required in early BYT boards. I do not seem to recall
why the call to sst_restore_shim64 was removed from resume routine, it was
there when we added it and due to file move git log is useless.

Any idea how to get changes to file before the file was moved?

> thanks,
> 
> Takashi
> 
> > ---
> >  sound/soc/intel/atom/sst/sst.c | 16 ----------------
> >  1 file changed, 16 deletions(-)
> > 
> > diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
> > index f9ba71315e33..fb608d3a90c8 100644
> > --- a/sound/soc/intel/atom/sst/sst.c
> > +++ b/sound/soc/intel/atom/sst/sst.c
> > @@ -397,22 +397,6 @@ static inline void sst_save_shim64(struct intel_sst_drv *ctx,
> >  	spin_unlock_irqrestore(&ctx->ipc_spin_lock, irq_flags);
> >  }
> >  
> > -static inline void sst_restore_shim64(struct intel_sst_drv *ctx,
> > -				      void __iomem *shim,
> > -				      struct sst_shim_regs64 *shim_regs)
> > -{
> > -	unsigned long irq_flags;
> > -
> > -	/*
> > -	 * we only need to restore IMRX for this case, rest will be
> > -	 * initialize by FW or driver when firmware is loaded
> > -	 */
> > -	spin_lock_irqsave(&ctx->ipc_spin_lock, irq_flags);
> > -	sst_shim_write64(shim, SST_IMRX, shim_regs->imrx);
> > -	sst_shim_write64(shim, SST_CSR, shim_regs->csr);
> > -	spin_unlock_irqrestore(&ctx->ipc_spin_lock, irq_flags);
> > -}
> > -
> >  void sst_configure_runtime_pm(struct intel_sst_drv *ctx)
> >  {
> >  	pm_runtime_set_autosuspend_delay(ctx->dev, SST_SUSPEND_DELAY);
> > -- 
> > 2.13.0.303.g4ebf302169-goog
> > 
> > 

-- 
~Vinod
