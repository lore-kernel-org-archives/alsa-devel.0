From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Memory corruption in ASoC
Date: Thu, 18 Mar 2010 16:43:06 +0000
Message-ID: <20100318164305.GB6142@rakim.wolfsonmicro.main>
References: <20100318161755.GJ30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 29879103868
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 17:43:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100318161755.GJ30801@buzzloop.caiaq.de>
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
Cc: alsa-devel@alsa-project.org, Sven Neumann <s.neumann@raumfeld.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 18, 2010 at 05:17:55PM +0100, Daniel Mack wrote:

> So the first stream (PLAYBACK) already exported its dma_data which is
> now freed by the code initializing the second stream (CAPTURE).
> This corrupts all existing users of course, and in this particular case,
> the cleanup in __pxa2xx_pcm_hw_free() dereferences a pointer which is
> bogus.

> What I really don't understand is why this didn't crash a lot earlier
> for many more users.

> So how is this supposed to be fixed? Should dma_data become a member of
> some per-stream instance? I believe that also other platforms than PXA
> are actually affected - am I right?

It should really be per-substream, yes.

It's relatively hard to trigger problems on a lot of platform since the
DAI data pointer is often only really used at stream setup, meaning that
triggering a problem requires that a system not only does simultaneous
playback and capture but also has overlapping startup of the two.  PXA
is also very rare in doing dynamic allocation here, most drivers use
statically allocated resources which would make any problems much less
obvious.

There's some more generic issues there to do with imposing constraints
but that's a separate thing.
