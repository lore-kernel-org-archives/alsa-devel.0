From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Document DAI signal polarity" to the
	asoc tree
Date: Fri, 23 Oct 2015 08:09:01 +0900
Message-ID: <E1ZpOyj-0008KB-TU@finisterre>
References: <1443799984-26679-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 60008266ACC
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:09:12 +0200 (CEST)
In-Reply-To: <1443799984-26679-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Document DAI signal polarity

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 1d387a3fd86f2acf70803262c5a5a5a89df0e097 Mon Sep 17 00:00:00 2001
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Thu, 8 Oct 2015 09:37:51 -0700
Subject: [PATCH] ASoC: Document DAI signal polarity

Currently there is no clear definition of what FSYNC polarity is.
Different drivers use its own definition of what is "normal" and what is
"inverted" fsync. This leads to compatibility problems between drivers.

For example TegraX1 driver assumes that DSP-A format with frames
starting at rising FSYNC edge has "inverted" polarity,
while RT5677 assumes it is "normal" polarity.

Explicitly specify meaning of BCLK/FSYNC polarity to avoid future
compatibility problems.

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.6.1
