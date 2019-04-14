From: Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 2/2] ASoC: mpc5200_psc_i2s: Fix invalid license ID
Date: Sun, 14 Apr 2019 22:14:50 +0300
Message-ID: <20190414191450.18377-3-andradanciu1997@gmail.com>
References: <20190414191450.18377-1-andradanciu1997@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190414191450.18377-1-andradanciu1997@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, daniel.baluta@gmail.com
List-Id: alsa-devel@alsa-project.org

As the file had no other license notice/reference, it falls under the
project license and therefore the proper SPDX id is: GPL-2.0-only

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Fixes: 864a8472c4412 ("ASoC: mpc5200_psc_i2s: Switch to SPDX identifier")
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
---
 sound/soc/fsl/mpc5200_psc_i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index 6de97461ba25..9bc01f374b39 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL
+// SPDX-License-Identifier: GPL-2.0-only
 //
 // Freescale MPC5200 PSC in I2S mode
 // ALSA SoC Digital Audio Interface (DAI) driver
-- 
2.11.0
