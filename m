From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH 00/15]  twl6040 updates
Date: Mon, 6 Dec 2010 18:17:38 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4CFBCC5@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id F0C29103945
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 01:17:41 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This patch series contains several fixes and adds new features
for twl6040 (phoenix) codec.

Francois Mazard (1):
  ASoC: twl6040: Fix analog Mic L & R mux controls

Jorge Eduardo Candelaria (3):
  ASoC: twl6040: Add headset and handset mux controls
  ASoC: twl6040: Clear interrupt status at boot time
  ASoC: twl6040: Increase timeout for power up

Margarita Olaya Cabrera (9):
  ASoC: twl6040: Update twl IO macro
  ASoC: twl6040: Modify the IRQ handler
  ASoC: twl6040: Support all DAIs
  ASoC: twl6040: Restore bias level at resume
  ASoC: twl6040: Fix PCM error handling ops
  ASoC: twl6040: Support other sample rates.
  ASoC: twl6040: Enable automatic power for phoenix 1.1
  ASoC: twl6040: Add ramp up/down volume for HS and HF
  ASoC: twl6040: Fix TLV dB step values for gains.

Misael Lopez Cruz (2):
  ASoC: twl6040: Enable plug detection interrupts
  ASoC: twl6040: Use correct offset for LineInAmp Right

 sound/soc/codecs/twl6040.c |  815 +++++++++++++++++++++++++++++++++++++-------
 sound/soc/codecs/twl6040.h |    1 +
 2 files changed, 695 insertions(+), 121 deletions(-)

Regards,
Margarita
