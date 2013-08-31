From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 0/3] ASoC: generic simple sound card DT bindings
Date: Sat, 31 Aug 2013 12:44:35 +0200
Message-ID: <1377945878-13322-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id E17C8261A1B
 for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2013 12:45:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi,

The patches were already in the fsl-ssi ac97 series. I moved the seperated
simple sound card DT driver into the existing simple card driver.

Regards,

Markus


Markus Pargmann (3):
      ASoC: generic: simple card, use private data
      ASoC: generic simple sound card DT bindings
      ASoC: fsl: Kconfig, visible config items for simple card

 .../bindings/sound/generic,simple-dt-card.txt      |  28 +++
 include/sound/simple_card.h                        |   4 -
 sound/soc/fsl/Kconfig                              |  23 ++-
 sound/soc/generic/Kconfig                          |   1 +
 sound/soc/generic/simple-card.c                    | 225 ++++++++++++++++++---
 5 files changed, 246 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/generic,simple-dt-card.txt
