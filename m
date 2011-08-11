From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: snd soc spi read/write
Date: Thu, 11 Aug 2011 12:17:12 +0900
Message-ID: <20110811031711.GA15906@opensource.wolfsonmicro.com>
References: <20110805083058.GB4977@opensource.wolfsonmicro.com>
	<CAHG8p1AG2mteW0Bw6ScHCsM5okLr7Vd7Hqy=T8zz+C746qpn+g@mail.gmail.com>
	<20110809160447.GM15861@opensource.wolfsonmicro.com>
	<s5hwrela3d8.wl%tiwai@suse.de>
	<20110810145549.GA5724@opensource.wolfsonmicro.com>
	<s5hk4al9uql.wl%tiwai@suse.de>
	<20110810150316.GF5724@opensource.wolfsonmicro.com>
	<s5hhb5p9u2e.wl%tiwai@suse.de>
	<20110810153457.GG5724@opensource.wolfsonmicro.com>
	<s5hei0t9rvq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 22B5724333
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Aug 2011 05:17:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hei0t9rvq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Scott Jiang <scott.jiang.linux@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 10, 2011 at 06:02:33PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > > OK, I like the idea, but it sounds a bit like a long way to go.
> > > I guess the cache-in-regmap won't be merged in 3.1 cycle?

> > Well, regmap is only in 3.2.

> Oh, it's merged in 3.1 :)  Just unused by no one, yeah.

I meant regmap ASoC support.

> It'd be a quick fix that shall be removed in near future by regmap
> after all, so we don't need to waste time by discussing too much about
> it.

That's why I don't want to add stuff in the driver, I would like to
avoid adding more things in the driver that need removing because I
don't have confidence that we'll easily be able to back out the
workaround later on if the driver's not really being looked after.
