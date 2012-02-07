From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 3/7] ASoC: twl6040: Remove dependency on
	twl4030 from Kconfig
Date: Tue,  7 Feb 2012 15:01:14 +0200
Message-ID: <1328619678-26080-4-git-send-email-peter.ujfalusi@ti.com>
References: <1328619678-26080-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog110.obsmtp.com (na3sys009aog110.obsmtp.com
	[74.125.149.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F23110392B
	for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2012 14:01:37 +0100 (CET)
Received: by mail-lpp01m020-f179.google.com with SMTP id ge1so1870888lbb.24
	for <alsa-devel@alsa-project.org>; Tue, 07 Feb 2012 05:01:36 -0800 (PST)
In-Reply-To: <1328619678-26080-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dmitry Torokhov <dtor@mail.ru>
Cc: linux-arm-kernel@lists.infradead.org, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

twl6040 no longer needs twl4030.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 7c205e7..9462d50 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -56,7 +56,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_TPA6130A2 if I2C
 	select SND_SOC_TLV320DAC33 if I2C
 	select SND_SOC_TWL4030 if TWL4030_CORE
-	select SND_SOC_TWL6040 if TWL4030_CORE
+	select SND_SOC_TWL6040
 	select SND_SOC_UDA134X
 	select SND_SOC_UDA1380 if I2C
 	select SND_SOC_WL1273 if MFD_WL1273_CORE
-- 
1.7.8.4
