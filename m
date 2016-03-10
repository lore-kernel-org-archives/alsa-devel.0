From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Avoid "BUG:" string for warnings
	again
Date: Thu, 10 Mar 2016 21:01:35 +0100
Message-ID: <1457640095-23232-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E44B260515
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 21:01:36 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A80A6ABD3
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 20:01:35 +0000 (UTC)
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

The commit [d507941beb1e: ALSA: pcm: Correct PCM BUG error message]
made the warning prefix back to "BUG:" due to its previous wrong
prefix.  But a kernel message containing "BUG:" seems taken as an Oops
message wrongly by some brain-dead daemons, and it annoys users in the
end.  Instead of teaching daemons, change the string again to a more
reasonable one.

Fixes: 507941beb1e ('ALSA: pcm: Correct PCM BUG error message')
Cc: <stable@vger.kernel.org> # v3.19+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 6b5a811e01a5..3a9b66c6e09c 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -322,7 +322,7 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 			char name[16];
 			snd_pcm_debug_name(substream, name, sizeof(name));
 			pcm_err(substream->pcm,
-				"BUG: %s, pos = %ld, buffer size = %ld, period size = %ld\n",
+				"invalid position: %s, pos = %ld, buffer size = %ld, period size = %ld\n",
 				name, pos, runtime->buffer_size,
 				runtime->period_size);
 		}
-- 
2.7.2
