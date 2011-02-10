From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: Use explicit sequence for WM8903
	bias off
Date: Thu, 10 Feb 2011 14:44:48 +0000
Message-ID: <1297349088-26820-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1297349088-26820-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 60F8824524
	for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2011 15:44:52 +0100 (CET)
In-Reply-To: <1297349088-26820-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This makes no real difference compared to the write sequencer sequence
that was previously used but can run without a clock being provided.
Also remove the write sequencer support code as this was the last use
of it.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |   66 ++++++++++++++------------------------------
 1 files changed, 21 insertions(+), 45 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index c7faeea..20325b3 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -230,8 +230,6 @@ struct wm8903_priv {
 	/* Reference count */
 	int class_w_users;
 
-	struct completion wseq;
-
 	struct snd_soc_jack *mic_jack;
 	int mic_det;
 	int mic_short;
@@ -267,41 +265,6 @@ static int wm8903_volatile_register(struct snd_soc_codec *codec, unsigned int re
 	}
 }
 
-static int wm8903_run_sequence(struct snd_soc_codec *codec, unsigned int start)
-{
-	u16 reg[5];
-	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
-
-	BUG_ON(start > 48);
-
-	/* Enable the sequencer if it's not already on */
-	reg[0] = snd_soc_read(codec, WM8903_WRITE_SEQUENCER_0);
-	snd_soc_write(codec, WM8903_WRITE_SEQUENCER_0,
-		      reg[0] | WM8903_WSEQ_ENA);
-
-	dev_dbg(codec->dev, "Starting sequence at %d\n", start);
-
-	snd_soc_write(codec, WM8903_WRITE_SEQUENCER_3,
-		     start | WM8903_WSEQ_START);
-
-	/* Wait for it to complete.  If we have the interrupt wired up then
-	 * that will break us out of the poll early.
-	 */
-	do {
-		wait_for_completion_timeout(&wm8903->wseq,
-					    msecs_to_jiffies(10));
-
-		reg[4] = snd_soc_read(codec, WM8903_WRITE_SEQUENCER_4);
-	} while (reg[4] & WM8903_WSEQ_BUSY);
-
-	dev_dbg(codec->dev, "Sequence complete\n");
-
-	/* Disable the sequencer again if we enabled it */
-	snd_soc_write(codec, WM8903_WRITE_SEQUENCER_0, reg[0]);
-
-	return 0;
-}
-
 static void wm8903_reset(struct snd_soc_codec *codec)
 {
 	snd_soc_write(codec, WM8903_SW_RESET_AND_ID, 0);
@@ -1218,11 +1181,26 @@ static int wm8903_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_OFF:
-		snd_soc_update_bits(codec, WM8903_CLOCK_RATES_2,
-				    WM8903_CLK_SYS_ENA, WM8903_CLK_SYS_ENA);
-		wm8903_run_sequence(codec, 32);
-		snd_soc_update_bits(codec, WM8903_CLOCK_RATES_2,
-				    WM8903_CLK_SYS_ENA, 0);
+		snd_soc_update_bits(codec, WM8903_BIAS_CONTROL_0,
+				    WM8903_BIAS_ENA, 0);
+
+		snd_soc_update_bits(codec, WM8903_VMID_CONTROL_0,
+				    WM8903_VMID_SOFT_MASK,
+				    2 << WM8903_VMID_SOFT_SHIFT);
+
+		snd_soc_update_bits(codec, WM8903_VMID_CONTROL_0,
+				    WM8903_VMID_BUF_ENA, 0);
+
+		msleep(290);
+
+		snd_soc_update_bits(codec, WM8903_VMID_CONTROL_0,
+				    WM8903_VMID_TIE_ENA | WM8903_BUFIO_ENA |
+				    WM8903_VMID_IO_ENA | WM8903_VMID_RES_MASK |
+				    WM8903_VMID_SOFT_MASK |
+				    WM8903_VMID_BUF_ENA, 0);
+
+		snd_soc_update_bits(codec, WM8903_BIAS_CONTROL_0,
+				    WM8903_STARTUP_BIAS_ENA, 0);
 		break;
 	}
 
@@ -1864,8 +1842,7 @@ static irqreturn_t wm8903_irq(int irq, void *data)
 	int_val = snd_soc_read(codec, WM8903_INTERRUPT_STATUS_1) & mask;
 
 	if (int_val & WM8903_WSEQ_BUSY_EINT) {
-		dev_dbg(codec->dev, "Write sequencer done\n");
-		complete(&wm8903->wseq);
+		dev_warn(codec->dev, "Write sequencer done\n");
 	}
 
 	/*
@@ -2120,7 +2097,6 @@ static int wm8903_probe(struct snd_soc_codec *codec)
 	u16 val;
 
 	wm8903->codec = codec;
-	init_completion(&wm8903->wseq);
 
 	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
 	if (ret != 0) {
-- 
1.7.2.3
