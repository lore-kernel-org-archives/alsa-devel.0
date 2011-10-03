From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Staticise simtec_audio_resume()
Date: Mon, 03 Oct 2011 16:11:52 +0800
Message-ID: <1317629512.2820.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 342641038AF
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 10:12:03 +0200 (CEST)
Received: by yxk8 with SMTP id 8so3762521yxk.38
	for <alsa-devel@alsa-project.org>; Mon, 03 Oct 2011 01:12:02 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sangbeom Kim <sbkim73@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, Ben Dooks <ben@simtec.co.uk>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

It is exported via resume callback of struct dev_pm_ops rather than referenced
directly and so should be staticised.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/samsung/s3c24xx_simtec.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/samsung/s3c24xx_simtec.c b/sound/soc/samsung/s3c24xx_simtec.c
index 349566f..c8d525b 100644
--- a/sound/soc/samsung/s3c24xx_simtec.c
+++ b/sound/soc/samsung/s3c24xx_simtec.c
@@ -300,7 +300,7 @@ static void detach_gpio_amp(struct s3c24xx_audio_simtec_pdata *pd)
 }
 
 #ifdef CONFIG_PM
-int simtec_audio_resume(struct device *dev)
+static int simtec_audio_resume(struct device *dev)
 {
 	simtec_call_startup(pdata);
 	return 0;
-- 
1.7.4.1
