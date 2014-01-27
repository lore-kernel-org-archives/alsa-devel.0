From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v3 0/6] ASoC: tlv320aic32x4: DT support
Date: Mon, 27 Jan 2014 13:03:04 +0100
Message-ID: <1390824190-18376-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 37C2A2625E0
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2014 13:03:51 +0100 (CET)
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
Cc: Markus Pargmann <mpa@pengutronix.de>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Hi,

The series adds basic DT support for the TI tlv320aic32x4 codec.
Patch 3 ("ASoC: tlv320aic32x4: Use signed int mixer controls") depends on
series
"[PATCH 0/2] ASoC: core: volume control using signed register values".

I added the remaining two patches of the "ASoC: tlv320aic32x4 bugfixes" series
to the beginning of this series to have all tlv320aic32x4 patches in one series.

Regards,

Markus


Changes in v3:
 - Rename property gpio-reset to reset-gpios
 - Use negative constants as minimum volume instead of casting to negative
   integers

Changes in v2:
 - Regulator support
 - Fix documentation for gpio property


Markus Pargmann (6):
  ASoC: tlv320aic32x4: Fix mono playback
  ASoC: tlv320aic32x4: Fix MICPGA input configuration
  ASoC: tlv320aic32x4: Use signed int mixer controls
  ASoC: tlv320aic32x4: DT support
  ASoC: tlv320aic32x4: Support for master clock
  ASoC: tlv320aic32x4: Support for regulators

 .../devicetree/bindings/sound/tlv320aic32x4.txt    |  28 ++++
 sound/soc/codecs/tlv320aic32x4.c                   | 154 ++++++++++++++++++---
 sound/soc/codecs/tlv320aic32x4.h                   |   3 +
 3 files changed, 164 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/tlv320aic32x4.txt

-- 
1.8.5.2
