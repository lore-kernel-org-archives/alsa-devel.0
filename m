From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v2 0/4] ASoC: tlv320aic32x4: DT support
Date: Mon, 20 Jan 2014 13:05:54 +0100
Message-ID: <1390219558-25341-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 59AF52610CA
 for <alsa-devel@alsa-project.org>; Mon, 20 Jan 2014 13:06:25 +0100 (CET)
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

v2 adds a new patch to support regulators. The codec now decides on the given
regulators if LDO for AVDD should be enabled. 'ti,ldo-enable' was removed.

Regards,

Markus


Changes in v2:
 - Regulator support
 - Fix documentation for gpio property


Markus Pargmann (4):
  ASoC: tlv320aic32x4: Use signed int mixer controls
  ASoC: tlv320aic32x4: DT support
  ASoC: tlv320aic32x4: Support for master clock
  ASoC: tlv320aic32x4: Support for regulators

 .../devicetree/bindings/sound/tlv320aic32x4.txt    |  28 +++++
 sound/soc/codecs/tlv320aic32x4.c                   | 126 +++++++++++++++++++--
 2 files changed, 144 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/tlv320aic32x4.txt

-- 
1.8.5.2
