From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Dynamic PCM and Tegra AHUB
Date: Sun, 27 May 2012 23:33:36 +0100
Message-ID: <20120527223334.GC25019@opensource.wolfsonmicro.com>
References: <4FC02294.1000500@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C386F2434E
	for <alsa-devel@alsa-project.org>;
	Mon, 28 May 2012 00:33:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4FC02294.1000500@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 25, 2012 at 06:23:48PM -0600, Stephen Warren wrote:

> It seems like the whole point of ASoC dynamic PCM is to represent the
> AHUB core, and at least some of the surrounding boxes above, as an ASoC
> CODEC.

No, not really though it could do.  It's really intended for cases where
there's a much tighter coupling between the inputs and the outputs and
where the AP needs to manage the DMA on both sides of the hub (it looks
like that isn't the case from your diagram).  It wasn't especially
intended to be used in CODEC devices at all.

Note that the dynamic PCM setup ends up with you having to define links
between the components in the machine driver in a similar fashion to
that which you're discussing below, though the format is different.

> then the codec_dai_name interpreted relative to that. Without a CPU-side
> separation between name/node and dai_name, that's not possible. So, I
> sent a patch for that in case this is the right approach.

I think it is, we've just never been encountering naming collisions on
the CPU side for obvious reasons.

> An alternative to expanding struct snd_soc_dai_link might be to add an
> API so the machine driver could ask the AHUB driver for the
> globally-unique name of each DAI it exposes, and write that into
> dai_link.cpu_dai_name. But if we have that API, we could use it for the
> codec-side of the link to, and just have .codec_dai_name and remove the
> .codec_name and .codec_of_node fields.

This seems bad, it's replacing data with code which is the wrong way
round.

> Alternatively, perhaps the DMA FIFOs should be registered as CPU DAIs
> completely separately from the AHUB CODEC. The AHUB CIFs would then be
> the DAIs registered by the AHUB CODEC. But then, the machine driver

This is what I'd expect.

> would need to include dai_links for all the DMA FIFO <-> CIF
> connections, which would end up duplicating that list of links into all
> Tegra machine drives (or perhaps sharing it in common code).

We should probably just have a "link blob" class of device which can be
used by things like SoCs (and may also be useful for things that have
lots of derivatives or modular components) and then either placed in the
machine driver automatically or referenced by the machine driver
somehow.

Though with DT boards perhaps some DT include/refrence stuff can do this
transparently, I'd hope so but I'm not optimistic.
