From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: samsung: Enable accessory detect for
	WM8994 on Littlemill
Date: Mon,  6 Feb 2012 14:03:52 +0000
Message-ID: <1328537032-7814-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9DFCB103AFF
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 15:03:55 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The WM8994 has a different accessory detect architecture, call its setup
function too. We ignore the errors and the driver will check for chip type
so it's safe to call the setup functions for both architectures.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/littlemill.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/littlemill.c b/sound/soc/samsung/littlemill.c
index 9dd818b..e741685 100644
--- a/sound/soc/samsung/littlemill.c
+++ b/sound/soc/samsung/littlemill.c
@@ -189,6 +189,9 @@ static int littlemill_late_probe(struct snd_soc_card *card)
 	/* This will check device compatibility itself */
 	wm8958_mic_detect(codec, &littlemill_headset, NULL, NULL);
 
+	/* As will this */
+	wm8994_mic_detect(codec, &littlemill_headset, 1);
+
 	return 0;
 }
 
-- 
1.7.9.rc1
