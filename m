From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] Compressed Audio Playback/Capture through ALSA
 framework
Date: Thu, 17 Mar 2011 11:54:13 +0000
Message-ID: <20110317115413.GA31411@opensource.wolfsonmicro.com>
References: <4D7FB076.30300@codeaurora.org>
 <20110316103814.GA8369@sirena.org.uk>
 <1300273162.9428.10.camel@vkoul-udesk3>
 <20110316115627.GC14125@opensource.wolfsonmicro.com>
 <AANLkTinDzduAmCsTU2pD5vLnE47vgQHiTmpJTHRR6qWg@mail.gmail.com>
 <20110316175357.GB15605@opensource.wolfsonmicro.com>
 <AANLkTikomFyMpGQMgysHdj8b3i-_jjhwW+7PVK0+HZ-p@mail.gmail.com>
 <20110316180828.GC15605@opensource.wolfsonmicro.com>
 <1300328500.9428.21.camel@vkoul-udesk3>
 <4D819551.7090901@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D819551.7090901@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, pl bossart <bossart.nospam@gmail.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 16, 2011 at 10:00:01PM -0700, Patrick Lai wrote:
> On 3/16/2011 7:21 PM, Koul, Vinod wrote:

> >Wouldn't a virtual sound card solve this? I was thinking of representing
> >all DSP elements in a virtual card.

> I think it would work to certain extend but what if DSP can
> instantiate elements at run-time, how can we deal with this use case
> under current ALSA framework?

Yes, exactly - handing runtime changes is a big issue, as is
discoverability.
