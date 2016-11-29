From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm_adsp: Remove redundant extern
	declarations
Date: Tue, 29 Nov 2016 10:46:21 +0000
Message-ID: <1480416382-8655-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 64EE6266A4E
 for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2016 11:45:29 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Functions are given external linkage by default making the extern's
unnecessary, as such remove them.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.h | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 3f7c8ee..411d062 100644
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
2.1.4
