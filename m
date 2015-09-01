From: Albert Chen <albertchen@realtek.com>
Subject: Re: [PATCH] ASoC: Document DAI signal polarity
Date: Tue, 1 Sep 2015 01:27:26 +0000
Message-ID: <9EE27E29D4384141AEEB23E69581718501431DDB@RTITMBSV05.realtek.com.tw>
References: <1441054258-33200-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 96F332616F3
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2015 03:27:35 +0200 (CEST)
In-Reply-To: <1441054258-33200-1-git-send-email-anatol.pomozov@gmail.com>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, "broonie@kernel.org" <broonie@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Loop more

-----Original Message-----
From: Anatol Pomozov [mailto:anatol.pomozov@gmail.com] 
Sent: Tuesday, September 01, 2015 4:51 AM
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org; lars@metafoo.de; Albert Chen; liam.r.girdwood@linux.intel.com; Anatol Pomozov
Subject: [PATCH] ASoC: Document DAI signal polarity

Per discussion at [1] currently there is no clear definition of what is FSYNC polarity.
Different drivers use its own definition of what is "normal" and what is "inverted"
fsync in different modes. This leads to compatibility problems between drivers.

Explicitly specify meaning of BCLK/FSYNC polarity.

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2015-August/097121.html

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 include/sound/soc-dai.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h index 2df96b1..c8170c4 100644
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
+ *  - "normal" polarity means signal sensing happens at rising edge of 
+ BCLK
+ *  - "inverted" polarity means signal sensing happens at falling edge 
+ of BCLK
+ *
+ * For FSYNC:
+ *  - "normal" polarity means frame starts at rising edge of FSYNC
+ *  - "inverted" polarity means frame starts at falling edge of FSYNC
  */
 #define SND_SOC_DAIFMT_NB_NF		(0 << 8) /* normal bit clock + frame */
 #define SND_SOC_DAIFMT_NB_IF		(2 << 8) /* normal BCLK + inv FRM */
--
2.5.0.457.gab17608


------Please consider the environment before printing this e-mail.
