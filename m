From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH v2 18/21] ASoC: dapm: use match_string() helper
Date: Thu, 31 May 2018 19:11:23 +0800
Message-ID: <1527765086-19873-19-git-send-email-xieyisheng1@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D51C26790A
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

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
v2:
 - add Reviewed-by tag.

 sound/soc/soc-dapm.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2d97091..1e9a363 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -724,18 +724,14 @@ static int dapm_connect_mux(struct snd_soc_dapm_context *dapm,
 		item = 0;
 	}
 
-	for (i = 0; i < e->items; i++) {
-		if (!(strcmp(control_name, e->texts[i]))) {
-			path->name = e->texts[i];
-			if (i == item)
-				path->connect = 1;
-			else
-				path->connect = 0;
-			return 0;
-		}
-	}
+	i = match_string(e->texts, e->items, control_name);
+	if (i < 0)
+		return -ENODEV;
+
+	path->name = e->texts[i];
+	path->connect = (i == item);
+	return 0;
 
-	return -ENODEV;
 }
 
 /* set up initial codec paths */
-- 
1.7.12.4
