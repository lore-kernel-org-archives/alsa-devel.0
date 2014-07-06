From: Himangi Saraogi <himangi774@gmail.com>
Subject: [PATCH 0/5] Introduce a managed function for gpio_request_array
Date: Sun, 6 Jul 2014 23:16:09 +0530
Message-ID: <cover.1404665589.git.himangi774@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-doc-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Russell King <linux@arm.linux.org.uk>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-arm-kernel@lists.infradead.org, Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>
Cc: julia.lawall@lip6.fr
List-Id: alsa-devel@alsa-project.org

This patchset intoduces a new managed interface devm_gpio_request_array,
adds it in the documentation and its declaration in the gpio.h include
file. Some cases of gpio_request_array are changed to
devm_gpio_request_array.

Himangi Saraogi (5):
  gpiolib: devres: Introduce the function devm_request_gpio_array
  ASoC: wm1250-ev1: Use devm_gpio_request_array
  ASoC: pxa: Use devm_gpio_request_array
  ASoC: pxa: e800_wm9712: Introduce the use of devm_gpio_request_array
  ASoC: pxa/hx4700: Introduce the use of devm_gpio_request_array

 Documentation/driver-model/devres.txt |  1 +
 drivers/gpio/devres.c                 | 21 +++++++++++++++++++++
 include/linux/gpio.h                  |  2 ++
 sound/soc/codecs/wm1250-ev1.c         | 24 +++++-------------------
 sound/soc/pxa/e740_wm9705.c           |  9 +++------
 sound/soc/pxa/e800_wm9712.c           |  9 +++------
 sound/soc/pxa/hx4700.c                | 12 +++---------
 7 files changed, 38 insertions(+), 40 deletions(-)

-- 
1.9.1

