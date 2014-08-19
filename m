From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH V1 1/3] ASoC: fsl: Kconfig: remove
 dependence of SND_IMX_SOC for SND_SOC_IMX_PCM_DMA
Date: Tue, 19 Aug 2014 09:00:06 +0000
Message-ID: <3a0c98ca698e4d38b3e92f339049b883@BN1PR0301MB0609.namprd03.prod.outlook.com>
References: <cover.1408350626.git.shengjiu.wang@freescale.com>
 <f30ba4e2c4eb6702fa40bd255036e6e9ad6eb47d.1408350626.git.shengjiu.wang@freescale.com>
 <53F22F5E.2090601@metafoo.de> <20140819074103.GA5806@audiosh1>
 <d7b06608abcc4f098789f63cb9f36eef@BN1PR0301MB0609.namprd03.prod.outlook.com>
 <20140819082108.GB5806@audiosh1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0142.outbound.protection.outlook.com [207.46.163.142])
 by alsa0.perex.cz (Postfix) with ESMTP id E99CE2655F6
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 11:00:09 +0200 (CEST)
In-Reply-To: <20140819082108.GB5806@audiosh1>
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
To: "shengjiu.wang@freescale.com" <shengjiu.wang@freescale.com>
Cc: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, "timur@tabi.org" <timur@tabi.org>, "arnd@arndb.de" <arnd@arndb.de>, "shc_work@mail.ru" <shc_work@mail.ru>, "tiwai@suse.de" <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "xobs@kosagi.com" <xobs@kosagi.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

How about the following :


diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 5ae777a..d42f18c 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -15,7 +15,7 @@ config SND_SOC_FSL_ASRC
 config SND_SOC_FSL_SAI
        tristate "Synchronous Audio Interface (SAI) module support"
        select REGMAP_MMIO
-       select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
+       select SND_SOC_IMX_PCM_DMA
        select SND_SOC_GENERIC_DMAENGINE_PCM
        help
          Say Y if you want to add Synchronous Audio Interface (SAI)
@@ -25,7 +25,7 @@ config SND_SOC_FSL_SAI

 config SND_SOC_FSL_SSI
        tristate "Synchronous Serial Interface module support"
-       select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
+       select SND_SOC_IMX_PCM_DMA
        select SND_SOC_IMX_PCM_FIQ if SND_IMX_SOC != n && (MXC_TZIC || MXC_AVIC)
        select REGMAP_MMIO
        help
@@ -37,7 +37,7 @@ config SND_SOC_FSL_SSI
 config SND_SOC_FSL_SPDIF
        tristate "Sony/Philips Digital Interface module support"
        select REGMAP_MMIO
-       select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
+       select SND_SOC_IMX_PCM_DMA
        select SND_SOC_IMX_PCM_FIQ if SND_IMX_SOC != n && (MXC_TZIC || MXC_AVIC)
        help
          Say Y if you want to add Sony/Philips Digital Interface (SPDIF)
@@ -48,7 +48,7 @@ config SND_SOC_FSL_SPDIF
 config SND_SOC_FSL_ESAI
        tristate "Enhanced Serial Audio Interface (ESAI) module support"
        select REGMAP_MMIO
-       select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
+       select SND_SOC_IMX_PCM_DMA
        help
          Say Y if you want to add Enhanced Synchronous Audio Interface
          (ESAI) support for the Freescale CPUs.
@@ -76,6 +76,7 @@ config SND_SOC_FSL_ASOC_CARD

 config SND_SOC_IMX_PCM_DMA
        tristate
+       depends on SND_IMX_SOC
        select SND_SOC_GENERIC_DMAENGINE_PCM

 config SND_SOC_IMX_AUDMUX

Thanks,


BRs
Xiubo



