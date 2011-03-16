From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] Compressed Audio Playback/Capture through ALSA
 framework
Date: Wed, 16 Mar 2011 11:56:27 +0000
Message-ID: <20110316115627.GC14125@opensource.wolfsonmicro.com>
References: <4D7FB076.30300@codeaurora.org>
 <20110316103814.GA8369@sirena.org.uk>
 <1300273162.9428.10.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1300273162.9428.10.camel@vkoul-udesk3>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: Patrick Lai <plai@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 16, 2011 at 04:29:22PM +0530, Koul, Vinod wrote:
> On Wed, 2011-03-16 at 16:08 +0530, Mark Brown wrote:

> > Nobody's really tried to do more yet but this may end up being the best
> > choice overall as there's substantial variation in how the DSPs are
> > structured both physically and OS wise which make the abstractions below
> > the userspace API level less clear.

> I was thinking more on having a generic framework which coexists with
> alsa, asoc (dapm), and provided a way to write driver for your dsp to do
> decoder, sink + decoder and other variations.
> The implementation of these can be specific to DSP in question, but
> framework should be able to push and pull data, timing information
> around with a standard way which coexists with current frameworks 

It would be nice to have a standard userspace API for this but I'm not
aware of anyone who's looked at it in detail and you start having to
also take into account other algorithms that are running on the device
so there's nothing to point people at right now and no real prospect of
there being.  I don't know if it's something we can resolve entirely in
the kernel as I'm aware that some of the DSP implementations have
non-trivial management code in userspace that they talk to which may
mean that the standard API has to be a userspace one.  There's also the
difference between memory to memory implementations (which fit into a
userspace chain much more readily) and tunneled implementations (which
do need new infrastructure).

I think this'll get substantially easier to look at once the media
controller API is merged and starts to be used in the audio subsystem.
