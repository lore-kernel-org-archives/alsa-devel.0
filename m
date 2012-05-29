From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: Dynamic PCM and Tegra AHUB
Date: Tue, 29 May 2012 11:29:26 -0600
Message-ID: <4FC50776.20006@wwwdotorg.org>
References: <4FC02294.1000500@wwwdotorg.org>
	<20120527223334.GC25019@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id DB3F224BAB
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2012 19:29:30 +0200 (CEST)
In-Reply-To: <20120527223334.GC25019@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 05/27/2012 04:33 PM, Mark Brown wrote:
> On Fri, May 25, 2012 at 06:23:48PM -0600, Stephen Warren wrote:
> 
>> It seems like the whole point of ASoC dynamic PCM is to represent the
>> AHUB core, and at least some of the surrounding boxes above, as an ASoC
>> CODEC.
> 
> No, not really though it could do.  It's really intended for cases where
> there's a much tighter coupling between the inputs and the outputs and
> where the AP needs to manage the DMA on both sides of the hub (it looks
> like that isn't the case from your diagram).  It wasn't especially
> intended to be used in CODEC devices at all.
> 
> Note that the dynamic PCM setup ends up with you having to define links
> between the components in the machine driver in a similar fashion to
> that which you're discussing below, though the format is different.
...
>> Alternatively, perhaps the DMA FIFOs should be registered as CPU DAIs
>> completely separately from the AHUB CODEC. The AHUB CIFs would then be
>> the DAIs registered by the AHUB CODEC. But then, the machine driver
> 
> This is what I'd expect.

OK, so perhaps I'm confusing codec<->codec links and dynamic PCM yet again.

Referring back to my earlier diagram, I assume that the DMA FIFO -> AHUB
CIF link would be a completely standard snd_soc_dai_link. There would be
another (set of) snd_soc_dai_link for the AHUB CIF -> I2S connections on
the right of the diagram, which would set snd_soc_dai_link.no_pcm=1.

So, in other words, snd_soc_dai_link.no_pcm=1 can end up being used
either for plain codec<->codec links, or dynamic PCM, whereas
snd_soc_dai_link.dynamic is most likely only used for dynamic PCM (I'd
kinda assumed that using the .no_pcm field implied dynamic PCM, but
perhaps that's not the case).
