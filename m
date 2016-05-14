From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Specifically propagate voice
	trigger event to caller" to the asoc tree
Date: Sat, 14 May 2016 11:12:55 +0100
Message-ID: <E1b1WZ5-0004pE-65@finisterre>
References: <1463154319-10070-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B160A261293
 for <alsa-devel@alsa-project.org>; Sat, 14 May 2016 12:22:19 +0200 (CEST)
In-Reply-To: <1463154319-10070-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lee.jones@linaro.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Specifically propagate voice trigger event to caller

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

>From ca7e86dd6d4902c23890d17b5984542490f51054 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Fri, 13 May 2016 16:45:17 +0100
Subject: [PATCH] ASoC: wm_adsp: Specifically propagate voice trigger event to
 caller

The DSP uses an IRQ to indicate data is available on the compressed
stream. For voice trigger use-cases the first such IRQ can be considered
an indication that the user has spoken the key phrase triggering the
firmware. Provide a means for the ADSP code to communicate back to the
calling driver whether an IRQ should be considered as trigger event or
not.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 5 +++++
 sound/soc/codecs/wm_adsp.h | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index a07bd7c2c587..378ec3095ed6 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -394,6 +394,7 @@ static const struct {
 	int compr_direction;
 	int num_caps;
 	const struct wm_adsp_fw_caps *caps;
+	bool voice_trigger;
 } wm_adsp_fw[WM_ADSP_NUM_FW] = {
 	[WM_ADSP_FW_MBC_VSS] =  { .file = "mbc-vss" },
 	[WM_ADSP_FW_HIFI] =     { .file = "hifi" },
@@ -406,6 +407,7 @@ static const struct {
 		.compr_direction = SND_COMPRESS_CAPTURE,
 		.num_caps = ARRAY_SIZE(ctrl_caps),
 		.caps = ctrl_caps,
+		.voice_trigger = true,
 	},
 	[WM_ADSP_FW_ASR] =      { .file = "asr" },
 	[WM_ADSP_FW_TRACE] =    {
@@ -2998,6 +3000,9 @@ int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
 		goto out;
 	}
 
+	if (wm_adsp_fw[dsp->fw].voice_trigger && buf->irq_count == 2)
+		ret = WM_ADSP_COMPR_VOICE_TRIGGER;
+
 out_notify:
 	if (compr && compr->stream)
 		snd_compr_fragment_elapsed(compr->stream);
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index feb61e2c4bb4..be3b5bcb7f17 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -19,6 +19,10 @@
 
 #include "wmfw.h"
 
+/* Return values for wm_adsp_compr_handle_irq */
+#define WM_ADSP_COMPR_OK                 0
+#define WM_ADSP_COMPR_VOICE_TRIGGER      1
+
 struct wm_adsp_region {
 	int type;
 	unsigned int base;
-- 
2.8.1
