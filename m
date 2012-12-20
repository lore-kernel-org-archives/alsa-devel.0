From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] ASoC: sta529: Fix update register bits in
 sta529_set_dai_fmt
Date: Thu, 20 Dec 2012 16:17:25 +0800
Message-ID: <1355991445.11688.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f49.google.com (mail-da0-f49.google.com
 [209.85.210.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CE00265181
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2012 09:17:40 +0100 (CET)
Received: by mail-da0-f49.google.com with SMTP id v40so1380957dad.8
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2012 00:17:39 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Both the mask and mode settings are wrong in current code.

According to the datasheet:

S2PCFG0 (0x0A)
BIT[3:1] DATA_FORMAT
        serial interface protocol format:
        000: left Justified
        001: I2S (default)
        010: right justified
        100: PCM no delay
        101: PCM delay
        111: DSP

Thus fixes the defines for LEFT_J_DATA_FORMAT, I2S_DATA_FORMAT, and
RIGHT_J_DATA_FORMAT.
Also adds define for DATA_FORMAT_MSK.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Rajeev,
I don't have this hardware, can you test this patch?
Thanks,
Axel
 sound/soc/codecs/sta529.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/sta529.c b/sound/soc/codecs/sta529.c
index ab355c4..40c07be 100644
--- a/sound/soc/codecs/sta529.c
+++ b/sound/soc/codecs/sta529.c
@@ -74,9 +74,10 @@
 				SNDRV_PCM_FMTBIT_S32_LE)
 #define	S2PC_VALUE		0x98
 #define CLOCK_OUT		0x60
-#define LEFT_J_DATA_FORMAT	0x10
-#define I2S_DATA_FORMAT		0x12
-#define RIGHT_J_DATA_FORMAT	0x14
+#define DATA_FORMAT_MSK		0x0E
+#define LEFT_J_DATA_FORMAT	0x00
+#define I2S_DATA_FORMAT		0x02
+#define RIGHT_J_DATA_FORMAT	0x04
 #define CODEC_MUTE_VAL		0x80
 
 #define POWER_CNTLMSAK		0x40
@@ -289,7 +290,7 @@ static int sta529_set_dai_fmt(struct snd_soc_dai *codec_dai, u32 fmt)
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, STA529_S2PCFG0, 0x0D, mode);
+	snd_soc_update_bits(codec, STA529_S2PCFG0, DATA_FORMAT_MSK, mode);
 
 	return 0;
 }
-- 
1.7.9.5
