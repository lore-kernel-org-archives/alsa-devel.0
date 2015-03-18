From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: ASoC: Intel: mrfld- add ACPI module
Date: Wed, 18 Mar 2015 16:45:39 +0530
Message-ID: <20150318111539.GH32683@intel.com>
References: <20141124235209.GA16222@mwanda>
 <20150318110932.GT16501@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EB1C2605F2
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 12:19:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20150318110932.GT16501@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 18, 2015 at 02:09:32PM +0300, Dan Carpenter wrote:
> Ping?
Sory dan, this seems to have slipped thru, I will send the patch for this.

Thanks a bunch for reporting

-- 
~Vinod

> 
> regards,
> dan carpenter
> 
> On Tue, Nov 25, 2014 at 02:52:09AM +0300, Dan Carpenter wrote:
> > Hello Vinod Koul,
> > 
> > The patch 336cfbb05edf: "ASoC: Intel: mrfld- add ACPI module" from
> > Nov 11, 2014, leads to the following static checker warning:
> > 
> > 	sound/soc/intel/sst/sst_acpi.c:313 sst_acpi_probe()
> > 	info: ignoring unreachable code.
> > 
> > sound/soc/intel/sst/sst_acpi.c
> >    304          ret = sst_context_init(ctx);
> >    305          if (ret < 0)
> >    306                  return ret;
> >    307  
> >    308          /* need to save shim registers in BYT */
> >    309          ctx->shim_regs64 = devm_kzalloc(ctx->dev, sizeof(*ctx->shim_regs64),
> >    310                                          GFP_KERNEL);
> >    311          if (!ctx->shim_regs64) {
> >    312                  return -ENOMEM;
> >                         ^^^^^^^^^^^^^^^
> >    313                  goto do_sst_cleanup;
> >                         ^^^^^^^^^^^^^^^^^^^^
> >    314          }
> >    315  
> >    316          sst_configure_runtime_pm(ctx);
> >    317          platform_set_drvdata(pdev, ctx);
> >    318          return ret;
> >    319  
> >    320  do_sst_cleanup:
> >    321          sst_context_cleanup(ctx);
> >    322          platform_set_drvdata(pdev, NULL);
> >    323          dev_err(ctx->dev, "failed with %d\n", ret);
> >    324          return ret;
> >    325  }
> > 
> > regards,
> > dan carpenter

-- 
