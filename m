From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASOC, SPDIF and AC97
Date: Wed, 28 May 2008 11:14:30 +0100
Message-ID: <20080528101430.GB12414@sirena.org.uk>
References: <9e4733910805271116t1d36e769qaedfc0362b03e48d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id F0C6E245D0
	for <alsa-devel@alsa-project.org>;
	Wed, 28 May 2008 12:14:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910805271116t1d36e769qaedfc0362b03e48d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 27, 2008 at 02:16:54PM -0400, Jon Smirl wrote:

> I'm having trouble with SPDIF. I can make two devices like this in the
> codec file. But how do I get the SPDIF device hooked up to the right
> AC97 slot, 10/11? Are any of the ASOC codecs implementing SPDIF?

None that I know of implementing SPDIF (or at least, none with driver
support for it) but it might be worth taking a look at the PXA2xx AC97
controller support - it implements supports for AC97 timeslots beyond
the base playback and record channels.

Briefly, the approach is to provide a DAI in the AC97 controller driver
which handles the relevant AC97 timeslots and a DAI in the CODEC driver
which does the CODEC side of things then match the two together.

> I also see that the STAC9766 is missing an ac97_patch. From my reading
> of the datasheet it needs somethings fixed up.

> Does the ac97 support belong in the PCI directory? It took me a while
> to locate it while working on ASOC. With a model more like ASOC
> codecs, the AC97 patches could be pushed into the codec files.

The ASoC AC97 support doesn't use the AC97 patch infrastructure at all -
it's completely independent so things are pretty much as you describe,
everything is in the CODEC drivers.
