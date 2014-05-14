From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/6] ASoC: ak4642: Fix typo zoro -> zero
Date: Wed, 14 May 2014 09:37:33 +0200
Message-ID: <1400053058-1115-2-git-send-email-s.hauer@pengutronix.de>
References: <1400053058-1115-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 54197265132
 for <alsa-devel@alsa-project.org>; Wed, 14 May 2014 09:38:06 +0200 (CEST)
In-Reply-To: <1400053058-1115-1-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/codecs/ak4642.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 92655cc..3373a9c 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -98,7 +98,7 @@
 #define MGAIN0		(1 << 0) /* MIC amp gain*/
 
 /* TIMER */
-#define ZTM(param)	((param & 0x3) << 4) /* ALC Zoro Crossing TimeOut */
+#define ZTM(param)	((param & 0x3) << 4) /* ALC Zero Crossing TimeOut */
 #define WTM(param)	(((param & 0x4) << 4) | ((param & 0x3) << 2))
 
 /* ALC_CTL1 */
-- 
2.0.0.rc0
