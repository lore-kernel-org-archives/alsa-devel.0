From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/3] Push WM8994 register cache down into mfd
Date: Mon, 28 Nov 2011 23:15:13 +0000
Message-ID: <20111128231513.GA1608@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0239D24562
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 00:15:17 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

These patches build on a series I just posted to the linux-kernel list
which use the regmap API to provide a single unified register cache over
wm8994 devices.  With those patches the ASoC register cache for the
driver becomes redundant and we may as well delete it saving us a bunch
of memory, image size and code complexity as well as giving us a nice
diffstat.

The diffstat below is for the whole series, I'm only posting the three
ASoC patches here.

The following changes since commit caca6a03d365883564885f2c1da3e88dcf65d139:

  Linux 3.2-rc3 (2011-11-23 20:20:28 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/wm8994

Mark Brown (14):
      regmap: Track if the register cache is dirty and suppress unneeded syncs
      regmap: Rename LZO cache type to compressed
      mfd: Remove some unused functions in wm8894-irq
      mfd: Add basic device tree binding for wm8994
      mfd: Convert wm8994 to devm_kzalloc()
      mfd: Disable more pulls on WM8994
      mfd: Don't hard code the reset value for WM8994 devices
      mfd: Define some additional wm8994 registers
      mfd: Add wm8994 register access and default information
      Merge branch 'topic/cache' of git://git.kernel.org/.../broonie/regmap into HEAD
      mfd: Enable register cache for wm8994 devices
      ASoC: Don't use control_data to get struct wm8994
      ASoC: Remove ASoC-specific WM8994 I/O code
      ASoC: Remove WM8994 register cache

 Documentation/devicetree/bindings/sound/wm8994.txt |   18 +
 drivers/base/regmap/internal.h                     |    1 +
 drivers/base/regmap/regcache-lzo.c                 |    2 +-
 drivers/base/regmap/regcache.c                     |   19 +
 drivers/base/regmap/regmap.c                       |    4 +-
 drivers/mfd/Makefile                               |    2 +-
 drivers/mfd/wm8994-core.c                          |  121 +-
 drivers/mfd/wm8994-irq.c                           |   10 -
 drivers/mfd/wm8994-regmap.c                        | 1218 ++++++++
 drivers/mfd/wm8994.h                               |   24 +
 include/linux/mfd/wm8994/core.h                    |    2 -
 include/linux/mfd/wm8994/pdata.h                   |    6 +
 include/linux/mfd/wm8994/registers.h               |   96 +
 include/linux/regmap.h                             |    3 +-
 sound/soc/codecs/Makefile                          |    2 +-
 sound/soc/codecs/wm8994-tables.c                   | 3147 --------------------
 sound/soc/codecs/wm8994.c                          |  216 +--
 sound/soc/codecs/wm8994.h                          |   15 +-
 18 files changed, 1494 insertions(+), 3412 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wm8994.txt
 create mode 100644 drivers/mfd/wm8994-regmap.c
 create mode 100644 drivers/mfd/wm8994.h
 delete mode 100644 sound/soc/codecs/wm8994-tables.c
