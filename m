From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: [PATCH v2 2/5] ASoC: ad193x: fix dac word len setting
Date: Fri, 12 Aug 2011 18:04:11 -0400
Message-ID: <1313186654-22520-2-git-send-email-scott.jiang.linux@gmail.com>
References: <1313186654-22520-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D3701039B4
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Aug 2011 10:57:58 +0200 (CEST)
In-Reply-To: <1313186654-22520-1-git-send-email-scott.jiang.linux@gmail.com>
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

dac word len value should left shift before setting

Signed-off-by: Scott Jiang <scott.jiang.linux@gmail.com>
---
 sound/soc/codecs/ad193x.c |    3 ++-
 sound/soc/codecs/ad193x.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 2374ca5..f1a8be5 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -307,7 +307,8 @@ static int ad193x_hw_params(struct snd_pcm_substream *substream,
 	snd_soc_write(codec, AD193X_PLL_CLK_CTRL0, reg);
 
 	reg = snd_soc_read(codec, AD193X_DAC_CTRL2);
-	reg = (reg & (~AD193X_DAC_WORD_LEN_MASK)) | word_len;
+	reg = (reg & (~AD193X_DAC_WORD_LEN_MASK))
+		| (word_len << AD193X_DAC_WORD_LEN_SHFT);
 	snd_soc_write(codec, AD193X_DAC_CTRL2, reg);
 
 	reg = snd_soc_read(codec, AD193X_ADC_CTRL1);
diff --git a/sound/soc/codecs/ad193x.h b/sound/soc/codecs/ad193x.h
index c1029d2..cccc2e8 100644
--- a/sound/soc/codecs/ad193x.h
+++ b/sound/soc/codecs/ad193x.h
@@ -34,6 +34,7 @@
 #define AD193X_DAC_LEFT_HIGH    (1 << 3)
 #define AD193X_DAC_BCLK_INV     (1 << 7)
 #define AD193X_DAC_CTRL2        0x804
+#define AD193X_DAC_WORD_LEN_SHFT        3
 #define AD193X_DAC_WORD_LEN_MASK        0x18
 #define AD193X_DAC_MASTER_MUTE  1
 #define AD193X_DAC_CHNL_MUTE    0x805
-- 
1.7.0.4
