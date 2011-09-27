From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: ssm2602: Support setting the
 oscillator and the clock output state
Date: Tue, 27 Sep 2011 13:30:33 +0100
Message-ID: <20110927123032.GJ4289@opensource.wolfsonmicro.com>
References: <1317114528-16736-1-git-send-email-lars@metafoo.de>
	<1317114528-16736-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EA67F103846
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 14:30:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317114528-16736-3-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 27, 2011 at 11:08:48AM +0200, Lars-Peter Clausen wrote:
> Currently the oscillator is always enabled and the clock output is always
> disabled. This patch adds support for controlling the oscillator and clock
> output state through snd_soc_dai_set_sysclk. Which makes it possible to
> disable or enable them dynamically according to the requirements of the board
> on which the CODEC is used.
> 
> This patch also slightly modifies the behavior as to when the oscillator is
> going to be disabled in low-power states. Previously it would only be disabled
> in BIAS_OFF, now it is also going to be disabled in BIAS_STANDBY, since no
> components which depend on it should be active in this state.

Is this last assumption actually true?  Things like accessory detect can
need clocks on devices even when they're idle from an audio point of
view.  Still, I've applied the patch - we can always fix up later if
something needs the clock enabling.
