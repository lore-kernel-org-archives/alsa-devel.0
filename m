From: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 0/2] Add ZTE ZTE zx-aud96p22 audio codec driver
Date: Sat, 17 Jun 2017 22:09:32 +0800
Message-ID: <1497708574-22380-1-git-send-email-shawnguo@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 467F0266838
 for <alsa-devel@alsa-project.org>; Sat, 17 Jun 2017 16:10:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Baoyou Xie <xie.baoyou@sanechips.com.cn>, Xin Zhou <zhou.xin8@sanechips.com.cn>, Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

From: Shawn Guo <shawn.guo@linaro.org>

This is a pick-up of Baoyou's zx-aud96p22 audio codec driver
submission [1], with quite some significant rework as below.

 - Instead of hard-coding the GPIO used to control external amplifier,
   use generic devm_gpiod_get_optional() call to retrieve the GPIO
   defined in device tree.
 - Rather than directly using I2C bus calls, use REGMAP_I2C interface
   which is more common for accessing codec register via I2C bus.
 - Use snd_kcontrol_new infrastructural for Volume and Mute control.
 - Use DAPM widget and route for various power bits control.
 - A lot of code cleanups

[1] https://lkml.org/lkml/2017/2/15/170

Baoyou Xie (2):
  ASoC: add bindings for ZTE zx-aud96p22 audio codec
  ASoC: zx_aud96p22: add ZTE ZX AUD96P22 codec driver

 .../devicetree/bindings/sound/zte,zx-aud96p22.txt  |  28 ++
 sound/soc/codecs/Kconfig                           |   5 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/zx_aud96p22.c                     | 425 +++++++++++++++++++++
 4 files changed, 460 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/zte,zx-aud96p22.txt
 create mode 100644 sound/soc/codecs/zx_aud96p22.c

-- 
1.9.1
