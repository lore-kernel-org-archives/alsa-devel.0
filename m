From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 0/3] Add wm8997 driver
Date: Wed, 12 Jun 2013 17:29:17 +0100
Message-ID: <1371054560-28770-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3E16B2610CA
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2013 18:38:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This series of patches adds support for the Wolfson wm8997 audio hub.

Thanks,
Charles


Charles Keepax (3):
  mfd: arizona: Integrate wm8997 into Arizona mfd
  ASoC: wm8997: Initial CODEC driver
  gpio: arizona: Add wm8997 support to probe

 drivers/gpio/gpio-arizona.c      |    1 +
 drivers/mfd/Kconfig              |    6 +
 drivers/mfd/Makefile             |    3 +
 drivers/mfd/arizona-core.c       |   26 +
 drivers/mfd/arizona-i2c.c        |    6 +
 drivers/mfd/arizona-irq.c        |    8 +
 drivers/mfd/arizona.h            |    5 +
 drivers/mfd/wm8997-tables.c      | 1525 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/arizona/core.h |    2 +
 sound/soc/codecs/Kconfig         |    6 +
 sound/soc/codecs/Makefile        |    2 +
 sound/soc/codecs/arizona.c       |   13 +-
 sound/soc/codecs/wm8997.c        | 1008 +++++++++++++++++++++++++
 sound/soc/codecs/wm8997.h        |   23 +
 14 files changed, 2631 insertions(+), 3 deletions(-)
 create mode 100644 drivers/mfd/wm8997-tables.c
 create mode 100644 sound/soc/codecs/wm8997.c
 create mode 100644 sound/soc/codecs/wm8997.h

-- 
1.7.2.5
