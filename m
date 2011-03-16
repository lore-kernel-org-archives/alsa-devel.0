From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [alsa-devel] Compressed Audio Playback/Capture through	ALSA
 framework
Date: Wed, 16 Mar 2011 16:29:22 +0530
Message-ID: <1300273162.9428.10.camel@vkoul-udesk3>
References: <4D7FB076.30300@codeaurora.org>
	 <20110316103814.GA8369@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20110316103814.GA8369@sirena.org.uk>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Patrick Lai <plai@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-03-16 at 16:08 +0530, Mark Brown wrote:
> On Tue, Mar 15, 2011 at 11:31:18AM -0700, Patrick Lai wrote:
> 
> > Is there a precedent for playback/capture compressed audio stream 
> > through ALSA playback/capture interface if underlying hardware supports 
> > decoder + sink & encoder + source capabilities?
> 
> I'm not sure if ALSA is the best API to use for this - the ALSA APIs are
> strongly oriented around data where the size is consistent in time while
> most compressed audio formats don't do that.  There's also existing APIs
> in userspace like gstreamer and the various OpenMAXish things to slot in
> with, everything below those is usually black boxed per implementation.
I would agree with Mark, our best approach would be to do a clean design
of a new API set which takes care of both CBR, VBR and be generic enough
for any format.

> 
> Within ASoC the current tunneled audio stuff I've seen does something
> like representing the decompressor output as a DAPM input and showing
> that as active when there's a stream being decoded.  Portions of the
> implementation for Moorestown are in mainline in sound/soc/mid-x86,
> though I'm not sure if it's all fully hooked up yet or not.
The current implementation in soc/mid-x86 is for PCM only. The
compressed path offload bits are in staging/intel_sst.
I will be working to make these bits move to soc/mid-x86 and also to
make them more suited for generic frameworks.
> 
> Nobody's really tried to do more yet but this may end up being the best
> choice overall as there's substantial variation in how the DSPs are
> structured both physically and OS wise which make the abstractions below
> the userspace API level less clear.
I was thinking more on having a generic framework which coexists with
alsa, asoc (dapm), and provided a way to write driver for your dsp to do
decoder, sink + decoder and other variations.
The implementation of these can be specific to DSP in question, but
framework should be able to push and pull data, timing information
around with a standard way which coexists with current frameworks 

Thoughts....?

-- 
~Vinod

