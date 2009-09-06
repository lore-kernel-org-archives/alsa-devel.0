From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Minor WM8580 enhancements.
Date: Sun, 6 Sep 2009 12:11:33 +0100
Message-ID: <20090906111133.GA26748@opensource.wolfsonmicro.com>
References: <1b68c6790909051709k600c8ecdv5bc457ae8e1242c1@mail.gmail.com>
	<20090906012232.GA4239@sirena.org.uk>
	<1b68c6790909051850y2386addhae71898ada96954@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 00F8324371
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Sep 2009 13:11:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1b68c6790909051850y2386addhae71898ada96954@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 06, 2009 at 10:50:26AM +0900, jassi brar wrote:

> Not all combinations of BFS and RFS are possible at all LRCLK values
> for CPU_DAI, not for Samsung SoCs those I am aware of.

These things are all sufficiently constrained by other factors - for
example, the MCLK to sample rate ratio is fixed by those two parameters
which are already known.  The Samsung CPUs aren't particularly
restrictive here as far as I remember, the fact that they implement
standard I2S helps a lot.  If you have datasheet references for any
restrictions you're concerned about please let me know.

> I get your recommendation, but i am already in the middle of
> submitting I2S machine
> driver for 6410-WM8580 mainline and that is one of the tasks i am assigned.
> Ofcourse, after 6410-wm8580 driver is all up and available to our
> users, i can switch to AC97.

All I'm saying is do the CPU drivers first - like I say, the main
obstacle to finishing off refreshing the CODEC driver has been having
the CPU driver to work off.  I'd expect to have something quickly given
that.  There shouldn't be much overall delay to getting the boards fully
supported.
