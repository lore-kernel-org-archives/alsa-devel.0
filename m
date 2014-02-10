From: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Subject: Re:
 =?utf-8?q?=5BPATCH_2/2=5D_ASoC=3A_fsl=3A_Allow_to_se?=
 =?utf-8?q?lect_individual_common_options?=
Date: Mon, 10 Feb 2014 10:41:44 +0400
Message-ID: <1392014504.682792060@f144.i.mail.ru>
References: <1391621512-15064-1-git-send-email-shc_work@mail.ru>
 <1391621512-15064-2-git-send-email-shc_work@mail.ru>
 <20140210055943.GF9628@S2101-09.ap.freescale.net>
Reply-To: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from f144.i.mail.ru (f144.i.mail.ru [128.140.171.240])
 by alsa0.perex.cz (Postfix) with ESMTP id 9ACFD2610B7
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2014 07:41:45 +0100 (CET)
In-Reply-To: <20140210055943.GF9628@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?U2hhd24gR3Vv?= <shawn.guo@linaro.org>
Cc: =?UTF-8?B?RmFiaW8gRXN0ZXZhbQ==?= <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, =?UTF-8?B?VGFrYXNoaSBJd2Fp?= <tiwai@suse.de>, =?UTF-8?B?TGlhbSBHaXJkd29vZA==?= <lgirdwood@gmail.com>, =?UTF-8?B?TWFyayBCcm93bg==?= <broonie@kernel.org>, =?UTF-8?B?Tmljb2xpbiBDaGVu?= <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org

Hello.

> On Wed, Feb 05, 2014 at 09:31:52PM +0400, Alexander Shiyan wrote:
> > This patch allow to select individual common sound options and
> > as a result allow using sound cards/codecs based on DT description.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  sound/soc/fsl/Kconfig | 23 ++++++++++++++++++++---
> >  1 file changed, 20 insertions(+), 3 deletions(-)
> > 
> > diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> > index ecc1092..ed74c19 100644
> > --- a/sound/soc/fsl/Kconfig
> > +++ b/sound/soc/fsl/Kconfig
> > @@ -1,14 +1,26 @@
> >  menu "SoC Audio for Freescale CPUs"
> >  
> > +comment "Common SoC Audio options for Freescale CPUs:"
> > +
> >  config SND_SOC_FSL_SAI
> >  	tristate
> >  	select SND_SOC_GENERIC_DMAENGINE_PCM
> 
> Why do you skip SND_SOC_FSL_SAI and SND_SOC_FSL_ESAI for the change?

My comments here are the same as for the patch 1/2.

...
> >  config SND_SOC_FSL_ESAI
> >  	tristate
> > @@ -21,7 +33,12 @@ config SND_SOC_IMX_PCM_DMA
> >  	select SND_SOC_GENERIC_DMAENGINE_PCM
> 
> Doesn't the simple card driver need this to work on IMX?

Simple card driver does not work for i.MX at now due to some other issues
which should be resolved in separate patches for that driver.
Just one example:
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-January/070697.html

Thanks.
---
