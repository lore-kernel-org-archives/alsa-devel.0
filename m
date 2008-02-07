From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: PXA27x and AC97 reset bug
Date: Thu, 7 Feb 2008 11:36:39 +0000
Message-ID: <20080207113639.GA7512@rakim.wolfsonmicro.main>
References: <87ejbpheqk.fsf@polgara.paysbobval>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9719E245A8
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 12:36:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87ejbpheqk.fsf@polgara.paysbobval>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <rjarzmik@free.fr>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 07, 2008 at 12:00:51AM +0100, Robert Jarzmik wrote:

> The basic question is : why can't the PXA27x reset the AC97 bus in front of an
> wm9713 ?

> And more precisely, I'd like to know :
>  - are there any references to this bug (Intel note, mailing list ref, ...)

I'm not aware of any public documentation for this.

>  - is it a hardware bug on PXA27x side ?

With the PXA27x AC97 controller it appears that doing a warm reset also
asserts the cold reset line so ends up performing a cold reset instead.

>  - is it a hardware bug on wm9713 side ?

No.

>  - is there a known generic workaround (assuming GPIO113 is connected to wm9713
> reset line is not generic for me) ?

Since our previous discussion I've realised that the use of GPIO113 is
in fact a generic workaround - GPIO113 is the multi-function pin which
provides the AC97 cold reset.  What the workaround does is to control
that manually rather than allowing the AC97 controller in the chip to do
the job, avoiding the spurious cold reset.  Sorry about that.

>  - is there a known platform where this bug does not happen ?

It's not a bug in the WM9713 - the issue is more apparent with the
WM9713 than with most other devices since the WM9713 starts in a very
low power state link off and requires the warm reset to bring up the
AC97 link while most devices keep it running all the time.

I guess we need to go back to your original problem and take a look at
how the register cache and chip are getting out of sync.
