From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH] Fix disable of SPDIF on STAC9766 codec
Date: Tue, 15 Dec 2009 20:53:44 -0500
Message-ID: <20091216015344.21806.5403.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 643E5103821
	for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2009 02:53:49 +0100 (CET)
Received: by qw-out-1920.google.com with SMTP id 14so94151qwa.56
	for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2009 17:53:48 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: joe@perches.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, clemens@ladisch.de, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Change code so that switching to playing music through the analog output disables SPDIF
out instead of disabling it when stream ends.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 sound/soc/codecs/stac9766.c |   18 +-----------------
 1 files changed, 1 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index bbc72c2..81b8c9d 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -191,6 +191,7 @@ static int ac97_analog_prepare(struct snd_pcm_substream *substream,
 	vra = stac9766_ac97_read(codec, AC97_EXTENDED_STATUS);
 
 	vra |= 0x1; /* enable variable rate audio */
+	vra &= ~0x4; /* disable SPDIF output */
 
 	stac9766_ac97_write(codec, AC97_EXTENDED_STATUS, vra);
 
@@ -221,22 +222,6 @@ static int ac97_digital_prepare(struct snd_pcm_substream *substream,
 	return stac9766_ac97_write(codec, reg, runtime->rate);
 }
 
-static int ac97_digital_trigger(struct snd_pcm_substream *substream,
-				int cmd, struct snd_soc_dai *dai)
-{
-	struct snd_soc_codec *codec = dai->codec;
-	unsigned short vra;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_STOP:
-		vra = stac9766_ac97_read(codec, AC97_EXTENDED_STATUS);
-		vra &= !0x04;
-		stac9766_ac97_write(codec, AC97_EXTENDED_STATUS, vra);
-		break;
-	}
-	return 0;
-}
-
 static int stac9766_set_bias_level(struct snd_soc_codec *codec,
 				   enum snd_soc_bias_level level)
 {
@@ -315,7 +300,6 @@ static struct snd_soc_dai_ops stac9766_dai_ops_analog = {
 
 static struct snd_soc_dai_ops stac9766_dai_ops_digital = {
 	.prepare = ac97_digital_prepare,
-	.trigger = ac97_digital_trigger,
 };
 
 struct snd_soc_dai stac9766_dai[] = {
