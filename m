From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/2] Add es7134 DAC driver support
Date: Mon, 27 Feb 2017 16:47:22 +0100
Message-ID: <20170227154724.13724-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 49BC5266CCC
 for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2017 16:47:32 +0100 (CET)
Received: by mail-wm0-f46.google.com with SMTP id v77so64228678wmv.1
 for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2017 07:47:32 -0800 (PST)
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

This patchset adds the support for the es7134 from Everest Semiconductor.
The es7134 is simple i2s DAC with no configuration interface.
It has been tested on Amlogic's meson-gxbb-p200 board.

Jerome Brunet (2):
  ASoC: es7134: add es7134 DAC driver
  ASoC: es7134: add dt-bindings for the es7134 dac

 .../devicetree/bindings/sound/everest,es7134.txt   |  10 ++
 sound/soc/codecs/Kconfig                           |   4 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/es7134.c                          | 116 +++++++++++++++++++++
 4 files changed, 132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es7134.txt
 create mode 100644 sound/soc/codecs/es7134.c

-- 
2.9.3
