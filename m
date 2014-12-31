From: Zidan Wang <b50113@freescale.com>
Subject: [alsa-devel][PATCH 4/4] ASoC: wm8960: Fix capture sample rate from 11250 to 11025
Date: Wed, 31 Dec 2014 11:39:14 +0800
Message-ID: <1419997154-860-4-git-send-email-b50113@freescale.com>
References: <1419997154-860-1-git-send-email-b50113@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1419997154-860-1-git-send-email-b50113@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, lars@metafoo.de, ckeepax@opensource.wolfsonmicro.com, Li.Xiubo@freescale.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Zidan Wang <b50113@freescale.com>
List-Id: alsa-devel@alsa-project.org

wm8960 codec can't support sample rate 11250, it must be 11025.

Signed-off-by: Zidan Wang <b50113@freescale.com>
---
 sound/soc/codecs/wm8960.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index cb42385..68790f1 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -560,7 +560,7 @@ static struct {
 	{ 22050, 2 },
 	{ 24000, 2 },
 	{ 16000, 3 },
-	{ 11250, 4 },
+	{ 11025, 4 },
 	{ 12000, 4 },
 	{  8000, 5 },
 };
-- 
1.9.1
