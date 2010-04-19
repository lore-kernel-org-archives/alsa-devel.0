From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: ASoC - Support for multiple components
Date: Mon, 19 Apr 2010 18:23:03 +0100
Message-ID: <1271697783.3208.438.camel@odin>
References: <1271686144.3208.305.camel@odin>
	<p2nfa686aa41004190815i38a4e670v34df390ef877973c@mail.gmail.com>
	<1271694314.3208.426.camel@odin>
	<20100419171418.GD29819@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F55B247F5
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Apr 2010 19:23:31 +0200 (CEST)
Received: by wwb22 with SMTP id 22so243400wwb.38
	for <alsa-devel@alsa-project.org>; Mon, 19 Apr 2010 10:23:30 -0700 (PDT)
In-Reply-To: <20100419171418.GD29819@opensource.wolfsonmicro.com>
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
Cc: vbarinov <vbarinov@embeddedalley.com>, alsa-devel <alsa-devel@alsa-project.org>, Joonyoung Shim <jy0922.shim@samsung.com>, Timur Tabi <timur@freescale.com>, mano@roarinelk.homelinux.net, "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, dg@emlix.com, Grant Likely <grant.likely@secretlab.ca>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, Cliff Cai <cliff.cai@analog.com>, ben-linux <ben-linux@fluff.org>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, "kyungmin.park" <kyungmin.park@samsung.com>, Sascha Hauer <s.hauer@pengutronix.de>, anemo@mba.ocn.ne.jp
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-04-20 at 02:14 +0900, Mark Brown wrote:
> On Mon, Apr 19, 2010 at 05:25:14PM +0100, Liam Girdwood wrote:

> 
> > ASoC doesn't fully use the driver model for components in this changeset
> > (or at all) due to the complex relationships between the individual
> > components for probing() and for control of PM operations (i.e. we cant
> > have pops and clicks at suspend). 
> 
> > This is not to say ASoC wont use the full driver model for components in
> > the future. This work is an important step on the way to achieving this
> > aim. 
> 
> The ordering requirements here mean this is a *very* open question.
> Linus just nacked a bunch of stuff for 2.6.34 which would have added
> some ability to waiting for components to probe stuff that things like
> ASoC would need to use the driver core fully.  At the minute subsystems
> like ASoC which are built up of components that don't have much to do
> with each other have to do something like ASoC is doing and waiting for
> all the components to come online before bringing the subsystem level
> devices up.

Heh - I wasn't volunteering to make the changes in driver core to
support this myself, but was planning to wait for someone else to do
something acceptable for Linus here ;)

Liam
