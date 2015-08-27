From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 5/5] ASoC: txx9: Convert to devm_snd_soc_register_platform
Date: Thu, 27 Aug 2015 09:14:50 +0800
Message-ID: <1440638090.18698.7.camel@ingics.com>
References: <1440637769.18698.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1440637769.18698.1.camel@ingics.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Mark Brown <broonie@kernel.org>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/txx9/txx9aclc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
index 88eacfd..a8f705b 100644
--- a/sound/soc/txx9/txx9aclc.c
+++ b/sound/soc/txx9/txx9aclc.c
@@ -411,13 +411,8 @@ static struct snd_soc_platform_driver txx9aclc_soc_platform = {
 
 static int txx9aclc_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&pdev->dev, &txx9aclc_soc_platform);
-}
-
-static int txx9aclc_soc_platform_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_platform(&pdev->dev,
+					      &txx9aclc_soc_platform);
 }
 
 static struct platform_driver txx9aclc_pcm_driver = {
@@ -426,7 +421,6 @@ static struct platform_driver txx9aclc_pcm_driver = {
 	},
 
 	.probe = txx9aclc_soc_platform_probe,
-	.remove = txx9aclc_soc_platform_remove,
 };
 
 module_platform_driver(txx9aclc_pcm_driver);
-- 
2.1.0
