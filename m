From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: codecs: Remove unused mutex
Date: Sun, 4 Sep 2011 08:27:20 -0700
Message-ID: <20110904152718.GA21528@opensource.wolfsonmicro.com>
References: <1315140751.8673.1.camel@phoenix>
	<20110904141015.GB3668@opensource.wolfsonmicro.com>
	<CAF+7xWn=1M+iGuXVt6cA0j+b4wZNJh+iyE7ChTQf2xaKCqbaMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E958E244CF
	for <alsa-devel@alsa-project.org>;
	Sun,  4 Sep 2011 17:27:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAF+7xWn=1M+iGuXVt6cA0j+b4wZNJh+iyE7ChTQf2xaKCqbaMw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Arnaud Patard <arnaud.patard@rtp-net.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 04, 2011 at 10:48:09PM +0800, Axel Lin wrote:
> 2011/9/4 Mark Brown <broonie@opensource.wolfsonmicro.com>:

> > This has already been done for wm9090, can you resubmit with just the
> > alc5623 change please?

> Ok. A new patch "ASoC: alc5623: Remove unused mutex" is on the way.

Thanks.  The patch has been sitting there for a little while but it's
not on kernel.org due to the lockdown after the compromise - until we
can start pushing updates again there's a risk of overlaps like this.
