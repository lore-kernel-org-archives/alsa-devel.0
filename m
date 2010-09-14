From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: tlv320aic3x: Complete the
 soc-cache conversion
Date: Tue, 14 Sep 2010 13:21:39 +0100
Message-ID: <20100914122139.GF27029@rakim.wolfsonmicro.main>
References: <1284465289-4865-1-git-send-email-jhnikula@gmail.com>
	<1284465289-4865-3-git-send-email-jhnikula@gmail.com>
	<20100914120458.GE27029@rakim.wolfsonmicro.main>
	<20100914151445.2fe7fd54.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AF303103895
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Sep 2010 14:21:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100914151445.2fe7fd54.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 14, 2010 at 03:14:45PM +0300, Jarkko Nikula wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > It'd be a bit nicer to do this by using snd_soc_read() here also and
> > marking the registers as volatile.  This makes the process much less
> > error prone since users can just use snd_soc_read() and the register
> > cache code will work out if it needs to go to the chip or not.

> Actually I looked that but problem with aic3x is that most of the
> volatile bits are with r/w configuration bits in the same registers.
> There are a few completely volatile read-only registers but currently
> there is no use for them.

Oh, so you would essentially kill the cache?  Sad.  It'd be nice to put
comments somewhere in the driver noting this to discourage people doing
the change.
