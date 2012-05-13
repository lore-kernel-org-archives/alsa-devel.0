From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: max98095: Single bit bitfields should be
	unsigned
Date: Sun, 13 May 2012 23:31:57 +0100
Message-ID: <1336948317-4443-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C025C248AB
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 00:32:03 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

There's no space for the sign bit.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/max98095.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/max98095.h b/include/sound/max98095.h
index 65b1c90..e87ae67 100644
--- a/include/sound/max98095.h
+++ b/include/sound/max98095.h
@@ -55,7 +55,7 @@ struct max98095_pdata {
 	 * 0 = PIN5 not supported
 	 * 1 = PIN5 supported
 	 */
-	int jack_detect_pin5en:1;
+	unsigned int jack_detect_pin5en:1;
 
 	/* Slew amount for jack detection. Calculated as 4 * (delay + 1).
 	 * Default delay is 24 to get a time of 100ms.
-- 
1.7.10
