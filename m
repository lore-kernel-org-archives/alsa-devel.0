From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dwc: Bodge around continuing absence of
	clock API stubs
Date: Mon, 25 Jun 2012 10:06:35 +0100
Message-ID: <1340615195-27547-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 22C8B245EF
	for <alsa-devel@Alsa-project.org>;
	Mon, 25 Jun 2012 11:06:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Rajeev kumar <rajeev-dlh.kumar@st.com>
Cc: alsa-devel@Alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The patches for stubbing out the generic clock API still haven't been
applied so we need to either add ifdefs here or add a dependency until
someone decides to actually apply them.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/dwc/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/dwc/Kconfig b/sound/soc/dwc/Kconfig
index 93e9fc3..e334900 100644
--- a/sound/soc/dwc/Kconfig
+++ b/sound/soc/dwc/Kconfig
@@ -1,5 +1,6 @@
 config SND_DESIGNWARE_I2S
 	tristate "Synopsys I2S Device Driver"
+	depends on CLKDEV_LOOKUP
 	help
 	 Say Y or M if you want to add support for I2S driver for
 	 Synopsys desigwnware I2S device. The device supports upto
-- 
1.7.10
