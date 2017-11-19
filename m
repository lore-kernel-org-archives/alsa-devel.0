From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/4] ASoC: soc-pcm: Improve unlocking of a
 mutex in soc_dpcm_runtime_update()
Date: Sun, 19 Nov 2017 21:20:19 +0100
Message-ID: <84ae04be-480e-6eba-0efc-52e7592b6e02@users.sourceforge.net>
References: <54203404-1e40-3c97-a6e5-75a41ec3e742@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 976BA266E76
 for <alsa-devel@alsa-project.org>; Sun, 19 Nov 2017 21:21:02 +0100 (CET)
In-Reply-To: <54203404-1e40-3c97-a6e5-75a41ec3e742@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 19 Nov 2017 19:43:07 +0100

* Add a jump target so that a call of the function "mutex_unlock" is stored
  only once in this function implementation.

* Replace two calls by goto statements.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/soc-pcm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 8075856668c2..ea771316afa9 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2674,8 +2674,7 @@ int soc_dpcm_runtime_update(struct snd_soc_card *card)
 		if (paths < 0) {
 			dev_warn(fe->dev, "ASoC: %s no valid %s path\n",
 					fe->dai_link->name,  "playback");
-			mutex_unlock(&card->mutex);
-			return paths;
+			goto unlock;
 		}
 
 		/* update any new playback paths */
@@ -2710,8 +2709,7 @@ int soc_dpcm_runtime_update(struct snd_soc_card *card)
 		if (paths < 0) {
 			dev_warn(fe->dev, "ASoC: %s no valid %s path\n",
 					fe->dai_link->name,  "capture");
-			mutex_unlock(&card->mutex);
-			return paths;
+			goto unlock;
 		}
 
 		/* update any new capture paths */
@@ -2733,8 +2731,10 @@ int soc_dpcm_runtime_update(struct snd_soc_card *card)
 		dpcm_path_put(&list);
 	}
 
+	paths = 0;
+unlock:
 	mutex_unlock(&card->mutex);
-	return 0;
+	return paths;
 }
 int soc_dpcm_be_digital_mute(struct snd_soc_pcm_runtime *fe, int mute)
 {
-- 
2.15.0
