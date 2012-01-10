From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] ASoC: Fix recursive dependency for
	SND_AT91_SOC_SAM9G20_WM8731
Date: Tue, 10 Jan 2012 00:05:22 -0200
Message-ID: <1326161122-20717-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3BABB1037EE
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2012 03:05:33 +0100 (CET)
Received: by ghbz2 with SMTP id z2so1896923ghb.38
	for <alsa-devel@alsa-project.org>; Mon, 09 Jan 2012 18:05:32 -0800 (PST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, axel.lin@gmail.com, broonie@opensource.wolfsonmicro.com, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

commit 739be96 (ASoC: Fix build dependency for SND_ATMEL_SOC_SSC) introduced the following
recursive dependency:

drivers/misc/Kconfig:212:error: recursive dependency detected!
drivers/misc/Kconfig:212:	symbol ATMEL_SSC is selected by SND_ATMEL_SOC_SSC
sound/soc/atmel/Kconfig:9:	symbol SND_ATMEL_SOC_SSC is selected by SND_AT91_SOC_SAM9G20_WM8731
sound/soc/atmel/Kconfig:18:	symbol SND_AT91_SOC_SAM9G20_WM8731 depends on ATMEL_SSC

Fix it by moving ATMEL_SSC to the 'depends' line.
 
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
This applies against linux-next and doing a 'make randconfig' triggers the error.

Change since v1:

- Get rid of the recursive errors by fixing SND_AT91_SOC_SAM9G20_WM8731
 sound/soc/atmel/Kconfig |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index a4d6742..bb49b7d 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -17,8 +17,7 @@ config SND_ATMEL_SOC_SSC
 
 config SND_AT91_SOC_SAM9G20_WM8731
 	tristate "SoC Audio support for WM8731-based At91sam9g20 evaluation board"
-	depends on ATMEL_SSC && ARCH_AT91SAM9G20 && SND_ATMEL_SOC && \
-                   AT91_PROGRAMMABLE_CLOCKS
+	depends on ARCH_AT91SAM9G20 && AT91_PROGRAMMABLE_CLOCKS
 	select SND_ATMEL_SOC_SSC
 	select SND_SOC_WM8731
 	help
-- 
1.7.1
