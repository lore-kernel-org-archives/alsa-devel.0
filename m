From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Palm interrupt driven touchscreen driver
Date: Thu, 4 Jun 2009 09:54:07 +0100
Message-ID: <20090604085407.GB6983@rakim.wolfsonmicro.main>
References: <200906032341.03266.marek.vasut@gmail.com>
	<f17812d70906031835u5a650772wedcab94fd6f2ae2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4EF2C24453
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 10:54:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f17812d70906031835u5a650772wedcab94fd6f2ae2d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 04, 2009 at 09:35:17AM +0800, Eric Miao wrote:
> On Thu, Jun 4, 2009 at 5:41 AM, Marek Vasut <marek.vasut@gmail.com> wrote:

> > Mark, it's the same patch we discussed on IRC, so it should be OK.

> Mark, the driver looks generic enough to me, is there some specific
> reason this remains named "mainstone-wm97xx.c"?

No, and in fact I've asked Marek in some off-list discussions to do
something along those lines and/or remove the mainstone code entirely
but he doesn't seem keen on it for some reason.  Now we have more widely
distributed platforms merged I see no reason to keep the Mainstone code
in mainline.

> I didn't look into the code too much, yet I'm wondering if it's possible
> to come up with a platform_data to cover the difference of boards
> and make this driver generic.

As I've said a number of times before AC97 does not support platform
data and the ALSA guys blocked adding it.
