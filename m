From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA porting to h/w having kernel version 2.6.18.5
Date: Fri, 17 Jul 2009 16:00:29 +0100
Message-ID: <20090717150029.GC4257@sirena.org.uk>
References: <COL106-W41CF75DA0AD6C9E6B599E4A71E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 28AA82432F
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jul 2009 17:00:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <COL106-W41CF75DA0AD6C9E6B599E4A71E0@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rakesh Kumar <itsrakesh@hotmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 17, 2009 at 08:19:01PM +0530, Rakesh Kumar wrote:

> I have following questions:

> 1. Shall I go ahead with ALSA 1.0.12 (which is already part of my kernel)?

> 2. or shall I download latest ALSA version 1.0.20?

I would recommend going with the most current ALSA version you can since
ASoC, the subsystem normally used for handling audio on embedded
platforms, is not present in 2.6.18.

> I tried building my kernel with latest ALSA (as a part of kernel) but
> facing some compilation errors.

It is likely that you will have to do some backporting, there have been
many changes in the kernel since 2.6.18 was released and ALSA will have
been updated for them.

It would be worth looking at moving forward to a more current kernel
version 2.6.18 is almost three years old and you are much more likely to
be able to obtain help from the community with a more current kernel
version.
