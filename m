From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 0/2] ASoC: add tas5707 support
Date: Wed, 27 Jun 2018 09:39:35 +0200
Message-ID: <20180627073937.29912-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id C5F73267943
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 09:39:42 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id p11-v6so4284090wmc.4
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 00:39:42 -0700 (PDT)
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

This patchset extends the tas571x driver to support the tas5707
audio power amplifier.

Jerome Brunet (2):
  ASoC: tas571x: add tas5707 compatible
  ASoC: tas517x: add tas5707 support

Changes since v1 [0]:
 * Fixed double const as reported by kbuild robot [1]

[0]: https://lkml.kernel.org/r/20180626174056.6400-1-jbrunet@baylibre.com
[1]: https://lore.kernel.org/lkml/201806271000.j9AWAfLp%25fengguang.wu@intel.com/

 .../devicetree/bindings/sound/tas571x.txt          |   1 +
 sound/soc/codecs/Kconfig                           |   5 +-
 sound/soc/codecs/tas571x.c                         | 110 +++++++++++++++++++++
 sound/soc/codecs/tas571x.h                         |  16 +++
 4 files changed, 131 insertions(+), 1 deletion(-)

-- 
2.14.4
