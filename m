From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] ASoC: wm8400: Use
	devm_snd_soc_register_component()
Date: Fri, 16 Mar 2018 07:32:07 +0000
Message-ID: <1521185527-164406-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from huawei.com (unknown [45.249.212.32])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AAFB26738C
 for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2018 08:26:01 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori
 Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: kernel-janitors@vger.kernel.org, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, Wei Yongjun <weiyongjun1@huawei.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Since the remove callback is removed, the snd_soc_unregister_component()
is missing when remove device. Using devm_snd_soc_register_component()
instead of snd_soc_register_component().

Fixes: 10dc44c6462d ("ASoC: wm8400: replace codec to component")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/codecs/wm8400.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index c237365..57b2206 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -1343,7 +1343,7 @@ static void  wm8400_component_remove(struct snd_soc_component *component)
 
 static int wm8400_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_component(&pdev->dev,
+	return devm_snd_soc_register_component(&pdev->dev,
 			&soc_component_dev_wm8400,
 			&wm8400_dai, 1);
 }
