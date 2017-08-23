From: Peng Donglin <dolinux.peng@gmail.com>
Subject: [PATCH v2 04/10] ASoC: atmel: Remove unnecessary
	function call
Date: Wed, 23 Aug 2017 05:19:37 -0700
Message-ID: <50230f1a328ce13a82aafe24cd04c4bd3c1a5f7a.1503484313.git.dolinux.peng@gmail.com>
References: <cover.1503484313.git.dolinux.peng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 by alsa0.perex.cz (Postfix) with ESMTP id E72C4267364
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 14:19:43 +0200 (CEST)
Received: by mail-pg0-f68.google.com with SMTP id m133so1361400pga.2
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 05:19:43 -0700 (PDT)
In-Reply-To: <cover.1503484313.git.dolinux.peng@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: nicolas.ferre@microchip.com
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Peng Donglin <dolinux.peng@gmail.com>, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The work of the function platform_set_drvdata is done by
devm_snd_soc_register_card.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 sound/soc/atmel/atmel-classd.c | 1 -
 sound/soc/atmel/atmel-pdmic.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
index b7ef8c59b49a..0cd7caaed9c4 100644
--- a/sound/soc/atmel/atmel-classd.c
+++ b/sound/soc/atmel/atmel-classd.c
@@ -652,7 +652,6 @@ static int atmel_classd_probe(struct platform_device *pdev)
 	}
 
 	snd_soc_card_set_drvdata(card, dd);
-	platform_set_drvdata(pdev, card);
 
 	ret = atmel_classd_asoc_card_init(dev, card);
 	if (ret) {
diff --git a/sound/soc/atmel/atmel-pdmic.c b/sound/soc/atmel/atmel-pdmic.c
index c917df7715d1..8e3d34be9e69 100644
--- a/sound/soc/atmel/atmel-pdmic.c
+++ b/sound/soc/atmel/atmel-pdmic.c
@@ -694,7 +694,6 @@ static int atmel_pdmic_probe(struct platform_device *pdev)
 	}
 
 	snd_soc_card_set_drvdata(card, dd);
-	platform_set_drvdata(pdev, card);
 
 	ret = atmel_pdmic_asoc_card_init(dev, card);
 	if (ret) {
-- 
2.14.1
