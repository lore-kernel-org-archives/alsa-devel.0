From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH v2 1/4] Set the MPC5200 i2s driver to BROKEN
	status.
Date: Mon, 27 Apr 2009 12:44:41 -0400
Message-ID: <20090427164441.18211.77969.stgit@terra>
References: <20090427164108.18211.44680.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EDA6245EA
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 18:44:49 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 6so14188yxn.2
	for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2009 09:44:48 -0700 (PDT)
In-Reply-To: <20090427164108.18211.44680.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: grant.likely@secretlab.ca, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Set the MPC5200 i2s driver to BROKEN status.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 sound/soc/fsl/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 9fc9082..e7dd79a 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -21,7 +21,7 @@ config SND_SOC_MPC8610_HPCD
 
 config SND_SOC_MPC5200_I2S
 	tristate "Freescale MPC5200 PSC in I2S mode driver"
-	depends on PPC_MPC52xx && PPC_BESTCOMM
+	depends on PPC_MPC52xx && PPC_BESTCOMM && BROKEN
 	select SND_SOC_OF_SIMPLE
 	select PPC_BESTCOMM_GEN_BD
 	help
