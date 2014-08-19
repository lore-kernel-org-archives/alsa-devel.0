From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH V1 1/3] ASoC: fsl: Kconfig: remove
 dependence of SND_IMX_SOC for SND_SOC_IMX_PCM_DMA
Date: Tue, 19 Aug 2014 08:13:15 +0000
Message-ID: <d7b06608abcc4f098789f63cb9f36eef@BN1PR0301MB0609.namprd03.prod.outlook.com>
References: <cover.1408350626.git.shengjiu.wang@freescale.com>
 <f30ba4e2c4eb6702fa40bd255036e6e9ad6eb47d.1408350626.git.shengjiu.wang@freescale.com>
 <53F22F5E.2090601@metafoo.de> <20140819074103.GA5806@audiosh1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0140.outbound.protection.outlook.com [207.46.163.140])
 by alsa0.perex.cz (Postfix) with ESMTP id 90D472655EE
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 10:13:21 +0200 (CEST)
In-Reply-To: <20140819074103.GA5806@audiosh1>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "shengjiu.wang@freescale.com" <shengjiu.wang@freescale.com>, Lars-Peter
 Clausen <lars@metafoo.de>
Cc: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@tabi.org" <timur@tabi.org>, "arnd@arndb.de" <arnd@arndb.de>, "shc_work@mail.ru" <shc_work@mail.ru>, "tiwai@suse.de" <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "xobs@kosagi.com" <xobs@kosagi.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

> Subject: Re: [alsa-devel] [PATCH V1 1/3] ASoC: fsl: Kconfig: remove dependence
> of SND_IMX_SOC for SND_SOC_IMX_PCM_DMA
> 
> On Mon, Aug 18, 2014 at 06:52:46PM +0200, Lars-Peter Clausen wrote:
> > On 08/18/2014 10:38 AM, Shengjiu Wang wrote:
> > >Build kernel with SND_SOC_IMC_PCM_DMA=m && SND_IMX_SOC=n leads the
> following
> > >error:
> > >
> > >    sound/built-in.o: In function `fsl_sai_probe':
> > >>>fsl_sai.c:(.text+0x5f662): undefined reference to `imx_pcm_dma_init'
> > >    sound/built-in.o: In function `fsl_esai_probe':
> > >>>fsl_esai.c:(.text+0x6044b): undefined reference to `imx_pcm_dma_init'
> > >
> > >Most cpu driver in soc/fsl has use the function 'imx_pcm_dma_init' which is
> > >defined in imx-pcm-dma.c, so need to select SND_SOC_IMX_PCM_DMA, but it
> depends
> > >on SND_IMX_SOC, if SND_IMX_SOC=n, then SND_SOC_IMX_PCM_DMA will not be
> > >selected.
> > >So remove the dependence of SND_IMX_SOC for SND_SOC_IMX_PCM_DMA.
> > >
> > >Reported-by: kbuild test robot <fengguang.wu@intel.com>
> > >Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
> >
> > Those if conditions where just added[1] by Arnd to avoid other build
> > failures. So just removing them again makes little sense.
> >
> > As far as I can see imx_pcm_dma_init() should be stubbed out when
> > SND_SOC_IMX_PCM_DMA is not selected. So what's going on here?
> >
> > [1]
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=ff40
> 260f79dc0436604452bccd449bffd25ebafb
> >
> Lars-Peter Clausen & Arnd
> 
> The purpose of Arnd's patch is same with me, which is to resolve the build
> error when SND_SOC_IMX_PCM_DMA=m & SND_SOC_FSL_SSI/SAI/ESAI/SPDIF=y, the
> error is "undefined reference to `imx_pcm_dma_init'".
> But Arnd's patch didn't involve this situation that SND_IMX_SOC=n &
> SND_SOC_IMX_PCM_DMA=m.
> 
> Currently I think out a solution for this issue is to change
> 
> select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
> 
> to
> 
> depends on SND_SOC_IMX_PCM_DMA != m
> 
> How do you think about this?
> 

What will happen if to build both SAI/ESAI and IMX_PCM_DMA as modules at the same
time ?

Thanks,

BRs
Xiubo


> best regards
> Wang shengjiu
