From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 0/7] Refactor audio device tree handling
Date: Mon, 4 Sep 2017 16:41:47 +0100
Message-ID: <20170904154154.4395-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 471F22670B5
 for <alsa-devel@alsa-project.org>; Mon,  4 Sep 2017 17:41:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lee.jones@linaro.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

Move the audio device tree binding out into its own
documentation file, as is already done for the regulator
and extcon bindings. Then add support for a new device tree
property allowing the volume limits on the CODEC to be
configured.

It should be possible to put the patches through their
separate trees.

Thanks,
Charles

Charles Keepax (7):
  ASoC: arizona: Add new common Arizona init function
  ASoC: arizona: Add handling for audio related device tree entries
  ASoC: arizona: Add audio device tree bindings
  mfd: arizona: Remove audio related device tree code
  mfd: arizona: Remove audio bindings from MFD binding document
  ASoC: arizona: Add support for setting the output volume limits
  ASoC: arizona: Add device tree binding doc for volume limits

 Documentation/devicetree/bindings/mfd/arizona.txt  |  40 +----
 .../devicetree/bindings/sound/wlf,arizona.txt      |  53 +++++++
 MAINTAINERS                                        |   1 +
 drivers/mfd/arizona-core.c                         | 132 +---------------
 include/linux/mfd/arizona/pdata.h                  |   3 +
 sound/soc/codecs/arizona.c                         | 166 ++++++++++++++++++++-
 sound/soc/codecs/arizona.h                         |   6 +-
 sound/soc/codecs/cs47l24.c                         |  14 +-
 sound/soc/codecs/wm5102.c                          |  14 +-
 sound/soc/codecs/wm5110.c                          |  14 +-
 sound/soc/codecs/wm8997.c                          |  15 +-
 sound/soc/codecs/wm8998.c                          |  11 +-
 12 files changed, 288 insertions(+), 181 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,arizona.txt

-- 
2.11.0
