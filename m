From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] Compressed Audio Playback/Capture through ALSA
 framework
Date: Wed, 16 Mar 2011 17:53:57 +0000
Message-ID: <20110316175357.GB15605@opensource.wolfsonmicro.com>
References: <4D7FB076.30300@codeaurora.org>
 <20110316103814.GA8369@sirena.org.uk>
 <1300273162.9428.10.camel@vkoul-udesk3>
 <20110316115627.GC14125@opensource.wolfsonmicro.com>
 <AANLkTinDzduAmCsTU2pD5vLnE47vgQHiTmpJTHRR6qWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinDzduAmCsTU2pD5vLnE47vgQHiTmpJTHRR6qWg@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Patrick Lai <plai@codeaurora.org>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 16, 2011 at 12:52:23PM -0500, pl bossart wrote:

> I must be missing something here. Why would this media controller API
> make things simpler? Based on what was presented at LPC, I don't
> understand this last part.

It'd make the tie up with algorithms part much easier as we could have
an interface for transferring the compressed data alone and then
externally describe how that's plumbed into any other DSP that's going
on and the physical outputs - it'd help with treating the data transfer
as a standalone problem.
