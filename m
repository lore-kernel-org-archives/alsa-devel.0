From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/4] ASoC: twl6040: Assign id for each DAI
Date: Mon, 24 Jun 2013 15:42:05 +0200
Message-ID: <1372081326-6917-4-git-send-email-peter.ujfalusi@ti.com>
References: <1372081326-6917-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id F119F2625E1
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 15:42:14 +0200 (CEST)
In-Reply-To: <1372081326-6917-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

Later we can identify the DAIs by this ID number.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index c2f2fdb..9ea3dbc 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -38,6 +38,14 @@
 
 #include "twl6040.h"
 
+enum twl6040_dai_id {
+	TWL6040_DAI_LEGACY = 0,
+	TWL6040_DAI_UL,
+	TWL6040_DAI_DL1,
+	TWL6040_DAI_DL2,
+	TWL6040_DAI_VIB,
+};
+
 #define TWL6040_RATES		SNDRV_PCM_RATE_8000_96000
 #define TWL6040_FORMATS	(SNDRV_PCM_FMTBIT_S32_LE)
 
@@ -1036,6 +1044,7 @@ static const struct snd_soc_dai_ops twl6040_dai_ops = {
 static struct snd_soc_dai_driver twl6040_dai[] = {
 {
 	.name = "twl6040-legacy",
+	.id = TWL6040_DAI_LEGACY,
 	.playback = {
 		.stream_name = "Legacy Playback",
 		.channels_min = 1,
@@ -1054,6 +1063,7 @@ static struct snd_soc_dai_driver twl6040_dai[] = {
 },
 {
 	.name = "twl6040-ul",
+	.id = TWL6040_DAI_UL,
 	.capture = {
 		.stream_name = "Capture",
 		.channels_min = 1,
@@ -1065,6 +1075,7 @@ static struct snd_soc_dai_driver twl6040_dai[] = {
 },
 {
 	.name = "twl6040-dl1",
+	.id = TWL6040_DAI_DL1,
 	.playback = {
 		.stream_name = "Headset Playback",
 		.channels_min = 1,
@@ -1076,6 +1087,7 @@ static struct snd_soc_dai_driver twl6040_dai[] = {
 },
 {
 	.name = "twl6040-dl2",
+	.id = TWL6040_DAI_DL2,
 	.playback = {
 		.stream_name = "Handsfree Playback",
 		.channels_min = 1,
@@ -1087,6 +1099,7 @@ static struct snd_soc_dai_driver twl6040_dai[] = {
 },
 {
 	.name = "twl6040-vib",
+	.id = TWL6040_DAI_VIB,
 	.playback = {
 		.stream_name = "Vibra Playback",
 		.channels_min = 1,
-- 
1.8.2.1
