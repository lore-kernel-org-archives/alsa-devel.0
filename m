From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8825: erase pop noise by soft mute
Date: Wed, 14 Sep 2016 15:47:32 +0800
Message-ID: <1473839252-18868-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EFFE261A5E
 for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2016 09:47:39 +0200 (CEST)
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

The patch is a solution to fix the following issue.
Chrome OS Issue 54078: Chell_headphone pop back from S3

When the system resume from S3 and playing music, there is a pop noise 
happened. It looks like system changes the sound immediately from maximum 
volume to the volume configured by user in playback beginning. The sound 
signal changes sharply, and there is a DC offset in the signal to make 
pop noise. Therefore, the driver introduces the soft mute to avoid the 
side effect of the unstable signal.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 52 +++++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/nau8825.h |  3 +++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index e643be9..3bcba14 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -754,8 +754,9 @@ static void nau8825_xtalk_measure(struct nau8825 *nau8825)
 			nau8825->imp_rms[NAU8825_XTALK_HPR_R2L],
 			nau8825->imp_rms[NAU8825_XTALK_HPL_R2L]);
 		dev_dbg(nau8825->dev, "cross talk sidetone: %x\n", sidetone);
+		nau8825->sidetone = (sidetone << 8) | sidetone;
 		regmap_write(nau8825->regmap, NAU8825_REG_DAC_DGAIN_CTRL,
-					(sidetone << 8) | sidetone);
+			nau8825->sidetone);
 		nau8825_xtalk_clean(nau8825);
 		nau8825->xtalk_state = NAU8825_XTALK_DONE;
 		break;
@@ -1334,6 +1335,50 @@ int nau8825_enable_jack_detect(struct snd_soc_codec *codec,
 }
 EXPORT_SYMBOL_GPL(nau8825_enable_jack_detect);
 
+/**
+ * nau8825_soft_mute - provide soft mute function
+ *
+ * @component: codec component
+ * @mute: 1 for mute; 0 for unmute
+ *
+ * Enable soft mute to gradually lower DAC volume to zero;
+ * Soft unmute will gradually increase DAC volume to volume setting.
+ * We found that signal at beginning is not stable in some application.
+ * That signal changes sharply will make pop noise; but the steps of soft
+ * mute is not enough in codec to cover the change period. Thus, the driver
+ * deffers 20ms to do soft unmute for the pop noise issue.
+ */
+int nau8825_soft_mute(struct snd_soc_codec *codec, int mute)
+{
+	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
+
+	if (mute) {
+		cancel_delayed_work(&nau8825->softmute_work);
+		/* Disable sidetone to avoid it affect the mute function */
+		regmap_write(nau8825->regmap, NAU8825_REG_DAC_DGAIN_CTRL, 0);
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_MUTE_CTRL,
+			NAU8825_DAC_SOFT_MUTE, NAU8825_DAC_SOFT_MUTE);
+	} else {
+		/* Defer 20ms to do soft unmute to skip the unstable signal */
+		schedule_delayed_work(&nau8825->softmute_work,
+			msecs_to_jiffies(20));
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nau8825_soft_mute);
+
+static void nau8825_unmute_deferred(struct work_struct *work)
+{
+	struct nau8825 *nau8825 = container_of(work,
+		struct nau8825, softmute_work.work);
+
+	/* Restore sidetone */
+	regmap_write(nau8825->regmap, NAU8825_REG_DAC_DGAIN_CTRL,
+		nau8825->sidetone);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_MUTE_CTRL,
+		NAU8825_DAC_SOFT_MUTE, 0);
+}
 
 static bool nau8825_is_jack_inserted(struct regmap *regmap)
 {
@@ -2150,6 +2195,7 @@ static int nau8825_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 
 static int nau8825_resume_setup(struct nau8825 *nau8825)
 {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(nau8825->dapm);
 	struct regmap *regmap = nau8825->regmap;
 
 	/* Close clock when jack type detection at manual mode */
@@ -2169,6 +2215,8 @@ static int nau8825_resume_setup(struct nau8825 *nau8825)
 		NAU8825_JACK_DET_DB_BYPASS, NAU8825_JACK_DET_DB_BYPASS);
 	regmap_update_bits(regmap, NAU8825_REG_INTERRUPT_DIS_CTRL,
 		NAU8825_IRQ_INSERT_DIS | NAU8825_IRQ_EJECT_DIS, 0);
+	/* Enable codec soft mute */
+	nau8825_soft_mute(codec, 1);
 
 	return 0;
 }
@@ -2393,8 +2441,10 @@ static int nau8825_i2c_probe(struct i2c_client *i2c,
 	 */
 	nau8825->xtalk_state = NAU8825_XTALK_DONE;
 	nau8825->xtalk_protect = false;
+	nau8825->sidetone = 0;
 	sema_init(&nau8825->xtalk_sem, 1);
 	INIT_WORK(&nau8825->xtalk_work, nau8825_xtalk_work);
+	INIT_DELAYED_WORK(&nau8825->softmute_work, nau8825_unmute_deferred);
 
 	nau8825_print_device_properties(nau8825);
 
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 1c63e2a..e15ea5c 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -433,6 +433,7 @@ struct nau8825 {
 	struct snd_soc_dapm_context *dapm;
 	struct snd_soc_jack *jack;
 	struct clk *mclk;
+	struct delayed_work softmute_work;
 	struct work_struct xtalk_work;
 	struct semaphore xtalk_sem;
 	int irq;
@@ -459,10 +460,12 @@ struct nau8825 {
 	int xtalk_event_mask;
 	bool xtalk_protect;
 	int imp_rms[NAU8825_XTALK_IMM];
+	int sidetone;
 };
 
 int nau8825_enable_jack_detect(struct snd_soc_codec *codec,
 				struct snd_soc_jack *jack);
+int nau8825_soft_mute(struct snd_soc_codec *codec, int mute);
 
 
 #endif  /* __NAU8825_H__ */
-- 
2.6.4
