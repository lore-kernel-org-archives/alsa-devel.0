From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: ASoC: AC97 codec PM
Date: Thu, 3 Jul 2008 09:33:10 +0200
Message-ID: <20080703073309.GA24116@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from roarinelk.homelinux.net (fnoeppeil48.netpark.at
	[217.175.205.176])
	by alsa0.perex.cz (Postfix) with ESMTP id C24C3243B0
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jul 2008 09:33:10 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lg@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Liam,

This simple patch adds suspend/resume support to the ASoC AC97 codec.
Tested on Au1200, works fine for me(TM).

Thanks!
	Manuel Lauss

---
From: Manuel Lauss <mano@roarinelk.homelinux.net>

Simple suspend/resume for AC97 ASoC codec.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 sound/soc/codecs/ac97.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index 2a1ffe3..fb9ac9f 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -146,9 +146,34 @@ static int ac97_soc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int ac97_soc_suspend(struct platform_device *pdev, pm_message_t msg)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+
+	snd_ac97_suspend(socdev->codec->ac97);
+
+	return 0;
+}
+
+static int ac97_soc_resume(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+
+	snd_ac97_resume(socdev->codec->ac97);
+
+	return 0;
+}
+#else
+#define ac97_soc_suspend NULL
+#define ac97_soc_resume NULL
+#endif
+
 struct snd_soc_codec_device soc_codec_dev_ac97 = {
 	.probe = 	ac97_soc_probe,
 	.remove = 	ac97_soc_remove,
+	.suspend =	ac97_soc_suspend,
+	.resume =	ac97_soc_resume,
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_ac97);
 
-- 
1.5.6.1
