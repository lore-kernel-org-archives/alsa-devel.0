From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] ASoC: Document DAI signal polarity
Date: Thu,  1 Oct 2015 11:09:19 -0700
Message-ID: <1443722959-5094-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 by alsa0.perex.cz (Postfix) with ESMTP id AAE532667EE
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 20:09:43 +0200 (CEST)
Received: by padhy16 with SMTP id hy16so81362207pad.1
 for <alsa-devel@alsa-project.org>; Thu, 01 Oct 2015 11:09:42 -0700 (PDT)
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

Currently there is no clear definition of what is FSYNC polarity.
Different drivers use its own definition of what is "normal" and what is
"inverted" fsync. This leads to compatibility problems between drivers.

For example TegraX1 driver assumes that DSP-A format with frames
starting at rising FSYNC edge has "negative" polarity,
while RT5677 assumes it is "positive" polarity.

Explicitly specify meaning of BCLK/FSYNC polarity to avoid future
compatibility problems.

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 include/sound/soc-dai.h | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 2df96b1..45198db 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -48,10 +48,22 @@ struct snd_compr_stream;
 #define SND_SOC_DAIFMT_GATED		(0 << 4) /* clock is gated */
 
 /*
- * DAI hardware signal inversions.
+ * DAI hardware signal polarity.
  *
- * Specifies whether the DAI can also support inverted clocks for the specified
- * format.
+ * BCLK:
+ * - "normal" polarity means signal is available at rising edge of BCLK
+ * - "inverted" polarity means signal is available at falling edge of BCLK
+ *
+ * FSYNC "normal" polarity depends on the frame format:
+ * - I2S: frame consists of left then right channel data. Left channel starts
+ *      with falling FSYNC edge, right channel starts with rising FSYNC edge.
+ * - I2S right/left justified: frame consists of left then right channel data.
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
