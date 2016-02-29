From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: seq: Remove unimplemented ioctls
Date: Mon, 29 Feb 2016 18:12:26 +0100
Message-ID: <1456765946-6124-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 528AF2606D2
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 18:12:28 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 6E0F2ADC6
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 17:12:27 +0000 (UTC)
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

SNDRV_SEQ_IOCTL_{GET|SET}_QUEUE_OWNER and *_{GET|SET}_QUEUE_SYNC
ioctls have been never implemented.  Get rid of the definitions from
uapi header file.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/uapi/sound/asequencer.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/uapi/sound/asequencer.h b/include/uapi/sound/asequencer.h
index 5a5fa4956ebd..af96f2044f91 100644
--- a/include/uapi/sound/asequencer.h
+++ b/include/uapi/sound/asequencer.h
@@ -594,14 +594,8 @@ struct snd_seq_query_subs {
 #define SNDRV_SEQ_IOCTL_GET_QUEUE_STATUS _IOWR('S', 0x40, struct snd_seq_queue_status)
 #define SNDRV_SEQ_IOCTL_GET_QUEUE_TEMPO	_IOWR('S', 0x41, struct snd_seq_queue_tempo)
 #define SNDRV_SEQ_IOCTL_SET_QUEUE_TEMPO	_IOW ('S', 0x42, struct snd_seq_queue_tempo)
-#define SNDRV_SEQ_IOCTL_GET_QUEUE_OWNER	_IOWR('S', 0x43, struct snd_seq_queue_owner)
-#define SNDRV_SEQ_IOCTL_SET_QUEUE_OWNER	_IOW ('S', 0x44, struct snd_seq_queue_owner)
 #define SNDRV_SEQ_IOCTL_GET_QUEUE_TIMER	_IOWR('S', 0x45, struct snd_seq_queue_timer)
 #define SNDRV_SEQ_IOCTL_SET_QUEUE_TIMER	_IOW ('S', 0x46, struct snd_seq_queue_timer)
-/* XXX
-#define SNDRV_SEQ_IOCTL_GET_QUEUE_SYNC	_IOWR('S', 0x53, struct snd_seq_queue_sync)
-#define SNDRV_SEQ_IOCTL_SET_QUEUE_SYNC	_IOW ('S', 0x54, struct snd_seq_queue_sync)
-*/
 #define SNDRV_SEQ_IOCTL_GET_QUEUE_CLIENT	_IOWR('S', 0x49, struct snd_seq_queue_client)
 #define SNDRV_SEQ_IOCTL_SET_QUEUE_CLIENT	_IOW ('S', 0x4a, struct snd_seq_queue_client)
 #define SNDRV_SEQ_IOCTL_GET_CLIENT_POOL	_IOWR('S', 0x4b, struct snd_seq_client_pool)
-- 
2.7.2
