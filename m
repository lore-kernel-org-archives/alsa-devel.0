From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 2/5] compress: add compress parameter
 definations
Date: Sat, 3 Sep 2011 01:05:14 +0100
Message-ID: <20110903000514.GB31813@opensource.wolfsonmicro.com>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1314943585-11670-3-git-send-email-vinod.koul@linux.intel.com>
	<20110902141859.GB10175@sirena.org.uk>
	<1314991562.2298.11.camel@plb-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A7C8C2440D
	for <alsa-devel@alsa-project.org>;
	Sat,  3 Sep 2011 02:05:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1314991562.2298.11.camel@plb-Dell>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@linux.intel.com>, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 02, 2011 at 02:26:01PM -0500, Pierre-Louis Bossart wrote:

> > > +/* AUDIO CODECS SUPPORTED */
> > > +#define MAX_NUM_CODECS 32
> > > +#define MAX_NUM_CODEC_DESCRIPTORS 32
> > > +#define MAX_NUM_RATES 32
> > > +#define MAX_NUM_BITRATES 32

> > Can we avoid these limitations?  The limit on the number of CODECs in
> > particular strikes me as not sufficiently high for me to be confident
> > we'd never run into it.  Consider a server side telephony system...

> The MAX_NUM_CODECS is actually the number of formats supported by your
> firmware, it's not related to the number of streams supported in
> parallel on your hardware. We could see support for 8 MP3 decoders, the
> number of codecs would be 1. This was dynamic but we limited it to make
> our life simpler. There's no problem to make it more flexible.

Yeah, I know.  I can't think it'll be a practical issue right now but
it's near enough to actual numbers that it doesn't make me happy seeing
it hard coded into an ABI.  The issue with server side telephony stuff
is that you end up interoperating with all sorts of weird stuff, some of
the PSTN stuff I used to work on would be getting close to this limit
due to some of the funky file formats people liked to do records in.

> We can align the sampling rates to use the exising ALSA definitions.
> The descriptors correspond to the number of variations for a given
> format, we can probably restrict it to 32...

That one is probably reasonable, yes.

> > I'd be inclined to add:

> > +#define SND_AUDIOCODEC_G723_1                  ((__u32) 0x0000000C)
> > +#define SND_AUDIOCODEC_G729                    ((__u32) 0x0000000D)

> > for VoIP usage as part of the default set but obviously it doesn't
> > really matter as it's trivial to add new numbers.

> Yes we can add these codecs, but it's actually extremely difficult to do
> any kind of hw acceleration for VoIP. G723.1 needs extra signaling for
> bad/lost frames, and you may want coupling between jitter buffer
> management, decoding and possibly a time-stretching solution to
> compensate for timing issues or dropped frames. This is difficult to

It's really not that hard, and there's also also the answerphone use
case where you're not dealing with a live VoIP stream but rather the
recorded data from one.  That was actually my main thought here - an
answerphone type thing rather than calls.

The G.723.1 lost frame stuff is generally just totally ignored, I'd be
astonished if anyone ever implements it and I'm not convinced from
memory that there's even a place for it in the RTP encoding.

> implement if the speech encoding/decoding is done on the DSP, while the
> jitter buffer management is done on the host. The data transfers based
> on ringbuffers/DMAs makes it also difficult to handle frames of varying
> sizes while limiting latency.

Yes, you would be using a message based thing if it were live audio
(which might be DMAed obviously but nothing like a single audio stream
with a single buffer) - the sort of thing copy() is good for.  The DMA
ring buffers just don't make much sense with the low volume low latency
traffic a live VoIP call generates.

> I'd rather push RTP packets down to the DSP and have the complete VoIP
> stack handled there.

Better yet, have a network stack on the DSP and never bother the host
with the data in the first place.
