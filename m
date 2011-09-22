From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 03/10] ASoC: twl6040: Remove strings "NULL"
	from DAPM route
Date: Thu, 22 Sep 2011 11:05:47 +0300
Message-ID: <1316678754-11935-4-git-send-email-peter.ujfalusi@ti.com>
References: <1316678754-11935-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id B978B1039C3
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Sep 2011 10:06:28 +0200 (CEST)
Received: by bke11 with SMTP id 11so3247527bke.34
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2011 01:06:22 -0700 (PDT)
In-Reply-To: <1316678754-11935-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Replace the string with plain NULL.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/codecs/twl6040.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 6f6b180..9fbfe0e 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1199,8 +1199,8 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"ADC Right", NULL, "MicAmpR"},
 
 	/* AFM path */
-	{"AFMAmpL", "NULL", "AFML"},
-	{"AFMAmpR", "NULL", "AFMR"},
+	{"AFMAmpL", NULL, "AFML"},
+	{"AFMAmpR", NULL, "AFMR"},
 
 	{"HS Left Playback", "HS DAC", "HSDAC Left"},
 	{"HS Left Playback", "Line-In amp", "AFMAmpL"},
@@ -1208,8 +1208,8 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"HS Right Playback", "HS DAC", "HSDAC Right"},
 	{"HS Right Playback", "Line-In amp", "AFMAmpR"},
 
-	{"Headset Left Driver", "NULL", "HS Left Playback"},
-	{"Headset Right Driver", "NULL", "HS Right Playback"},
+	{"Headset Left Driver", NULL, "HS Left Playback"},
+	{"Headset Right Driver", NULL, "HS Right Playback"},
 
 	{"HSOL", NULL, "Headset Left Driver"},
 	{"HSOR", NULL, "Headset Right Driver"},
-- 
1.7.6.1
