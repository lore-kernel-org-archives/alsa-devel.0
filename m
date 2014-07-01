From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 3/3] ASoC: wm8996: Remove unused variable
Date: Tue,  1 Jul 2014 09:59:33 +0530
Message-ID: <1404188973-1857-3-git-send-email-sachin.kamat@samsung.com>
References: <1404188973-1857-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com
 [209.85.192.175])
 by alsa0.perex.cz (Postfix) with ESMTP id C1FF9262607
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 06:33:12 +0200 (CEST)
Received: by mail-pd0-f175.google.com with SMTP id v10so9371775pde.6
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 21:33:11 -0700 (PDT)
In-Reply-To: <1404188973-1857-1-git-send-email-sachin.kamat@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, spk.linux@gmail.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

'ret' is not used in the function. Remove it.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
---
 sound/soc/codecs/wm8996.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 9304a91b8403..f16ff4f56923 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -620,15 +620,12 @@ static int bg_event(struct snd_soc_dapm_widget *w,
 static int cp_event(struct snd_soc_dapm_widget *w,
 		    struct snd_kcontrol *kcontrol, int event)
 {
-	int ret = 0;
-
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		msleep(5);
 		break;
 	default:
 		WARN(1, "Invalid event %d\n", event);
-		ret = -EINVAL;
 	}
 
 	return 0;
-- 
1.7.9.5
