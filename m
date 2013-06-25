From: Mark Brown <broonie@linaro.org>
Subject: [PATCH] ASoC: wm9705: Remove noisy print on boot
Date: Tue, 25 Jun 2013 17:21:42 +0100
Message-ID: <1372177302-9282-1-git-send-email-broonie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C6C626568B
 for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2013 18:21:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

There's no content in the announcement.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm9705.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 05b1f34..a5fc61d 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -337,8 +337,6 @@ static int wm9705_soc_probe(struct snd_soc_codec *codec)
 {
 	int ret = 0;
 
-	printk(KERN_INFO "WM9705 SoC Audio Codec\n");
-
 	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
 	if (ret < 0) {
 		printk(KERN_ERR "wm9705: failed to register AC97 codec\n");
-- 
1.8.3.1
