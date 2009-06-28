From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/2] alsa/soc: Fix typo in MPC5200 PSC AC97
	driver Kconfig
Date: Sun, 28 Jun 2009 01:41:52 -0600
Message-ID: <20090628074109.26905.9927.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f200.google.com (mail-px0-f200.google.com
	[209.85.216.200])
	by alsa0.perex.cz (Postfix) with ESMTP id D13CB2469C
	for <alsa-devel@alsa-project.org>;
	Sun, 28 Jun 2009 09:41:57 +0200 (CEST)
Received: by pxi38 with SMTP id 38so394447pxi.16
	for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2009 00:41:56 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jonsmirl@gmail.com, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk, timur@freescale.com
List-Id: alsa-devel@alsa-project.org

From: Grant Likely <grant.likely@secretlab.ca>

ALSA SoC drivers should be specify SND_SOC_AC97_BUS instead, not AC97_BUS.
Without SND_SOC_AC97_BUS defined, an AC97 device will not get correctly
registered on the AC97 bus, which prevents thinks like the WM9712
touchscreen driver from getting probed.

Tested against 2.6.31-rc1.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 sound/soc/fsl/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 5dbebf8..5661876 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -33,7 +33,7 @@ config SND_SOC_MPC5200_I2S
 config SND_SOC_MPC5200_AC97
 	tristate "Freescale MPC5200 PSC in AC97 mode driver"
 	depends on PPC_MPC52xx && PPC_BESTCOMM
-	select AC97_BUS
+	select SND_SOC_AC97_BUS
 	select SND_MPC52xx_DMA
 	select PPC_BESTCOMM_GEN_BD
 	help
