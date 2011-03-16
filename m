From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] Compressed Audio Playback/Capture through ALSA
	framework
Date: Wed, 16 Mar 2011 10:38:14 +0000
Message-ID: <20110316103814.GA8369@sirena.org.uk>
References: <4D7FB076.30300@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D7FB076.30300@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 15, 2011 at 11:31:18AM -0700, Patrick Lai wrote:

> Is there a precedent for playback/capture compressed audio stream 
> through ALSA playback/capture interface if underlying hardware supports 
> decoder + sink & encoder + source capabilities?

I'm not sure if ALSA is the best API to use for this - the ALSA APIs are
strongly oriented around data where the size is consistent in time while
most compressed audio formats don't do that.  There's also existing APIs
in userspace like gstreamer and the various OpenMAXish things to slot in
with, everything below those is usually black boxed per implementation.

Within ASoC the current tunneled audio stuff I've seen does something
like representing the decompressor output as a DAPM input and showing
that as active when there's a stream being decoded.  Portions of the
implementation for Moorestown are in mainline in sound/soc/mid-x86,
though I'm not sure if it's all fully hooked up yet or not.

Nobody's really tried to do more yet but this may end up being the best
choice overall as there's substantial variation in how the DSPs are
structured both physically and OS wise which make the abstractions below
the userspace API level less clear.
