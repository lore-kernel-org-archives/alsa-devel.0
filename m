From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v5 0/4] ASoC: tlv320aic32x4: DT support
Date: Mon, 17 Feb 2014 11:04:16 +0100
Message-ID: <1392631460-32002-1-git-send-email-mpa@pengutronix.de>
References: <1392575252-9222-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id CE656261AFC
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 11:04:41 +0100 (CET)
In-Reply-To: <1392575252-9222-1-git-send-email-mpa@pengutronix.de>
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

v5 fixes the uninitialized variable in the regulator patch.

Regards,

Markus


Changes in v5:
 - Fix uninitialized variable in regulator setup function

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
 sound/soc/codecs/tlv320aic32x4.c                   | 134 ++++++++++++++++++---
 3 files changed, 131 insertions(+), 16 deletions(-)

-- 
1.8.5.3
