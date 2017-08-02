From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: wm8524: Don't use dev_err to show
	supported sample rate
Date: Wed,  2 Aug 2017 16:13:46 +0800
Message-ID: <20170802081346.8179-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 by alsa0.perex.cz (Postfix) with ESMTP id DF7EF266847
 for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2017 10:14:01 +0200 (CEST)
Received: by mail-pg0-f68.google.com with SMTP id 123so3931194pga.5
 for <alsa-devel@alsa-project.org>; Wed, 02 Aug 2017 01:14:01 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Mihai Serban <mihai.serban@nxp.com>, Shengjiu Wang <shengjiu.wang@nxp.com>, Axel Lin <axel.lin@ingics.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Switch to use dev_dbg instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/wm8524.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8524.c b/sound/soc/codecs/wm8524.c
index e22b76d..b66147e 100644
--- a/sound/soc/codecs/wm8524.c
+++ b/sound/soc/codecs/wm8524.c
@@ -118,7 +118,7 @@ static int wm8524_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		case 96000:
 		case 176400:
 		case 192000:
-			dev_err(codec->dev, "Supported sample rate: %dHz\n",
+			dev_dbg(codec->dev, "Supported sample rate: %dHz\n",
 				val);
 			wm8524->rate_constraint_list[j++] = val;
 			wm8524->rate_constraint.count++;
-- 
2.9.3
