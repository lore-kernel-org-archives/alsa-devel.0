From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 0/4] ASoC: tlv320aic32x4: DT support
Date: Thu, 16 Jan 2014 16:30:23 +0100
Message-ID: <1389886227-876-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 3FF51261A99
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 16:31:06 +0100 (CET)
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

Here are some more updates for the tlv320aic32x4 codec. This series fixes the
mixer controls to operate on the full range instead of only the positive range.
This depends on my other series:
"ASoC: core: volume control using signed register values"

Patch 3 adds DT support. Patch 4 adds support to control the master clock
connected to the codec.

Regards,

Markus


Markus Pargmann (4):
  ASoC: tlv320aic32x4: Use signed int mixer controls
  ASoC: tlv320aic32x4: Use gpio_is_valid
  ASoC: tlv320aic32x4: DT support
  ASoC: tlv320aic32x4: Support for master clock

 .../devicetree/bindings/sound/tlv320aic32x4.txt    | 25 +++++++
 sound/soc/codecs/tlv320aic32x4.c                   | 83 ++++++++++++++++++----
 2 files changed, 96 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/tlv320aic32x4.txt

-- 
1.8.5.2
