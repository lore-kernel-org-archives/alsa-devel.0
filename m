From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: [PATCH 7/9] dsnoop: rewindable and forwardable logic
	was swapped
Date: Sun, 14 Sep 2014 00:30:19 +0600
Message-ID: <1410633021-20395-8-git-send-email-patrakov@gmail.com>
References: <1410633021-20395-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f43.google.com (mail-la0-f43.google.com
 [209.85.215.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 96F0F261ACB
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 20:31:02 +0200 (CEST)
Received: by mail-la0-f43.google.com with SMTP id gi9so2633097lab.16
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 11:30:56 -0700 (PDT)
In-Reply-To: <1410633021-20395-1-git-send-email-patrakov@gmail.com>
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
Cc: tiwai@suse.de, clemens@ladisch.de, "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>
---
 src/pcm/pcm_dsnoop.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/pcm/pcm_dsnoop.c b/src/pcm/pcm_dsnoop.c
index e56e402..8333eef 100644
--- a/src/pcm/pcm_dsnoop.c
+++ b/src/pcm/pcm_dsnoop.c
@@ -335,7 +335,7 @@ static int snd_pcm_dsnoop_pause(snd_pcm_t *pcm ATTRIBUTE_UNUSED, int enable ATTR
 
 static snd_pcm_sframes_t snd_pcm_dsnoop_rewindable(snd_pcm_t *pcm)
 {
-	return snd_pcm_mmap_capture_avail(pcm);
+	return snd_pcm_mmap_capture_hw_avail(pcm);
 }
 
 static snd_pcm_sframes_t snd_pcm_dsnoop_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
@@ -351,7 +351,7 @@ static snd_pcm_sframes_t snd_pcm_dsnoop_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t
 
 static snd_pcm_sframes_t snd_pcm_dsnoop_forwardable(snd_pcm_t *pcm)
 {
-	return snd_pcm_mmap_capture_hw_avail(pcm);
+	return snd_pcm_mmap_capture_avail(pcm);
 }
 
 static snd_pcm_sframes_t snd_pcm_dsnoop_forward(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
@@ -359,8 +359,6 @@ static snd_pcm_sframes_t snd_pcm_dsnoop_forward(snd_pcm_t *pcm, snd_pcm_uframes_
 	snd_pcm_sframes_t avail;
 
 	avail = snd_pcm_dsnoop_forwardable(pcm);
-	if (avail < 0)
-		return 0;
 	if (frames > (snd_pcm_uframes_t)avail)
 		frames = avail;
 	snd_pcm_mmap_appl_forward(pcm, frames);
-- 
2.1.0
