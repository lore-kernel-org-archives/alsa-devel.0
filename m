From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: lock longer to avoid playback
	pop upon resume" to the asoc tree
Date: Wed, 30 Nov 2016 18:07:31 +0000
Message-ID: <E1cC9I3-0008DX-CZ@debutante>
References: <1480385116-11900-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E8140266BA4
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2016 19:07:37 +0100 (CET)
In-Reply-To: <1480385116-11900-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, benzh@chromium.org, WTLI@nuvoton.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com, broonie@kernel.org, CTLIN0@nuvoton.com, yong.zhi@intel.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: lock longer to avoid playback pop upon resume

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

>From 2263fddcd0ba9d8e75a90b1359f92d3b9d0b78b3 Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Tue, 29 Nov 2016 10:05:16 +0800
Subject: [PATCH] ASoC: nau8825: lock longer to avoid playback pop upon resume

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 3f9137f60c0d..2b89569333a1 100644
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
2.10.2
