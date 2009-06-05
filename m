From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Palm interrupt driven touchscreen driver
Date: Fri, 5 Jun 2009 11:42:25 +0100
Message-ID: <20090605104225.GA29455@rakim.wolfsonmicro.main>
References: <20090604085407.GB6983@rakim.wolfsonmicro.main>
	<alpine.LNX.2.00.0906041104080.4067@eeebox2.perex-int.cz>
	<20090604093737.GF6983@rakim.wolfsonmicro.main>
	<s5hiqjcqqo9.wl%tiwai@suse.de>
	<20090604103807.GG6983@rakim.wolfsonmicro.main>
	<s5hy6s7yrab.wl%tiwai@suse.de>
	<20090605093001.GA21128@rakim.wolfsonmicro.main>
	<s5h63fb573c.wl%tiwai@suse.de>
	<20090605102036.GA2808@sirena.org.uk>
	<s5hzlcn3r02.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BFAF724675
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Jun 2009 12:42:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hzlcn3r02.wl%tiwai@suse.de>
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
Cc: Marek Vasut <marek.vasut@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 05, 2009 at 12:38:05PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > We'd need to add the void * to snd_ac97_template too so that the data is
> > initialised before snd_ac97_mixer() instantiates the device but that's
> > the only issue I can see.  If you're happy with that approach I can send
> > some patches for it?

> Just setting it after calling snd_ac97_mixer() doesn't suffice?
> It's always NULL as default.

Ah, should be - I'd misremembered how much snd_device_new() was doing
when looking at the snd_ac97_mixer() code.
