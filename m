From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH] ASoC: core: fix return code in error message
Date: Sat, 19 May 2018 08:01:19 +0200
Message-ID: <20180519060119.2612-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E8E1267046
 for <alsa-devel@alsa-project.org>; Sat, 19 May 2018 08:01:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Log the correct error code in case the .open() call to a component fails.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/soc/soc-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 68d9dc930096..abc1dc7074f5 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -517,7 +517,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		if (__ret < 0) {
 			dev_err(component->dev,
 				"ASoC: can't open component %s: %d\n",
-				component->name, ret);
+				component->name, __ret);
 			ret = __ret;
 		}
 	}
-- 
2.14.3
