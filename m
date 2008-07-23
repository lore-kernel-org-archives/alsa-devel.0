From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH] Add a Kconfig option to force all ASOC codecs
	to build
Date: Wed, 23 Jul 2008 15:57:23 -0400
Message-ID: <20080723195723.24968.88510.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by alsa0.perex.cz (Postfix) with ESMTP id CF45B24813
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jul 2008 21:57:25 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so519526and.80
	for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2008 12:57:24 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


---

 sound/soc/Kconfig        |    7 +++++++
 sound/soc/codecs/Kconfig |   15 ++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index f743530..ec5d036 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -35,5 +35,12 @@ source "sound/soc/omap/Kconfig"
 # Supported codecs
 source "sound/soc/codecs/Kconfig"
 
+config SND_SOC_ALL_CODECS
+	bool "Force all codecs to build"
+	default N
+	---help---
+	
+		Select this to force all codecs to build to assist with testing.
+
 endif	# SND_SOC
 
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 1db04a2..6d82c6d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1,37 +1,48 @@
 config SND_SOC_AC97_CODEC
 	tristate
+	default y if SND_SOC_ALL_CODECS
 	select SND_AC97_CODEC
 
 config SND_SOC_AK4535
 	tristate
+	default y if SND_SOC_ALL_CODECS
 
 config SND_SOC_UDA1380
-        tristate
+	tristate
+	default y if SND_SOC_ALL_CODECS
 
 config SND_SOC_WM8510
 	tristate
+	default y if SND_SOC_ALL_CODECS
 
 config SND_SOC_WM8731
 	tristate
+	default y if SND_SOC_ALL_CODECS
 
 config SND_SOC_WM8750
 	tristate
+	default y if SND_SOC_ALL_CODECS
 
 config SND_SOC_WM8753
 	tristate
+	default y if SND_SOC_ALL_CODECS
 
 config SND_SOC_WM8990
 	tristate
+	default y if SND_SOC_ALL_CODECS
 
 config SND_SOC_WM9712
 	tristate
+	default y if SND_SOC_ALL_CODECS
 
 config SND_SOC_WM9713
 	tristate
+	default y if SND_SOC_ALL_CODECS
 
 # Cirrus Logic CS4270 Codec
 config SND_SOC_CS4270
 	tristate
+	default y if SND_SOC_ALL_CODECS
 
 # Cirrus Logic CS4270 Codec Hardware Mute Support
 # Select if you have external muting circuitry attached to your CS4270.
@@ -50,3 +61,5 @@ config SND_SOC_CS4270_VD33_ERRATA
 config SND_SOC_TLV320AIC3X
 	tristate
 	depends on I2C
+	default y if SND_SOC_ALL_CODECS
+	
\ No newline at end of file
