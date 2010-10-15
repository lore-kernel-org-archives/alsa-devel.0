From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v3 0/3] ASoC AC97 audio support for ep93xx
Date: Fri, 15 Oct 2010 10:57:19 +0100
Message-ID: <1287136639.3271.3.camel@odin>
References: <cover.1287066937.git.mika.westerberg@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DBE9103C11
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 11:57:28 +0200 (CEST)
Received: by wyb32 with SMTP id 32so468421wyb.38
	for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2010 02:57:28 -0700 (PDT)
In-Reply-To: <cover.1287066937.git.mika.westerberg@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mika Westerberg <mika.westerberg@iki.fi>
Cc: alsa-devel@alsa-project.org, martinwguy@gmail.com, broonie@opensource.wolfsonmicro.com, hsweeten@visionengravers.com, ryan@bluewatersys.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-10-14 at 17:49 +0300, Mika Westerberg wrote:
> Hi,
> 
> This series adds AC97 audio support for Cirrus Logic EP93xx family SoCs. Example
> machine driver is for Simplemachines Sim.One (which is the only hardware that I
> have which has AC97 codec).
> 
> Changes the previous version:
> 	- rebased against latest ASoC tree (added support for
> 	  multicomponent ASoC)
> 	- fixed according comments by Mark Brown
> 	- patch 1/4 (DMA fix) is now in ARM tree so dropped from
> 	  this series.
> 
> Thanks,
> MW
> 
> Mika Westerberg (3):
>   ASoC: add ep93xx AC97 audio driver
>   ARM: ep93xx: add AC97 platform support
>   ASoC: ep93xx: add Simplemachines Sim.One AC97 audio support
> 
>  arch/arm/mach-ep93xx/core.c                     |   34 ++
>  arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    1 +
>  arch/arm/mach-ep93xx/include/mach/platform.h    |    1 +
>  arch/arm/mach-ep93xx/simone.c                   |    1 +
>  sound/soc/ep93xx/Kconfig                        |   16 +-
>  sound/soc/ep93xx/Makefile                       |    4 +
>  sound/soc/ep93xx/ep93xx-ac97.c                  |  468 +++++++++++++++++++++++
>  sound/soc/ep93xx/simone.c                       |   89 +++++
>  8 files changed, 613 insertions(+), 1 deletions(-)
>  create mode 100644 sound/soc/ep93xx/ep93xx-ac97.c
>  create mode 100644 sound/soc/ep93xx/simone.c

All

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
