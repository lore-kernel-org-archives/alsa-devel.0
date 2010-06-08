From: Ryan Mallon <ryan@bluewatersys.com>
Subject: [PATCH 0/3] EP93xx: Add i2s audio support
Date: Tue,  8 Jun 2010 22:01:09 +1200
Message-ID: <1275991272-30122-1-git-send-email-ryan@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hayes.bluewaternz.com (mail.bluewatersys.com [202.124.120.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 55C1624335
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Jun 2010 12:01:20 +0200 (CEST)
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
Cc: john.cooper@third-harmonic.com, chasedouglas@gmail.com, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Ryan Mallon <ryan@bluewatersys.com>, r&d4@dave-tech.it, hartleys@visionengravers.com, dhuggins@cs.cmu.edu, marshall@coolbananas.co.nz, buytenh@wantstofly.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Repost of the i2s audio series for ep93xx. Patch 2/3 is unchanged. The
core support has been modified to move setting of the SPOL and ORIDE
bits of the i2sclkdiv register, as well as the i2s pin strapping
configuration, to a new function called ep93xx_i2s_acquire which is
called from the audio board drivers.

Ryan Mallon (3):
  EP93xx: Add i2s core support
  EP93xx: Add i2s audio driver
  EP93xx: Add Snapper CL15 i2s audio support

 arch/arm/mach-ep93xx/clock.c                    |   67 +++-
 arch/arm/mach-ep93xx/core.c                     |   67 +++
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |   10 +
 arch/arm/mach-ep93xx/include/mach/platform.h    |    3 +
 arch/arm/mach-ep93xx/snappercl15.c              |    1 +
 sound/soc/Kconfig                               |    1 +
 sound/soc/Makefile                              |    1 +
 sound/soc/ep93xx/Kconfig                        |   18 +
 sound/soc/ep93xx/Makefile                       |   11 +
 sound/soc/ep93xx/ep93xx-i2s.c                   |  487 +++++++++++++++++++++++
 sound/soc/ep93xx/ep93xx-i2s.h                   |   18 +
 sound/soc/ep93xx/ep93xx-pcm.c                   |  319 +++++++++++++++
 sound/soc/ep93xx/ep93xx-pcm.h                   |   22 +
 sound/soc/ep93xx/snappercl15.c                  |  150 +++++++
 14 files changed, 1174 insertions(+), 1 deletions(-)
 create mode 100644 sound/soc/ep93xx/Kconfig
 create mode 100644 sound/soc/ep93xx/Makefile
 create mode 100644 sound/soc/ep93xx/ep93xx-i2s.c
 create mode 100644 sound/soc/ep93xx/ep93xx-i2s.h
 create mode 100644 sound/soc/ep93xx/ep93xx-pcm.c
 create mode 100644 sound/soc/ep93xx/ep93xx-pcm.h
 create mode 100644 sound/soc/ep93xx/snappercl15.c
