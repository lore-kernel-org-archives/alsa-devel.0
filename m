From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Strange control interactions on Tegra Harmony
Date: Thu, 27 Jan 2011 18:49:28 +0000
Message-ID: <20110127184927.GC12717@opensource.wolfsonmicro.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0310C8DD47@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AC5AB103806
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 19:49:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0310C8DD47@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: dp@opensource.wolfsonmicro.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 27, 2011 at 10:20:22AM -0800, Stephen Warren wrote:

> The Right Speaker Right Bypass control works the first and all subsequent
> times. Perhaps that's something to do with it being the last entry in
> wm8903.c's right_speaker_mixer[] array?

Possibly, though given the way DAPM processes those arrays I'd be a bit
surprised if it made a difference.  More likely to be that the bypass
paths is one of the simpler and more direct paths in the CODEC.

> I briefly started to debug this, and notice that the SND_SOC_DAPM_SPK event
> function isn't being called at all in the cases where muting doesn't toggle
> as expected.

I noticed something similar while developing a new driver the other day
but didn't get a chance to chase it down yet.  It's likely something got
confused, possibly with the recent changes to propagate DAPM state
between contexts, but that's just a guess as it's the most invasive
thing that happened there recently.

> Can you comment on this? I can certainly continue to debug it, but I figured
> it might be immediately obvious to you what the problem was e.g. if the same
> thing had happened on other platforms/codecs.

I'm on holiday tomorrow so can't have a proper look at live systems - if
you've not got anywhere by Monday I should be able to sort it then.
