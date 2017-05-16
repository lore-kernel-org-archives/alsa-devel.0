From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: pcm: constify function local and
	read-only table
Date: Wed, 17 May 2017 08:48:18 +0900
Message-ID: <20170516234820.14728-2-o-takashi@sakamocchi.jp>
References: <20170516234820.14728-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 7E141266F5B
 for <alsa-devel@alsa-project.org>; Wed, 17 May 2017 01:48:25 +0200 (CEST)
In-Reply-To: <20170516234820.14728-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In a function snd_pcm_hw_params_choose(), target parameters are arranged
into a table. Though each entry of this table is read-only, they don't
have const qualifier.

This commit adds the qualifier.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_lib.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index af439e5..ab4b1d1 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1734,7 +1734,7 @@ EXPORT_SYMBOL(snd_pcm_hw_param_last);
 int snd_pcm_hw_params_choose(struct snd_pcm_substream *pcm,
 			     struct snd_pcm_hw_params *params)
 {
-	static int vars[] = {
+	static const int vars[] = {
 		SNDRV_PCM_HW_PARAM_ACCESS,
 		SNDRV_PCM_HW_PARAM_FORMAT,
 		SNDRV_PCM_HW_PARAM_SUBFORMAT,
@@ -1745,7 +1745,8 @@ int snd_pcm_hw_params_choose(struct snd_pcm_substream *pcm,
 		SNDRV_PCM_HW_PARAM_TICK_TIME,
 		-1
 	};
-	int err, *v;
+	const int *v;
+	int err;
 
 	for (v = vars; *v != -1; v++) {
 		if (*v != SNDRV_PCM_HW_PARAM_BUFFER_SIZE)
-- 
2.9.3
