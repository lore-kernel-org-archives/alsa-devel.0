From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 1/2] amidi: ignore not only Active Sensing but
	all System	Real-Time messages
Date: Sun, 10 Apr 2016 21:29:04 +0200
Message-ID: <570AA980.3070802@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id BD09326074D
 for <alsa-devel@alsa-project.org>; Sun, 10 Apr 2016 21:29:27 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Martin Tarenskeen <m.tarenskeen@zonnet.nl>
List-Id: alsa-devel@alsa-project.org

By default, amidi ignores Active Sensing messages because they are sent
by many devices in the background and would only interfere with the
actual messages that amidi is supposed to capture.  However, there are
also devices that send Clock messages with the same problem, so it is
a better idea to filter out all System Real-Time messages.

Reported-by: Martin Tarenskeen <m.tarenskeen@zonnet.nl>
Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 amidi/amidi.1 |   19 +++++++++++++------
 amidi/amidi.c |   11 ++++++-----
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/amidi/amidi.1 b/amidi/amidi.1
index 1b4cfb1..46e9c50 100644
--- a/amidi/amidi.1
+++ b/amidi/amidi.1
@@ -1,4 +1,4 @@
-.TH AMIDI 1 "26 Jun 2006"
+.TH AMIDI 1 "26 Mar 2016"

 .SH NAME
 amidi \- read from and write to ALSA RawMIDI ports
@@ -80,7 +80,7 @@ to record a Standard MIDI (.mid) file, use
 .B arecordmidi(1).

 .B amidi
-will filter out any Active Sensing bytes (FEh), unless the
+will filter out System Real-Time messages (F8h...FFh), unless the
 .I \-a
 option has been given.

@@ -91,7 +91,7 @@ Sends the bytes specified as hexadecimal numbers to the MIDI port.
 .TP
 .I \-d, \-\-dump
 Prints data received from the MIDI port as hexadecimal bytes.
-Active Sensing bytes (FEh) will not be shown, unless the
+System Real-Time messages (F8h...FFh) will not be shown, unless the
 .I \-a
 option has been given.

@@ -107,9 +107,16 @@ If this option has not been given, you must press Ctrl+C (or kill
 to stop receiving data.

 .TP
-.I \-a, \-\-active\-sensing
-Does not ignore Active Sensing bytes (FEh) when saving or printing
-received MIDI commands.
+.I \-a, \-\-all\-messages
+Includes System Real-Time messages (F8h...FFh) when saving or
+printing received MIDI commands.
+By default, these messages are ignored.
+
+(Clock (F8h) or Active Sensing (FEh) messages are sent in the
+background by many devices, but typically are not wanted and would
+only clutter up
+.B amidi\fR's
+output.)

 .SH EXAMPLES

diff --git a/amidi/amidi.c b/amidi/amidi.c
index cedf18c..4978249 100644
--- a/amidi/amidi.c
+++ b/amidi/amidi.c
@@ -77,7 +77,7 @@ static void usage(void)
 		"-d, --dump             print received data as hexadecimal bytes\n"
 		"-t, --timeout=seconds  exits when no data has been received\n"
 		"                       for the specified duration\n"
-		"-a, --active-sensing   don't ignore active sensing bytes\n");
+		"-a, --all-messages     include system real-time messages\n");
 }

 static void version(void)
@@ -418,11 +418,12 @@ int main(int argc, char *argv[])
 		{"send-hex", 2, NULL, 'S'},
 		{"dump", 0, NULL, 'd'},
 		{"timeout", 1, NULL, 't'},
-		{"active-sensing", 0, NULL, 'a'},
+		{"all-messages", 0, NULL, 'a'},
+		{"active-sensing", 0, NULL, 'a'}, /* for backwards compatibility */
 		{ }
 	};
 	int c, err, ok = 0;
-	int ignore_active_sensing = 1;
+	int ignore_system_realtime = 1;
 	int do_send_hex = 0;

 	while ((c = getopt_long(argc, argv, short_options,
@@ -461,7 +462,7 @@ int main(int argc, char *argv[])
 			timeout = atoi(optarg);
 			break;
 		case 'a':
-			ignore_active_sensing = 0;
+			ignore_system_realtime = 0;
 			break;
 		default:
 			error("Try `amidi --help' for more information.");
@@ -589,7 +590,7 @@ int main(int argc, char *argv[])
 			}
 			length = 0;
 			for (i = 0; i < err; ++i)
-				if (!ignore_active_sensing || buf[i] != 0xfe)
+				if (!ignore_system_realtime || buf[i] < 0xf8)
 					buf[length++] = buf[i];
 			if (length == 0)
 				continue;
