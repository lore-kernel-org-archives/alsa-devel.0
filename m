From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/9] ALSA: pcm: Fix kerneldoc for params_*()
	functions
Date: Mon, 29 Dec 2014 19:41:40 +0100
Message-ID: <1419878506-28684-3-git-send-email-lars@metafoo.de>
References: <1419878506-28684-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-184.synserver.de (smtp-out-184.synserver.de
 [212.40.185.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A6132605C3
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 19:41:51 +0100 (CET)
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

Fix a copy and paste error in the kernel doc description for the params_*()
functions.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/pcm.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index dbf2f7f..3652c94 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -854,7 +854,7 @@ static inline unsigned int params_channels(const struct snd_pcm_hw_params *p)
 }
 
 /**
- * params_channels - Get the sample rate from the hw params
+ * params_rate - Get the sample rate from the hw params
  * @p: hw params
  */
 static inline unsigned int params_rate(const struct snd_pcm_hw_params *p)
@@ -863,7 +863,7 @@ static inline unsigned int params_rate(const struct snd_pcm_hw_params *p)
 }
 
 /**
- * params_channels - Get the period size (in frames) from the hw params
+ * params_period_size - Get the period size (in frames) from the hw params
  * @p: hw params
  */
 static inline unsigned int params_period_size(const struct snd_pcm_hw_params *p)
@@ -872,7 +872,7 @@ static inline unsigned int params_period_size(const struct snd_pcm_hw_params *p)
 }
 
 /**
- * params_channels - Get the number of periods from the hw params
+ * params_periods - Get the number of periods from the hw params
  * @p: hw params
  */
 static inline unsigned int params_periods(const struct snd_pcm_hw_params *p)
@@ -881,7 +881,7 @@ static inline unsigned int params_periods(const struct snd_pcm_hw_params *p)
 }
 
 /**
- * params_channels - Get the buffer size (in frames) from the hw params
+ * params_buffer_size - Get the buffer size (in frames) from the hw params
  * @p: hw params
  */
 static inline unsigned int params_buffer_size(const struct snd_pcm_hw_params *p)
@@ -890,7 +890,7 @@ static inline unsigned int params_buffer_size(const struct snd_pcm_hw_params *p)
 }
 
 /**
- * params_channels - Get the buffer size (in bytes) from the hw params
+ * params_buffer_bytes - Get the buffer size (in bytes) from the hw params
  * @p: hw params
  */
 static inline unsigned int params_buffer_bytes(const struct snd_pcm_hw_params *p)
-- 
1.8.0
