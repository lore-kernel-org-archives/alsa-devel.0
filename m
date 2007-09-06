From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: How can I make sure the period size is a multiple
 of 16?
Date: Thu, 6 Sep 2007 10:14:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0709061009280.31808@shell4.speakeasy.net>
References: <46DDE137.2070507@freescale.com>
	<200709051229.54852.linux@audioscience.com>
	<46E033BF.1010104@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail7.sea5.speakeasy.net (mail7.sea5.speakeasy.net
	[69.17.117.9]) by alsa0.perex.cz (Postfix) with ESMTP id 5374110381C
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Sep 2007 19:14:29 +0200 (CEST)
In-Reply-To: <46E033BF.1010104@freescale.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 6 Sep 2007, Timur Tabi wrote:
> Eliot Blennerhassett wrote:
>
> > You need to add some constraints to your driver, in the open callback.
> > E.g.
> > snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 16);
>
> Thanks.  snd_pcm_hw_constraint_step() is not documented anywhere, and the
> comments in the source code don't provide any clues, either.  Even the "ALSA
> Driver API" document just lists the function, but doesn't actually tell you
> what it does.

I still haven't figured out what the "condition bits" do.  It's always 0 every
time one of the constraint functions are called.  I looked in the ALSA core
code, and it seems that if you specify some condition bits they must match
some flag bits in the hw params for the constraint to apply.  But the flags
bits just get copied from user space, so there is no clue in the kernel code
what they are or what they do.
