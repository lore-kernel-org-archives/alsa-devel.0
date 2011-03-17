From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [alsa-devel] Compressed Audio Playback/Capture through ALSA framework
Date: Thu, 17 Mar 2011 14:16:23 -0500
Message-ID: <AANLkTik6zYxu70JFDRC-vUcWE6n=HZ1_ejsKkLdJrsEC@mail.gmail.com>
References: <1300273162.9428.10.camel@vkoul-udesk3>
	<20110316115627.GC14125@opensource.wolfsonmicro.com>
	<AANLkTinDzduAmCsTU2pD5vLnE47vgQHiTmpJTHRR6qWg@mail.gmail.com>
	<20110316175357.GB15605@opensource.wolfsonmicro.com>
	<AANLkTikomFyMpGQMgysHdj8b3i-_jjhwW+7PVK0+HZ-p@mail.gmail.com>
	<20110316180828.GC15605@opensource.wolfsonmicro.com>
	<1300328500.9428.21.camel@vkoul-udesk3>
	<4D819551.7090901@codeaurora.org>
	<20110317115413.GA31411@opensource.wolfsonmicro.com>
	<AANLkTiknu+TvXADvbt3egRcSmTjmv2+BScfWGNyCTkjr@mail.gmail.com>
	<20110317182518.GI31411@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20110317182518.GI31411@opensource.wolfsonmicro.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Patrick Lai <plai@codeaurora.org>, "Koul, Vinod" <vinod.koul@intel.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> Wow. Run-time changes and discoverability? This sounds wild. what ty=
pe
>> of solutions are we talking about here?
>> All the DSP implementations I've seen are pretty dumb, the firmware =
is
>> downloaded at the request of the host when a specific service is
>> requested; discoverability isn't an issue since the driver and
>> possibly user-space know what's been downloaded and how the download=
ed
>> parts interact with the rest of the firmware.
>
> Having the driver figure out what's going on isn't usually much of an
> issue, it's letting the application know about the configuration that=
's
> available. =A0In situations where the DSP can support flexible routin=
g
> (eg, if it's got multiple audio interfaces and can route or mix betwe=
en
> them and also to and from the CPU) with per-flow algorithm selection =
it
> gets unmanagable if you try to show everything possible via the curre=
nt
> ALSA APIs. =A0Things get worse the more algorithms and so on the DSP =
can
> support.

Ok I get your point and agree with the analysis.
Still, isn't UCM going to address some of the complexity by
abstracting the routing/agorithms with some predefined configurations?
Or are you talking about going beyond static UCM configurations into
something more flexible based on the Media Controller API?
--
To unsubscribe from this list: send the line "unsubscribe linux-arm-msm=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
