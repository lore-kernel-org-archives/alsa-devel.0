From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/intel 36/41]
 sound/soc/intel/skylake/skl-sst-cldma.c:141:1-3: ERROR: test of a
 variable/field address
Date: Fri, 20 Nov 2015 17:59:04 +0800
Message-ID: <201511201702.ZnD2L1We%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 03563261294
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2015 10:59:38 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/intel
head:   314038e40a62c7cdfc07aad0fe14dcd4383bc34d
commit: ae395937ab95b8c62806af6a17a6cdfe6086401e [36/41] ASoC: Intel: Skylake: Fix cleanup of dma buffer


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/intel/skylake/skl-sst-cldma.c:141:1-3: ERROR: test of a variable/field address
   sound/soc/intel/skylake/skl-sst-cldma.c:143:1-3: ERROR: test of a variable/field address

vim +141 sound/soc/intel/skylake/skl-sst-cldma.c

   125	
   126		sst_dsp_shim_update_bits(ctx, SKL_ADSP_REG_CL_SD_CTL,
   127					CL_SD_CTL_IOCE_MASK, CL_SD_CTL_IOCE(0));
   128		sst_dsp_shim_update_bits(ctx, SKL_ADSP_REG_CL_SD_CTL,
   129					CL_SD_CTL_FEIE_MASK, CL_SD_CTL_FEIE(0));
   130		sst_dsp_shim_update_bits(ctx, SKL_ADSP_REG_CL_SD_CTL,
   131					CL_SD_CTL_DEIE_MASK, CL_SD_CTL_DEIE(0));
   132		sst_dsp_shim_update_bits(ctx, SKL_ADSP_REG_CL_SD_CTL,
   133					CL_SD_CTL_STRM_MASK, CL_SD_CTL_STRM(0));
   134	
   135		sst_dsp_shim_write(ctx, SKL_ADSP_REG_CL_SD_BDLPL, CL_SD_BDLPLBA(0));
   136		sst_dsp_shim_write(ctx, SKL_ADSP_REG_CL_SD_BDLPU, 0);
   137	
   138		sst_dsp_shim_write(ctx, SKL_ADSP_REG_CL_SD_CBL, 0);
   139		sst_dsp_shim_write(ctx, SKL_ADSP_REG_CL_SD_LVI, 0);
   140	
 > 141		if (&ctx->cl_dev.dmab_data)
   142			ctx->dsp_ops.free_dma_buf(ctx->dev, &ctx->cl_dev.dmab_data);
   143		if (&ctx->cl_dev.dmab_bdl)
   144			ctx->dsp_ops.free_dma_buf(ctx->dev, &ctx->cl_dev.dmab_bdl);
   145	}
   146	
   147	static int skl_cldma_wait_interruptible(struct sst_dsp *ctx)
   148	{
   149		int ret = 0;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
