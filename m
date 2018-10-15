From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH] ASoC: sun4i-i2s: don't try to start up or
 shut down DAI if it's active
Date: Mon, 15 Oct 2018 10:11:51 +0200
Message-ID: <20181015081151.rrn5xmso2hgckvh6@flea>
References: <20181012153254.10844-1-anarsoul@gmail.com>
 <20181012160905.GA2340@sirena.org.uk>
 <7437935.iAfLsdZGOz@anarsoul-thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id E96502677CE
 for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2018 10:11:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7437935.iAfLsdZGOz@anarsoul-thinkpad>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Yong Deng <yong.deng@magewell.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 12, 2018 at 09:28:56AM -0700, Vasily Khoruzhick wrote:
> On Friday, October 12, 2018 9:09:05 AM PDT Mark Brown wrote:
> > On Fri, Oct 12, 2018 at 08:32:54AM -0700, Vasily Khoruzhick wrote:
> > > Otherwise we may end up with shutting down I2S if shutdown() was
> > > called for capture substream, but playback is still running.
> > 
> > Would it be cleaner and more robust to use runtime PM?  I'm wondering
> > what happens if some of the configuration stuff turns out to also need
> > some of the clocks for example.
> 
> I guess. I'm not sure why this code was put into startup and shutdown 
> callbacks in first place.
> 
> Maybe Marcus or Maxime know?

I can't really come up with a good explanation, so I guess there's
none :)

> As for configuration - only bus clock is necessary for configuration
> and it's already enabled in runtime_resume() callback.

Not really. Or at least, on the A64, yes, but shutting down the bus
clock on older SoCs will reset the controller. I'd just put the enable
bit on the runtime_pm hook.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
