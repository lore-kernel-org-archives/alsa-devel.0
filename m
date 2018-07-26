From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH] ASoC: AMD: Fix build warning
Date: Thu, 26 Jul 2018 13:55:48 +0800
Message-ID: <1532584572-8362-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: akshu.agrawal@amd.com, Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Kurtz <djkurtz@chromium.org>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Wei Yongjun <weiyongjun1@huawei.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Fixes
sound/soc/amd/acp-da7219-max98357a.c: In function 'cz_probe':
sound/soc/amd/acp-da7219-max98357a.c:367:3: warning: 'ret' may
be used uninitialized in this function [-Wmaybe-uninitialized]
   dev_err(&pdev->dev, "Failed to register regulator: %d\n",
ret);

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index cd3cf6e..48c1d94 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -365,7 +365,7 @@ static int cz_probe(struct platform_device *pdev)
 				       &acp_da7219_cfg);
 	if (IS_ERR(rdev)) {
 		dev_err(&pdev->dev, "Failed to register regulator: %d\n",
-			ret);
+			(int)PTR_ERR(rdev);
 		return -EINVAL;
 	}
 
-- 
1.9.1
