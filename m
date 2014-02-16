From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v4 0/4] ASoC: tlv320aic32x4: DT support
Date: Sun, 16 Feb 2014 19:27:28 +0100
Message-ID: <1392575252-9222-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id AE18F261A09
 for <alsa-devel@alsa-project.org>; Sun, 16 Feb 2014 19:28:11 +0100 (CET)
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

These are the remaining patches from v3 of this version. They add master clock
and regulator support.

In v4 I added a check for the regulator dependencies and updated the binding
documentation for them. I fixed the master clock patch to shutdown the master
clock after the PLL and added another patch to shutdown all dividers before the
PLL.

Regards,

Markus


Changes in v4:
 - Fix clock shutdown order
 - Add regulator dependency checks
 - Revert the previously added tlv320aic32x4 compatible from the binding
   documentation

Markus Pargmann (4):
  ASoC: tlv320aic32x4: Support for master clock
  ASoC: tlv320aic32x4: Support for regulators
  ASoC: tlv320aic32x4: Rearrange clock tree shutdown
  Revert "ASoC: codec doc, tlv320aic3x: Add tlv320aic32x4 as compatible"

 .../devicetree/bindings/sound/tlv320aic32x4.txt    |  12 ++
 .../devicetree/bindings/sound/tlv320aic3x.txt      |   1 -
 sound/soc/codecs/tlv320aic32x4.c                   | 126 ++++++++++++++++++---
 3 files changed, 123 insertions(+), 16 deletions(-)

-- 
1.8.5.3
