From: David Henningsson <diwic@ubuntu.com>
Subject: [PATCH] test/pcm-multi-thread: Remove pthread_cancel,
	add snd_pcm_close
Date: Thu,  1 Sep 2016 04:23:26 +0200
Message-ID: <1472696606-15309-1-git-send-email-diwic@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id A2B05265750
 for <alsa-devel@alsa-project.org>; Thu,  1 Sep 2016 04:23:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, clemens@ladisch.de, alsa-devel@alsa-project.org
Cc: David Henningsson <diwic@ubuntu.com>
List-Id: alsa-devel@alsa-project.org

Because
 1) Apparently, our thread cancellation policy is
    "don't even think about it" and we shouldn't break
    our own rules
 2) It is good practice to close pcm after usage

Signed-off-by: David Henningsson <diwic@ubuntu.com>
---
 test/pcm-multi-thread.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/test/pcm-multi-thread.c b/test/pcm-multi-thread.c
index da1b87c..26de7db 100644
--- a/test/pcm-multi-thread.c
+++ b/test/pcm-multi-thread.c
@@ -219,18 +219,22 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	if (setup_params())
+	if (setup_params()) {
+		snd_pcm_close(pcm);
 		return 1;
+	}
 
 	buf = calloc(1, snd_pcm_format_size(format, bufsize) * channels);
 	if (!buf) {
 		fprintf(stderr, "cannot alloc buffer\n");
+		snd_pcm_close(pcm);
 		return 1;
 	}
 
 	for (i = 0; i < num_threads; i++) {
 		if (pthread_create(&peeper_threads[i], NULL, peeper, (void *)(long)i)) {
 			fprintf(stderr, "pthread_create error\n");
+			snd_pcm_close(pcm);
 			return 1;
 		}
 	}
@@ -255,9 +259,8 @@ int main(int argc, char **argv)
 
 	running = 0;
 	for (i = 0; i < num_threads; i++)
-		pthread_cancel(peeper_threads[i]);
-	for (i = 0; i < num_threads; i++)
 		pthread_join(peeper_threads[i], NULL);
 
+	snd_pcm_close(pcm);
 	return 1;
 }
-- 
1.9.1
