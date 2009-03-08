From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] CS4270: comments: slave mode is now supported
Date: Sun,  8 Mar 2009 17:16:03 +0100
Message-ID: <1236528963-11943-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B4981037ED
	for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2009 17:16:13 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

Just a minor thing: make the comments reflect the new slave mode
feature.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Timur Tabi <timur@freescale.com>
---
 sound/soc/codecs/cs4270.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 4c7e546..0558674 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -14,12 +14,11 @@
  *
  * 1) Software mode is supported.  Stand-alone mode is not supported.
  * 2) Only I2C is supported, not SPI
- * 3) Only Master mode is supported, not Slave.
- * 4) The machine driver's 'startup' function must call
+ * 3) The machine driver's 'startup' function must call
  *    cs4270_set_dai_sysclk() with the value of MCLK.
- * 5) Only I2S and left-justified modes are supported
- * 6) Power management is not supported
- * 7) The only supported control is volume and hardware mute (if enabled)
+ * 4) Only I2S and left-justified modes are supported
+ * 5) Power management is not supported
+ * 6) The only supported control is volume and hardware mute (if enabled)
  */
 
 #include <linux/module.h>
-- 
1.6.1.3
