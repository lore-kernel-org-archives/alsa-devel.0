From: Matthias Reichl <hias@horus.com>
Subject: [PATCH 3/4] ASoC: bcm2835: Support additional
	samplerates up to 384kHz
Date: Wed,  8 Nov 2017 21:03:31 +0100
Message-ID: <20171108200332.28949-4-hias@horus.com>
References: <20171108200332.28949-1-hias@horus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.horus.com (mail.horus.com [78.46.148.228])
 by alsa0.perex.cz (Postfix) with ESMTP id 418B52675AA
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 21:03:35 +0100 (CET)
In-Reply-To: <20171108200332.28949-1-hias@horus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>
Cc: alsa-devel@alsa-project.org, linux-rpi-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Sample rates are only restricted by the capabilities of the
clock driver, so use SNDRV_PCM_RATE_CONTINUOUS instead of
SNDRV_PCM_RATE_8000_192000.

Tests (eg with pcm5122) have shown that bcm2835 works fine
in 384kHz/32bit stereo mode, so change the maximum allowed
rate from 192kHz to 384kHz.

Signed-off-by: Matthias Reichl <hias@horus.com>
---
 sound/soc/bcm/bcm2835-i2s.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index 3a706fda4f39..43f5715a0d5d 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -765,7 +765,9 @@ static struct snd_soc_dai_driver bcm2835_i2s_dai = {
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
@@ -773,7 +775,9 @@ static struct snd_soc_dai_driver bcm2835_i2s_dai = {
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
2.11.0
