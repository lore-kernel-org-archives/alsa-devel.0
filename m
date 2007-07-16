From: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
Subject: Re: [PATCH 2/2] ALSA sound driver for
	the	AT73C213	DAC	using Atmel SSC driver
Date: Mon, 16 Jul 2007 16:43:34 +0200
Message-ID: <1184597014.15535.33.camel@localhost.localdomain>
References: <11845952993023-git-send-email-hcegtvedt@atmel.com>
	<11845952991232-git-send-email-hcegtvedt@atmel.com>
	<s5hbqeczb7k.wl%tiwai@suse.de>
	<1184595928.15535.26.camel@localhost.localdomain>
	<s5h7ip0zahr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (nat-132.atmel.no [80.232.32.132])
	by alsa0.perex.cz (Postfix) with ESMTP id 21295103804
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jul 2007 16:41:52 +0200 (CEST)
In-Reply-To: <s5h7ip0zahr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, kernel@avr32linux.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2007-07-16 at 16:30 +0200, Takashi Iwai wrote:
> At Mon, 16 Jul 2007 16:25:28 +0200,
> Hans-Christian Egtvedt wrote:
> > 
> > 
> > On Mon, 2007-07-16 at 16:15 +0200, Takashi Iwai wrote:
> > > At Mon, 16 Jul 2007 16:14:59 +0200,
> > > Hans-Christian Egtvedt wrote:
> > > > 
> > > > This patch adds support for the AT73C213 DAC using the misc Atmel SSC driver in
> > > > I2S mode. The driver also requires a SPI to setup the registers and control
> > > > volume.
> > > > 
> > > > It has been tested with an AT32AP7000 on the ATSTK1000 development board. The
> > > > driver should also work with any Atmel device with an SSC module supported by
> > > > the Atmel SSC driver (atmel-ssc).
> > > > 
> > > > The atmel-ssc driver is just submitted to the Linux kernel. Please see mail
> > > > thread http://lkml.org/lkml/2007/7/16/32
> > > > 
> > > > Signed-off-by: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
> > > 
> > > Are these intended to be merged to 2.6.23 kernel?
> > 
> > I would prefer that yes. AFAIK alsa-devel@ is the correct list for the
> > sound drivers?
> 
> Yes.  Then the questions are:
> - the driver is mature enough for the upstream merge,

The first driver was made for Linux 2.6.16, and since then I have
forward ported it to the never kernels.

We have done some internal code review of this driver as well, so I feel
confident that it is mature enough for upstream.

> - whether it's built and tested on the latest 2.6.22 (or more
>   prefarably on the latest git) tree

It is based on Linux 2.6.22 + additional AVR32 patches which does not
affect ALSA.

The driver also needs the atmel-ssc driver I submitted to the kernel
list earlier today. I hope that also will make it for the 2.6.22 cut.

> If they are all OK, I'm willing to merge soon.

Sound nice, let me know if you have any problems merging it into the
ALSA tree.

-- 
With kind regards,

Hans-Christian Egtvedt, siv.ing. (M.Sc.)
Applications Engineer - AVR32 System Solutions - Atmel Norway
