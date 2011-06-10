From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Device-drivers-devel] [PATCH 2/3] ASoC: Blackfin:
 Add bf5xx-adau1701 machine driver
Date: Fri, 10 Jun 2011 19:15:38 +0100
Message-ID: <20110610181538.GS26436@opensource.wolfsonmicro.com>
References: <1307726331-28618-1-git-send-email-lars@metafoo.de>
	<1307726331-28618-2-git-send-email-lars@metafoo.de>
	<20110610173004.GJ26441@sirena.org.uk>
	<BANLkTimBJbkYJnU5vgmo+a5eerRroE1uBg@mail.gmail.com>
	<20110610180137.GP26436@opensource.wolfsonmicro.com>
	<BANLkTi=S2GayUj8-ctjbDOE_bcEb-6GtJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E7DE8103D3F
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 20:15:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTi=S2GayUj8-ctjbDOE_bcEb-6GtJQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 10, 2011 at 02:13:05PM -0400, Mike Frysinger wrote:

> often times, people do have just basic needs, but i see what you mean.
>  i want the base driver to be flexible enough to handle all the base
> changes (diff SPORT num and perhaps addresses), but anything beyond
> that i'd expect someone to write a custom driver.  perhaps renaming
> the Kconfig description to be like "Basic Blackfin connection to XXX
> Codec" would be sufficient ?  and then add a few more details to the
> help text ?

Yes, that's exactly the sort of thing I'd like to see.  It shouldn't be
that big a change to the code, it's more about making it clear that it's
a 90% case driver rather than the only way to connect things up.
