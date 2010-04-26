From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC - Support for multiple components
Date: Mon, 26 Apr 2010 11:49:39 +0100
Message-ID: <20100426104939.GC2035@sirena.org.uk>
References: <1271686144.3208.305.camel@odin>
	<201004201017.47719.peter.ujfalusi@nokia.com>
	<1271760367.3234.159.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A0DA1037F5
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Apr 2010 12:49:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1271760367.3234.159.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: vbarinov <vbarinov@embeddedalley.com>, Cliff Cai <cliff.cai@analog.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Timur Tabi <timur@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, "Candelaria Villareal,
	Jorge" <jorge.candelaria@ti.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, alsa-devel@alsa-project.org, Haojian Zhuang <haojian.zhuang@gmail.com>, "dg@emlix.com" <dg@emlix.com>, Grant Likely <grant.likely@secretlab.ca>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "kyungmin.park" <kyungmin.park@samsung.com>, ben-linux <ben-linux@fluff.org>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, "mano@roarinelk.homelinux.net" <mano@roarinelk.homelinux.net>, "anemo@mba.ocn.ne.jp" <anemo@mba.ocn.ne.jp>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 20, 2010 at 11:46:07AM +0100, Liam Girdwood wrote:
> On Tue, 2010-04-20 at 10:17 +0300, Peter Ujfalusi wrote:

> > How the user will see these in one card?

> A subsequent patch will add an ID qualifier to kcontrol names and DAPM
> widget names. So we can have things like "Master Playback Volume.0" and
> "Master Playback Volume.1" to differentiate the two separate controls. 

It occurs to me that we probably want something a bit more flexible
here than just a numeric ID - most of the use cases for having more than
one of the same device are for things like 5.1 or dual speaker amps for
stereo where it'd be much more convenient to have the machine driver be
able to add text based prefixes to the control names (eg, "Left" and
"Right").
