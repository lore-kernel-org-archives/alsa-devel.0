From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 12/26] ALSA: dummy: Convert to copy_silence
	ops
Date: Thu, 11 May 2017 23:09:11 +0200
Message-ID: <20170511210925.18208-13-tiwai@suse.de>
References: <20170511210925.18208-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EA54E266FEB
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 23:09:31 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 8C542AEC7
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 21:09:30 +0000 (UTC)
In-Reply-To: <20170511210925.18208-1-tiwai@suse.de>
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

It's a dummy ops, so just replacing it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/dummy.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 172dacd925f5..68519689a9ea 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -645,14 +645,8 @@ static int alloc_fake_buffer(void)
 
 static int dummy_pcm_copy(struct snd_pcm_substream *substream,
 			  int channel, snd_pcm_uframes_t pos,
-			  void __user *dst, snd_pcm_uframes_t count)
-{
-	return 0; /* do nothing */
-}
-
-static int dummy_pcm_silence(struct snd_pcm_substream *substream,
-			     int channel, snd_pcm_uframes_t pos,
-			     snd_pcm_uframes_t count)
+			  void __user *dst, snd_pcm_uframes_t count,
+			  bool in_kernel)
 {
 	return 0; /* do nothing */
 }
@@ -683,8 +677,7 @@ static struct snd_pcm_ops dummy_pcm_ops_no_buf = {
 	.prepare =	dummy_pcm_prepare,
 	.trigger =	dummy_pcm_trigger,
 	.pointer =	dummy_pcm_pointer,
-	.copy =		dummy_pcm_copy,
-	.silence =	dummy_pcm_silence,
+	.copy_silence =	dummy_pcm_copy,
 	.page =		dummy_pcm_page,
 };
 
-- 
2.12.2
