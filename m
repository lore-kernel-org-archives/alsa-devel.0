From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 1/2] ASoC: dapm: fix memory leak
Date: Thu, 10 Sep 2015 18:01:44 +0530
Message-ID: <1441888305-19957-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

Incase of an unknown event we were directly returning but we missed
freeing params.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index f4bf21a..ff8bda4 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3501,7 +3501,7 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 
 	default:
 		WARN(1, "Unknown event %d\n", event);
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 
 out:
-- 
1.9.1
