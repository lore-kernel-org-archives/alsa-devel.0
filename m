From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH 0/2] add syscon property to binding document
Date: Fri, 16 Mar 2018 16:08:11 +0900
Message-ID: <20180316070813.17969-1-suzuki.katsuhiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by alsa0.perex.cz (Postfix) with ESMTP id 708C926738C
 for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2018 08:08:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>
Cc: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-arm-kernel@lists.infradead.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds syscon property for specifying soc-glue core.

The soc-glue core is used for changing the state of S/PDIF signal
output pin to signal output state or Hi-Z state. After resetting of
SoC Hi-Z state is selected.

Currently, we set this mode in local changed U-Boot or some
bootloaders fixedly. This patch removes dependencies of bootloader
from UniPhier audio system driver.

Katsuhiro Suzuki (2):
  ASoC: uniphier: add syscon property to binding document
  ASoC: uniphier: add syscon property for UniPhier sound system

 .../devicetree/bindings/sound/uniphier,aio.txt      |  8 ++++++++
 sound/soc/uniphier/aio-core.c                       | 21 +++++++++++++++++++++
 sound/soc/uniphier/aio-cpu.c                        | 11 +++++++++++
 sound/soc/uniphier/aio-reg.h                        |  3 +++
 sound/soc/uniphier/aio.h                            |  2 ++
 5 files changed, 45 insertions(+)

-- 
2.16.2
