From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH -next] soc: sgtl5000 uses regulator interfaces
Date: Fri, 4 Mar 2011 17:33:57 -0800
Message-ID: <20110304173357.23d36116.randy.dunlap@oracle.com>
References: <20110304180027.20deb6c4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet10.oracle.com (rcsinet10.oracle.com [148.87.113.121])
	by alsa0.perex.cz (Postfix) with ESMTP id EF7A4243CD
	for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2011 02:35:39 +0100 (CET)
In-Reply-To: <20110304180027.20deb6c4.sfr@canb.auug.org.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Zeng Zhaoming <zhaoming.zeng@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, Liam@alsa-project.org, Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <randy.dunlap@oracle.com>

sgtl5000 uses regulator interfaces, so make selecting it depend
on REGULATOR.

sgtl5000.c:(.text+0x4ae33): undefined reference to `regulator_unregister'
sgtl5000.c:(.text+0x4af41): undefined reference to `rdev_get_drvdata'
sgtl5000.c:(.text+0x4b191): undefined reference to `regulator_register'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Zeng Zhaoming <zhaoming.zeng@freescale.com>
---
 sound/soc/codecs/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20110304.orig/sound/soc/codecs/Kconfig
+++ linux-next-20110304/sound/soc/codecs/Kconfig
@@ -33,7 +33,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_MAX98088 if I2C
 	select SND_SOC_MAX9877 if I2C
 	select SND_SOC_PCM3008
-	select SND_SOC_SGTL5000 if I2C
+	select SND_SOC_SGTL5000 if I2C && REGULATOR
 	select SND_SOC_SN95031 if INTEL_SCU_IPC
 	select SND_SOC_SPDIF
 	select SND_SOC_SSM2602 if I2C
