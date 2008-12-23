From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [topic/asoc][PATCH]] ASoC: OMAP: Select OMAP pin
	multiplexing when using Nokia N810 ASoC drivers
Date: Tue, 23 Dec 2008 10:06:02 +0200
Message-ID: <1230019562-6564-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 62C5A103814
	for <alsa-devel@alsa-project.org>; Tue, 23 Dec 2008 09:06:17 +0100 (CET)
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	mBN85tpu031735
	for <alsa-devel@alsa-project.org>; Tue, 23 Dec 2008 10:06:10 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

N810 bootloader muxes I2S pins for OMAP2420 EAC block while N810 ASoC
drivers are using McBSP block so the kernel have to change configuration
runtime.

Author has not seen problems using kernel pin multiplexing on N810 but very
many times unworking audio after forgotten to enable it and spending
15 minutes each time to figure it out again...

This change makes it easier for other users as well. If problems arise, then
they are better to find and fix in OMAP pin multiplexing framework.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/omap/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index a7b1d77..4f7f040 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -10,6 +10,7 @@ config SND_OMAP_SOC_N810
 	tristate "SoC Audio support for Nokia N810"
 	depends on SND_OMAP_SOC && MACH_NOKIA_N810
 	select SND_OMAP_SOC_MCBSP
+	select OMAP_MUX
 	select SND_SOC_TLV320AIC3X
 	help
 	  Say Y if you want to add support for SoC audio on Nokia N810.
-- 
1.5.6.5
