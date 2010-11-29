From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 5/5] ASoC: Remove unneeded !! operations while checking
	return value of nuc900_checkready
Date: Mon, 29 Nov 2010 17:43:39 +0800
Message-ID: <1291023819.22911.11.camel@mola>
References: <1291023491.22911.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1291023491.22911.1.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wan ZongShun <mcuos.com@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I think this unneededd !! operations just reduce the readability.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/nuc900/nuc900-ac97.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index 3d9d8b1..dac6732 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -49,7 +49,7 @@ static unsigned short nuc900_ac97_read(struct snd_ac97 *ac97,
 	mutex_lock(&ac97_mutex);
 
 	val = nuc900_checkready();
-	if (!!val) {
+	if (val) {
 		dev_err(nuc900_audio->dev, "AC97 codec is not ready\n");
 		goto out;
 	}
@@ -102,7 +102,7 @@ static void nuc900_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 	mutex_lock(&ac97_mutex);
 
 	tmp = nuc900_checkready();
-	if (!!tmp)
+	if (tmp)
 		dev_err(nuc900_audio->dev, "AC97 codec is not ready\n");
 
 	/* clear the R_WB bit and write register index */
@@ -149,7 +149,7 @@ static void nuc900_ac97_warm_reset(struct snd_ac97 *ac97)
 	udelay(100);
 
 	val = nuc900_checkready();
-	if (!!val)
+	if (val)
 		dev_err(nuc900_audio->dev, "AC97 codec is not ready\n");
 
 	mutex_unlock(&ac97_mutex);
-- 
1.7.2
