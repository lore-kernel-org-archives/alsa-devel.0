From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH 32/33] ASoC: max98095: use match_string() helper
Date: Mon, 21 May 2018 19:58:09 +0800
Message-ID: <1526903890-35761-33-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by alsa0.perex.cz (Postfix) with ESMTP id 0783C267628
 for <alsa-devel@alsa-project.org>; Mon, 21 May 2018 14:09:25 +0200 (CEST)
In-Reply-To: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Yisheng Xie <xieyisheng1@huawei.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

match_string() returns the index of an array for a matching string,
which can be used intead of open coded variant.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 sound/soc/codecs/max98095.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 6bf2d0b..0ef42dc 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -1634,15 +1634,12 @@ static void max98095_handle_eq_pdata(struct snd_soc_component *component)
 static int max98095_get_bq_channel(struct snd_soc_component *component,
 				   const char *name)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(bq_mode_name); i++)
-		if (strcmp(name, bq_mode_name[i]) == 0)
-			return i;
+	int ret = match_string(bq_mode_name, ARRAY_SIZE(bq_mode_name), name);
 
 	/* Shouldn't happen */
-	dev_err(component->dev, "Bad biquad channel name '%s'\n", name);
-	return -EINVAL;
+	if (ret < 0)
+		dev_err(component->dev, "Bad biquad channel name '%s'\n", name);
+	return ret;
 }
 
 static int max98095_put_bq_enum(struct snd_kcontrol *kcontrol,
-- 
1.7.12.4
