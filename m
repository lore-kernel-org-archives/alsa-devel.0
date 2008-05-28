From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: ASOC, SPDIF and AC97
Date: Wed, 28 May 2008 09:40:13 -0400
Message-ID: <9e4733910805280640nd460258i547c8bc6581b411a@mail.gmail.com>
References: <9e4733910805271116t1d36e769qaedfc0362b03e48d@mail.gmail.com>
	<20080528101430.GB12414@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.185])
	by alsa0.perex.cz (Postfix) with ESMTP id A43D424600
	for <alsa-devel@alsa-project.org>;
	Wed, 28 May 2008 15:40:14 +0200 (CEST)
Received: by rn-out-0910.google.com with SMTP id k32so1608584rnd.21
	for <alsa-devel@alsa-project.org>; Wed, 28 May 2008 06:40:13 -0700 (PDT)
In-Reply-To: <20080528101430.GB12414@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 5/28/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, May 27, 2008 at 02:16:54PM -0400, Jon Smirl wrote:
>
>  > I'm having trouble with SPDIF. I can make two devices like this in the
>  > codec file. But how do I get the SPDIF device hooked up to the right
>  > AC97 slot, 10/11? Are any of the ASOC codecs implementing SPDIF?
>
>
> None that I know of implementing SPDIF (or at least, none with driver
>  support for it) but it might be worth taking a look at the PXA2xx AC97
>  controller support - it implements supports for AC97 timeslots beyond
>  the base playback and record channels.

I'll look at PXA2xx. I had assumed that some of the SOC codecs were
implementing SPDIF and that wrongly led me into the pci code.

I'm practicing on the Efika while I wait on our own hardware. The
Efika hardware can support simultaneous independent playback on analog
and spdif. I see now that it is too hard to jump straight to
independent playback, instead I'll work on getting them both to play
standalone.

For independent playback I need to interleave the data from two
buffers and DMA it into the PSC. I believe the Bestcomm DMA controller
can do this. Does ALSA hand me the two buffers simultaneously? I
haven't located any code yet supporting independent playback.

>
>  Briefly, the approach is to provide a DAI in the AC97 controller driver
>  which handles the relevant AC97 timeslots and a DAI in the CODEC driver
>  which does the CODEC side of things then match the two together.
>
>
>  > I also see that the STAC9766 is missing an ac97_patch. From my reading
>  > of the datasheet it needs somethings fixed up.
>
>  > Does the ac97 support belong in the PCI directory? It took me a while
>  > to locate it while working on ASOC. With a model more like ASOC
>  > codecs, the AC97 patches could be pushed into the codec files.
>
>
> The ASoC AC97 support doesn't use the AC97 patch infrastructure at all -
>  it's completely independent so things are pretty much as you describe,
>  everything is in the CODEC drivers.

I've figured out now that the pci codec code is independent of the
asoc code. Are there plans to unify this in the future?


>


-- 
Jon Smirl
jonsmirl@gmail.com
