From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Compressed Audio Playback/Capture through ALSA
 framework
Date: Thu, 17 Mar 2011 18:25:18 +0000
Message-ID: <20110317182518.GI31411@opensource.wolfsonmicro.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 378B524462
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 19:25:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTiknu+TvXADvbt3egRcSmTjmv2+BScfWGNyCTkjr@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Patrick Lai <plai@codeaurora.org>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 17, 2011 at 09:27:02AM -0500, pl bossart wrote:

> Wow. Run-time changes and discoverability? This sounds wild. what type
> of solutions are we talking about here?
> All the DSP implementations I've seen are pretty dumb, the firmware is
> downloaded at the request of the host when a specific service is
> requested; discoverability isn't an issue since the driver and
> possibly user-space know what's been downloaded and how the downloaded
> parts interact with the rest of the firmware.

Having the driver figure out what's going on isn't usually much of an
issue, it's letting the application know about the configuration that's
available.  In situations where the DSP can support flexible routing
(eg, if it's got multiple audio interfaces and can route or mix between
them and also to and from the CPU) with per-flow algorithm selection it
gets unmanagable if you try to show everything possible via the current
ALSA APIs.  Things get worse the more algorithms and so on the DSP can
support.
