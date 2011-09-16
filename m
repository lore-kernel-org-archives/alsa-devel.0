From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [v2] ASoC: support all possible sample
 rates in the WM8776 driver
Date: Fri, 16 Sep 2011 18:13:00 +0100
Message-ID: <20110916171259.GG23727@opensource.wolfsonmicro.com>
References: <1316182614-9666-1-git-send-email-timur@freescale.com>
	<20110916164412.GD23727@opensource.wolfsonmicro.com>
	<4E737D89.9060900@freescale.com>
	<20110916164838.GF23727@opensource.wolfsonmicro.com>
	<4E737FA8.5090109@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 76B6B10380D
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 19:13:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E737FA8.5090109@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 16, 2011 at 11:56:08AM -0500, Timur Tabi wrote:

> But it is reference in ASoC.  That's the point I was trying to make:

> "Although the WM8776 driver includes a .set_sysclk function, it was also
> hard-coding the list of supported sample rates."

Right, but the two things aren't connected.  As I've *repeatedly* said
the list of supported sample rates in the DAI should be the full set
that the device can support, unrelated to any clock setup.

> Unless you're saying that the "it" refers to the set_sysclk function, rather
> than "the WM8776 driver".

That is actually how I parsed it, though in any case there's still the
thing with dynamic sysclk configuration being unrelated to rate lists.
