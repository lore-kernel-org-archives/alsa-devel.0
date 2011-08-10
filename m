From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: snd soc spi read/write
Date: Thu, 11 Aug 2011 00:34:58 +0900
Message-ID: <20110810153457.GG5724@opensource.wolfsonmicro.com>
References: <20110805072908.GA28149@opensource.wolfsonmicro.com>
	<CAHG8p1BSW1_enLqJL4fxxHvTd3MdwmS+Av+zy4i23BH+TuhJqw@mail.gmail.com>
	<20110805083058.GB4977@opensource.wolfsonmicro.com>
	<CAHG8p1AG2mteW0Bw6ScHCsM5okLr7Vd7Hqy=T8zz+C746qpn+g@mail.gmail.com>
	<20110809160447.GM15861@opensource.wolfsonmicro.com>
	<s5hwrela3d8.wl%tiwai@suse.de>
	<20110810145549.GA5724@opensource.wolfsonmicro.com>
	<s5hk4al9uql.wl%tiwai@suse.de>
	<20110810150316.GF5724@opensource.wolfsonmicro.com>
	<s5hhb5p9u2e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6608910381D
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Aug 2011 17:35:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hhb5p9u2e.wl%tiwai@suse.de>
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

On Wed, Aug 10, 2011 at 05:15:21PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > The idea is that the CODEC drivers will end up using regmap directly
> > once it gets cache support migrated over to it.  There's nothing ALSA
> > specific about the cache support.  Though right just not bothering to
> > cache this device (it has readback support after all) is probably good
> > enough.

> OK, I like the idea, but it sounds a bit like a long way to go.
> I guess the cache-in-regmap won't be merged in 3.1 cycle?

Well, regmap is only in 3.2.

> Basically I don't care too much about this, but the fact we leave this
> being broken over two release cycles doesn't appear nice, especially
> when there is a quick-n-easy fix...

I don't see a problem with the idea of just making the registers
volatile.  There's no real need to cache the registers on a small SPI
device with readback support, the caches mainly benefit I2C (which is
much slower) and devices with no readback support with some other
benefits for larger devices.

That ought to work for all versions of the framework and keeps the
driver looking like a standard driver.  There's existing stuff with the
driver doing non-standard things like the fixed default setup which have
been around for quite some time and I'd rather reduce that sort of
stuff.
