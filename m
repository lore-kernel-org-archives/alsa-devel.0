From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: [PATCH] pcm,
	rate: hw_avail must not be negative before starting the stream
Date: Mon, 15 Sep 2014 20:23:05 +0600
Message-ID: <1410790985-4882-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f182.google.com (mail-lb0-f182.google.com
 [209.85.217.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 753F0260824
 for <alsa-devel@alsa-project.org>; Mon, 15 Sep 2014 16:23:16 +0200 (CEST)
Received: by mail-lb0-f182.google.com with SMTP id u10so956243lbd.13
 for <alsa-devel@alsa-project.org>; Mon, 15 Sep 2014 07:23:16 -0700 (PDT)
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

If it is, then it means most likely the driver problem, so we should
return error immediately instead.

Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>
---

As suggested by Takashi Iwai.

 src/pcm/pcm_rate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index 736d558..c76db25 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -1069,7 +1069,10 @@ static int snd_pcm_rate_start(snd_pcm_t *pcm)
 	gettimestamp(&rate->trigger_tstamp, pcm->tstamp_type);
 
 	avail = snd_pcm_mmap_playback_hw_avail(rate->gen.slave);
-	if (avail <= 0) {
+	if (avail < 0) /* can't happen on healthy drivers */
+		return -EBADFD;
+
+	if (avail == 0) {
 		/* postpone the trigger since we have no data committed yet */
 		rate->start_pending = 1;
 		return 0;
-- 
2.1.0
