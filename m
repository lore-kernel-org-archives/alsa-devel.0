From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Palm interrupt driven touchscreen driver
Date: Thu, 4 Jun 2009 10:27:28 +0100
Message-ID: <20090604092727.GE6983@rakim.wolfsonmicro.main>
References: <200906032341.03266.marek.vasut@gmail.com>
	<f17812d70906031835u5a650772wedcab94fd6f2ae2d@mail.gmail.com>
	<20090604085407.GB6983@rakim.wolfsonmicro.main>
	<20090604091329.GI29926@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6BF201037E3
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 11:27:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090604091329.GI29926@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Marek Vasut <marek.vasut@gmail.com>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 04, 2009 at 10:13:29AM +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 04, 2009 at 09:54:07AM +0100, Mark Brown wrote:

> > Now we have more widely
> > distributed platforms merged I see no reason to keep the Mainstone code
> > in mainline.

> Why not?  So what do those of us with mainstone platforms but not these
> "more widely distributed platforms" use instead?

This isn't a standard fit module for the Mainstone - it's the Mainstone
with the default audio plugin module replaced by a Wolfson plugin module.
If you just have a standard Mainstone you'd need a different accelerated
touch driver for the relevant AC97 controller.

If there are people out there with these setups then obviously the
driver is worth keeping in mainline, but I'm not aware of any active
users.
