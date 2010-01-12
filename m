From: Thomas Weber <weber@corscience.de>
Subject: [PATCH] ASoC: TWL4030: Fix typo in comment in header
	file
Date: Tue, 12 Jan 2010 17:07:18 +0100
Message-ID: <1263312438-4193-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
	by alsa0.perex.cz (Postfix) with ESMTP id D9C2B103806
	for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2010 17:07:53 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: peter.ujfalusi@nokia.com
Cc: Thomas Weber <weber@corscience.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 sound/soc/codecs/twl4030.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/twl4030.h b/sound/soc/codecs/twl4030.h
index dd6396e..f206d24 100644
--- a/sound/soc/codecs/twl4030.h
+++ b/sound/soc/codecs/twl4030.h
@@ -25,7 +25,7 @@
 /* Register descriptions are here */
 #include <linux/mfd/twl4030-codec.h>
 
-/* Sgadow register used by the audio driver */
+/* Shadow register used by the audio driver */
 #define TWL4030_REG_SW_SHADOW		0x4A
 #define TWL4030_CACHEREGNUM	(TWL4030_REG_SW_SHADOW + 1)
 
-- 
1.6.4.4
