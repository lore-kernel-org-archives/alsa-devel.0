From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: ASoC - Support for multiple components
Date: Tue, 20 Apr 2010 11:46:07 +0100
Message-ID: <1271760367.3234.159.camel@odin>
References: <1271686144.3208.305.camel@odin>
	<201004201017.47719.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 793352414C
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Apr 2010 12:46:14 +0200 (CEST)
Received: by wwb22 with SMTP id 22so660408wwb.38
	for <alsa-devel@alsa-project.org>; Tue, 20 Apr 2010 03:46:11 -0700 (PDT)
In-Reply-To: <201004201017.47719.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: vbarinov <vbarinov@embeddedalley.com>, alsa-devel@alsa-project.org, Joonyoung Shim <jy0922.shim@samsung.com>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Cliff Cai <cliff.cai@analog.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, "dg@emlix.com" <dg@emlix.com>, Grant Likely <grant.likely@secretlab.ca>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "kyungmin.park" <kyungmin.park@samsung.com>, "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>, ben-linux <ben-linux@fluff.org>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, "mano@roarinelk.homelinux.net" <mano@roarinelk.homelinux.net>, Timur Tabi <timur@freescale.com>, "anemo@mba.ocn.ne.jp" <anemo@mba.ocn.ne.jp>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-04-20 at 10:17 +0300, Peter Ujfalusi wrote:

> 
> > 
> > I've CC'ed folks on this mail who have either contributed or maintain
> > ASoC architecture code. Please have a look at your architecture and test
> > if you can. I only have access to OMAP and pxa3xx hardware and as such
> > have only tested the changes on these two architectures only. I'd
> > appreciated anyone else testing on the other architectures too.
> 
> Just a side note: you missed the OMAP PCM/McBSP folks from the CC: Jarkko, and 
> me ;) I'll add Jarkko to the cc...

Oops, sorry about that.

> 
> > The changes are all purely mechanical to component registration and
> > component private data only. However, some architectures (txx9, imx,
> > s3c) required some extra effort to use the device model as they had (to
> > varying degrees) coupled their DMA and DAI code more tightly. The fsl
> > platform also required extra work around the open firmware interface.
> > Grant/Timur do we still need soc-of-simple now that all components are
> > regular devices ?
> 
> I have one question:
> How the overlapping kcontrol names are going to handled (plain kcontrol and DAPM 
> widget names)?
> What will happen if let say you have wm8711 _and_ wm8731 in the same card?
> Both have:
> "Master Playback Volume", "Master Playback ZC Switch" in snd_kcontrol_new, and 
> also LOUT, ROUT, LHPOUT, RHPOUT, and SND_SOC_DAPM_MIXER("Output Mixer",..) in 
> snd_soc_dapm_widget.
> 
> How the user will see these in one card?

A subsequent patch will add an ID qualifier to kcontrol names and DAPM
widget names. So we can have things like "Master Playback Volume.0" and
"Master Playback Volume.1" to differentiate the two separate controls. 

Liam


-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
