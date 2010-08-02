From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 0/2] soc-dapm or TWL4030: Runtime DAPM
	ordering problem
Date: Mon, 2 Aug 2010 11:27:21 +0100
Message-ID: <2EC9E5A5-E55F-4303-B6EF-2351B9440989@opensource.wolfsonmicro.com>
References: <1280732895-29010-1-git-send-email-peter.ujfalusi@nokia.com>
	(sfid-20100802_080839_029697_86A3E38F)
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 07BC924480
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 12:27:25 +0200 (CEST)
In-Reply-To: <1280732895-29010-1-git-send-email-peter.ujfalusi@nokia.com>
	(sfid-20100802_080839_029697_86A3E38F)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On 2 Aug 2010, at 08:08, Peter Ujfalusi wrote:

> I'm facing the following problem with the TWL4030 codec:
> The order of DAPM register write order different in case, when I start a capture
> operation after setting up the routing, and when I change the routing during
> active capture.
> This is really visible, when I want to record from the digital microphone
> interface.

> Because of this ordering problem, when during active capture I switch to the
> digital mic from analog path, the codec would enable analog bias (2.2 volts) to
> the digital mic for a moment, and than later it will switch to the correct
> digital mic bias (1.8 volts).

It'd be really helpful in this section if you could've said what the actual problem you see is...

> Since the twl4030 codec needs several bits in different registers to be changed,
> when I change between analog and digital input it is not that obvious how to get
> the correct ordering all the time.
> 
> I have two different ways to fix this:
> A: by reordering how DAPM would handle control changes (patch 1)
> B: by changing TWL4030 internal DAPM widgets (patch 2)

...you even start proposing solutions before describing what they're fixing :)

Just summarising briefly since I can't see a clear problem statement I think what you're saying is that DAPM applies control changes for routing before checking for power up changes but for some TWL4030 routes it would be more convenient to only write the changes for route setup after changing the power state?

I think this is best handled in TWL4030, or possibly with some sort of optional flag in DAPM which TWL4030 and anything else could then use. 

With most things it's safer to implement the route change first - especially in the analogue domain route changes tend to introduce DC offsets so it's safer to set the route prior to powering up so the offset changes don't get amplified. This is also very important when doing DC offset correction, obviously there it's important to measure the offset of the path you're actually trying to run rather than using whatever path was there before.
