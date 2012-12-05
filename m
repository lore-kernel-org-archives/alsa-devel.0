From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/3] ALSA: ASoC: McASP: determine XSSZ value
	programatically
Date: Wed,  5 Dec 2012 16:37:41 +0100
Message-ID: <1354721862-10318-2-git-send-email-zonque@gmail.com>
References: <1354721862-10318-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 20E93260376
 for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2012 16:37:54 +0100 (CET)
In-Reply-To: <1354721862-10318-1-git-send-email-zonque@gmail.com>
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
Cc: khilman@ti.com, mporter@ti.com, broonie@opensource.wolfsonmicro.com, nsekhar@ti.com, vaibhav.bedia@ti.com, gururaja.hebbar@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

This shouldn't change any functionality and is just a preparation a
special case handling.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/davinci/davinci-mcasp.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 023a70d..68a2ea0 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -621,48 +621,48 @@ static int davinci_mcasp_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 static int davinci_config_channel_size(struct davinci_audio_dev *dev,
 				       int channel_size)
 {
-	u32 fmt = 0;
-	u32 mask, rotate;
+	u32 fmt, mask, rotate;
+	u8 n_bits = 0;
 
 	switch (channel_size) {
 	case DAVINCI_AUDIO_WORD_8:
-		fmt = 0x03;
+		n_bits = 8;
 		rotate = 6;
 		mask = 0x000000ff;
 		break;
 
 	case DAVINCI_AUDIO_WORD_12:
-		fmt = 0x05;
+		n_bits = 12;
 		rotate = 5;
 		mask = 0x00000fff;
 		break;
 
 	case DAVINCI_AUDIO_WORD_16:
-		fmt = 0x07;
+		n_bits = 16;
 		rotate = 4;
 		mask = 0x0000ffff;
 		break;
 
 	case DAVINCI_AUDIO_WORD_20:
-		fmt = 0x09;
+		n_bits = 20;
 		rotate = 3;
 		mask = 0x000fffff;
 		break;
 
 	case DAVINCI_AUDIO_WORD_24:
-		fmt = 0x0B;
+		n_bits = 24;
 		rotate = 2;
 		mask = 0x00ffffff;
 		break;
 
 	case DAVINCI_AUDIO_WORD_28:
-		fmt = 0x0D;
+		n_bits = 28;
 		rotate = 1;
 		mask = 0x0fffffff;
 		break;
 
 	case DAVINCI_AUDIO_WORD_32:
-		fmt = 0x0F;
+		n_bits = 32;
 		rotate = 0;
 		mask = 0xffffffff;
 		break;
@@ -671,6 +671,9 @@ static int davinci_config_channel_size(struct davinci_audio_dev *dev,
 		return -EINVAL;
 	}
 
+	/* mapping of the XSSZ bit-field as described in the datasheet */
+	fmt = (n_bits >> 1) - 1;
+
 	mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMT_REG,
 					RXSSZ(fmt), RXSSZ(0x0F));
 	mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
-- 
1.7.11.7
