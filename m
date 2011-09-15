From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 09/17] ASoC: twl6040: Remove strings "NULL"
	from DAPM route
Date: Thu, 15 Sep 2011 15:39:31 +0300
Message-ID: <1316090379-30760-10-git-send-email-peter.ujfalusi@ti.com>
References: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog123.obsmtp.com (na3sys009aog123.obsmtp.com
	[74.125.149.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 3213C103B9B
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 14:40:33 +0200 (CEST)
Received: by mail-bw0-f52.google.com with SMTP id 5so3393894bke.11
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2011 05:40:32 -0700 (PDT)
In-Reply-To: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <samuel.ortiz@intel.com>, Dmitry Torokhov <dtor@mail.ru>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Replace the string with plain NULL.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 9d1f82d..689e88b 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1195,8 +1195,8 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"ADC Right", NULL, "MicAmpR"},
 
 	/* AFM path */
-	{"AFMAmpL", "NULL", "AFML"},
-	{"AFMAmpR", "NULL", "AFMR"},
+	{"AFMAmpL", NULL, "AFML"},
+	{"AFMAmpR", NULL, "AFMR"},
 
 	{"HS Left Playback", "HS DAC", "HSDAC Left"},
 	{"HS Left Playback", "Line-In amp", "AFMAmpL"},
@@ -1204,8 +1204,8 @@ static const struct snd_soc_dapm_route intercon[] = {
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
