From: Clive Messer <clive.messer@digitaldreamtime.co.uk>
Subject: [PATCH 1/1] ASoC: bcm2835-i2s: Support 384k sample rate
Date: Sun, 19 Jun 2016 18:52:19 +0100
Message-ID: <1466358739-31669-1-git-send-email-clive.messer@digitaldreamtime.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dreamtime.org (barcelona.digitaldreamtime.co.uk
 [85.158.46.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 097BD261A2F
 for <alsa-devel@alsa-project.org>; Sun, 19 Jun 2016 19:52:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-rpi-kernel@lists.infradead.org
Cc: alsa-devel@alsa-project.org, Clive Messer <clive.messer@digitaldreamtime.co.uk>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Add support for sample rates up to 384k to bcm2835-i2s driver,
with SNDRV_PCM_RATE_CONTINUOUS and specifying 8k min and 384k max,
for both playback and capture.

Signed-off-by: Clive Messer <clive.messer@digitaldreamtime.co.uk>
---
 sound/soc/bcm/bcm2835-i2s.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index 6ba2049..4a67db2 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -578,7 +578,9 @@ static struct snd_soc_dai_driver bcm2835_i2s_dai = {
 	.playback = {
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates =	SNDRV_PCM_RATE_8000_192000,
+		.rates =	SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min =	8000,
+		.rate_max =	384000,
 		.formats =	SNDRV_PCM_FMTBIT_S16_LE
 				| SNDRV_PCM_FMTBIT_S24_LE
 				| SNDRV_PCM_FMTBIT_S32_LE
@@ -586,7 +588,9 @@ static struct snd_soc_dai_driver bcm2835_i2s_dai = {
 	.capture = {
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates =	SNDRV_PCM_RATE_8000_192000,
+		.rates =	SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min =	8000,
+		.rate_max =	384000,
 		.formats =	SNDRV_PCM_FMTBIT_S16_LE
 				| SNDRV_PCM_FMTBIT_S24_LE
 				| SNDRV_PCM_FMTBIT_S32_LE
-- 
2.5.5