> -----Original Message-----
> From: Shengjiu Wang [mailto:shengjiu.wang@freescale.com]
> Sent: Tuesday, August 19, 2014 4:21 PM
> To: Xiubo Li-B47053
> Cc: Lars-Peter Clausen; lgirdwood@gmail.com; broonie@kernel.org;
> perex@perex.cz; tiwai@suse.de; nicoleotsuka@gmail.com; shc_work@mail.ru;
> Estevam Fabio-R49496; xobs@kosagi.com; arnd@arndb.de; sfr@canb.auug.org.au;
> timur@tabi.org; alsa-devel@alsa-project.org; linuxppc-dev@lists.ozlabs.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [alsa-devel] [PATCH V1 1/3] ASoC: fsl: Kconfig: remove dependence
> of SND_IMX_SOC for SND_SOC_IMX_PCM_DMA
> 
> On Tue, Aug 19, 2014 at 04:13:15PM +0800, Xiubo Li-B47053 wrote:
> > > Subject: Re: [alsa-devel] [PATCH V1 1/3] ASoC: fsl: Kconfig: remove
> dependence
> > > of SND_IMX_SOC for SND_SOC_IMX_PCM_DMA
> > >
> > > On Mon, Aug 18, 2014 at 06:52:46PM +0200, Lars-Peter Clausen wrote:
> > > > On 08/18/2014 10:38 AM, Shengjiu Wang wrote:
> > > > >Build kernel with SND_SOC_IMC_PCM_DMA=m && SND_IMX_SOC=n leads the
> > > following
> > > > >error:
> > > > >
> > > > >    sound/built-in.o: In function `fsl_sai_probe':
> > > > >>>fsl_sai.c:(.text+0x5f662): undefined reference to `imx_pcm_dma_init'
> > > > >    sound/built-in.o: In function `fsl_esai_probe':
> > > > >>>fsl_esai.c:(.text+0x6044b): undefined reference to `imx_pcm_dma_init'
> > > > >
> > > > >Most cpu driver in soc/fsl has use the function 'imx_pcm_dma_init'
> which is
> > > > >defined in imx-pcm-dma.c, so need to select SND_SOC_IMX_PCM_DMA, but it
> > > depends
> > > > >on SND_IMX_SOC, if SND_IMX_SOC=n, then SND_SOC_IMX_PCM_DMA will not be
> > > > >selected.
> > > > >So remove the dependence of SND_IMX_SOC for SND_SOC_IMX_PCM_DMA.
> > > > >
> > > > >Reported-by: kbuild test robot <fengguang.wu@intel.com>
> > > > >Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
> > > >
> > > > Those if conditions where just added[1] by Arnd to avoid other build
> > > > failures. So just removing them again makes little sense.
> > > >
> > > > As far as I can see imx_pcm_dma_init() should be stubbed out when
> > > > SND_SOC_IMX_PCM_DMA is not selected. So what's going on here?
> > > >
> > > > [1]
> > >
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=ff40
> > > 260f79dc0436604452bccd449bffd25ebafb
> > > >
> > > Lars-Peter Clausen & Arnd
> > >
> > > The purpose of Arnd's patch is same with me, which is to resolve the build
> > > error when SND_SOC_IMX_PCM_DMA=m & SND_SOC_FSL_SSI/SAI/ESAI/SPDIF=y, the
> > > error is "undefined reference to `imx_pcm_dma_init'".
> > > But Arnd's patch didn't involve this situation that SND_IMX_SOC=n &
> > > SND_SOC_IMX_PCM_DMA=m.
> > >
> > > Currently I think out a solution for this issue is to change
> > >
> > > select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
> > >
> > > to
> > >
> > > depends on SND_SOC_IMX_PCM_DMA != m
> > >
> > > How do you think about this?
> > >
> >
> > What will happen if to build both SAI/ESAI and IMX_PCM_DMA as modules at the
> same
> > time ?
> >
> > Thanks,
> >
> > BRs
> > Xiubo
> 
> I didn't find error/warning when SAI/ESAI and IMX_PCM_DMA are as modules. The
> build is successful.
> 
> >
> >
> > > best regards
> > > Wang shengjiu
