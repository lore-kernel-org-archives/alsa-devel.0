From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/5] ALSA: pcm: Correct PCM BUG error message
Date: Tue,  4 Nov 2014 14:28:14 +0100
Message-ID: <1415107696-17123-4-git-send-email-tiwai@suse.de>
References: <1415107696-17123-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 00906261524
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 14:28:19 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 6033CAD53
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 13:28:19 +0000 (UTC)
In-Reply-To: <1415107696-17123-1-git-send-email-tiwai@suse.de>
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

While converting to dev_*(), the message showing the invalid PCM
position was wrongly tagged as if an XRUN although it's actually a
BUG.  This patch corrects the message again.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index dfc28542a007..7b9e2fb35a86 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -345,7 +345,7 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 			snd_pcm_debug_name(substream, name, sizeof(name));
 			xrun_log_show(substream);
 			pcm_err(substream->pcm,
-				"XRUN: %s, pos = %ld, buffer size = %ld, period size = %ld\n",
+				"BUG: %s, pos = %ld, buffer size = %ld, period size = %ld\n",
 				name, pos, runtime->buffer_size,
 				runtime->period_size);
 		}
-- 
2.1.3
