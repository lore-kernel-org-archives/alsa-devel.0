From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/7] ASoC: i.MX31ads: initialize only on
	correct machine
Date: Fri, 5 Nov 2010 09:09:42 -0400
Message-ID: <20101105130941.GA13709@opensource.wolfsonmicro.com>
References: <1288886745-25977-1-git-send-email-s.hauer@pengutronix.de>
	<1288886745-25977-2-git-send-email-s.hauer@pengutronix.de>
	<20101104185136.GG6088@opensource.wolfsonmicro.com>
	<20101105091624.GS6017@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 800D5103946
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 14:09:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101105091624.GS6017@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 05, 2010 at 10:16:24AM +0100, Sascha Hauer wrote:
> On Thu, Nov 04, 2010 at 02:51:36PM -0400, Mark Brown wrote:

> > As previously discussed we need a better check than this - most of these
> > machines won't have a 1133-EV1 PMIC module on them.  Better to convert
> > the driver to instantiate from a platform device...

> This does not solve the problem as we do not know when to register the
> platform_device. I think what we need is a kernel parameter which can be
> used to select the correct path in arch/arm/mach-mx3/mach-mx31ads.c

It can be registered in the callback that's called immmediately after
the WM835x is probed on the machine driver.

> aswell. I will look into it. For now, can we just take this patch? It
> at least fixes all other i.MX31 boards and leaves only the mx31ads to
> work on.

I'd much rather get it fixed properly - it's not so urgent since it
really only only affects allyesconfig or allmodconfig type stuff with
people explicitly loading the driver.
