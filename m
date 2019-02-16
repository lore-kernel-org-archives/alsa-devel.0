From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] ASoC: samsung: i2s: Fix return value check in i2s_create_secondary_device()
Date: Sat, 16 Feb 2019 01:20:55 +0000
Message-ID: <20190216012055.79622-1-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In case of error, the function platform_device_register_simple() returns
ERR_PTR() and never returns NULL. The NULL test in the return value
check should be replaced with IS_ERR().

Fixes: 7196c64c7d0c ("ASoC: samsung: i2s: Restore support for the secondary PCM")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/samsung/i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 72f0cb7abb30..15844c00c3cd 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1342,8 +1342,8 @@ static int i2s_create_secondary_device(struct samsung_i2s_priv *priv)
 	int ret;
 
 	pdev = platform_device_register_simple("samsung-i2s-sec", -1, NULL, 0);
-	if (!pdev)
-		return -ENOMEM;
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
 
 	ret = device_attach(&pdev->dev);
 	if (ret < 0) {
