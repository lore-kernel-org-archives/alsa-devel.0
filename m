From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH v2 17/21] ASoC: max98095: use match_string()
	helper
Date: Thu, 31 May 2018 19:11:22 +0800
Message-ID: <1527765086-19873-18-git-send-email-xieyisheng1@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C2D9267909
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 13:22:49 +0200 (CEST)
In-Reply-To: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
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
Cc: Yisheng Xie <xieyisheng1@huawei.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, andy.shevchenko@gmail.com, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

match_string() returns the index of an array for a matching string,
which can be used instead of open coded variant.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
v2:
 - split ret=xxxx and move assignment to the line before 'if' - per Andy

 sound/soc/codecs/max98095.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 6bf2d0b..3b3a10d 100644
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
+	int ret;
 
-	/* Shouldn't happen */
-	dev_err(component->dev, "Bad biquad channel name '%s'\n", name);
-	return -EINVAL;
+	ret = match_string(bq_mode_name, ARRAY_SIZE(bq_mode_name), name);
+	if (ret < 0)
+		dev_err(component->dev, "Bad biquad channel name '%s'\n", name);
+	return ret;
 }
 
 static int max98095_put_bq_enum(struct snd_kcontrol *kcontrol,
-- 
1.7.12.4
