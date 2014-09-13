From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: [PATCH 9/9] pcm,
	file: don't recurse in the rewindable and forwardable callbacks
Date: Sun, 14 Sep 2014 00:30:21 +0600
Message-ID: <1410633021-20395-10-git-send-email-patrakov@gmail.com>
References: <1410633021-20395-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f174.google.com (mail-lb0-f174.google.com
 [209.85.217.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BF9B261AC3
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 20:30:58 +0200 (CEST)
Received: by mail-lb0-f174.google.com with SMTP id 10so2563583lbg.33
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 11:30:58 -0700 (PDT)
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
 src/pcm/pcm_file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index a0b8bf4..5541a93 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -454,7 +454,7 @@ static int snd_pcm_file_drain(snd_pcm_t *pcm)
 static snd_pcm_sframes_t snd_pcm_file_rewindable(snd_pcm_t *pcm)
 {
 	snd_pcm_file_t *file = pcm->private_data;
-	snd_pcm_sframes_t res = snd_pcm_rewindable(pcm);
+	snd_pcm_sframes_t res = snd_pcm_rewindable(file->gen.slave);
 	snd_pcm_sframes_t n = snd_pcm_bytes_to_frames(pcm, file->wbuf_used_bytes);
 	if (res > n)
 		res = n;
@@ -482,7 +482,7 @@ static snd_pcm_sframes_t snd_pcm_file_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t f
 static snd_pcm_sframes_t snd_pcm_file_forwardable(snd_pcm_t *pcm)
 {
 	snd_pcm_file_t *file = pcm->private_data;
-	snd_pcm_sframes_t res = snd_pcm_forwardable(pcm);
+	snd_pcm_sframes_t res = snd_pcm_forwardable(file->gen.slave);
 	snd_pcm_sframes_t n = snd_pcm_bytes_to_frames(pcm, file->wbuf_size_bytes - file->wbuf_used_bytes);
 	if (res > n)
 		res = n;
-- 
2.1.0
