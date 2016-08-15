From: "Felipe F. Tonello" <eu@felipetonello.com>
Subject: [PATCH v3 1/2] amidi: add delay option
Date: Mon, 15 Aug 2016 16:36:06 +0100
Message-ID: <20160815153607.28953-2-eu@felipetonello.com>
References: <20160815153607.28953-1-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id B208C266671
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2016 17:36:10 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id i5so11726086wmg.2
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2016 08:36:10 -0700 (PDT)
Received: from localhost.localdomain ([81.145.202.106])
 by smtp.gmail.com with ESMTPSA id g184sm17122871wme.15.2016.08.15.08.36.09
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Aug 2016 08:36:09 -0700 (PDT)
In-Reply-To: <20160815153607.28953-1-eu@felipetonello.com>
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
List-Id: alsa-devel@alsa-project.org

This patch adds a new options to amidi tool to add a delay (in milliseconds)
to each SysEx message.

This is very useful when sending firmware updates to a remote device via SysEx
or any other use that requires this delay in between messages.

Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
---
 amidi/amidi.1 | 14 ++++++++++++++
 amidi/amidi.c | 38 +++++++++++++++++++++++++++++++++-----
 2 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/amidi/amidi.1 b/amidi/amidi.1
index 1b4cfb1ea956..391008177610 100644
--- a/amidi/amidi.1
+++ b/amidi/amidi.1
@@ -111,6 +111,12 @@ to stop receiving data.
 Does not ignore Active Sensing bytes (FEh) when saving or printing
 received MIDI commands.
 
+.TP
+.I \-D, \-\-delay=mseconds
+Adds a delay in between each SysEx message sent to a device. It is
+useful when sending firmware updates via SysEx messages to a remote
+device.
+
 .SH EXAMPLES
 
 .TP
@@ -121,6 +127,14 @@ to port
 .I hw:0.
 
 .TP
+.B amidi \-p hw:1,0,0 -s firmware.syx \-D 100
+will send the MIDI commands in
+.I firmware.syx
+to port
+.I hw:1,0,0
+with 100 milliseconds delay in between each SysEx message.
+
+.TP
 .B amidi \-S 'F0 43 10 4C 00 00 7E 00 F7'
 sends an XG Reset to the default port.
 
diff --git a/amidi/amidi.c b/amidi/amidi.c
index cedf18c5fd39..a1cb77f362bd 100644
--- a/amidi/amidi.c
+++ b/amidi/amidi.c
@@ -48,6 +48,7 @@ static int receive_file;
 static int dump;
 static int timeout;
 static int stop;
+static int delay;
 static snd_rawmidi_t *input, **inputp;
 static snd_rawmidi_t *output, **outputp;
 
@@ -77,7 +78,8 @@ static void usage(void)
 		"-d, --dump             print received data as hexadecimal bytes\n"
 		"-t, --timeout=seconds  exits when no data has been received\n"
 		"                       for the specified duration\n"
-		"-a, --active-sensing   don't ignore active sensing bytes\n");
+		"-a, --active-sensing   don't ignore active sensing bytes\n"
+		"-D, --delay=mseconds   delay in between each SysEx message\n");
 }
 
 static void version(void)
@@ -406,7 +408,7 @@ static void add_send_hex_data(const char *str)
 
 int main(int argc, char *argv[])
 {
-	static const char short_options[] = "hVlLp:s:r:S::dt:a";
+	static const char short_options[] = "hVlLp:s:r:S::dt:aD:";
 	static const struct option long_options[] = {
 		{"help", 0, NULL, 'h'},
 		{"version", 0, NULL, 'V'},
@@ -419,6 +421,7 @@ int main(int argc, char *argv[])
 		{"dump", 0, NULL, 'd'},
 		{"timeout", 1, NULL, 't'},
 		{"active-sensing", 0, NULL, 'a'},
+		{"delay", 1, NULL, 'D'},
 		{ }
 	};
 	int c, err, ok = 0;
@@ -463,6 +466,9 @@ int main(int argc, char *argv[])
 		case 'a':
 			ignore_active_sensing = 0;
 			break;
+		case 'D':
+			delay = atoi(optarg);
+			break;
 		default:
 			error("Try `amidi --help' for more information.");
 			return 1;
@@ -538,9 +544,31 @@ int main(int argc, char *argv[])
 			error("cannot set blocking mode: %s", snd_strerror(err));
 			goto _exit;
 		}
-		if ((err = snd_rawmidi_write(output, send_data, send_data_length)) < 0) {
-			error("cannot send data: %s", snd_strerror(err));
-			goto _exit;
+		if (!delay) {
+			if ((err = snd_rawmidi_write(output, send_data, send_data_length)) < 0) {
+				error("cannot send data: %s", snd_strerror(err));
+				return err;
+			}
+		} else {
+			char *data = send_data;
+
+			while (data < (send_data + send_data_length)) {
+				int len;
+
+				if (data > send_data)
+					usleep(delay * 1000);
+
+				/* find end of SysEx */
+				len = (char *)memchr(data, 0xf7, (send_data + send_data_length) - data)
+					- data + 1;
+
+				if ((err = snd_rawmidi_write(output, data, len)) < 0) {
+					error("cannot send data: %s", snd_strerror(err));
+					return err;
+				}
+
+				data += len;
+			}
 		}
 	}
 
-- 
2.9.3
