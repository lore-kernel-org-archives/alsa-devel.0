From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: soc-core: Question about cpu_dai and
	codec_dai	conversions
Date: Tue, 30 Sep 2008 20:09:27 +0100
Message-ID: <20080930190926.GC3338@sirena.org.uk>
References: <48E24F91.1020201@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FC81245D6
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Sep 2008 21:09:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48E24F91.1020201@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 30, 2008 at 09:10:57AM -0700, Troy Kisky wrote:

> Currently, we have the line

> runtime->hw.formats =
> 	codec_dai->playback.formats & cpu_dai->playback.formats;

> This seems to force the two to support a common subset.
> For example some codec support only big-endian or little-endian

You'll find that for historical reasons all current codec drivers claim
to support little endian only though actually all they're really
declaring is the word length - they don't care about the memory layout
since by the time it hits the DAI and they can see it the endianness is
gone.

> My codec expects the most significant bit to be shifted 1st. I would
> call that big-endian. But the codec marks itself as only doing little
> endian, because the cpu_dai converts from little-endian to big-endian.
> Do all codecs expect the msb 1st? If so, then endianness would seem irrelevant
> to codecs and both should be set.

Yes, pretty much all codecs expect that format.  Either the codecs should
be setting both endianesses or this should be fudged for them in the core 
before doing the DAI capability matching.  I'm tending towards the latter
since it makes the codec drivers less verbose, it's on my list of patches
to cook up since it's an existing problem for AVR32 systems.

> The same goes with number of channels. The davinci dma engine can convert
> a playback stream from mono to stereo, or a capture stream from stereo

At the minute ASoC has a restricted view of the digital domain - up
until fairly recently there hasn't been much need to do a lot there
since the complexity was all been in the analogue side.  The digital
side usually just provided fairly simple data transfer.  That is
changing with modern audio hub codecs working much more in the digital
domain but dealing well with them will require some core work - at
present I can't immediately think of a clean way of handling things like
that.

I think off the top of my head what'd be best for handling the channel
conversion is support for representing digital mixing and paths in DAPM.
The audio hub codecs certainly need that.  You'd probably then end up
with something like a memory interface widget that knows about the
memory format, a DAI widget and a digital mixer widget between the two.
Like I say, that's off the top of my head rather than a proper design.

> to mono. The davinci McBsp can also be more efficient if allowed to swap
> left and right channels. Is there a method to let the codec know to swap
> them back?

No, that's not possible at present - this is the first time it's been
suggested that I can remember.

It's easy enough to do, though: add a lr_swap operation to the DAIs 
similar to the existing digital mute operation which codecs can then
implement (the codecs that have this at the minute do it by exposing
a control to user space).  We can then either have machine drivers do
the configuration or add something to the core to figure out when to
set it up automatically.  If the core does do it automatically it
ought to be overridable by the machine driver - safer to just put it in
the machine driver only, at least initially.
