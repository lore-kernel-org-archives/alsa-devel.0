From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] ASoC: Intel: sst: Remove unused function
 sst_restore_shim64()
Date: Wed, 7 Jun 2017 14:53:29 -0700
Message-ID: <20170607215329.GD141096@google.com>
References: <20170523001258.81618-1-mka@chromium.org>
 <s5hshjb329o.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hshjb329o.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

El Wed, Jun 07, 2017 at 11:40:19PM +0200 Takashi Iwai ha dit:

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

Doug Anderson also noticed this and removed the function and struct
sst_shim_regs64:

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?h=for-next&id=98cf2c03b467fa67df58cb52adeb85b425cabcb2

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
