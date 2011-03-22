From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Compressed Audio Playback/Capture through ALSA
 framework
Date: Tue, 22 Mar 2011 13:01:11 +0000
Message-ID: <20110322130110.GB22583@opensource.wolfsonmicro.com>
References: <AANLkTikomFyMpGQMgysHdj8b3i-_jjhwW+7PVK0+HZ-p@mail.gmail.com>
	<20110316180828.GC15605@opensource.wolfsonmicro.com>
	<1300328500.9428.21.camel@vkoul-udesk3>
	<4D819551.7090901@codeaurora.org>
	<20110317115413.GA31411@opensource.wolfsonmicro.com>
	<AANLkTiknu+TvXADvbt3egRcSmTjmv2+BScfWGNyCTkjr@mail.gmail.com>
	<20110317182518.GI31411@opensource.wolfsonmicro.com>
	<AANLkTik6zYxu70JFDRC-vUcWE6n=HZ1_ejsKkLdJrsEC@mail.gmail.com>
	<20110317201653.GL31411@opensource.wolfsonmicro.com>
	<AANLkTinOmh1RBgd5g3F59ZwnF7nhR_QJ+LbGN60AkZUO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A5B7A2414A
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 14:01:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTinOmh1RBgd5g3F59ZwnF7nhR_QJ+LbGN60AkZUO@mail.gmail.com>
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

On Fri, Mar 18, 2011 at 11:03:57AM -0500, pl bossart wrote:

> I don't disagree, but I view tunneling as very difficult to implement
> when you have something like PulseAudio or AudioFlinger handling all
> the routing, policy and volume control. The approach based on

I don't think it's an intractible problem - I think we can get to a
point where UCM when asked for an output stream hands back either an
object of some type which wraps up a sink and any controls for that sink
has well enough for PulseAudio or AudioFlinger to figure out if it wants
to layer anything on top to provide functionality like per-stream volume
control.

> passthrough makes things simpler in terms of links/routing/policy.
> Instead of tunneling you push compressed data as far as possible into
> the sink. The application doesn't need to know what the connections
> are, this can be handled at the driver/fw level

The application doesn't need this but the audio daemon does so that we
can support multiple output paths depending on the audio type.
