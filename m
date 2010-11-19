From: Torben Hohn <torbenh@gmx.de>
Subject: [PATCH] jack: use eventfd which never blocks.
Date: Fri, 19 Nov 2010 15:22:29 +0100
Message-ID: <1290176549-31258-1-git-send-email-torbenh@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id 6A1C210396D
	for <alsa-devel@alsa-project.org>; Fri, 19 Nov 2010 15:22:34 +0100 (CET)
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
Cc: Torben Hohn <torbenh@gmx.de>
List-Id: alsa-devel@alsa-project.org

the use of the socketpair for synchronisation is not correct.
jack does not allow blocking calls in the process_callback,
the socket buffers are quite small, and seem to overflow under some
conditions.

the result was write(2) blocking, and jack kicking the client.
(jack needs to be running in RT mode, with a pretty low period size (<=128)
but this really is the normal usecase)

this patch uses eventfd(2) when its available to mitigate the problem.

Signed-off-by: Torben Hohn <torbenh@gmx.de>
---
 configure.in    |    5 +++++
 jack/pcm_jack.c |   30 +++++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/configure.in b/configure.in
index 5d71cae..9fa7f27 100644
--- a/configure.in
+++ b/configure.in
@@ -21,6 +21,11 @@ AC_CHECK_LIB(asound, snd_pcm_ioplug_create,,
 AC_ARG_ENABLE([jack],
       AS_HELP_STRING([--disable-jack], [Disable building of JACK plugin]))
 
+AC_CHECK_HEADER([sys/eventfd.h], [HAVE_EVENTFD=yes], [HAVE_EVENTFD=no])
+if test "$HAVE_EVENTFD" = "yes"; then
+	AC_DEFINE(HAVE_EVENTFD, 1,"eventfd is available")
+fi
+
 if test "x$enable_jack" != "xno"; then
   PKG_CHECK_MODULES(JACK, jack >= 0.98, [HAVE_JACK=yes], [HAVE_JACK=no])
 fi
diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index 3370a26..83ac56a 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -20,6 +20,8 @@
  *
  */
 
+#include "config.h"
+
 #include <byteswap.h>
 #include <sys/shm.h>
 #include <sys/types.h>
@@ -28,6 +30,10 @@
 #include <alsa/asoundlib.h>
 #include <alsa/pcm_external.h>
 
+#ifdef HAVE_EVENTFD
+#include <sys/eventfd.h>
+#endif
+
 typedef enum _jack_format {
 	SND_PCM_JACK_FORMAT_RAW
 } snd_pcm_jack_format_t;
@@ -63,8 +69,10 @@ static void snd_pcm_jack_free(snd_pcm_jack_t *jack)
 		}
 		if (jack->fd >= 0)
 			close(jack->fd);
+#ifndef HAVE_EVENTFD
 		if (jack->io.poll_fd >= 0)
 			close(jack->io.poll_fd);
+#endif
 		free(jack->areas);
 		free(jack);
 	}
@@ -81,11 +89,19 @@ static int snd_pcm_jack_poll_revents(snd_pcm_ioplug_t *io ATTRIBUTE_UNUSED,
 				     struct pollfd *pfds, unsigned int nfds,
 				     unsigned short *revents)
 {
+#ifdef HAVE_EVENTFD
+	eventfd_t buf[1];
+#else
 	static char buf[1];
-	
+#endif
+
 	assert(pfds && nfds == 1 && revents);
 
-	read(pfds[0].fd, buf, 1);
+	read(pfds[0].fd, buf, sizeof(buf));
+#ifdef HAVE_EVENTFD
+	buf[0] -= 1;
+	write(pfds[0].fd, buf, sizeof(buf));
+#endif
 
 	*revents = pfds[0].revents;
 	return 0;
@@ -103,7 +119,11 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
 	snd_pcm_jack_t *jack = io->private_data;
 	const snd_pcm_channel_area_t *areas;
 	snd_pcm_uframes_t xfer = 0;
+#ifdef HAVE_EVENTFD
+	static eventfd_t buf[1] = { 0x00000001 };
+#else
 	static char buf[1];
+#endif
 	unsigned int channel;
 	
 	for (channel = 0; channel < io->channels; channel++) {
@@ -143,7 +163,7 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
 		xfer += frames;
 	}
 
-	write(jack->fd, buf, 1); /* for polling */
+	write(jack->fd, buf, sizeof(buf)); /* for polling */
 
 	return 0;
 }
@@ -361,7 +381,11 @@ static int snd_pcm_jack_open(snd_pcm_t **pcmp, const char *name,
 		return -ENOMEM;
 	}
 
+#ifdef HAVE_EVENTFD
+	fd[0] = fd[1] = eventfd(0, 0);
+#else
 	socketpair(AF_LOCAL, SOCK_STREAM, 0, fd);
+#endif
 	
 	jack->fd = fd[0];
 
-- 
1.7.1
