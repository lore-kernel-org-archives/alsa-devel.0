From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: core: Report audio_tstamp in
	snd_pcm_sync_ptr
Date: Sat, 21 Apr 2018 14:57:40 +0200
Message-ID: <20180421125740.10931-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C7A6267230
 for <alsa-devel@alsa-project.org>; Sat, 21 Apr 2018 14:57:47 +0200 (CEST)
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
Cc: David Henningsson <diwic@ubuntu.com>
List-Id: alsa-devel@alsa-project.org

From: David Henningsson <diwic@ubuntu.com>

It looks like a simple mistake that this struct member
was forgotten.

Audio_tstamp isn't used much, and on some archs (such as x86) this
ioctl is not used by default, so that might be the reason why this
has slipped for so long.

Fixes: 4eeaaeaea1ce ("ALSA: core: add hooks for audio timestamps")
Signed-off-by: David Henningsson <diwic@ubuntu.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>

---

 sound/core/pcm_native.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 35ffcce..632228b 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2751,6 +2751,7 @@ static int snd_pcm_sync_ptr(struct snd_pcm_substream *substream,
 	sync_ptr.s.status.hw_ptr = status->hw_ptr;
 	sync_ptr.s.status.tstamp = status->tstamp;
 	sync_ptr.s.status.suspended_state = status->suspended_state;
+	sync_ptr.s.status.audio_tstamp = status->audio_tstamp;
 	snd_pcm_stream_unlock_irq(substream);
 	if (copy_to_user(_sync_ptr, &sync_ptr, sizeof(sync_ptr)))
 		return -EFAULT;
-- 
2.7.4
