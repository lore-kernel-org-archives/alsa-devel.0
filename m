Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 0680B26532C
 for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2014 09:53:00 +0200 (CEST)
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 4 Sep 2014 10:52:53 +0300
Message-ID: <1409817173-29234-1-git-send-email-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Subject: [alsa-devel] [PATCH] ASoC: davinci-mcasp: Correct rx format unit
	configuration
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, jsarha@ti.com, zonque@gmail.com
List-ID: <alsa-devel@alsa-project.org>

In case of capture we should not use rotation. The reverse and mask is
enough to get the data align correctly from the bus to MCU:
Format	  data from bus    after reverse (XRBUF)
S16_LE:  |LSB|MSB|xxx|xxx|  |xxx|xxx|MSB|LSB|
S24_3LE: |LSB|DAT|MSB|xxx|  |xxx|MSB|DAT|LSB|
S24_LE:  |LSB|DAT|MSB|xxx|  |xxx|MSB|DAT|LSB|
S32_LE:  |LSB|DAT|DAT|MSB|  |MSB|DAT|DAT|LSB|

With this patch all supported formats will work for playback and capture.

Reported-by: Jyri Sarha <jsarha@ti.com> (broken S24_3LE capture)
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 6a6b2ff7d7d7..68347b55f6e1 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -467,8 +467,17 @@ static int davinci_config_channel_size(struct davinci_mcasp *mcasp,
 {
 	u32 fmt;
 	u32 tx_rotate = (word_length / 4) & 0x7;
-	u32 rx_rotate = (32 - word_length) / 4;
 	u32 mask = (1ULL << word_length) - 1;
+	/*
+	 * For captured data we should not rotate, inversion and masking is
+	 * enoguh to get the data to the right position:
+	 * Format	  data from bus		after reverse (XRBUF)
+	 * S16_LE:	|LSB|MSB|xxx|xxx|	|xxx|xxx|MSB|LSB|
+	 * S24_3LE:	|LSB|DAT|MSB|xxx|	|xxx|MSB|DAT|LSB|
+	 * S24_LE:	|LSB|DAT|MSB|xxx|	|xxx|MSB|DAT|LSB|
+	 * S32_LE:	|LSB|DAT|DAT|MSB|	|MSB|DAT|DAT|LSB|
+	 */
+	u32 rx_rotate = 0;
 
 	/*
 	 * if s BCLK-to-LRCLK ratio has been configured via the set_clkdiv()
-- 
2.1.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
