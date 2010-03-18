From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Memory corruption in ASoC
Date: Thu, 18 Mar 2010 17:48:53 +0100
Message-ID: <20100318164853.GK30801@buzzloop.caiaq.de>
References: <20100318161755.GJ30801@buzzloop.caiaq.de>
	<20100318164305.GB6142@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 409A024141
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 17:48:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100318164305.GB6142@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Sven Neumann <s.neumann@raumfeld.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 18, 2010 at 04:43:06PM +0000, Mark Brown wrote:
> On Thu, Mar 18, 2010 at 05:17:55PM +0100, Daniel Mack wrote:
> 
> > So the first stream (PLAYBACK) already exported its dma_data which is
> > now freed by the code initializing the second stream (CAPTURE).
> > This corrupts all existing users of course, and in this particular case,
> > the cleanup in __pxa2xx_pcm_hw_free() dereferences a pointer which is
> > bogus.
> 
> > What I really don't understand is why this didn't crash a lot earlier
> > for many more users.
> 
> > So how is this supposed to be fixed? Should dma_data become a member of
> > some per-stream instance? I believe that also other platforms than PXA
> > are actually affected - am I right?
> 
> It should really be per-substream, yes.

Do you want me to fix this or are you working on this already?

I know there are some pxa-ssp related things pending which will also
cause merge conflicts - which tree should thing apply to currently?

> It's relatively hard to trigger problems on a lot of platform since the
> DAI data pointer is often only really used at stream setup, meaning that
> triggering a problem requires that a system not only does simultaneous
> playback and capture but also has overlapping startup of the two.

Well, how would you initialize them in a non-overlapping way? The
example I sent does the setup fairly straight-forward, doesn't it?

I'd say any full-duplex system is affected.

Daniel
