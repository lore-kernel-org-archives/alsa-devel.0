From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: [PATCH alsa-lib 1/2] pcm_share: Fix compiler warnings
	-Wunused-result
Date: Thu, 15 Nov 2018 08:19:56 +0100
Message-ID: <20181115071957.22753-1-kmarinushkin@birdec.tech>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from host.euro-space.net (host.euro-space.net [87.117.239.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 10124267A61
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2018 08:18:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Kirill Marinushkin <kmarinushkin@birdec.tech>
List-Id: alsa-devel@alsa-project.org

Before this commit, compilation of `pcm_share` causes warnings "ignoring
return value" for several `read` and `write` operations:

~~~~
pcm_share.c: In function '_snd_pcm_share_missing':
pcm_share.c:293:5: warning: ignoring return value of 'read', declared with
attribute warn_unused_result [-Wunused-result]
     read(share->slave_socket, buf, 1);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<...>
~~~~

However, ignoring return values in these use-cases is safe and optimal,
because `read` and `write` operations are executed upon descriptors,
created with `socketpair()` and `pipe()`.

This commit fixes the warnings by introducing the return value with the
attribute `unused` (for details, see [1]). The macro, used in this commit,
is defined at `global.h`:

~~~~
define ATTRIBUTE_UNUSED __attribute__ ((__unused__))
~~~~

I explicitly checked the objdump: this commit doesn't change the machine
code, related to the modified C code lines. The execution performance is
not affected.

[1] https://gcc.gnu.org/onlinedocs/gcc-8.2.0/gcc/Common-Variable-Attributes.html

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
---
 src/pcm/pcm_share.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/src/pcm/pcm_share.c b/src/pcm/pcm_share.c
index 5a540c4f..9592e003 100644
--- a/src/pcm/pcm_share.c
+++ b/src/pcm/pcm_share.c
@@ -287,17 +287,18 @@ static snd_pcm_uframes_t _snd_pcm_share_missing(snd_pcm_t *pcm)
 
  update_poll:
 	if (ready != share->ready) {
+		int un ATTRIBUTE_UNUSED;
 		char buf[1];
 		if (pcm->stream == SND_PCM_STREAM_PLAYBACK) {
 			if (ready)
-				read(share->slave_socket, buf, 1);
+				un = read(share->slave_socket, buf, 1);
 			else
-				write(share->client_socket, buf, 1);
+				un = write(share->client_socket, buf, 1);
 		} else {
 			if (ready)
-				write(share->slave_socket, buf, 1);
+				un = write(share->slave_socket, buf, 1);
 			else
-				read(share->client_socket, buf, 1);
+				un = read(share->client_socket, buf, 1);
 		}
 		share->ready = ready;
 	}
@@ -404,8 +405,9 @@ static void *snd_pcm_share_thread(void *data)
 			err = poll(pfd, 2, -1);
 			Pthread_mutex_lock(&slave->mutex);
 			if (pfd[0].revents & POLLIN) {
+				int un ATTRIBUTE_UNUSED;
 				char buf[1];
-				read(pfd[0].fd, buf, 1);
+				un = read(pfd[0].fd, buf, 1);
 			}
 		} else {
 			slave->polling = 0;
-- 
2.13.6
