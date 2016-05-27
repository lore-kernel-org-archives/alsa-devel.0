From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Add event notification on
	voice trigger events" to the asoc tree
Date: Fri, 27 May 2016 21:46:34 +0100
Message-ID: <E1b6OeQ-0001iR-Lj@debutante>
References: <1463154319-10070-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 25F26266867
 for <alsa-devel@alsa-project.org>; Fri, 27 May 2016 22:46:40 +0200 (CEST)
In-Reply-To: <1463154319-10070-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

   ASoC: arizona: Add event notification on voice trigger events

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

>From 7580cc37a00285450eb5aa4f90f76d8a5d41859c Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Fri, 13 May 2016 16:45:19 +0100
Subject: [PATCH] ASoC: arizona: Add event notification on voice trigger events

Inform the notifier chain if the DSP recognises a voice trigger.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.h | 3 +++
 sound/soc/codecs/cs47l24.c | 4 ++++
 sound/soc/codecs/wm5110.c  | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 245d13c157a5..18d347f3bfbe 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -63,6 +63,9 @@
 #define ARIZONA_DVFS_SR1_RQ	0x001
 #define ARIZONA_DVFS_ADSP1_RQ	0x100
 
+/* Notifier events */
+#define ARIZONA_NOTIFY_VOICE_TRIGGER   0x1
+
 struct arizona;
 struct wm_adsp;
 
diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index fa9a6a5a6120..7e3d138d077b 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1074,6 +1074,10 @@ static irqreturn_t cs47l24_adsp2_irq(int irq, void *data)
 		ret = wm_adsp_compr_handle_irq(&priv->core.adsp[i]);
 		if (ret != -ENODEV)
 			serviced++;
+		if (ret == WM_ADSP_COMPR_VOICE_TRIGGER)
+			arizona_call_notifiers(arizona,
+					       ARIZONA_NOTIFY_VOICE_TRIGGER,
+					       (void *)i);
 	}
 
 	if (!serviced) {
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 338a3b52705b..dbc9b4df38a0 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2229,6 +2229,10 @@ static irqreturn_t wm5110_adsp2_irq(int irq, void *data)
 		ret = wm_adsp_compr_handle_irq(&priv->core.adsp[i]);
 		if (ret != -ENODEV)
 			serviced++;
+		if (ret == WM_ADSP_COMPR_VOICE_TRIGGER)
+			arizona_call_notifiers(arizona,
+					       ARIZONA_NOTIFY_VOICE_TRIGGER,
+					       (void *)i);
 	}
 
 	if (!serviced) {
-- 
2.8.1
