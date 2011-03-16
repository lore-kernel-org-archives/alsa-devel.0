From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] Compressed Audio Playback/Capture through ALSA
 framework
Date: Wed, 16 Mar 2011 18:08:28 +0000
Message-ID: <20110316180828.GC15605@opensource.wolfsonmicro.com>
References: <4D7FB076.30300@codeaurora.org>
 <20110316103814.GA8369@sirena.org.uk>
 <1300273162.9428.10.camel@vkoul-udesk3>
 <20110316115627.GC14125@opensource.wolfsonmicro.com>
 <AANLkTinDzduAmCsTU2pD5vLnE47vgQHiTmpJTHRR6qWg@mail.gmail.com>
 <20110316175357.GB15605@opensource.wolfsonmicro.com>
 <AANLkTikomFyMpGQMgysHdj8b3i-_jjhwW+7PVK0+HZ-p@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikomFyMpGQMgysHdj8b3i-_jjhwW+7PVK0+HZ-p@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Patrick Lai <plai@codeaurora.org>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 16, 2011 at 01:00:09PM -0500, pl bossart wrote:
> On Wed, Mar 16, 2011 at 12:53 PM, Mark Brown

> > It'd make the tie up with algorithms part much easier as we could have
> > an interface for transferring the compressed data alone and then
> > externally describe how that's plumbed into any other DSP that's going
> > on and the physical outputs - it'd help with treating the data transfer
> > as a standalone problem.

> Still not convinced. Why would you need to 'externally describe' how
> compressed data is linked to post-processing. It's all part of DSP
> firmware, why should anyone care how the decoder provides data to
> post-processes? You can control post-processes with ALSA controls as
> for regular PCM.

The problem is figuring out which controls are where and what can be
joined up with what.  This is a problem with regular PCM too but it gets
much worse when everything is virtual.  Media controller should provide
a route to allowing applications to figure out what's going on in the
hardware.
