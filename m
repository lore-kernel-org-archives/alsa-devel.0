From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/10] ALSA: pcm: Fix sparse warning wrt PCM
	format type
Date: Wed, 25 Jul 2018 23:19:38 +0200
Message-ID: <20180725211945.19222-4-tiwai@suse.de>
References: <20180725211945.19222-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5783B267784
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:19:54 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id C2A75B089
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:19:53 +0000 (UTC)
In-Reply-To: <20180725211945.19222-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The PCM format type is with __bitwise, hence it needs the explicit
cast with __force.  It's ugly, but there is a reason for that cost...

This fixes the sparse warning:
  sound/core/oss/pcm_oss.c:1854:55: warning: incorrect type in argument 1 (different base types)

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/oss/pcm_oss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 905a53c1cde5..f8d4a419f3af 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1851,7 +1851,7 @@ static int snd_pcm_oss_get_formats(struct snd_pcm_oss_file *pcm_oss_file)
 	format_mask = hw_param_mask_c(params, SNDRV_PCM_HW_PARAM_FORMAT);
 	for (fmt = 0; fmt < 32; ++fmt) {
 		if (snd_mask_test(format_mask, fmt)) {
-			int f = snd_pcm_oss_format_to(fmt);
+			int f = snd_pcm_oss_format_to((__force snd_pcm_format_t)fmt);
 			if (f >= 0)
 				formats |= f;
 		}
-- 
2.18.0
