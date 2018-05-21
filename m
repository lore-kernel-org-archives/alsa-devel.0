From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH 33/33] ASoC: dapm: use match_string() helper
Date: Mon, 21 May 2018 19:58:10 +0800
Message-ID: <1526903890-35761-34-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Yisheng Xie <xieyisheng1@huawei.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
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
