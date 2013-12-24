From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ALSA: Add params_width() helpers
Date: Tue, 24 Dec 2013 12:24:28 +0000
Message-ID: <1387887868-22084-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E1C526158C
 for <alsa-devel@alsa-project.org>; Tue, 24 Dec 2013 13:24:41 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Add helpers for obtaining the width of a format directly from params
since this is expected to become a common operation in ASoC.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 include/sound/pcm_params.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/sound/pcm_params.h b/include/sound/pcm_params.h
index 37ae12e..6b1c78f 100644
--- a/include/sound/pcm_params.h
+++ b/include/sound/pcm_params.h
@@ -354,4 +354,16 @@ params_period_bytes(const struct snd_pcm_hw_params *p)
 		params_channels(p)) / 8;
 }
 
+static inline int
+params_width(const struct snd_pcm_hw_params *p)
+{
+	return snd_pcm_format_width(params_format(p));
+}
+
+static inline int
+params_physical_width(const struct snd_pcm_hw_params *p)
+{
+	return snd_pcm_format_physical_width(params_format(p));
+}
+
 #endif /* __SOUND_PCM_PARAMS_H */
-- 
1.8.5.2
