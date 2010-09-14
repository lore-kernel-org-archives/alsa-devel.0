From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: tlv320aic3x: Complete the
 soc-cache conversion
Date: Tue, 14 Sep 2010 15:45:25 +0300
Message-ID: <20100914154525.77e86440.jhnikula@gmail.com>
References: <1284465289-4865-1-git-send-email-jhnikula@gmail.com>
	<1284465289-4865-3-git-send-email-jhnikula@gmail.com>
	<20100914120458.GE27029@rakim.wolfsonmicro.main>
	<20100914151445.2fe7fd54.jhnikula@gmail.com>
	<20100914122139.GF27029@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E53BC103881
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Sep 2010 14:45:29 +0200 (CEST)
Received: by eye27 with SMTP id 27so2026448eye.38
	for <alsa-devel@alsa-project.org>; Tue, 14 Sep 2010 05:45:29 -0700 (PDT)
In-Reply-To: <20100914122139.GF27029@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 14 Sep 2010 13:21:39 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Tue, Sep 14, 2010 at 03:14:45PM +0300, Jarkko Nikula wrote:
> > Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> 
> > > It'd be a bit nicer to do this by using snd_soc_read() here also and
> > > marking the registers as volatile.  This makes the process much less
> > > error prone since users can just use snd_soc_read() and the register
> > > cache code will work out if it needs to go to the chip or not.
> 
> > Actually I looked that but problem with aic3x is that most of the
> > volatile bits are with r/w configuration bits in the same registers.
> > There are a few completely volatile read-only registers but currently
> > there is no use for them.
> 
> Oh, so you would essentially kill the cache?  Sad.  It'd be nice to put
> comments somewhere in the driver noting this to discourage people doing
> the change.

Well cache is then out of sync with regarding of those gpio & headset
detect bits here but there wasn't use for them elsewhere so at the
moment it looks like null-op to write value to cache.

But is it marking register as volatile due 1-2 bits causing more
problems if we don't cache rest of the r/w bits?


-- 
Jarkko
