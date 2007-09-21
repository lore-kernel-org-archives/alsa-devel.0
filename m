From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: [PATCH] ad1848 ac loop
Date: Thu, 20 Sep 2007 23:15:05 -0400
Message-ID: <75b66ecd0709202015u61611827x4bf77c8ad25ccbfe@mail.gmail.com>
References: <Pine.LNX.4.58.0709181930050.27377@shell4.speakeasy.net>
	<20070919112413.70051500.krzysztof.h1@gmail.com>
	<Pine.LNX.4.58.0709191205330.27377@shell4.speakeasy.net>
	<20070919225521.116d1787.krzysztof.h1@gmail.com>
	<Pine.LNX.4.58.0709201419350.27377@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 525E9245E3
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Sep 2007 05:15:07 +0200 (CEST)
Received: by rv-out-0910.google.com with SMTP id k20so578484rvb
	for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2007 20:15:05 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.58.0709201419350.27377@shell4.speakeasy.net>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: Krzysztof Helt <krzysztof.h1@gmail.com>, alsa-devel@alsa-project.org, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 9/20/07, Trent Piepho <xyzzy@speakeasy.org> wrote:
> It's also worth noting that only local interrupts are disabled, not global
> interrupts.  Absent a spin-lock, an SMP system can still have an irq
> handler run while another thread on another CPU has interupts disabled.
>
> > I am not expert on this but following your reasoning any core kernel code
> > (vm, scheduler) could not be interrupt-safe because most of interrupt handlers
> > are in drivers and the core has no idea that drivers exist.
>
> None of the variables used by drivers' interrupt handlers are modified by
> the core kernel code.  In this case, chip->playback_substream and
> chip->record_substream are the relevant variables.  They are used
> non-atomically from the irq handler, so any code which modifies them must
> be protected from the irq handler.

Most ALSA drivers would not enable the device interrupt until trigger
START, and disable them in trigger STOP.  So your interrupt should
never be enabled during open()/close().

Lee
