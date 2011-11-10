From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: sta32x: add workaround for ESD reset
	issue
Date: Thu, 10 Nov 2011 15:11:37 +0000
Message-ID: <20111110151136.GH3832@opensource.wolfsonmicro.com>
References: <20111109133001.GA7394@sig21.net>
	<20111109143647.GB587@opensource.wolfsonmicro.com>
	<20111109173419.GA10174@sig21.net>
	<20111109233256.GA5010@opensource.wolfsonmicro.com>
	<20111110142708.GA12808@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5319124349
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 16:11:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20111110142708.GA12808@sig21.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Johannes Stezenbach <js@sig21.net>
Cc: alsa-devel@alsa-project.org, Sven Neumann <s.neumann@raumfeld.com>, Liam Girdwood <lrg@ti.com>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 10, 2011 at 03:27:08PM +0100, Johannes Stezenbach wrote:
> On Wed, Nov 09, 2011 at 11:32:57PM +0000, Mark Brown wrote:

> > Yeah, but if it suddenly stops in the middle of playback then that'll
> > tend to register with users and if you keep it powered off at all other
> > times.

> Hm, the goal is to fix the issue without user interaction.
> The app will keep the device open and will play back
> without noticing the problem.

Well, the user is going to hear a horrific glitch anyway...

> > Right, but the bias level management is disabling the regulators for the
> > device so power loss may happen then and _STANDBY is also used to resume
> > the device after suspend when power loss may also occur.

> Ah, you're right, if the system cuts power to the sta32x during
> standby we need to restore the coef RAM after resume.  How I
> see where my code is buggy.  I also see what you mean about
> using idle_bias_off to restore the settings, namely

> 	level = codec->dapm.bias_level;
> 	BUG_ON(level == SND_SOC_BIAS_OFF);
> 	sta32x_set_bias_level(codec, SND_SOC_BIAS_OFF);
> 	sta32x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> 	if (level > SND_SOC_BIAS_STANDBY);
> 		sta32x_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
> 	if (level > SND_SOC_BIAS_PREPARE);
> 		sta32x_set_bias_level(codec, SND_SOC_BIAS_ON);

> Right?

Not really what I meant - I meant just let the framework power the
device down when it goes idle so you don't have to worry about it
resetting - though you will need to go through the
OFF->STANDBY->PREPARE->ON transition to bring the device up nicely if
you do restart while active.
