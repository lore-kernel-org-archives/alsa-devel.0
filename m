From: Hong Xu <hong.xu@atmel.com>
Subject: [PATCH] ASoC: Add MICBIAS routing information for
	WM8904
Date: Fri, 16 Mar 2012 16:54:58 +0800
Message-ID: <1331888098-28717-1-git-send-email-hong.xu@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
	by alsa0.perex.cz (Postfix) with ESMTP id EFE9024413
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 09:53:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, Hong Xu <hong.xu@atmel.com>
List-Id: alsa-devel@alsa-project.org

Add MICBIAS routing entries for WM8904.

Tested on ATMEL's AT91SAM9N12-EK with a electret condenser
microphone connected to IN1L.

Signed-off-by: Hong Xu <hong.xu@atmel.com>
---
 sound/soc/codecs/wm8904.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 285ef87..2158f30 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -1318,6 +1318,14 @@ static const struct snd_soc_dapm_route core_intercon[] = {
 };
 
 static const struct snd_soc_dapm_route adc_intercon[] = {
+	{ "MICBIAS", NULL, "IN1L" },
+	{ "MICBIAS", NULL, "IN1R" },
+
+	{ "Left Capture Mux", NULL, "MICBIAS" },
+	{ "Right Capture Mux", NULL, "MICBIAS" },
+	{ "Left Capture Inverting Mux", NULL, "MICBIAS" },
+	{ "Right Capture Inverting Mux", NULL, "MICBIAS" },
+
 	{ "Left Capture Mux", "IN1L", "IN1L" },
 	{ "Left Capture Mux", "IN2L", "IN2L" },
 	{ "Left Capture Mux", "IN3L", "IN3L" },
-- 
1.7.6
