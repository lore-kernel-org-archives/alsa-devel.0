From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/2] sound/soc: remove BROKEN from Efika and
	pcm030 fabric	drivers
Date: Sun, 28 Jun 2009 01:42:06 -0600
Message-ID: <20090628074158.26905.36950.stgit@localhost.localdomain>
References: <20090628074109.26905.9927.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f200.google.com (mail-px0-f200.google.com
	[209.85.216.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D890246A7
	for <alsa-devel@alsa-project.org>;
	Sun, 28 Jun 2009 09:42:09 +0200 (CEST)
Received: by mail-px0-f200.google.com with SMTP id 38so394447pxi.16
	for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2009 00:42:09 -0700 (PDT)
In-Reply-To: <20090628074109.26905.9927.stgit@localhost.localdomain>
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

The needed spin_event_timeout() macro is now merged in from the
powerpc tree, so these drivers are no longer broken.  This reverts
commit 0c0e09e21a9e7bc6ca54e06ef3d497255ca26383 (ASoC: Mark MPC5200
AC97 as BROKEN until PowerPC merge issues are resolved)

Tested against 2.6.31-rc1.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 sound/soc/fsl/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 5661876..8cb65cc 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -41,7 +41,7 @@ config SND_SOC_MPC5200_AC97
 
 config SND_MPC52xx_SOC_PCM030
 	tristate "SoC AC97 Audio support for Phytec pcm030 and WM9712"
-	depends on PPC_MPC5200_SIMPLE && BROKEN
+	depends on PPC_MPC5200_SIMPLE
 	select SND_SOC_MPC5200_AC97
 	select SND_SOC_WM9712
 	help
@@ -50,7 +50,7 @@ config SND_MPC52xx_SOC_PCM030
 
 config SND_MPC52xx_SOC_EFIKA
 	tristate "SoC AC97 Audio support for bbplan Efika and STAC9766"
-	depends on PPC_EFIKA && BROKEN
+	depends on PPC_EFIKA
 	select SND_SOC_MPC5200_AC97
 	select SND_SOC_STAC9766
 	help
