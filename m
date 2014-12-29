From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/9] ALSA: pcm: Simplify params_period_bytes()
Date: Mon, 29 Dec 2014 19:41:43 +0100
Message-ID: <1419878506-28684-6-git-send-email-lars@metafoo.de>
References: <1419878506-28684-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-184.synserver.de (smtp-out-184.synserver.de
 [212.40.185.184])
 by alsa0.perex.cz (Postfix) with ESMTP id E2A982605C7
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 19:41:52 +0100 (CET)
In-Reply-To: <1419878506-28684-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The hw_params struct has a parameter that contains the period size in bytes.
This can be used instead of deriving the value from other parameters. This
is similar to e.g. params_buffer_bytes()

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/pcm_params.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/sound/pcm_params.h b/include/sound/pcm_params.h
index 2e2169e..042049b 100644
--- a/include/sound/pcm_params.h
+++ b/include/sound/pcm_params.h
@@ -363,9 +363,7 @@ params_subformat(const struct snd_pcm_hw_params *p)
 static inline unsigned int
 params_period_bytes(const struct snd_pcm_hw_params *p)
 {
-	return (params_period_size(p) *
-		snd_pcm_format_physical_width(params_format(p)) *
-		params_channels(p)) / 8;
+	return hw_param_interval_c(p, SNDRV_PCM_HW_PARAM_PERIOD_BYTES)->min;
 }
 
 /**
-- 
1.8.0
