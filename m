From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: Patches for Freescale MXC SoCs (SSI,
	DMA	and machine).
Date: Wed, 5 Aug 2009 22:37:09 +0100
Message-ID: <20090805213709.GC20853@opensource.wolfsonmicro.com>
References: <eedb5540908040817g15c981f8ye8aac6d4b253317f@mail.gmail.com>
	<20090804202657.GH4342@sirena.org.uk>
	<eedb5540908050421we065ad3ieb63eb100d2b1df8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 676D82463D
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Aug 2009 23:37:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <eedb5540908050421we065ad3ieb63eb100d2b1df8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 05, 2009 at 01:21:54PM +0200, javier Martin wrote:

> They must be applied over the previous patches in the following order:
> 1. fix_pcm.patch
> 2. rename-ssi.patch

I've applied all your patches except for rename-ssi.patch which git am
doesn't seem to like at all - might be worth retrying with git
format-patch -M?  The rename is a fairly simple job and can be compile
tested so I may well do it myself if you're too busy.

Everything is sitting on a branch 'mxc' in my git applied against
2.6.30.  I want to do final check for API updates before I merge into
for-2.6.32, probably this weekend sometime.

Like I said before, thanks a lot for taking the time to sort this out.
