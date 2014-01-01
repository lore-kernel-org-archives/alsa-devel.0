From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH (alsa-plugins)] a52: Propagate errors from hw
Date: Wed,  1 Jan 2014 13:17:38 +0100
Message-ID: <1388578658-26544-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 0531D2608D6
 for <alsa-devel@alsa-project.org>; Wed,  1 Jan 2014 13:17:46 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Several callbacks returned 0 even though the hw was failing, leading
applications to believe everything was fine when it wasn't.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 a52/pcm_a52.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/a52/pcm_a52.c b/a52/pcm_a52.c
index 7188809..59a49ed 100644
--- a/a52/pcm_a52.c
+++ b/a52/pcm_a52.c
@@ -195,8 +195,8 @@ static int a52_drain(snd_pcm_ioplug_t *io)
 	err = write_out_pending(io, rec);
 	if (err < 0)
 		return err;
-	snd_pcm_drain(rec->slave);
-	return 0;
+	
+	return snd_pcm_drain(rec->slave);
 }
 
 /* check whether the areas consist of a continuous interleaved stream */
@@ -479,16 +479,14 @@ static int a52_start(snd_pcm_ioplug_t *io)
 {
 	struct a52_ctx *rec = io->private_data;
 
-	snd_pcm_start(rec->slave);
-	return 0;
+	return snd_pcm_start(rec->slave);
 }
 
 static int a52_stop(snd_pcm_ioplug_t *io)
 {
 	struct a52_ctx *rec = io->private_data;
 
-	snd_pcm_drop(rec->slave);
-	return 0;
+	return snd_pcm_drop(rec->slave);
 }
 
 /* release resources */
@@ -645,7 +643,7 @@ static int a52_close(snd_pcm_ioplug_t *io)
 
 	a52_free(rec);
 	if (rec->slave)
-		snd_pcm_close(rec->slave);
+		return snd_pcm_close(rec->slave);
 	return 0;
 }
 			      
-- 
1.8.4.2
