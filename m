From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/4] ASoC: AC'97 regmap support and conversion
Date: Tue, 18 Nov 2014 19:45:50 +0100
Message-ID: <1416336354-32148-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-252.synserver.de (smtp-out-252.synserver.de
 [212.40.185.252])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B95C26047F
 for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2014 19:45:55 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This series contains the final pieces for the AC'97 conversion to regmap.
The first patch adds a regmap backend for AC'97 devices that will use the
AC'97 bus of the device to perform reads and writes. The second patch adds a
bit of plumbing to the ASoC framework that it makes it possible to assign a
regmap instance to ASoC CODEC (or component) after it has been registered.
This is necessary since for AC'97 drivers we allocate the AC'97 device in
the CODEC drivers probe callback. For now the series only converts the
ad1980 driver, others might follow later.

- Lars 

Lars-Peter Clausen (3):
  ASoC: Add helper functions for deferred regmap setup
  ASoC: ad1980: Convert to regmap
  ASoC: ad1980: Remove ac97_read/ac97_write wrappers

Mark Brown (1):
  regmap: ac97: Add generic AC'97 callbacks

 drivers/base/regmap/Kconfig       |   5 +-
 drivers/base/regmap/Makefile      |   1 +
 drivers/base/regmap/regmap-ac97.c | 114 +++++++++++++++++++++++++
 include/linux/regmap.h            |   7 ++
 include/sound/soc.h               |  35 ++++++++
 sound/soc/codecs/Kconfig          |   1 +
 sound/soc/codecs/ad1980.c         | 173 +++++++++++++++++++++-----------------
 sound/soc/soc-core.c              |  58 ++++++++++---
 8 files changed, 306 insertions(+), 88 deletions(-)
 create mode 100644 drivers/base/regmap/regmap-ac97.c

-- 
1.8.0
