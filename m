From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8825: lock longer to avoid playback
	pop upon resume
Date: Tue, 29 Nov 2016 10:05:16 +0800
Message-ID: <1480385116-11900-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C0970266FD9
 for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2016 03:05:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

There is an issue about pop noise in NAU88L25 as follows.
Issue 54078: Chell_headphone pop back from S3
(1)Play directly to hw, bypassing CRAS:
sox -b 16 -n -t alsa hw:0,0 synth sine 200 sine 200
(2)Close lid or powerd_dbus_suspend, then press a key to resume.
(3)no audio after resume
(4)Audio will be back after close then reopen the pcm device.

After verification, we find one defect is that semaphone lock is not
long enough and expired. In this situation, the playback comes back
early but pauses a while to wait for the crosstalk detection done.
But the detection spends too much time and lock time is up. Therefore,
the playback and jack detection sequence interfere to each other.
That breaks sequence and makes noise. The driver extends the lock
time for the issue.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 3f9137f..2b89569 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1233,7 +1233,7 @@ static int nau8825_hw_params(struct snd_pcm_substream *substream,
 	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
 	unsigned int val_len = 0, osr;
 
-	nau8825_sema_acquire(nau8825, 2 * HZ);
+	nau8825_sema_acquire(nau8825, 3 * HZ);
 
 	/* CLK_DAC or CLK_ADC = OSR * FS
 	 * DAC or ADC clock frequency is defined as Over Sampling Rate (OSR)
@@ -1293,7 +1293,7 @@ static int nau8825_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
 	unsigned int ctrl1_val = 0, ctrl2_val = 0;
 
-	nau8825_sema_acquire(nau8825, 2 * HZ);
+	nau8825_sema_acquire(nau8825, 3 * HZ);
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
@@ -2121,7 +2121,7 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 		 * fered by cross talk process, the driver make the playback
 		 * preparation halted until cross talk process finish.
 		 */
-		nau8825_sema_acquire(nau8825, 2 * HZ);
+		nau8825_sema_acquire(nau8825, 3 * HZ);
 		nau8825_configure_mclk_as_sysclk(regmap);
 		/* MCLK not changed by clock tree */
 		regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
@@ -2169,7 +2169,7 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 		 * fered by cross talk process, the driver make the playback
 		 * preparation halted until cross talk process finish.
 		 */
-		nau8825_sema_acquire(nau8825, 2 * HZ);
+		nau8825_sema_acquire(nau8825, 3 * HZ);
 		/* Higher FLL reference input frequency can only set lower
 		 * gain error, such as 0000 for input reference from MCLK
 		 * 12.288Mhz.
@@ -2191,7 +2191,7 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 		 * fered by cross talk process, the driver make the playback
 		 * preparation halted until cross talk process finish.
 		 */
-		nau8825_sema_acquire(nau8825, 2 * HZ);
+		nau8825_sema_acquire(nau8825, 3 * HZ);
 		/* If FLL reference input is from low frequency source,
 		 * higher error gain can apply such as 0xf which has
 		 * the most sensitive gain error correction threshold,
@@ -2217,7 +2217,7 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 		 * fered by cross talk process, the driver make the playback
 		 * preparation halted until cross talk process finish.
 		 */
-		nau8825_sema_acquire(nau8825, 2 * HZ);
+		nau8825_sema_acquire(nau8825, 3 * HZ);
 		/* If FLL reference input is from low frequency source,
 		 * higher error gain can apply such as 0xf which has
 		 * the most sensitive gain error correction threshold,
-- 
2.6.4
