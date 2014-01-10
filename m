From: Alexander Shiyan <shc_work@mail.ru>
Subject: Re: [PATCH v2] ASoC: imx: Allow using sound with DT
 descriptions only
Date: Fri, 10 Jan 2014 16:31:12 +0400
Message-ID: <20140110163112.db1e0db01924d32c7dc16273@mail.ru>
References: <1389170635-22301-1-git-send-email-shc_work@mail.ru>
 <20140110034501.GH21717@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp35.i.mail.ru (smtp35.i.mail.ru [94.100.177.95])
 by alsa0.perex.cz (Postfix) with ESMTP id C9BE0260309
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 13:31:20 +0100 (CET)
In-Reply-To: <20140110034501.GH21717@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 10 Jan 2014 11:45:04 +0800
Shawn Guo <shawn.guo@linaro.org> wrote:

> On Wed, Jan 08, 2014 at 12:43:55PM +0400, Alexander Shiyan wrote:
> > This patch allow using generic sound cards/codecs based on DT description.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  sound/soc/fsl/Kconfig   | 25 +++----------------------
> >  sound/soc/fsl/Makefile  |  5 ++---
> >  sound/soc/fsl/imx-pcm.h |  7 -------
> >  3 files changed, 5 insertions(+), 32 deletions(-)
> > 
> > diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> > index 1c7b3b7..cf0d5af 100644
> > --- a/sound/soc/fsl/Kconfig
> > +++ b/sound/soc/fsl/Kconfig
> > @@ -7,6 +7,7 @@ config SND_SOC_FSL_SSI
> >  
> >  config SND_SOC_FSL_SPDIF
> >  	tristate
> > +	select REGMAP_MMIO
> >  
> >  config SND_SOC_FSL_UTILS
> >  	tristate
> > @@ -106,6 +107,8 @@ endif # SND_POWERPC_SOC
> >  menuconfig SND_IMX_SOC
> >  	tristate "SoC Audio for Freescale i.MX CPUs"
> >  	depends on ARCH_MXC || COMPILE_TEST
> > +	select SND_SOC_FSL_SSI if OF
> > +	select SND_SOC_GENERIC_DMAENGINE_PCM
> 
> I'm seeing the following link error when I build a kernel with
> SND_IMX_SOC=y and SND_SOC_PHYCORE_AC97=m.
> 
> sound/built-in.o: In function `fsl_ssi_probe':
> last.c:(.text+0x292c0): undefined reference to `imx_pcm_fiq_init'

Oops. I'll fix this in v3.

-- 
Alexander Shiyan <shc_work@mail.ru>
