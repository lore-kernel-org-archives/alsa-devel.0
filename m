From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: ASoC - Support for multiple components
Date: Wed, 21 Apr 2010 08:18:46 +0100
Message-ID: <1271834326.3234.27.camel@odin>
References: <1271686144.3208.305.camel@odin>
	<201004201017.47719.peter.ujfalusi@nokia.com>
	<1271760367.3234.159.camel@odin>
	<201004210853.09498.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 68DB5103834
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 09:18:51 +0200 (CEST)
Received: by wwi14 with SMTP id 14so377705wwi.38
	for <alsa-devel@alsa-project.org>; Wed, 21 Apr 2010 00:18:51 -0700 (PDT)
In-Reply-To: <201004210853.09498.peter.ujfalusi@nokia.com>
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
Cc: vbarinov <vbarinov@embeddedalley.com>, Cliff Cai <cliff.cai@analog.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Timur Tabi <timur@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, "dg@emlix.com" <dg@emlix.com>, Grant Likely <grant.likely@secretlab.ca>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "kyungmin.park" <kyungmin.park@samsung.com>, "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>, ben-linux <ben-linux@fluff.org>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, "mano@roarinelk.homelinux.net" <mano@roarinelk.homelinux.net>, "anemo@mba.ocn.ne.jp" <anemo@mba.ocn.ne.jp>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-04-21 at 08:53 +0300, Peter Ujfalusi wrote:
> On Tuesday 20 April 2010 13:46:07 ext Liam Girdwood wrote:
> > > I have one question:
> > > How the overlapping kcontrol names are going to handled (plain kcontrol
> > > and DAPM widget names)?
> > > What will happen if let say you have wm8711 _and_ wm8731 in the same
> > > card? Both have:
> > > "Master Playback Volume", "Master Playback ZC Switch" in
> > > snd_kcontrol_new, and also LOUT, ROUT, LHPOUT, RHPOUT, and
> > > SND_SOC_DAPM_MIXER("Output Mixer",..) in snd_soc_dapm_widget.
> > > 
> > > How the user will see these in one card?
> > 
> > A subsequent patch will add an ID qualifier to kcontrol names and DAPM
> > widget names. So we can have things like "Master Playback Volume.0" and
> > "Master Playback Volume.1" to differentiate the two separate controls.
> 
> I see. How these IDs will be added?
> Will does are given by the core automatically based on device load order, or 
> will the machine driver have the ability to specify the ID for a codec?
> 

The machine driver will be able to specify the ID.

> Another question: how the PCM interfaces will be seen when we have multiple 
> codec/dai in a card?
> I suppose we will have multiple PCMs in a card, when we have multiple codec 
> (multiple dai pairs)..?

Yes, that's correct. We already support many cards with multiple PCMs
atm. e.g. some WM9713 based cards already support 3 PCMs - 1 HiFi, 1
voice and 1 System.

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
