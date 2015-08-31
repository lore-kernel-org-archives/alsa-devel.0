From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] ASoC: Document DAI signal polarity
Date: Mon, 31 Aug 2015 13:50:58 -0700
Message-ID: <1441054258-33200-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A6C826053D
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2015 22:51:06 +0200 (CEST)
Received: by pacdd16 with SMTP id dd16so150438713pac.2
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2015 13:51:04 -0700 (PDT)
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
Cc: liam.r.girdwood@linux.intel.com, albertchen@realtek.com, broonie@kernel.org, lars@metafoo.de, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Per discussion at [1] currently there is no clear definition of what is FSYNC polarity.
Different drivers use its own definition of what is "normal" and what is "inverted"
fsync in different modes. This leads to compatibility problems between drivers.

Explicitly specify meaning of BCLK/FSYNC polarity.

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2015-August/097121.html

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 include/sound/soc-dai.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 2df96b1..c8170c4 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -48,10 +48,15 @@ struct snd_compr_stream;
 #define SND_SOC_DAIFMT_GATED		(0 << 4) /* clock is gated */
 
 /*
- * DAI hardware signal inversions.
+ * DAI hardware signal polarity.
  *
- * Specifies whether the DAI can also support inverted clocks for the specified
- * format.
+ * For BCLK:
+ *  - "normal" polarity means signal sensing happens at rising edge of BCLK
+ *  - "inverted" polarity means signal sensing happens at falling edge of BCLK
+ *
+ * For FSYNC:
+ *  - "normal" polarity means frame starts at rising edge of FSYNC
+ *  - "inverted" polarity means frame starts at falling edge of FSYNC
  */
 #define SND_SOC_DAIFMT_NB_NF		(0 << 8) /* normal bit clock + frame */
 #define SND_SOC_DAIFMT_NB_IF		(2 << 8) /* normal BCLK + inv FRM */
-- 
2.5.0.457.gab17608
