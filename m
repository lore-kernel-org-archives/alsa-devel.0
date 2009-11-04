From: GNUtoo <GNUtoo@no-log.org>
Subject: Re: MSM DSP
Date: Wed, 04 Nov 2009 22:29:22 +0100
Message-ID: <1257370162.6812.76.camel@localhost>
References: <1257264142.19223.17.camel@localhost>
	<20091104104943.GA25044@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out26.alice.it (smtp-out26.alice.it [85.33.2.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 280032448A
	for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2009 21:29:47 +0100 (CET)
In-Reply-To: <20091104104943.GA25044@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2009-11-04 at 10:49 +0000, Mark Brown wrote:
> Please fix your MUA to word wrap at 80 columns, not doing this makes
> your posts much harder to read and reply to.  It'd also be helpful to
> place blank lines between paragraphs to improve legibility.
So sorry,I was told that evolution does it by default.
There must have been a wrong manipulation by me or a bug...
I'm so sorry.

> 
> On Tue, Nov 03, 2009 at 05:02:22PM +0100, GNUtoo wrote:
> 
> > codeaurora(
> > https://www.codeaurora.org/gitweb/quic/le/?p=kernel/msm.git ) had alsa
> > in its kenrel I first tried to compile that kernel...but due to
> > numerous bugs(It didn't compile and needed too much fixing) in it
> > android-msm-2.6.29 branch I decided to import alsa in the linuxtogo
> > kernel,and I pushed the sources at a temporary htc-alsa branch at
> > git://gitorious.org/replicant/gnulinuxkernel.git (it's called gnulinux
> > in order to differentiate from an android kernel,I didn't find a good
> > name for it)
> 
> Please submit any code you have to the mailing list, it's much easier to
> review things via the standard workflows and getting the drivers into
> mainline would be good.
I'll make git send a mail.
But note that the code of the alsa driver depends on a custom android
sound system that is in :
arch/arm/mach-msm/qdsp5/
so it's platform specific.

> The problems you're reporting suggest that the driver either isn't
> communicating the requirements it has for data buffers to the
> applications correctly or it isn't correctly notifying applications when
> buffers have drained.  mplayer is much more sensitive to both of these
> issues.
Thanks a lot

Denis.
