From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [alsa-devel] Compressed Audio Playback/Capture through ALSA framework
Date: Thu, 17 Mar 2011 09:27:02 -0500
Message-ID: <AANLkTiknu+TvXADvbt3egRcSmTjmv2+BScfWGNyCTkjr@mail.gmail.com>
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
	<20110317115413.GA31411@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20110317115413.GA31411@opensource.wolfsonmicro.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Patrick Lai <plai@codeaurora.org>, "Koul, Vinod" <vinod.koul@intel.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> >Wouldn't a virtual sound card solve this? I was thinking of representing
>> >all DSP elements in a virtual card.
>
>> I think it would work to certain extend but what if DSP can
>> instantiate elements at run-time, how can we deal with this use case
>> under current ALSA framework?
>
> Yes, exactly - handing runtime changes is a big issue, as is
> discoverability.

Wow. Run-time changes and discoverability? This sounds wild. what type
of solutions are we talking about here?
All the DSP implementations I've seen are pretty dumb, the firmware is
downloaded at the request of the host when a specific service is
requested; discoverability isn't an issue since the driver and
possibly user-space know what's been downloaded and how the downloaded
parts interact with the rest of the firmware.
