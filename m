From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: [PATCH v2 1/5] ASoC: ad193x: fix registers definition
Date: Fri, 12 Aug 2011 18:04:10 -0400
Message-ID: <1313186654-22520-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142])
	by alsa0.perex.cz (Postfix) with ESMTP id 887CD1039B4
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Aug 2011 10:59:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Scott Jiang <scott.jiang.linux@gmail.com>
List-Id: alsa-devel@alsa-project.org

fix dac word len mask and adc tdm fmt shift value

Signed-off-by: Scott Jiang <scott.jiang.linux@gmail.com>
---
 sound/soc/codecs/ad193x.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ad193x.h b/sound/soc/codecs/ad193x.h
index 9747b54..c1029d2 100644
--- a/sound/soc/codecs/ad193x.h
+++ b/sound/soc/codecs/ad193x.h
@@ -34,7 +34,7 @@
 #define AD193X_DAC_LEFT_HIGH    (1 << 3)
 #define AD193X_DAC_BCLK_INV     (1 << 7)
 #define AD193X_DAC_CTRL2        0x804
-#define AD193X_DAC_WORD_LEN_MASK	0xC
+#define AD193X_DAC_WORD_LEN_MASK        0x18
 #define AD193X_DAC_MASTER_MUTE  1
 #define AD193X_DAC_CHNL_MUTE    0x805
 #define AD193X_DACL1_MUTE       0
@@ -63,7 +63,7 @@
 #define AD193X_ADC_CTRL1        0x80f
 #define AD193X_ADC_SERFMT_MASK		0x60
 #define AD193X_ADC_SERFMT_STEREO	(0 << 5)
-#define AD193X_ADC_SERFMT_TDM		(1 << 2)
+#define AD193X_ADC_SERFMT_TDM		(1 << 5)
 #define AD193X_ADC_SERFMT_AUX		(2 << 5)
 #define AD193X_ADC_WORD_LEN_MASK	0x3
 #define AD193X_ADC_CTRL2        0x810
-- 
1.7.0.4
