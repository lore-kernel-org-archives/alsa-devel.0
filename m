From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [alsa-devel] Compressed Audio Playback/Capture through ALSA framework
Date: Fri, 18 Mar 2011 11:03:57 -0500
Message-ID: <AANLkTinOmh1RBgd5g3F59ZwnF7nhR_QJ+LbGN60AkZUO@mail.gmail.com>
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
	<20110317201653.GL31411@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20110317201653.GL31411@opensource.wolfsonmicro.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Patrick Lai <plai@codeaurora.org>, "Koul, Vinod" <vinod.koul@intel.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> UCM definitely helps at runtime but in an ideal world we'd still have
> the nice pointy clicky tools that provide a beautiful GUI visualising
> the system audio setup so people could use those when configuring the
> setup for UCM.
>
>> Or are you talking about going beyond static UCM configurations into
>> something more flexible based on the Media Controller API?
>
> I can see us still needing something dynamic for things like tunneled
> audio streams where you're likely to have them being instantiated
> dynamically (with associated control), you'd want UCM to be able to work
> with this to tell the application about how these should be joined up to
> the rest of the system and so on.

I don't disagree, but I view tunneling as very difficult to implement
when you have something like PulseAudio or AudioFlinger handling all
the routing, policy and volume control. The approach based on
passthrough makes things simpler in terms of links/routing/policy.
Instead of tunneling you push compressed data as far as possible into
the sink. The application doesn't need to know what the connections
are, this can be handled at the driver/fw level
