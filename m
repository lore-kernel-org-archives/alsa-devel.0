From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: [PATCH] ad1848 ac loop
Date: Fri, 21 Sep 2007 02:31:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0709210221150.27377@shell4.speakeasy.net>
References: <Pine.LNX.4.58.0709181930050.27377@shell4.speakeasy.net>
	<20070919112413.70051500.krzysztof.h1@gmail.com>
	<Pine.LNX.4.58.0709191205330.27377@shell4.speakeasy.net>
	<20070919225521.116d1787.krzysztof.h1@gmail.com>
	<Pine.LNX.4.58.0709201419350.27377@shell4.speakeasy.net>
	<75b66ecd0709202015u61611827x4bf77c8ad25ccbfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail4.sea5.speakeasy.net (mail4.sea5.speakeasy.net
	[69.17.117.6]) by alsa0.perex.cz (Postfix) with ESMTP id 398742437C
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Sep 2007 11:31:17 +0200 (CEST)
In-Reply-To: <75b66ecd0709202015u61611827x4bf77c8ad25ccbfe@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: Krzysztof Helt <krzysztof.h1@gmail.com>, alsa-devel@alsa-project.org, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 20 Sep 2007, Lee Revell wrote:
> On 9/20/07, Trent Piepho <xyzzy@speakeasy.org> wrote:
> > It's also worth noting that only local interrupts are disabled, not global
> > interrupts.  Absent a spin-lock, an SMP system can still have an irq
> > handler run while another thread on another CPU has interupts disabled.
> >
> > > I am not expert on this but following your reasoning any core kernel code
> > > (vm, scheduler) could not be interrupt-safe because most of interrupt handlers
> > > are in drivers and the core has no idea that drivers exist.
> >
> > None of the variables used by drivers' interrupt handlers are modified by
> > the core kernel code.  In this case, chip->playback_substream and
> > chip->record_substream are the relevant variables.  They are used
> > non-atomically from the irq handler, so any code which modifies them must
> > be protected from the irq handler.
>
> Most ALSA drivers would not enable the device interrupt until trigger
> START, and disable them in trigger STOP.  So your interrupt should
> never be enabled during open()/close().

Multiple substreams per device.  One could call open or close on one
substream while another is active.

Just because one has told the device to stop generating interrupts, doesn't
mean there isn't a pending interrupt already being handled.  That's what
synchronize_irq() is for.
