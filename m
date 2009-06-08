From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/7] Alchemy: DB1200 AC97+I2S audio	support.
Date: Mon, 8 Jun 2009 13:44:11 +0100
Message-ID: <20090608124411.GA3396@rakim.wolfsonmicro.main>
References: <1244399944-29043-2-git-send-email-manuel.lauss@gmail.com>
	<1244399944-29043-3-git-send-email-manuel.lauss@gmail.com>
	<1244399944-29043-4-git-send-email-manuel.lauss@gmail.com>
	<1244399944-29043-5-git-send-email-manuel.lauss@gmail.com>
	<20090608092521.GA7858@sirena.org.uk>
	<f861ec6f0906080243g6be8e613p7ab9c2df66576be8@mail.gmail.com>
	<20090608102018.GA6547@rakim.wolfsonmicro.main>
	<f861ec6f0906080425i388a99a1kb89667c749a815c8@mail.gmail.com>
	<20090608115336.GA25827@rakim.wolfsonmicro.main>
	<f861ec6f0906080521y4443b888gb81a78305dfca5e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9328E243B8
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 14:44:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f861ec6f0906080521y4443b888gb81a78305dfca5e2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, alsa-devel@alsa-project.org, Ralf Baechle <ralf@linux-mips.org>, Manuel Lauss <manuel.lauss@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 08, 2009 at 02:21:18PM +0200, Manuel Lauss wrote:

> I see now what you mean, but this is ugly as sin:
> I now need to register 2 platform devices in the board code: 1 for the DAI
> (with resources mmio + irq) and 1 for the DMA engine (with ddma id resources),
> or register the DMA engine device from within the AC97/I2S drivers.

> This is in my opinion even worse than the current scheme, which at least allows
> me to group all PSC resources into one struct resource which all audio-related
> drivers can share without too much uglyness.

If you trigger registration the DMA engine from within the I2S and AC97
devices you can still group everything together like you want to so I
don't really see the problem - they're peering at a different device for
the data but other than that things are unchanged.  At the minute you're
loosing a lot of sharing by having this in the individual machine
drivers.

Note that one of the possibilities once multiple sound card support is
introduced is that DAIs could be shared between multiple cards.  This is
only going to be at all useful for CPU DAIs which allow separate
configuration of the RX and TX paths and will never be the common case
but it's something to bear in mind.
