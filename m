From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 3/5 v2] ASoC: nuc900: Fix platform_get_irq's
	error checking
Date: Sat, 18 Nov 2017 10:57:53 +0530
Message-ID: <19f8c64a4720118a6d6c4fedd5f8defa6938d1db.1510982440.git.arvind.yadav.cs@gmail.com>
References: <874375c0dca41790e47b60ce30f88ab353f97b38.1510982440.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 by alsa0.perex.cz (Postfix) with ESMTP id CCBEB267269
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 06:28:14 +0100 (CET)
Received: by mail-pg0-f67.google.com with SMTP id s11so3480107pgc.5
 for <alsa-devel@alsa-project.org>; Fri, 17 Nov 2017 21:28:14 -0800 (PST)
In-Reply-To: <874375c0dca41790e47b60ce30f88ab353f97b38.1510982440.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <874375c0dca41790e47b60ce30f88ab353f97b38.1510982440.git.arvind.yadav.cs@gmail.com>
References: <874375c0dca41790e47b60ce30f88ab353f97b38.1510982440.git.arvind.yadav.cs@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
             nuc900_audio->irq_num is unsigned. so handle through signed variable.

 sound/soc/nuc900/nuc900-ac97.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index b6615af..71fce7c 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -345,11 +345,10 @@ static int nuc900_ac97_drvprobe(struct platform_device *pdev)
 		goto out;
 	}
 
-	nuc900_audio->irq_num = platform_get_irq(pdev, 0);
-	if (!nuc900_audio->irq_num) {
-		ret = -EBUSY;
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
 		goto out;
-	}
+	nuc900_audio->irq_num = ret;
 
 	nuc900_ac97_data = nuc900_audio;
 
-- 
2.7.4
