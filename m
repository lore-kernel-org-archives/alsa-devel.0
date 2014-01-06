From: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Subject: Re:
 =?utf-8?q?=5BPATCH=5D_ASoC=3A_imx=3A_Allow_using_sou?=
 =?utf-8?q?nd_with_DT_descriptions_only?=
Date: Mon, 06 Jan 2014 17:25:39 +0400
Message-ID: <1389014739.377805031@f170.i.mail.ru>
References: <1388903726-2053-1-git-send-email-shc_work@mail.ru>
 <20140106131650.GS31886@sirena.org.uk>
Reply-To: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from f170.i.mail.ru (f170.i.mail.ru [94.100.178.89])
 by alsa0.perex.cz (Postfix) with ESMTP id 778E3261A98
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 14:25:42 +0100 (CET)
In-Reply-To: <20140106131650.GS31886@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?TWFyayBCcm93bg==?= <broonie@kernel.org>
Cc: =?UTF-8?B?RmFiaW8gRXN0ZXZhbQ==?= <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, =?UTF-8?B?VGFrYXNoaSBJd2Fp?= <tiwai@suse.de>, =?UTF-8?B?Tmljb2xpbiBDaGVu?= <b42378@freescale.com>, =?UTF-8?B?TGlhbSBHaXJkd29vZA==?= <lgirdwood@gmail.com>, =?UTF-8?B?U2hhd24gR3Vv?= <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hello.

> > +config SND_SOC_IMX_DT
> > +	tristate "SoC Audio support for i.MX DT boards"
> > +	depends on OF
> > +	select SND_SOC_FSL_SSI
> > +	select SND_SOC_IMX_AUDMUX
> > +	select SND_SOC_IMX_PCM_DMA
> > +	help
> > +	  Say Y if you want to add support for SoC audio on an i.MX boards
> > +	  described in devicetree.
> > +
> 
> Rather than adding a separate Kconfig option it seems better to just
> move these to being selected by SND_IMX_SOC and delete all the extra
> selects from the individual machine drivers - I don't think it's worth
> worrying about building the extra driver for S/PDIF only systems and
> it's easier for users to work out what they need to set.

OK, probably this will be better.
Thanks.

---
