From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: Add ADAU1373 codec support
Date: Fri, 12 Aug 2011 10:20:46 +0900
Message-ID: <1313112046.19990.32.camel@finisterre.wolfsonmicro.main>
References: <1312948364-2587-1-git-send-email-lars@metafoo.de>
	<1312948364-2587-2-git-send-email-lars@metafoo.de>
	<20110811092702.GA18454@opensource.wolfsonmicro.com>
	<4E43AACF.5060701@metafoo.de>
	<1313068590.19990.2.camel@finisterre.wolfsonmicro.main>
	<4E4471E1.5060706@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A1C5910398E
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Aug 2011 04:49:55 +0200 (CEST)
In-Reply-To: <4E4471E1.5060706@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mike Frysinger <vapier.adi@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, device-drivers-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-08-12 at 02:20 +0200, Lars-Peter Clausen wrote:
> On 08/11/2011 03:16 PM, Mark Brown wrote:

> > Sorry, what does this actually control? I guess I've been mislead but
> > from the name of the control I'd expect it to control if the outputs
> > were physically connected as mono or stereo outputs.

> It controls how Lineout and Speaker mixers distribute the left and right input
> channels to their output channels.

Ah, I see. I guess that should really be represented in DAPM so that if
we're playing a mono signal out we figure out that both left and right
channels are connected even if there's only input for one of them,
especially for the line outputs which may be connected to external
speaker drivers or something that needs power management.
