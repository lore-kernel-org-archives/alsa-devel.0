From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Remove redundant extern
	declarations" to the asoc tree
Date: Tue, 29 Nov 2016 11:45:12 +0000
Message-ID: <E1cBgqW-0004NO-42@debutante>
References: <1480416382-8655-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AF3226707F
 for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2016 12:45:19 +0100 (CET)
In-Reply-To: <1480416382-8655-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Remove redundant extern declarations

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

>From 63079b6e43a813341fc5b44bc899796d5a857fd8 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 29 Nov 2016 10:46:21 +0000
Subject: [PATCH] ASoC: wm_adsp: Remove redundant extern declarations

Functions are given external linkage by default making the extern's
unnecessary, as such remove them.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.h | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 3f7c8ee42243..411d062c13f2 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -110,18 +110,17 @@ int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
 int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event);
 
-extern int wm_adsp_compr_open(struct wm_adsp *dsp,
-			      struct snd_compr_stream *stream);
-extern int wm_adsp_compr_free(struct snd_compr_stream *stream);
-extern int wm_adsp_compr_set_params(struct snd_compr_stream *stream,
-				    struct snd_compr_params *params);
-extern int wm_adsp_compr_get_caps(struct snd_compr_stream *stream,
-				  struct snd_compr_caps *caps);
-extern int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd);
-extern int wm_adsp_compr_handle_irq(struct wm_adsp *dsp);
-extern int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
-				 struct snd_compr_tstamp *tstamp);
-extern int wm_adsp_compr_copy(struct snd_compr_stream *stream,
-			      char __user *buf, size_t count);
+int wm_adsp_compr_open(struct wm_adsp *dsp, struct snd_compr_stream *stream);
+int wm_adsp_compr_free(struct snd_compr_stream *stream);
+int wm_adsp_compr_set_params(struct snd_compr_stream *stream,
+			     struct snd_compr_params *params);
+int wm_adsp_compr_get_caps(struct snd_compr_stream *stream,
+			   struct snd_compr_caps *caps);
+int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd);
+int wm_adsp_compr_handle_irq(struct wm_adsp *dsp);
+int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
+			  struct snd_compr_tstamp *tstamp);
+int wm_adsp_compr_copy(struct snd_compr_stream *stream,
+		       char __user *buf, size_t count);
 
 #endif
-- 
2.10.2
