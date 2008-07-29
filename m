From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 14/14] ASoC: Add all CODECs Kconfig option
Date: Tue, 29 Jul 2008 11:42:35 +0100
Message-ID: <1217328155-30158-14-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1217328155-30158-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-12-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-13-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8B8AD103818
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jul 2008 12:42:41 +0200 (CEST)
In-Reply-To: <1217328155-30158-13-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Allow all the CODEC drivers to be built without a machine driver in order
to facilitate testing of subsystem-wide changes and gain better coverage
from automated testing efforts. This also helps things like the generic
OpenFirmware machine driver for PowerPC.

Currently AC97 CODECs are not included since the current setup relies
on having a controller driver available.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Kconfig |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 7ab74cd..1c93423 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1,3 +1,26 @@
+config SND_SOC_ALL_CODECS
+	tristate "Build all ASoC CODEC drivers"
+	select I2C
+	select SPI
+	select SND_SOC_AK4535
+	select SND_SOC_UDA1380
+	select SND_SOC_WM8510
+	select SND_SOC_WM8731
+	select SND_SOC_WM8750
+	select SND_SOC_WM8753
+	select SND_SOC_WM8990
+	select SND_SOC_CS4270
+	select SND_SOC_TLV320AIC26
+	select SND_SOC_TLV320AIC3X
+        help
+          Normally ASoC codec drivers are only built if a machine driver which
+          uses them is also built since they are only usable with a machine
+          driver.  Selecting this option will allow these drivers to be built
+          without an explicit machine driver for test and development purposes.
+
+          If unsure select "N".
+
+
 config SND_SOC_AC97_CODEC
 	tristate
 	select SND_AC97_CODEC
-- 
1.5.6.3
