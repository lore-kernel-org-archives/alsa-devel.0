From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH V1 1/3] ASoC: fsl: Kconfig: remove
 dependence of SND_IMX_SOC for SND_SOC_IMX_PCM_DMA
Date: Mon, 18 Aug 2014 18:52:46 +0200
Message-ID: <53F22F5E.2090601@metafoo.de>
References: <cover.1408350626.git.shengjiu.wang@freescale.com>
 <f30ba4e2c4eb6702fa40bd255036e6e9ad6eb47d.1408350626.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-045.synserver.de (smtp-out-050.synserver.de
 [212.40.185.50])
 by alsa0.perex.cz (Postfix) with ESMTP id B9A5B261A8E
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 18:52:48 +0200 (CEST)
In-Reply-To: <f30ba4e2c4eb6702fa40bd255036e6e9ad6eb47d.1408350626.git.shengjiu.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shengjiu Wang <shengjiu.wang@freescale.com>, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, nicoleotsuka@gmail.com, Li.Xiubo@freescale.com, shc_work@mail.ru, fabio.estevam@freescale.com, xobs@kosagi.com, sfr@canb.auug.org.au, timur@tabi.org
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

On 08/18/2014 10:38 AM, Shengjiu Wang wrote:
> Build kernel with SND_SOC_IMC_PCM_DMA=m && SND_IMX_SOC=n leads the following
> error:
>
>     sound/built-in.o: In function `fsl_sai_probe':
>>> fsl_sai.c:(.text+0x5f662): undefined reference to `imx_pcm_dma_init'
>     sound/built-in.o: In function `fsl_esai_probe':
>>> fsl_esai.c:(.text+0x6044b): undefined reference to `imx_pcm_dma_init'
>
> Most cpu driver in soc/fsl has use the function 'imx_pcm_dma_init' which is
> defined in imx-pcm-dma.c, so need to select SND_SOC_IMX_PCM_DMA, but it depends
> on SND_IMX_SOC, if SND_IMX_SOC=n, then SND_SOC_IMX_PCM_DMA will not be
> selected.
> So remove the dependence of SND_IMX_SOC for SND_SOC_IMX_PCM_DMA.
>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>

Those if conditions where just added[1] by Arnd to avoid other build 
failures. So just removing them again makes little sense.

As far as I can see imx_pcm_dma_init() should be stubbed out when 
SND_SOC_IMX_PCM_DMA is not selected. So what's going on here?

[1] 
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=ff40260f79dc0436604452bccd449bffd25ebafb
