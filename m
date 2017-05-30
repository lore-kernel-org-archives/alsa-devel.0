From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC PATCH v2] ASoC: Intel: sst: Delete
 sst_shim_regs64; saved regs are never used
Date: Tue, 30 May 2017 20:06:38 +0300
Message-ID: <CAHp75Ve2nRf5SdFUTcAPwpYSKWvG4fyHKMJUzoVcg73NQp0xYQ@mail.gmail.com>
References: <20170530165130.15011-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f196.google.com (mail-qk0-f196.google.com
 [209.85.220.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A8CB266D5D
 for <alsa-devel@alsa-project.org>; Tue, 30 May 2017 19:06:39 +0200 (CEST)
Received: by mail-qk0-f196.google.com with SMTP id v195so5306694qka.2
 for <alsa-devel@alsa-project.org>; Tue, 30 May 2017 10:06:39 -0700 (PDT)
In-Reply-To: <20170530165130.15011-1-dianders@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Douglas Anderson <dianders@chromium.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, naveen.m@intel.com, Colin King <colin.king@canonical.com>, =?UTF-8?B?5Z2C5pys6LK05Y+y?= <o-takashi@sakamocchi.jp>, sebastien.guiriec@intel.com, Matthias Kaehlcke <mka@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 30, 2017 at 7:51 PM, Douglas Anderson <dianders@chromium.org> wrote:
> In commit 9a075265c6dc ("ASoC: Intel: sst: Remove unused function
> sst_restore_shim64()"), we deleted the sst_restore_shim64() since it
> was never used.  ...but a quick look at the code shows that we should
> also be able to remove the sst_save_shim64() function and the
> structure members we were storing data in.
>
> Once we delete sst_save_shim64() there are no longer any users of the
> 'sst_shim_regs64' structure.  That means we can delete it completely
> and also avoid allocating memory for it.  This saves a whopping 136
> bytes of devm allocated memory.  We also get the nice benefit of
> avoiding an error path in the init code.
>
> Note that the saving code that we're removing (and the comments
> talking about how important it is to do the save) has been around
> since commit 336cfbb05edf ("ASoC: Intel: mrfld- add ACPI module").

I like it!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

P.S. Perhaps there are more leftovers or dead code?

>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This problem was found only by code inspection and only compile
> tested.  Hence, RFC.
>
> Changes in v2:
> - Fully delete the structure.
>
>  sound/soc/intel/atom/sst/sst.c      | 19 -------------------
>  sound/soc/intel/atom/sst/sst.h      | 22 ----------------------
>  sound/soc/intel/atom/sst/sst_acpi.c | 14 --------------
>  3 files changed, 55 deletions(-)
>
> diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
> index 2d43b8693c0c..5ee92257ca85 100644
> --- a/sound/soc/intel/atom/sst/sst.c
> +++ b/sound/soc/intel/atom/sst/sst.c
> @@ -382,21 +382,6 @@ void sst_context_cleanup(struct intel_sst_drv *ctx)
>  }
>  EXPORT_SYMBOL_GPL(sst_context_cleanup);
>
> -static inline void sst_save_shim64(struct intel_sst_drv *ctx,
> -                           void __iomem *shim,
> -                           struct sst_shim_regs64 *shim_regs)
> -{
> -       unsigned long irq_flags;
> -
> -       spin_lock_irqsave(&ctx->ipc_spin_lock, irq_flags);
> -
> -       shim_regs->imrx = sst_shim_read64(shim, SST_IMRX);
> -       shim_regs->csr = sst_shim_read64(shim, SST_CSR);
> -
> -
> -       spin_unlock_irqrestore(&ctx->ipc_spin_lock, irq_flags);
> -}
> -
>  void sst_configure_runtime_pm(struct intel_sst_drv *ctx)
>  {
>         pm_runtime_set_autosuspend_delay(ctx->dev, SST_SUSPEND_DELAY);
> @@ -416,8 +401,6 @@ void sst_configure_runtime_pm(struct intel_sst_drv *ctx)
>                 pm_runtime_set_active(ctx->dev);
>         else
>                 pm_runtime_put_noidle(ctx->dev);
> -
> -       sst_save_shim64(ctx, ctx->shim, ctx->shim_regs64);
>  }
>  EXPORT_SYMBOL_GPL(sst_configure_runtime_pm);
>
> @@ -441,8 +424,6 @@ static int intel_sst_runtime_suspend(struct device *dev)
>         flush_workqueue(ctx->post_msg_wq);
>
>         ctx->ops->reset(ctx);
> -       /* save the shim registers because PMC doesn't save state */
> -       sst_save_shim64(ctx, ctx->shim, ctx->shim_regs64);
>
>         return ret;
>  }
> diff --git a/sound/soc/intel/atom/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
> index 5c9a51cc77aa..1693befa455a 100644
> --- a/sound/soc/intel/atom/sst/sst.h
> +++ b/sound/soc/intel/atom/sst/sst.h
> @@ -317,26 +317,6 @@ struct sst_ipc_reg {
>         int ipcd;
>  };
>
> -struct sst_shim_regs64 {
> -       u64 csr;
> -       u64 pisr;
> -       u64 pimr;
> -       u64 isrx;
> -       u64 isrd;
> -       u64 imrx;
> -       u64 imrd;
> -       u64 ipcx;
> -       u64 ipcd;
> -       u64 isrsc;
> -       u64 isrlpesc;
> -       u64 imrsc;
> -       u64 imrlpesc;
> -       u64 ipcsc;
> -       u64 ipclpesc;
> -       u64 clkctl;
> -       u64 csr2;
> -};
> -
>  struct sst_fw_save {
>         void *iram;
>         void *dram;
> @@ -356,7 +336,6 @@ struct sst_fw_save {
>   * @dram : SST DRAM pointer
>   * @pdata : SST info passed as a part of pci platform data
>   * @shim_phy_add : SST shim phy addr
> - * @shim_regs64: Struct to save shim registers
>   * @ipc_dispatch_list : ipc messages dispatched
>   * @rx_list : to copy the process_reply/process_msg from DSP
>   * @ipc_post_msg_wq : wq to post IPC messages context
> @@ -398,7 +377,6 @@ struct intel_sst_drv {
>         unsigned int            ddr_end;
>         unsigned int            ddr_base;
>         unsigned int            mailbox_recv_offset;
> -       struct sst_shim_regs64  *shim_regs64;
>         struct list_head        block_list;
>         struct list_head        ipc_dispatch_list;
>         struct sst_platform_info *pdata;
> diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
> index 592f6afaf2a5..cf88cd1865fb 100644
> --- a/sound/soc/intel/atom/sst/sst_acpi.c
> +++ b/sound/soc/intel/atom/sst/sst_acpi.c
> @@ -358,23 +358,9 @@ static int sst_acpi_probe(struct platform_device *pdev)
>         if (ret < 0)
>                 return ret;
>
> -       /* need to save shim registers in BYT */
> -       ctx->shim_regs64 = devm_kzalloc(ctx->dev, sizeof(*ctx->shim_regs64),
> -                                       GFP_KERNEL);
> -       if (!ctx->shim_regs64) {
> -               ret = -ENOMEM;
> -               goto do_sst_cleanup;
> -       }
> -
>         sst_configure_runtime_pm(ctx);
>         platform_set_drvdata(pdev, ctx);
>         return ret;
> -
> -do_sst_cleanup:
> -       sst_context_cleanup(ctx);
> -       platform_set_drvdata(pdev, NULL);
> -       dev_err(ctx->dev, "failed with %d\n", ret);
> -       return ret;
>  }
>
>  /**
> --
> 2.13.0.219.gdb65acc882-goog
>



-- 
With Best Regards,
Andy Shevchenko
