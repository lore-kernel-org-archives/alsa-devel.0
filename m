From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v6 0/4] ASoC: tlv320aic32x4: DT support
Date: Thu, 20 Feb 2014 18:22:57 +0100
Message-ID: <1392916981-9333-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 8D3C3265847
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 18:23:28 +0100 (CET)
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

This series adds master clock and regulators to the tlv320aic32x4 driver.

In v6 I added error handling for the regulator setup. master clock is required
for the driver now but still optional in the DT bindings.

Regards,

Markus


Markus Pargmann (4):
  ASoC: tlv320aic32x4: Support for master clock
  ASoC: tlv320aic32x4: Support for regulators
  ASoC: tlv320aic32x4: Rearrange clock tree shutdown
  Asoc: codecs: Remove tlv320aic32x4 from compatibles of tlv320aic3x

 .../devicetree/bindings/sound/tlv320aic32x4.txt    |  12 ++
 .../devicetree/bindings/sound/tlv320aic3x.txt      |   1 -
 sound/soc/codecs/tlv320aic32x4.c                   | 177 +++++++++++++++++++--
 3 files changed, 173 insertions(+), 17 deletions(-)

-- 
1.8.5.3
