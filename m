From: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
Subject: Re: [PATCH 2/2] ALSA sound driver for the
	AT73C213	DAC	using Atmel SSC driver
Date: Mon, 16 Jul 2007 16:25:28 +0200
Message-ID: <1184595928.15535.26.camel@localhost.localdomain>
References: <11845952993023-git-send-email-hcegtvedt@atmel.com>
	<11845952991232-git-send-email-hcegtvedt@atmel.com>
	<s5hbqeczb7k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (nat-132.atmel.no [80.232.32.132])
	by alsa0.perex.cz (Postfix) with ESMTP id DF957103809
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jul 2007 16:23:45 +0200 (CEST)
In-Reply-To: <s5hbqeczb7k.wl%tiwai@suse.de>
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


On Mon, 2007-07-16 at 16:15 +0200, Takashi Iwai wrote:
> At Mon, 16 Jul 2007 16:14:59 +0200,
> Hans-Christian Egtvedt wrote:
> > 
> > This patch adds support for the AT73C213 DAC using the misc Atmel SSC driver in
> > I2S mode. The driver also requires a SPI to setup the registers and control
> > volume.
> > 
> > It has been tested with an AT32AP7000 on the ATSTK1000 development board. The
> > driver should also work with any Atmel device with an SSC module supported by
> > the Atmel SSC driver (atmel-ssc).
> > 
> > The atmel-ssc driver is just submitted to the Linux kernel. Please see mail
> > thread http://lkml.org/lkml/2007/7/16/32
> > 
> > Signed-off-by: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
> 
> Are these intended to be merged to 2.6.23 kernel?

I would prefer that yes. AFAIK alsa-devel@ is the correct list for the
sound drivers?

-- 
With kind regards,

Hans-Christian Egtvedt, siv.ing. (M.Sc.)
Applications Engineer - AVR32 System Solutions - Atmel Norway
