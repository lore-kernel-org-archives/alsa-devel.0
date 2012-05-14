From: Antonio Borneo <borneo.antonio@gmail.com>
Subject: [PATCH alsa-lib] pcm_dsnoop: comment fall-through in
	next "case"
Date: Mon, 14 May 2012 23:56:34 +0800
Message-ID: <1337010994-32504-1-git-send-email-borneo.antonio@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 7820A24A4A
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:56:48 +0200 (CEST)
Received: by pbbrp16 with SMTP id rp16so8840954pbb.38
	for <alsa-devel@alsa-project.org>; Mon, 14 May 2012 08:56:47 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
---
 src/pcm/pcm_dsnoop.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/pcm/pcm_dsnoop.c b/src/pcm/pcm_dsnoop.c
index 988f1f4..bacb4ae 100644
--- a/src/pcm/pcm_dsnoop.c
+++ b/src/pcm/pcm_dsnoop.c
@@ -223,6 +223,7 @@ static int snd_pcm_dsnoop_delay(snd_pcm_t *pcm, snd_pcm_sframes_t *delayp)
 		err = snd_pcm_dsnoop_sync_ptr(pcm);
 		if (err < 0)
 			return err;
+		/* Fall through */
 	case SNDRV_PCM_STATE_PREPARED:
 	case SNDRV_PCM_STATE_SUSPENDED:
 		*delayp = snd_pcm_mmap_capture_hw_avail(pcm);
-- 
1.7.3.4
