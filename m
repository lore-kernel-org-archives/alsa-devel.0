From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: tlv320dac33: typo fix in the header
Date: Wed, 21 Oct 2009 09:58:35 +0300
Message-ID: <1256108315-26343-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 17053103827
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Oct 2009 08:59:12 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Fix the definition of DAC33_LTM field, the LTM bits in
FIFO_IRQ_MODE_B register are starting at bit 6.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.h b/sound/soc/codecs/tlv320dac33.h
index 0fedd70..eb8ae07 100644
--- a/sound/soc/codecs/tlv320dac33.h
+++ b/sound/soc/codecs/tlv320dac33.h
@@ -186,7 +186,7 @@
 #define DAC33_NSM(x)			(x << 0)
 #define DAC33_PSM(x)			(x << 2)
 #define DAC33_ATM(x)			(x << 4)
-#define DAC33_LTM(x)			(x << 4)
+#define DAC33_LTM(x)			(x << 6)
 
 /* DAC33_DAC_CTRL_A (0x2C) */
 #define DAC33_DACRATE(x)		(x << 0)
-- 
1.6.5.1
