From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCHv2 0/3] regmap: Use different lockdep class for each regmap init call
Date: Wed,  8 Jul 2015 14:30:15 +0800
Message-ID: <1436337018-32464-1-git-send-email-drinkcat@chromium.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Ingo Molnar <mingo@redhat.com>, Arjan van de Ven <arjan@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Nicolas Boichat <drinkcat@chromium.org>, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Lee Jones <lee.jones@linaro.org>, Maxime Coquelin <maxime.coquelin@st.com>, Ajit
List-Id: alsa-devel@alsa-project.org

Second version. Small fixup in the regmap patch itself [3/3] (the
declaration of __devm_regmap_init_ac97 was missing lock_key/name
parameters).

Also, there are 2 drivers that are using function pointers named
"regmap_init", which causes problems as it is now a macro: put these
in parentheses to prevent the preprocessor from substituting them.

Patches 1+2 should be pushed first to avoid breaking git bissect.

Compile tested with allyesconfig on x86_64 and arm.

Nicolas Boichat (3):
  mfd: vexpress: Add parentheses around bridge->ops->regmap_init call
  thermal: sti: Add parentheses around bridge->ops->regmap_init call
  regmap: Use different lockdep class for each regmap init call

 drivers/base/regmap/regmap-ac97.c |  22 +++--
 drivers/base/regmap/regmap-i2c.c  |  22 +++--
 drivers/base/regmap/regmap-mmio.c |  27 ++++--
 drivers/base/regmap/regmap-spi.c  |  22 +++--
 drivers/base/regmap/regmap-spmi.c |  44 +++++----
 drivers/base/regmap/regmap.c      |  31 +++---
 drivers/bus/vexpress-config.c     |   2 +-
 drivers/thermal/st/st_thermal.c   |   2 +-
 include/linux/regmap.h            | 192 ++++++++++++++++++++++++++++----------
 9 files changed, 252 insertions(+), 112 deletions(-)

-- 
2.4.3.573.g4eafbef

