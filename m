From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] Compressed Audio Playback/Capture through ALSA
 framework
Date: Thu, 17 Mar 2011 20:16:54 +0000
Message-ID: <20110317201653.GL31411@opensource.wolfsonmicro.com>
References: <AANLkTinDzduAmCsTU2pD5vLnE47vgQHiTmpJTHRR6qWg@mail.gmail.com>
 <20110316175357.GB15605@opensource.wolfsonmicro.com>
 <AANLkTikomFyMpGQMgysHdj8b3i-_jjhwW+7PVK0+HZ-p@mail.gmail.com>
 <20110316180828.GC15605@opensource.wolfsonmicro.com>
 <1300328500.9428.21.camel@vkoul-udesk3>
 <4D819551.7090901@codeaurora.org>
 <20110317115413.GA31411@opensource.wolfsonmicro.com>
 <AANLkTiknu+TvXADvbt3egRcSmTjmv2+BScfWGNyCTkjr@mail.gmail.com>
 <20110317182518.GI31411@opensource.wolfsonmicro.com>
 <AANLkTik6zYxu70JFDRC-vUcWE6n=HZ1_ejsKkLdJrsEC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTik6zYxu70JFDRC-vUcWE6n=HZ1_ejsKkLdJrsEC@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: Patrick Lai <plai@codeaurora.org>, "Koul, Vinod" <vinod.koul@intel.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 17, 2011 at 02:16:23PM -0500, pl bossart wrote:

> Still, isn't UCM going to address some of the complexity by
> abstracting the routing/agorithms with some predefined configurations?

UCM definitely helps at runtime but in an ideal world we'd still have
the nice pointy clicky tools that provide a beautiful GUI visualising
the system audio setup so people could use those when configuring the
setup for UCM.

> Or are you talking about going beyond static UCM configurations into
> something more flexible based on the Media Controller API?

I can see us still needing something dynamic for things like tunneled
audio streams where you're likely to have them being instantiated
dynamically (with associated control), you'd want UCM to be able to work
with this to tell the application about how these should be joined up to
the rest of the system and so on.
