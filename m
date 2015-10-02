From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] ASoC: Document DAI signal polarity
Date: Fri,  2 Oct 2015 08:33:04 -0700
Message-ID: <1443799984-26679-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 by alsa0.perex.cz (Postfix) with ESMTP id BE4E92612AF
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2015 17:33:10 +0200 (CEST)
Received: by pacex6 with SMTP id ex6so109588175pac.0
 for <alsa-devel@alsa-project.org>; Fri, 02 Oct 2015 08:33:09 -0700 (PDT)
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
Cc: albertchen@realtek.com, broonie@kernel.org, Anatol Pomozov <anatol.pomozov@gmail.com>, lars@metafoo.de, benoit.thebaudeau.dev@gmail.com
List-Id: alsa-devel@alsa-project.org

Currently there is no clear definition of what FSYNC polarity is.
Different drivers use its own definition of what is "normal" and what is
"inverted" fsync. This leads to compatibility problems between drivers.

For example TegraX1 driver assumes that DSP-A format with frames
starting at rising FSYNC edge has "inverted" polarity,
while RT5677 assumes it is "normal" polarity.

Explicitly specify meaning of BCLK/FSYNC polarity to avoid future
compatibility problems.

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 include/sound/soc-dai.h | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 2df96b1..91e2e61 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -48,10 +48,25 @@ struct snd_compr_stream;
 #define SND_SOC_DAIFMT_GATED		(0 << 4) /* clock is gated */
 
 /*
- * DAI hardware signal inversions.
+ * DAI hardware signal polarity.
  *
  * Specifies whether the DAI can also support inverted clocks for the specified
  * format.
+ *
+ * BCLK:
+ * - "normal" polarity means signal is available at rising edge of BCLK
+ * - "inverted" polarity means signal is available at falling edge of BCLK
+ *
+ * FSYNC "normal" polarity depends on the frame format:
+ * - I2S: frame consists of left then right channel data. Left channel starts
+ *      with falling FSYNC edge, right channel starts with rising FSYNC edge.
+ * - Left/Right Justified: frame consists of left then right channel data.
+ *      Left channel starts with rising FSYNC edge, right channel starts with
+ *      falling FSYNC edge.
+ * - DSP A/B: Frame starts with rising FSYNC edge.
+ * - AC97: Frame starts with rising FSYNC edge.
+ *
+ * "Negative" FSYNC polarity is the one opposite of "normal" polarity.
  */
 #define SND_SOC_DAIFMT_NB_NF		(0 << 8) /* normal bit clock + frame */
 #define SND_SOC_DAIFMT_NB_IF		(2 << 8) /* normal BCLK + inv FRM */
-- 
2.6.0.rc2.230.g3dd15c0
