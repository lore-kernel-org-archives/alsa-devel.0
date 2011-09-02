From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC 2/5] compress: add compress parameter
 definations
Date: Fri, 02 Sep 2011 14:26:01 -0500
Message-ID: <1314991562.2298.11.camel@plb-Dell>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1314943585-11670-3-git-send-email-vinod.koul@linux.intel.com>
	<20110902141859.GB10175@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id D74DE245D7
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Sep 2011 21:26:16 +0200 (CEST)
In-Reply-To: <20110902141859.GB10175@sirena.org.uk>
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@linux.intel.com>, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Thanks Mark for your feedback.

> > +/* AUDIO CODECS SUPPORTED */
> > +#define MAX_NUM_CODECS 32
> > +#define MAX_NUM_CODEC_DESCRIPTORS 32
> > +#define MAX_NUM_RATES 32
> > +#define MAX_NUM_BITRATES 32
> 
> Can we avoid these limitations?  The limit on the number of CODECs in
> particular strikes me as not sufficiently high for me to be confident
> we'd never run into it.  Consider a server side telephony system...

The MAX_NUM_CODECS is actually the number of formats supported by your
firmware, it's not related to the number of streams supported in
parallel on your hardware. We could see support for 8 MP3 decoders, the
number of codecs would be 1. This was dynamic but we limited it to make
our life simpler. There's no problem to make it more flexible.
We can align the sampling rates to use the exising ALSA definitions.
The descriptors correspond to the number of variations for a given
format, we can probably restrict it to 32...

> I'd be inclined to add:
> 
> +#define SND_AUDIOCODEC_G723_1                  ((__u32) 0x0000000C)
> +#define SND_AUDIOCODEC_G729                    ((__u32) 0x0000000D)
> 
> for VoIP usage as part of the default set but obviously it doesn't
> really matter as it's trivial to add new numbers.

Yes we can add these codecs, but it's actually extremely difficult to do
any kind of hw acceleration for VoIP. G723.1 needs extra signaling for
bad/lost frames, and you may want coupling between jitter buffer
management, decoding and possibly a time-stretching solution to
compensate for timing issues or dropped frames. This is difficult to
implement if the speech encoding/decoding is done on the DSP, while the
jitter buffer management is done on the host. The data transfers based
on ringbuffers/DMAs makes it also difficult to handle frames of varying
sizes while limiting latency.
I'd rather push RTP packets down to the DSP and have the complete VoIP
stack handled there.

> Should we use the existing ALSA rate constants and whatnot for the
> sample rate here?

Yes. No issue on our side.
