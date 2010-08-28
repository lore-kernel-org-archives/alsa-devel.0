From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: uda1380: make driver more
	powersave-friendly
Date: Sat, 28 Aug 2010 09:56:36 +0100
Message-ID: <20100828085627.GA9324@opensource.wolfsonmicro.com>
References: <1282981776-10014-1-git-send-email-anarsoul@gmail.com>
	<1282981776-10014-2-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 98F74245DF
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Aug 2010 10:56:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1282981776-10014-2-git-send-email-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 28, 2010 at 10:49:35AM +0300, Vasily Khoruzhick wrote:
> Disable some codec modules in standby mode, completely disable
> codec in off mode to save some power.

> Fix suspend/resume: mark mixer regs as dirty on resume to
> restore mixer values, otherwise driver produces no sound
> (master is muted by default).

This sounds like there's a pre-existing bug where the register cache
defaults don't correspond to the chip defaults.  In general we always
keep the initial chip defaults for user visible controls in the driver
and let the application layer set the values it wants.  This avoids
having to worry about defaults being inappropriate for some systems (eg,
volumes far too loud or bad output path selection) - normally the chip
defaults will be reasonable for first power up.

The code itself looks good from a quick read through.
