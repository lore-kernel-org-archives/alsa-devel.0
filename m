From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC - Support for multiple components
Date: Tue, 20 Apr 2010 02:03:38 +0900
Message-ID: <20100419170337.GC29819@opensource.wolfsonmicro.com>
References: <1271686144.3208.305.camel@odin>
	<p2nfa686aa41004190815i38a4e670v34df390ef877973c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 28ED6247BE
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Apr 2010 19:03:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <p2nfa686aa41004190815i38a4e670v34df390ef877973c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: vbarinov <vbarinov@embeddedalley.com>, alsa-devel <alsa-devel@alsa-project.org>, Sascha Hauer <s.hauer@pengutronix.de>, Joonyoung Shim <jy0922.shim@samsung.com>, mano@roarinelk.homelinux.net, "Candelaria Villareal,
	Jorge" <jorge.candelaria@ti.com>, Cliff Cai <cliff.cai@analog.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, dg@emlix.com, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "kyungmin.park" <kyungmin.park@samsung.com>, ben-linux <ben-linux@fluff.org>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Timur Tabi <timur@freescale.com>, anemo@mba.ocn.ne.jp, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 19, 2010 at 09:15:49AM -0600, Grant Likely wrote:

> This is definitely a step in the right direction.  All of the OF ASoC
> stuff is definitely a hack to work around the lack of separate devices
> & drivers in the ASoC subsystem.  I'll take a look through, but some

Note that as I've mentioned to you before it's been possible to do
device model registration of ASoC drivers for about a year now - Timur's
drivers show an example of doing that with OpenFirmware.  The changes
Liam has done are more working towards taking advantage of this to add
new features.
