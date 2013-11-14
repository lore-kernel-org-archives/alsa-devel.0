From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 03/20] ASoC: davinci: kconfig: Prepare for
	AM43xx support
Date: Thu, 14 Nov 2013 11:35:19 +0200
Message-ID: <1384421737-4467-4-git-send-email-peter.ujfalusi@ti.com>
References: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 697E4261A1C
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 10:35:46 +0100 (CET)
In-Reply-To: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Michal Bachraty <michal.bachraty@streamunlimited.com>, nsekhar@ti.com, jsarha@ti.com, gururaja.hebbar@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

AM43xx have the same McASP IP as AM33xx and both platform uses eDMA. Modify
the Kconfig so it will be possible to add audio support for AM43xx based
boards later.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt | 2 +-
 sound/soc/davinci/Kconfig                                       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
index ed785b3..1eed972 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
@@ -4,7 +4,7 @@ Required properties:
 - compatible :
 	"ti,dm646x-mcasp-audio"	: for DM646x platforms
 	"ti,da830-mcasp-audio"	: for both DA830 & DA850 platforms
-	"ti,am33xx-mcasp-audio"	: for AM33xx platforms (AM33xx, TI81xx)
+	"ti,am33xx-mcasp-audio"	: for AM33xx platforms (AM33xx, AM43xx, TI81xx)
 
 - reg : Should contain reg specifiers for the entries in the reg-names property.
 - reg-names : Should contain:
diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index be66771..a8ec1fc 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -1,6 +1,6 @@
 config SND_DAVINCI_SOC
-	tristate "SoC Audio for the TI DAVINCI or AM33XX chip"
-	depends on ARCH_DAVINCI || SOC_AM33XX
+	tristate "SoC Audio for TI DAVINCI or AM33XX/AM43XX chips"
+	depends on ARCH_DAVINCI || SOC_AM33XX || SOC_AM43XX
 
 config SND_DAVINCI_SOC_I2S
 	tristate
-- 
1.8.4.2
