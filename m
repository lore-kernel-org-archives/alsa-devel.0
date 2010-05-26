From: Ryan Mallon <ryan@bluewatersys.com>
Subject: [RFC PATCH v2 0/3] ep93xx i2s audio
Date: Wed, 26 May 2010 17:09:45 +1200
Message-ID: <1274850588-30460-1-git-send-email-ryan@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hayes.bluewaternz.com (mail.bluewatersys.com [202.124.120.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 2371124359
	for <alsa-devel@alsa-project.org>;
	Wed, 26 May 2010 07:09:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: john.cooper@third-harmonic.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, chasedouglas@gmail.com, Ryan Mallon <ryan@bluewatersys.com>, r&d4@dave-tech.it, hartleys@visionengravers.com, dhuggins@cs.cmu.edu, buytenh@wantstofly.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

The following patch series adds support for i2s audio on the ep93xx,
with the Snapper CL15 used as an example implementation. 

I have created psuedo clocks for sclk and lrclk as suggested by
Hartley/Mark. This moves the sdiv/lrdiv calculation into
ep93xx_i2s_hw_parms. The ep93xx documentation implies that lrclk is
gated for unused bits (ie if lrdiv > word length). If this is true for
all ep93xx i2s setups then the lrclk/sclk's could be replaced by a
single audio rate clock.

I have fixed the enabling/disabling of the i2s peripheral, which
corrects the problem I was having with playback sometimes resulting in
noise.

I have also made a number of changes suggested from the first round of
patches.

Ryan Mallon (3):
  ep93xx i2s audio driver
  ep93xx i2s core support
  ep93xx i2s audio snapper cl15 support

 arch/arm/mach-ep93xx/clock.c                    |   69 ++++-
 arch/arm/mach-ep93xx/core.c                     |   31 ++
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |   10 +
 arch/arm/mach-ep93xx/include/mach/platform.h    |    1 +
 arch/arm/mach-ep93xx/snappercl15.c              |    1 +
 sound/soc/Kconfig                               |    1 +
 sound/soc/Makefile                              |    1 +
 sound/soc/ep93xx/Kconfig                        |   18 +
 sound/soc/ep93xx/Makefile                       |   11 +
 sound/soc/ep93xx/ep93xx-i2s.c                   |  489 +++++++++++++++++++++++
 sound/soc/ep93xx/ep93xx-i2s.h                   |   25 ++
 sound/soc/ep93xx/ep93xx-pcm.c                   |  323 +++++++++++++++
 sound/soc/ep93xx/ep93xx-pcm.h                   |   22 +
 sound/soc/ep93xx/snappercl15.c                  |  143 +++++++
 14 files changed, 1144 insertions(+), 1 deletions(-)
 create mode 100644 sound/soc/ep93xx/Kconfig
 create mode 100644 sound/soc/ep93xx/Makefile
 create mode 100644 sound/soc/ep93xx/ep93xx-i2s.c
 create mode 100644 sound/soc/ep93xx/ep93xx-i2s.h
 create mode 100644 sound/soc/ep93xx/ep93xx-pcm.c
 create mode 100644 sound/soc/ep93xx/ep93xx-pcm.h
 create mode 100644 sound/soc/ep93xx/snappercl15.c
