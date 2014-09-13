From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: [PATCH 6/9] rate: handle negative values from
	snd_pcm_mmap_playback_hw_avail
Date: Sun, 14 Sep 2014 00:30:18 +0600
Message-ID: <1410633021-20395-7-git-send-email-patrakov@gmail.com>
References: <1410633021-20395-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f45.google.com (mail-la0-f45.google.com
 [209.85.215.45])
 by alsa0.perex.cz (Postfix) with ESMTP id C24792625C4
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 20:30:55 +0200 (CEST)
Received: by mail-la0-f45.google.com with SMTP id b17so2663351lan.32
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 11:30:55 -0700 (PDT)
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

Such negative returns are possible during an underrun if xrun detection
is disabled.

So, don't store the result in an unsigned variable (where it will
overflow), and postpone the trigger in such case, too.

Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>
---

The patch is only compile-tested and the second hunk may well be wrong.

There are also similar issues in pcm_share.c, but, as I don't completely
understand the code there and cannot test that plugin at all due to
unrelated crashes, there will be no patch from me.

 src/pcm/pcm_rate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index b436a8e..736d558 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -1058,7 +1058,7 @@ static snd_pcm_state_t snd_pcm_rate_state(snd_pcm_t *pcm)
 static int snd_pcm_rate_start(snd_pcm_t *pcm)
 {
 	snd_pcm_rate_t *rate = pcm->private_data;
-	snd_pcm_uframes_t avail;
+	snd_pcm_sframes_t avail;
 		
 	if (pcm->stream == SND_PCM_STREAM_CAPTURE)
 		return snd_pcm_start(rate->gen.slave);
@@ -1069,7 +1069,7 @@ static int snd_pcm_rate_start(snd_pcm_t *pcm)
 	gettimestamp(&rate->trigger_tstamp, pcm->tstamp_type);
 
 	avail = snd_pcm_mmap_playback_hw_avail(rate->gen.slave);
-	if (avail == 0) {
+	if (avail <= 0) {
 		/* postpone the trigger since we have no data committed yet */
 		rate->start_pending = 1;
 		return 0;
-- 
2.1.0
