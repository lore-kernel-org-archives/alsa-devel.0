From: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Subject: Re:
 =?utf-8?q?=5BPATCH=5D_ASoC=3A_imx=3A_Allow_using_sou?=
 =?utf-8?q?nd_with_DT_descriptions_only?=
Date: Mon, 06 Jan 2014 11:06:17 +0400
Message-ID: <1388991977.423552795@f73.i.mail.ru>
References: <1388903726-2053-1-git-send-email-shc_work@mail.ru>
 <20140106070028.GF26128@S2101-09.ap.freescale.net>
Reply-To: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from f73.i.mail.ru (f73.i.mail.ru [94.100.178.234])
 by alsa0.perex.cz (Postfix) with ESMTP id 49782261600
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 08:06:20 +0100 (CET)
In-Reply-To: <20140106070028.GF26128@S2101-09.ap.freescale.net>
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
Cc: =?UTF-8?B?RmFiaW8gRXN0ZXZhbQ==?= <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, =?UTF-8?B?VGFrYXNoaSBJd2Fp?= <tiwai@suse.de>, =?UTF-8?B?Tmljb2xpbiBDaGVu?= <b42378@freescale.com>, =?UTF-8?B?TGlhbSBHaXJkd29vZA==?= <lgirdwood@gmail.com>, =?UTF-8?B?TWFyayBCcm93bg==?= <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hello.

> > This patch adds new Kconfig symbol to allow using generic sound
> > cards/codecs based on DT description.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  sound/soc/fsl/Kconfig | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> > index bb4ab96..51fabc6 100644
> > --- a/sound/soc/fsl/Kconfig
> > +++ b/sound/soc/fsl/Kconfig
> > @@ -126,6 +126,16 @@ config SND_SOC_IMX_PCM_DMA
> >  config SND_SOC_IMX_AUDMUX
> >  	tristate
> >  
> > +config SND_SOC_IMX_DT
> > +	tristate "SoC Audio support for i.MX DT boards"
> 
> "i.MX ASoC generic sound card support" would be better?
> 
> > +	depends on OF
> 
> It seems to me that we should depend on SND_SIMPLE_CARD and add OF
> dependency for SND_SIMPLE_CARD symbol?

SND_SIMPLE_CARD can be used with pdata.
For i.MX non-DT boards the imx-ssi driver is used, but for OF - fsl-ssi only,
so I think OF dependency should be still here.
Thanks.

---
