From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 0/53] ASoC: switch over to use
	snd_soc_register_component()
Date: Mon, 18 Mar 2013 16:44:23 +0100
Message-ID: <51473657.5000104@metafoo.de>
References: <87txo96xiu.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-073.synserver.de (smtp-out-073.synserver.de
 [212.40.185.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 32DA026535F
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2013 16:42:22 +0100 (CET)
In-Reply-To: <87txo96xiu.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Stephen Warren <swarren@wwwdotorg.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Simon <horms@verge.net.au>, Liam Girdwood <liam.r.girdwood@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


On 03/18/2013 07:18 AM, Kuninori Morimoto wrote:
> 
> Hi Mark, Liam, Lars, Stephen
> 
> These patches switch over to use snd_soc_register_component()
> instead of snd_soc_register_dai[s]() on all drivers
> Last patch moves snd_soc_[un]register_dai[s]() to non global function.
> 
> I could compile test on some of them, but couldn't for all drivers
> 
> These patches are based on asoc/topic/component branch
>

Hi,

quite a few drivers use snd_soc_register_dai(), while
snd_soc_register_component() uses snd_soc_register_dais().
snd_soc_register_dai() uses fmt_single_name(), while snd_soc_register_dais()
uses fmt_multiple_name() to create the name for the device. So for all
drivers using snd_soc_register_dai() the name of the DAI is different now,
which will break the name based matching of the dai link.

- Lars


> Kuninori Morimoto (53):
>       ASoC: switch over to use snd_soc_register_component() on atmel ssc
>       ASoC: switch over to use snd_soc_register_component() on au1x i2sc
>       ASoC: switch over to use snd_soc_register_component() on au1x psc-ac97
>       ASoC: switch over to use snd_soc_register_component() on au1x psc-i2s
>       ASoC: switch over to use snd_soc_register_component() on au1x ac97c
>       ASoC: switch over to use snd_soc_register_component() on bf6xx i2s
>       ASoC: switch over to use snd_soc_register_component() on bf5xx ac97
>       ASoC: switch over to use snd_soc_register_component() on bf5xx i2s
>       ASoC: switch over to use snd_soc_register_component() on bf5xx tdm
>       ASoC: switch over to use snd_soc_register_component() on ep93xx ac97
>       ASoC: switch over to use snd_soc_register_component() on ep93xx i2s
>       ASoC: switch over to use snd_soc_register_component() on davinci i2s
>       ASoC: switch over to use snd_soc_register_component() on davinci vcif
>       ASoC: switch over to use snd_soc_register_component() on davinci mcasp
>       ASoC: switch over to use snd_soc_register_component() on dw i2s
>       ASoC: switch over to use snd_soc_register_component() on mpc5200 ac97
>       ASoC: switch over to use snd_soc_register_component() on mpc5200 i2s
>       ASoC: switch over to use snd_soc_register_component() on fsl ssi
>       ASoC: switch over to use snd_soc_register_component() on imx ssi
>       ASoC: switch over to use snd_soc_register_component() on jz4740 i2s
>       ASoC: switch over to use snd_soc_register_component() on kirkwood i2s
>       ASoC: switch over to use snd_soc_register_component() on sst
>       ASoC: switch over to use snd_soc_register_component() on mxs saif
>       ASoC: switch over to use snd_soc_register_component() on nuc900 ac97
>       ASoC: switch over to use snd_soc_register_component() on omap mcbsp
>       ASoC: switch over to use snd_soc_register_component() on omap mcpdm
>       ASoC: switch over to use snd_soc_register_component() on omap dmic
>       ASoC: switch over to use snd_soc_register_component() on omap hdmi
>       ASoC: switch over to use snd_soc_register_component() on pxa ssp
>       ASoC: pxa2xx-ac97: move EXPORT_SYMBOL_GPL() next to definition
>       ASoC: switch over to use snd_soc_register_component() on pxa2xx ac97
>       ASoC: switch over to use snd_soc_register_component() on pxa2xx i2s
>       ASoC: switch over to use snd_soc_register_component() on mmp sspa
>       ASoC: switch over to use snd_soc_register_component() on s6000 i2s
>       ASoC: switch over to use snd_soc_register_component() on s3c24xx i2s
>       ASoC: switch over to use snd_soc_register_component() on s3c i2s
>       ASoC: switch over to use snd_soc_register_component() on s3c ac97
>       ASoC: switch over to use snd_soc_register_component() on samsung spdif
>       ASoC: switch over to use snd_soc_register_component() on samsung i2s
>       ASoC: switch over to use snd_soc_register_component() on samsung pcm
>       ASoC: switch over to use snd_soc_register_component() on goni_wm8994
>       ASoC: switch over to use snd_soc_register_component() on sh4 ssi
>       ASoC: switch over to use snd_soc_register_component() on sh4 siu
>       ASoC: switch over to use snd_soc_register_component() on sh4 hac
>       ASoC: switch over to use snd_soc_register_component() on spear spdif out
>       ASoC: switch over to use snd_soc_register_component() on spear spdif in
>       ASoC: switch over to use snd_soc_register_component() on tegra30 i2s
>       ASoC: switch over to use snd_soc_register_component() on tegra20 spdif
>       ASoC: switch over to use snd_soc_register_component() on tegra20 ac97
>       ASoC: switch over to use snd_soc_register_component() on tegra20 i2s
>       ASoC: switch over to use snd_soc_register_component() on txx9aclc ac97
>       ASoC: switch over to use snd_soc_register_component() on ux500 msp
>       ASoC: snd_soc_[un]register_dai[s]() become non global function
> 
>  include/sound/soc-dai.h           |    8 --------
>  sound/soc/atmel/atmel_ssc_dai.c   |   11 ++++++++---
>  sound/soc/au1x/ac97c.c            |    9 +++++++--
>  sound/soc/au1x/i2sc.c             |    9 +++++++--
>  sound/soc/au1x/psc-ac97.c         |    9 +++++++--
>  sound/soc/au1x/psc-i2s.c          |    9 +++++++--
>  sound/soc/blackfin/bf5xx-ac97.c   |    9 +++++++--
>  sound/soc/blackfin/bf5xx-i2s.c    |    9 +++++++--
>  sound/soc/blackfin/bf5xx-tdm.c    |    9 +++++++--
>  sound/soc/blackfin/bf6xx-i2s.c    |    9 +++++++--
>  sound/soc/cirrus/ep93xx-ac97.c    |    9 +++++++--
>  sound/soc/cirrus/ep93xx-i2s.c     |    9 +++++++--
>  sound/soc/davinci/davinci-i2s.c   |   15 ++++++++++-----
>  sound/soc/davinci/davinci-mcasp.c |   15 ++++++++++-----
>  sound/soc/davinci/davinci-vcif.c  |   11 ++++++++---
>  sound/soc/dwc/designware_i2s.c    |    9 +++++++--
>  sound/soc/fsl/fsl_ssi.c           |   11 ++++++++---
>  sound/soc/fsl/imx-ssi.c           |   11 ++++++++---
>  sound/soc/fsl/mpc5200_psc_ac97.c  |    8 ++++++--
>  sound/soc/fsl/mpc5200_psc_i2s.c   |    9 +++++++--
>  sound/soc/jz4740/jz4740-i2s.c     |    9 +++++++--
>  sound/soc/kirkwood/kirkwood-i2s.c |   11 ++++++++---
>  sound/soc/mid-x86/sst_platform.c  |    8 ++++++--
>  sound/soc/mxs/mxs-saif.c          |   11 ++++++++---
>  sound/soc/nuc900/nuc900-ac97.c    |    9 +++++++--
>  sound/soc/omap/omap-dmic.c        |    9 +++++++--
>  sound/soc/omap/omap-hdmi.c        |    9 +++++++--
>  sound/soc/omap/omap-mcbsp.c       |    9 +++++++--
>  sound/soc/omap/omap-mcpdm.c       |    9 +++++++--
>  sound/soc/pxa/mmp-sspa.c          |    9 +++++++--
>  sound/soc/pxa/pxa-ssp.c           |    9 +++++++--
>  sound/soc/pxa/pxa2xx-ac97.c       |   11 +++++++----
>  sound/soc/pxa/pxa2xx-i2s.c        |    9 +++++++--
>  sound/soc/s6000/s6000-i2s.c       |    9 +++++++--
>  sound/soc/samsung/ac97.c          |   12 ++++++++----
>  sound/soc/samsung/goni_wm8994.c   |   11 ++++++++---
>  sound/soc/samsung/i2s.c           |   14 ++++++++++----
>  sound/soc/samsung/pcm.c           |   11 ++++++++---
>  sound/soc/samsung/s3c-i2s-v2.c    |    9 +++++----
>  sound/soc/samsung/s3c-i2s-v2.h    |    7 ++++---
>  sound/soc/samsung/s3c2412-i2s.c   |   12 +++++++++---
>  sound/soc/samsung/s3c24xx-i2s.c   |   11 ++++++++---
>  sound/soc/samsung/spdif.c         |   11 ++++++++---
>  sound/soc/sh/hac.c                |   10 +++++++---
>  sound/soc/sh/siu_dai.c            |   11 ++++++++---
>  sound/soc/sh/ssi.c                |   10 +++++++---
>  sound/soc/soc-core.c              |   12 ++++--------
>  sound/soc/spear/spdif_in.c        |    9 +++++++--
>  sound/soc/spear/spdif_out.c       |    9 +++++++--
>  sound/soc/tegra/tegra20_ac97.c    |   15 ++++++++++-----
>  sound/soc/tegra/tegra20_i2s.c     |   15 ++++++++++-----
>  sound/soc/tegra/tegra20_spdif.c   |   15 ++++++++++-----
>  sound/soc/tegra/tegra30_i2s.c     |   15 ++++++++++-----
>  sound/soc/txx9/txx9aclc-ac97.c    |    9 +++++++--
>  sound/soc/ux500/ux500_msp_dai.c   |   13 +++++++++----
>  55 files changed, 405 insertions(+), 165 deletions(-)
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
