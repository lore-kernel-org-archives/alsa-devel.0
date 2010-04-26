From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: ASoC - Support for multiple components
Date: Mon, 26 Apr 2010 12:17:27 +0100
Message-ID: <1272280647.3208.6.camel@odin>
References: <1271686144.3208.305.camel@odin>
	<201004201017.47719.peter.ujfalusi@nokia.com>
	<1271760367.3234.159.camel@odin> <20100426104939.GC2035@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 060341037F5
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Apr 2010 13:17:32 +0200 (CEST)
Received: by wya21 with SMTP id 21so613260wya.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Apr 2010 04:17:32 -0700 (PDT)
In-Reply-To: <20100426104939.GC2035@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: vbarinov <vbarinov@embeddedalley.com>, Cliff Cai <cliff.cai@analog.com>, Joonyoung Shim <jy0922.shim@samsung.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "Candelaria Villareal,
	Jorge" <jorge.candelaria@ti.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, "dg@emlix.com" <dg@emlix.com>, Grant Likely <grant.likely@secretlab.ca>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "kyungmin.park" <kyungmin.park@samsung.com>, ben-linux <ben-linux@fluff.org>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, "mano@roarinelk.homelinux.net" <mano@roarinelk.homelinux.net>, Timur Tabi <timur@freescale.com>, "anemo@mba.ocn.ne.jp" <anemo@mba.ocn.ne.jp>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-04-26 at 11:49 +0100, Mark Brown wrote:
> On Tue, Apr 20, 2010 at 11:46:07AM +0100, Liam Girdwood wrote:
> > On Tue, 2010-04-20 at 10:17 +0300, Peter Ujfalusi wrote:
> 
> > > How the user will see these in one card?
> 
> > A subsequent patch will add an ID qualifier to kcontrol names and DAPM
> > widget names. So we can have things like "Master Playback Volume.0" and
> > "Master Playback Volume.1" to differentiate the two separate controls. 
> 
> It occurs to me that we probably want something a bit more flexible
> here than just a numeric ID - most of the use cases for having more than
> one of the same device are for things like 5.1 or dual speaker amps for
> stereo where it'd be much more convenient to have the machine driver be
> able to add text based prefixes to the control names (eg, "Left" and
> "Right").

So I think here we can have an optional 'identifier' that could be used
to describe the intended use case better (like the "Left" and "Right"
above). If the string ID is not supplied we can revert back to the
number or nothing at all i.e. if the system is a simple single codec
design.

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
