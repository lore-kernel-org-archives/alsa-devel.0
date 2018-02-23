From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH v2 0/2] ASoC: add support for ROHM BD28623 codec
Date: Fri, 23 Feb 2018 10:17:15 +0900
Message-ID: <20180223011717.2799-1-suzuki.katsuhiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by alsa0.perex.cz (Postfix) with ESMTP id 623FE267845
 for <alsa-devel@alsa-project.org>; Fri, 23 Feb 2018 02:17:28 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-arm-kernel@lists.infradead.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds support for ROHM BD28623MUV class D speaker
amplifier codec driver.

This driver only refers information of HW specification document
that can be derivered at website of ROHM.

http://www.rohm.com/web/global/products/-/product/BD28623MUV

---

Changes in v2:
  - Change gpio properties to optional
  - Change VCCA, VCCP-supply to mandatory
  - Fix lisence comment style
  - Use _cansleep() version for manipulating GPIO
  - Use ASoC component remove() function instead of
    platform remove() function to power off this IC
  - Remove update function that was just alias of gpiod_set_value


Katsuhiro Suzuki (2):
  ASoC: add DT bindings documentation for ROHM BD28623 codec
  ASoC: support ROHM BD28623 codec

 .../devicetree/bindings/sound/rohm,bd28623.txt     |  29 +++
 sound/soc/codecs/Kconfig                           |   8 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/bd28623.c                         | 242 +++++++++++++++++++++
 4 files changed, 281 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rohm,bd28623.txt
 create mode 100644 sound/soc/codecs/bd28623.c

-- 
2.16.1
