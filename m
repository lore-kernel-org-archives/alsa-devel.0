From: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v2 0/2] Add ZTE zx-aud96p22 audio codec driver
Date: Thu, 22 Jun 2017 14:51:56 +0800
Message-ID: <1498114318-32077-1-git-send-email-shawnguo@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 166B92664EB
 for <alsa-devel@alsa-project.org>; Thu, 22 Jun 2017 08:53:01 +0200 (CEST)
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

It adds the ASoC driver for zx-aud96p22 audio codec found on ZTE ZX
family SoCs.

Changes for v2:
 - Follow document control-names.rst to name controls in a standard way,
   so that user space mixer UIs know what to do with them.
 - Drop the GPIO support for an optional external amplifier, as it
   belongs to machine driver rather than codec driver.
 - Support overall power bit with a DAPM supply widget and attach it to
   both DAC and ADC components.
 - Instead of reset DAC/ADC data path in startup/shutdown hooks, handle
   it with DAPM event, so that startup/shutdown hooks get dropped
   completely.

Baoyou Xie (2):
  ASoC: add bindings for ZTE zx-aud96p22 audio codec
  ASoC: zx_aud96p22: add ZTE ZX AUD96P22 codec driver

 .../devicetree/bindings/sound/zte,zx-aud96p22.txt  |  24 ++
 sound/soc/codecs/Kconfig                           |   5 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/zx_aud96p22.c                     | 403 +++++++++++++++++++++
 4 files changed, 434 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/zte,zx-aud96p22.txt
 create mode 100644 sound/soc/codecs/zx_aud96p22.c

-- 
1.9.1
