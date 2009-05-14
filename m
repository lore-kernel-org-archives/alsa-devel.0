From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Dynamically registering a codec
Date: Thu, 14 May 2009 17:15:50 +0100
Message-ID: <1242317750.31458.1782.camel@finisterre>
References: <9e4733910905131218t174b3b7cxc0e5c2fd5f5a0a06@mail.gmail.com>
	<20090513224424.GB24973@sirena.org.uk>
	<9e4733910905140844h1899bb60p19309953905b51d3@mail.gmail.com>
	(sfid-20090514_164415_433146_A39F7FC2)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1A2491039A2
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 18:22:53 +0200 (CEST)
In-Reply-To: <9e4733910905140844h1899bb60p19309953905b51d3@mail.gmail.com>
	(sfid-20090514_164415_433146_A39F7FC2)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2009-05-14 at 11:44 -0400, Jon Smirl wrote:

> Can we stick with the modifications to of_simple I just posted for
> 2.6.31 and then try to get the core fixed in 2.6.32 so that of_simple
> can be removed? I have no love for of_simple, I will immediately
> remove it in favor of core support. Removing it has no impact on user
> space.

My main objection is to your abuse of platform devices here - there is
no need for this on non-PowerPC platforms and a platform device affects
everyone. So long as you come up with a solution that does not impact
other platforms I'm less worried.

> of_simple handles both i2s and ac97. There's no probing mechanism for
> i2s so we will have to keep device tree support that attaches i2s
> codecs. There's also the problem of platform data for the ac97 codec
> contained in the of node.

Like I said, Linux does not support platform data for AC97 devices.
