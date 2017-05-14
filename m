From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 16/21] ALSA: pcm/oss: refer to parameters
	instead of copying to reduce usage of kernel stack
Date: Sun, 14 May 2017 17:57:51 +0900
Message-ID: <20170514085756.22382-17-o-takashi@sakamocchi.jp>
References: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 1BFAA266BCF
 for <alsa-devel@alsa-project.org>; Sun, 14 May 2017 10:58:06 +0200 (CEST)
In-Reply-To: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, lars@metafoo.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Some functions in compatibility layer for Open Sound System interface has
local variable to copy some parameters in runtime of PCM substream, while
this can be replaced with reference of pointers to parameter itself. This
brings an advantage to reduce usage of kernel stack.

This commit applies this idea.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/oss/pcm_oss.c    | 16 ++++++++--------
 sound/core/oss/pcm_plugin.c |  5 +++--
 sound/core/oss/pcm_plugin.h |  2 +-
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 2a47351..e306f05 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -848,7 +848,7 @@ static int snd_pcm_oss_change_params(struct snd_pcm_substream *substream,
 	int direct;
 	snd_pcm_format_t format, sformat;
 	int n;
-	struct snd_mask sformat_mask;
+	const struct snd_mask *sformat_mask;
 	struct snd_mask mask;
 
 	if (trylock) {
@@ -891,18 +891,18 @@ static int snd_pcm_oss_change_params(struct snd_pcm_substream *substream,
 
 	format = snd_pcm_oss_format_from(runtime->oss.format);
 
-	sformat_mask = *hw_param_mask(sparams, SNDRV_PCM_HW_PARAM_FORMAT);
+	sformat_mask = hw_param_mask_c(sparams, SNDRV_PCM_HW_PARAM_FORMAT);
 	if (direct)
 		sformat = format;
 	else
-		sformat = snd_pcm_plug_slave_format(format, &sformat_mask);
+		sformat = snd_pcm_plug_slave_format(format, sformat_mask);
 
 	if ((__force int)sformat < 0 ||
-	    !snd_mask_test(&sformat_mask, (__force int)sformat)) {
+	    !snd_mask_test(sformat_mask, (__force int)sformat)) {
 		for (sformat = (__force snd_pcm_format_t)0;
 		     (__force int)sformat <= (__force int)SNDRV_PCM_FORMAT_LAST;
 		     sformat = (__force snd_pcm_format_t)((__force int)sformat + 1)) {
-			if (snd_mask_test(&sformat_mask, (__force int)sformat) &&
+			if (snd_mask_test(sformat_mask, (__force int)sformat) &&
 			    snd_pcm_oss_format_to(sformat) >= 0)
 				break;
 		}
@@ -1780,7 +1780,7 @@ static int snd_pcm_oss_get_formats(struct snd_pcm_oss_file *pcm_oss_file)
 	int direct;
 	struct snd_pcm_hw_params *params;
 	unsigned int formats = 0;
-	struct snd_mask format_mask;
+	const struct snd_mask *format_mask;
 	int fmt;
 
 	if ((err = snd_pcm_oss_get_active_substream(pcm_oss_file, &substream)) < 0)
@@ -1802,12 +1802,12 @@ static int snd_pcm_oss_get_formats(struct snd_pcm_oss_file *pcm_oss_file)
 		return -ENOMEM;
 	_snd_pcm_hw_params_any(params);
 	err = snd_pcm_hw_refine(substream, params);
-	format_mask = *hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT); 
+	format_mask = hw_param_mask_c(params, SNDRV_PCM_HW_PARAM_FORMAT);
 	kfree(params);
 	if (err < 0)
 		return err;
 	for (fmt = 0; fmt < 32; ++fmt) {
-		if (snd_mask_test(&format_mask, fmt)) {
+		if (snd_mask_test(format_mask, fmt)) {
 			int f = snd_pcm_oss_format_to(fmt);
 			if (f >= 0)
 				formats |= f;
diff --git a/sound/core/oss/pcm_plugin.c b/sound/core/oss/pcm_plugin.c
index 727ac44..cadc937 100644
--- a/sound/core/oss/pcm_plugin.c
+++ b/sound/core/oss/pcm_plugin.c
@@ -266,7 +266,8 @@ snd_pcm_sframes_t snd_pcm_plug_slave_size(struct snd_pcm_substream *plug, snd_pc
 	return frames;
 }
 
-static int snd_pcm_plug_formats(struct snd_mask *mask, snd_pcm_format_t format)
+static int snd_pcm_plug_formats(const struct snd_mask *mask,
+				snd_pcm_format_t format)
 {
 	struct snd_mask formats = *mask;
 	u64 linfmts = (SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S8 |
@@ -309,7 +310,7 @@ static snd_pcm_format_t preferred_formats[] = {
 };
 
 snd_pcm_format_t snd_pcm_plug_slave_format(snd_pcm_format_t format,
-					   struct snd_mask *format_mask)
+					   const struct snd_mask *format_mask)
 {
 	int i;
 
diff --git a/sound/core/oss/pcm_plugin.h b/sound/core/oss/pcm_plugin.h
index a5035c2..38e2c14 100644
--- a/sound/core/oss/pcm_plugin.h
+++ b/sound/core/oss/pcm_plugin.h
@@ -126,7 +126,7 @@ int snd_pcm_plug_format_plugins(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *slave_params);
 
 snd_pcm_format_t snd_pcm_plug_slave_format(snd_pcm_format_t format,
-					   struct snd_mask *format_mask);
+					   const struct snd_mask *format_mask);
 
 int snd_pcm_plugin_append(struct snd_pcm_plugin *plugin);
 
-- 
2.9.3
