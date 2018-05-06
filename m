From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/3] ASoC: pcm_native: Use 'snd_pcm_format_t'
	type
Date: Sun,  6 May 2018 12:47:43 -0300
Message-ID: <1525621665-11022-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
 [209.85.216.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E0873267338
 for <alsa-devel@alsa-project.org>; Sun,  6 May 2018 17:47:51 +0200 (CEST)
Received: by mail-qt0-f193.google.com with SMTP id m16-v6so33274073qtg.13
 for <alsa-devel@alsa-project.org>; Sun, 06 May 2018 08:47:51 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

'snd_pcm_format_t' type is better suited for iterating through the
SNDRV_PCM_FORMAT members.

Also, use SNDRV_PCM_FORMAT_FIRST for the first element.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/core/pcm_native.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 7585444..5d62b7c 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2051,13 +2051,13 @@ static int snd_pcm_hw_rule_mulkdiv(struct snd_pcm_hw_params *params,
 static int snd_pcm_hw_rule_format(struct snd_pcm_hw_params *params,
 				  struct snd_pcm_hw_rule *rule)
 {
-	unsigned int k;
+	snd_pcm_format_t k;
 	const struct snd_interval *i =
 				hw_param_interval_c(params, rule->deps[0]);
 	struct snd_mask m;
 	struct snd_mask *mask = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
 	snd_mask_any(&m);
-	for (k = 0; k <= SNDRV_PCM_FORMAT_LAST; ++k) {
+	for (k = SNDRV_PCM_FORMAT_FIRST; k <= SNDRV_PCM_FORMAT_LAST; ++k) {
 		int bits;
 		if (! snd_mask_test(mask, k))
 			continue;
@@ -2074,12 +2074,12 @@ static int snd_pcm_hw_rule_sample_bits(struct snd_pcm_hw_params *params,
 				       struct snd_pcm_hw_rule *rule)
 {
 	struct snd_interval t;
-	unsigned int k;
+	snd_pcm_format_t k;
 	t.min = UINT_MAX;
 	t.max = 0;
 	t.openmin = 0;
 	t.openmax = 0;
-	for (k = 0; k <= SNDRV_PCM_FORMAT_LAST; ++k) {
+	for (k = SNDRV_PCM_FORMAT_FIRST; k <= SNDRV_PCM_FORMAT_LAST; ++k) {
 		int bits;
 		if (! snd_mask_test(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT), k))
 			continue;
-- 
2.7.4
