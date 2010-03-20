From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: move dma_data from	snd_soc_dai
	to snd_soc_pcm_stream
Date: Sat, 20 Mar 2010 15:30:22 +0000
Message-ID: <20100320153022.GA32428@opensource.wolfsonmicro.com>
References: <20100318182211.GH6142@rakim.wolfsonmicro.main>
	<1268940238-6283-1-git-send-email-daniel@caiaq.de>
	<201003190856.40650.peter.ujfalusi@nokia.com>
	<20100319070852.GR30801@buzzloop.caiaq.de>
	<20100319151453.GH23306@rakim.wolfsonmicro.main>
	<20100319183958.GA30801@buzzloop.caiaq.de>
	<20100319195422.GB15902@opensource.wolfsonmicro.com>
	<20100320145428.GC30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A7AB62449E
	for <alsa-devel@alsa-project.org>; Sat, 20 Mar 2010 16:30:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100320145428.GC30801@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Sven Neumann <s.neumann@raumfeld.com>, alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Michael Hirsch <m.hirsch@raumfeld.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 20, 2010 at 03:54:29PM +0100, Daniel Mack wrote:

> Agreed. However, I believe when pushed to .34, it will get greater
> exposion, and regressions would more likely be found and get fixed.
> Faster than in your for-2.6.35 branch I mean.

I want it to at least appear in -next for a few days before backporting.
That will get a moderate amount of automatic cover, and would make me
much more happy about pushing a version for .34.  If you want to do the
backport to .34 that'd be helpful.
