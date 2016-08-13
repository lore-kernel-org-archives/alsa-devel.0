From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH v2 2/2] amidi: fix timeout handling
Date: Sat, 13 Aug 2016 16:41:58 +0200
Message-ID: <c787da6c-c35b-3296-2217-73782b3bbcfd@ladisch.de>
References: <ac3f1f9a-5201-7a98-e659-fd9bbcf41ab7@ladisch.de>
 <bde1ef45-8255-5ca7-01fc-5dbf0b8f3684@ladisch.de>
 <b630d5ab-da0d-d92f-010b-b8c8e4698be7@sakamocchi.jp>
 <7982b196-edae-3330-86a8-83338e182f3e@sakamocchi.jp>
 <7105f8ec-be96-04af-45b0-e86326e1cf62@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 26BDC266027
 for <alsa-devel@alsa-project.org>; Sat, 13 Aug 2016 16:43:40 +0200 (CEST)
In-Reply-To: <7105f8ec-be96-04af-45b0-e86326e1cf62@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The timeout is not supposed to expire when ignored messages are
received.  This cannot be handled with the poll() timeout, so add
a separate timer.

Reported-by: Martin Tarenskeen <m.tarenskeen@gmail.com>
Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 amidi/amidi.c |   69 ++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 16 deletions(-)

diff --git a/amidi/amidi.c b/amidi/amidi.c
index 5871512..c20512c 100644
--- a/amidi/amidi.c
+++ b/amidi/amidi.c
@@ -25,9 +25,11 @@
 #include <stdarg.h>
 #include <string.h>
 #include <ctype.h>
+#include <math.h>
 #include <getopt.h>
 #include <errno.h>
 #include <signal.h>
+#include <sys/timerfd.h>
 #include <sys/types.h>
 #include <sys/poll.h>
 #include <sys/stat.h>
@@ -37,6 +39,8 @@
 #include "aconfig.h"
 #include "version.h"

+#define NSEC_PER_SEC 1000000000L
+
 static int do_device_list, do_rawmidi_list;
 static char *port_name = "default";
 static char *send_file_name;
@@ -46,7 +50,7 @@ static char *send_data;
 static int send_data_length;
 static int receive_file;
 static int dump;
-static int timeout;
+static float timeout;
 static int stop;
 static snd_rawmidi_t *input, **inputp;
 static snd_rawmidi_t *output, **outputp;
@@ -427,6 +431,7 @@ int main(int argc, char *argv[])
 	int ignore_active_sensing = 1;
 	int ignore_clock = 1;
 	int do_send_hex = 0;
+	struct itimerspec itimerspec = { .it_interval = { 0, 0 } };

 	while ((c = getopt_long(argc, argv, short_options,
 		     		long_options, NULL)) != -1) {
@@ -461,7 +466,7 @@ int main(int argc, char *argv[])
 			dump = 1;
 			break;
 		case 't':
-			timeout = atoi(optarg);
+			timeout = atof(optarg);
 			break;
 		case 'a':
 			ignore_active_sensing = 0;
@@ -552,40 +557,64 @@ int main(int argc, char *argv[])

 	if (inputp) {
 		int read = 0;
-		int npfds, time = 0;
+		int npfds;
 		struct pollfd *pfds;

-		timeout *= 1000;
-		npfds = snd_rawmidi_poll_descriptors_count(input);
+		npfds = 1 + snd_rawmidi_poll_descriptors_count(input);
 		pfds = alloca(npfds * sizeof(struct pollfd));
-		snd_rawmidi_poll_descriptors(input, pfds, npfds);
+
+		if (timeout > 0) {
+			pfds[0].fd = timerfd_create(CLOCK_MONOTONIC, 0);
+			if (pfds[0].fd == -1) {
+				error("cannot create timer: %s", strerror(errno));
+				goto _exit;
+			}
+			pfds[0].events = POLLIN;
+		} else {
+			pfds[0].fd = -1;
+		}
+
+		snd_rawmidi_poll_descriptors(input, &pfds[1], npfds - 1);
+
 		signal(SIGINT, sig_handler);
+
+		if (timeout > 0) {
+			float timeout_int;
+
+			itimerspec.it_value.tv_nsec = modff(timeout, &timeout_int) * NSEC_PER_SEC;
+			itimerspec.it_value.tv_sec = timeout_int;
+			err = timerfd_settime(pfds[0].fd, 0, &itimerspec, NULL);
+			if (err < 0) {
+				error("cannot set timer: %s", strerror(errno));
+				goto _exit;
+			}
+		}
 		for (;;) {
 			unsigned char buf[256];
 			int i, length;
 			unsigned short revents;

-			err = poll(pfds, npfds, 200);
+			err = poll(pfds, npfds, -1);
 			if (stop || (err < 0 && errno == EINTR))
 				break;
 			if (err < 0) {
 				error("poll failed: %s", strerror(errno));
 				break;
 			}
-			if (err == 0) {
-				time += 200;
-				if (timeout && time >= timeout)
-					break;
-				continue;
-			}
-			if ((err = snd_rawmidi_poll_descriptors_revents(input, pfds, npfds, &revents)) < 0) {
+
+			err = snd_rawmidi_poll_descriptors_revents(input, &pfds[1], npfds - 1, &revents);
+			if (err < 0) {
 				error("cannot get poll events: %s", snd_strerror(errno));
 				break;
 			}
 			if (revents & (POLLERR | POLLHUP))
 				break;
-			if (!(revents & POLLIN))
+			if (!(revents & POLLIN)) {
+				if (pfds[0].revents & POLLIN)
+					break;
 				continue;
+			}
+
 			err = snd_rawmidi_read(input, buf, sizeof(buf));
 			if (err == -EAGAIN)
 				continue;
@@ -603,7 +632,7 @@ int main(int argc, char *argv[])
 			if (length == 0)
 				continue;
 			read += length;
-			time = 0;
+
 			if (receive_file != -1)
 				write(receive_file, buf, length);
 			if (dump) {
@@ -611,6 +640,14 @@ int main(int argc, char *argv[])
 					print_byte(buf[i]);
 				fflush(stdout);
 			}
+
+			if (timeout > 0) {
+				err = timerfd_settime(pfds[0].fd, 0, &itimerspec, NULL);
+				if (err < 0) {
+					error("cannot set timer: %s", strerror(errno));
+					break;
+				}
+			}
 		}
 		if (isatty(fileno(stdout)))
 			printf("\n%d bytes read\n", read);
