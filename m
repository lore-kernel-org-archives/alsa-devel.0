From: Jorge Eduardo Candelaria <x0107209@ti.com>
Subject: [PATCH] ASoC: Zoom2: Update twl4030_setup_data
	parameters
Date: Wed, 24 Jun 2009 21:27:13 -0500
Message-ID: <1245896833-4002-1-git-send-email-x0107209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 67A8B249FC
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Jun 2009 04:29:06 +0200 (CEST)
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
Cc: Jorge Eduardo Candelaria <x0107209@ti.com>, broonie@opensource.wolfsonmicro.com, peter.ujfalusi@nokia.com
List-Id: alsa-devel@alsa-project.org

Add EXT_MUTE support in Zoom2 machine driver. Member ext_mute_gpio
is passed to TWL4030 as an external mute control for headset power
on/off sequence. This is necessary to further reduce pop noise
problem. Gpio 153 is connected to signal EXT_MUTE in Zoom2 board.

In addition, change ramp delay value to 3 (218/161/109 ms). With
previous ramp delay value, pop noise was louder, and with any
longer value beep tone can be observed.

Signed-off-by: Jorge Eduardo Candelaria <x0107209@ti.com>
---
 sound/soc/omap/zoom2.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/zoom2.c b/sound/soc/omap/zoom2.c
index 3de6d2b..8941f45 100644
--- a/sound/soc/omap/zoom2.c
+++ b/sound/soc/omap/zoom2.c
@@ -236,8 +236,9 @@ static struct snd_soc_card snd_soc_zoom2 = {
 
 /* twl4030 setup */
 static struct twl4030_setup_data twl4030_setup = {
-	.ramp_delay_value = 2,	/* 81 ms */
+	.ramp_delay_value = 3,	/* 161 ms */
 	.sysclk = 26000,
+	.ext_mute_gpio = 153,
 };
 
 /* Audio subsystem */
-- 
1.6.0.4
