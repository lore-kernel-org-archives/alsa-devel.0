From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: What recommended performance for ALSA(ASoC)?
Date: Fri, 7 Mar 2008 11:20:09 +0000
Message-ID: <20080307112008.GA5033@rakim.wolfsonmicro.main>
References: <280b69ac0803061801o4ef80585mdd8b7753ab40be8a@mail.gmail.com>
	<Pine.LNX.4.61.0803070838120.7942@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6646F245E8
	for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2008 12:20:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0803070838120.7942@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Jinyoung Park <mcjin02@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 07, 2008 at 08:49:09AM +0100, Jaroslav Kysela wrote:
> On Fri, 7 Mar 2008, Jinyoung Park wrote:

> > Target system' processor(ARM9) clock is 200MHz and BogoMIPS is
> > 99.6(cat /proc/cpuinfo). Linux kernel version is 2.6.24.1.

> > What recommended performance for ALSA(ASoC)?
> > If my target system is enough performance, shall I do that solve problem?

That should be more than enough in terms of CPU performance - it's
fairly typical for an ASoC-based system.

> It looks like that your driver has trouble with highter rates. Also, try 
> to measure where the problem occurs. Maybe your system is not able to 
> deliver data from source in time to sound DMA buffer for continuous 
> playback. Note that whole system must be tuned not only ALSA driver to get 
> satisfiable results. DMA+mmap transfers are pretty lightweight in ALSA, 
> but if disc read operation eats too much CPU time, you cannot expect good 
> results.

If the CPU is busy it's also worth ensuring that the playback format you
are using is directly supported by the hardware to avoid the CPU having
to do any additional transcoding.

> Regarding noises - I would check if DMA ring buffer position reported from 
> driver is correct in application. It looks like a handshake or 
> maybe cache problem.

Also check that the clocking of the audio subsystem isn't going to be
introducing any glitches.  You usually want to ensure that the audio
parts of the system are part of a single clocking domain.
