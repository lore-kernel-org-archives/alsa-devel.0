From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Allow drivers to specify how
 many bits are significant on a DAI
Date: Tue, 17 Jan 2012 16:44:52 +0000
Message-ID: <20120117164452.GJ2944@opensource.wolfsonmicro.com>
References: <1326739267-9678-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F15377B.6080108@ti.com>
	<20120117113848.GE2944@opensource.wolfsonmicro.com>
	<4F157264.5020102@ti.com>
	<20120117131950.GF2944@opensource.wolfsonmicro.com>
	<4F15833B.2000808@ti.com>
	<20120117145646.GG2944@opensource.wolfsonmicro.com>
	<4F159CE2.4090306@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8AD96103A33
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 17:44:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F159CE2.4090306@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 17, 2012 at 05:08:02PM +0100, Peter Ujfalusi wrote:
> On 01/17/2012 03:56 PM, Mark Brown wrote:

> > Well, if it's doing something more complicated that doesn't fit in the
> > framework then it shouldn't be doing that.

> What do you mean? If user plays 16bit audio we configure the codec in
> 16bit mode. If it is opened in 24msbit/32 mode it is configured accordingly.

The framework feature is much simpler than that, it just supports a
fixed number of bits that the device uses internally regardless of what
the bus carries.  If the hardware actually does something substantial
internally then it doesn't really fit in with that.

> >> It does not give any useful information for application that the codec
> >> will upsample the 16bit data internally to 24 bits. It does not really
> >> matter for them since all 16bit data will be used by the codec.

> > Oh, I dunno - I'm sure someone could think of a use for it.

> Sure it might be good to know, but it is something we do not have
> control over. There's a datasheet if someone is interested.

The datasheet isn't terribly machine parseable.

> Even if you could select the algorithm for the in HW resampling it could
> be configured via kcontrol, or via qos.
> For application it does not matter.

I don't recall suggesting configuring the hardware algorithm here?

> > Right, like I say that's because it's got most of a DAC in it.

> The McPDM does not have codec, the internal FIFO has this layout which
> dictates the 24msbit. It just cuts the 8lsb.

Look at what a PDM output actually does compared to a sampled interface
and compare that to what a CODEC is doing - an awful lot of devices are
do the actual D/A and A/D conversions on an oversampled bitstream which
is what a PDM output is, generating that from the samples at some point
in the chain.

> >> 8bit lsb. This can make difference for PA when applying the digital gain
> >> in SW.

> > Well, it saves it a bit of effort but that's about it.

> This is not a point. If it does it's internal digital volume on the full
> 32bit resolution from which the HW just discards 8bits we will loose
> resolution. If PA knows that out of the 32bit only the 24bit msbit is
> going to be used it can apply the gain correctly.

This isn't a correctness thing really, it's just that it's doing more
work than it needs to because nothing is going to pay attention to the
the lower bits it outputs.  A gain applied with 24 bits just has an
output with a bit less resolution than one applied with 32 bits but it
shouldn't be substantially different.

> If we tell PA that the codec internally works in 24bit, and we play
> 16bit audio (in 16bit mode) PA needs to apply the gain in 16bit
> resolution. The information about the codec working internally in 24bit
> irrelevant.

I can't think why Pulse might want to use it.  On the other hand it's
not going to hurt to tell it.
