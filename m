From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH] ASoC: sun4i-i2s: don't try to start up or
	shut down DAI if it's active
Date: Fri, 12 Oct 2018 09:28:56 -0700
Message-ID: <7437935.iAfLsdZGOz@anarsoul-thinkpad>
References: <20181012153254.10844-1-anarsoul@gmail.com>
 <20181012160905.GA2340@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 89EE2267845
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2018 18:28:59 +0200 (CEST)
Received: by mail-pg1-f194.google.com with SMTP id f8-v6so6077629pgq.5
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2018 09:28:59 -0700 (PDT)
In-Reply-To: <20181012160905.GA2340@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Maxime Ripard <maxime.ripard@bootlin.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Yong Deng <yong.deng@magewell.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Friday, October 12, 2018 9:09:05 AM PDT Mark Brown wrote:
> On Fri, Oct 12, 2018 at 08:32:54AM -0700, Vasily Khoruzhick wrote:
> > Otherwise we may end up with shutting down I2S if shutdown() was
> > called for capture substream, but playback is still running.
> 
> Would it be cleaner and more robust to use runtime PM?  I'm wondering
> what happens if some of the configuration stuff turns out to also need
> some of the clocks for example.

I guess. I'm not sure why this code was put into startup and shutdown 
callbacks in first place.

Maybe Marcus or Maxime know?

As for configuration - only bus clock is necessary for configuration and it's 
already enabled in runtime_resume() callback.
