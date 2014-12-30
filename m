From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH] pcm: fix buffer overflow in
	snd_pcm_chmap_print()
Date: Tue, 30 Dec 2014 20:46:11 +0200
Message-ID: <1419965171-23403-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.ippnet.fi (mail3.ippnet.fi [62.197.168.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 16D5A260717
 for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2014 19:46:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The size argument is wrong for one of the snprintf() calls in
snd_pcm_chmap_print(), allowing an overflow to happen (the user-provided
buffer may be written data up to 2x its actual size).

Seen in an user report here: http://trac.kodi.tv/ticket/15641

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 src/pcm/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index baa47c7..e74e02f 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -7621,7 +7621,7 @@ int snd_pcm_chmap_print(const snd_pcm_chmap_t *map, size_t maxlen, char *buf)
 				return -ENOMEM;
 		}
 		if (map->pos[i] & SND_CHMAP_DRIVER_SPEC)
-			len += snprintf(buf + len, maxlen, "%d", p);
+			len += snprintf(buf + len, maxlen - len, "%d", p);
 		else {
 			const char *name = chmap_names[p];
 			if (name)
-- 
1.8.4.5
