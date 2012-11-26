From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 00/14] ASoC: Use devm_* APIs
Date: Mon, 26 Nov 2012 17:19:33 +0530
Message-ID: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f51.google.com (mail-da0-f51.google.com
 [209.85.210.51])
 by alsa0.perex.cz (Postfix) with ESMTP id EE65026507A
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 12:56:14 +0100 (CET)
Received: by mail-da0-f51.google.com with SMTP id i30so2953117dad.38
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 03:56:14 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, sachin.kamat@linaro.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

This series is build tested against the for-next branch of
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
tree.

Sachin Kamat (14):
  ASoC: wm8350: Use devm_regulator_bulk_get
  ASoC: wm8962: Use devm_regulator_bulk_get
  ASoC: wm8400: Use devm_regulator_bulk_get
  ASoC: wm8993: Use devm_regulator_bulk_get
  ASoC: ak4535: Use devm_regmap_init_i2c()
  ASoC: da7210: Use devm_regmap_init_i2c()
  ASoC: lm49453: Use devm_regmap_init_i2c()
  ASoC: max9768: Use devm_regmap_init_i2c()
  ASoC: wm8955: Use devm_regmap_init_i2c()
  ASoC: wm8960: Use devm_regmap_init_i2c()
  ASoC: wm8962: Use devm_regmap_init_i2c()
  ASoC: wm8978: Use devm_regmap_init_i2c()
  ASoC: wm8993: Use devm_regmap_init_i2c()
  ASoC: wm9081: Use devm_regmap_init_i2c()

 sound/soc/codecs/ak4535.c  |    7 +------
 sound/soc/codecs/da7210.c  |   13 ++-----------
 sound/soc/codecs/lm49453.c |   10 ++--------
 sound/soc/codecs/max9768.c |    7 ++-----
 sound/soc/codecs/wm8350.c  |    4 +---
 sound/soc/codecs/wm8400.c  |   14 +++-----------
 sound/soc/codecs/wm8955.c  |   11 +----------
 sound/soc/codecs/wm8960.c  |    2 +-
 sound/soc/codecs/wm8962.c  |   24 ++++++++----------------
 sound/soc/codecs/wm8978.c  |   13 +++----------
 sound/soc/codecs/wm8993.c  |   14 ++++----------
 sound/soc/codecs/wm9081.c  |   22 ++++++----------------
 12 files changed, 34 insertions(+), 107 deletions(-)

-- 
1.7.4.1
