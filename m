From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH v2 1/2] amidi: ignore not only Active Sensing
	but also Clock	bytes
Date: Sat, 13 Aug 2016 16:41:23 +0200
Message-ID: <0ae3bd47-3823-9b52-4e36-c4525d247f96@ladisch.de>
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
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 72BEE26657F
 for <alsa-devel@alsa-project.org>; Sat, 13 Aug 2016 16:43:00 +0200 (CEST)
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

Active Sensing messages are sent by many devices in the background and
would only interfere with the actual messages that amidi is supposed to
capture.  Therefore, amidi ignores them by default.  However, there are
also devices that send Clock messages with the same problem, so it is
a better idea to filter them out, too.

Reported-by: Martin Tarenskeen <m.tarenskeen@gmail.com>
Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 amidi/amidi.1 |   19 ++++++++++++++-----
 amidi/amidi.c |   15 ++++++++++++---
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/amidi/amidi.1 b/amidi/amidi.1
index 1b4cfb1..86beb27 100644
--- a/amidi/amidi.1
+++ b/amidi/amidi.1
@@ -1,4 +1,4 @@
-.TH AMIDI 1 "26 Jun 2006"
+.TH AMIDI 1 "16 Apr 2016"

 .SH NAME
 amidi \- read from and write to ALSA RawMIDI ports
@@ -80,9 +80,11 @@ to record a Standard MIDI (.mid) file, use
 .B arecordmidi(1).

 .B amidi
-will filter out any Active Sensing bytes (FEh), unless the
+will filter out any Active Sensing and Clock bytes (FEh, F8h), unless the
 .I \-a
-option has been given.
+or
+.I \-c
+options have been given.

 .TP
 .I \-S, \-\-send\-hex="..."
@@ -91,9 +93,11 @@ Sends the bytes specified as hexadecimal numbers to the MIDI port.
 .TP
 .I \-d, \-\-dump
 Prints data received from the MIDI port as hexadecimal bytes.
-Active Sensing bytes (FEh) will not be shown, unless the
+Active Sensing and Clock bytes (FEh, F8h) will not be shown, unless the
 .I \-a
-option has been given.
+or
+.I \-c
+options have been given.

 This option is useful for debugging.

@@ -111,6 +115,11 @@ to stop receiving data.
 Does not ignore Active Sensing bytes (FEh) when saving or printing
 received MIDI commands.

+.TP
+.I \-c, \-\-clock
+Does not ignore Clock bytes (F8h) when saving or printing received
+MIDI commands.
+
 .SH EXAMPLES

 .TP
diff --git a/amidi/amidi.c b/amidi/amidi.c
index cedf18c..5871512 100644
--- a/amidi/amidi.c
+++ b/amidi/amidi.c
@@ -77,7 +77,8 @@ static void usage(void)
 		"-d, --dump             print received data as hexadecimal bytes\n"
 		"-t, --timeout=seconds  exits when no data has been received\n"
 		"                       for the specified duration\n"
-		"-a, --active-sensing   don't ignore active sensing bytes\n");
+		"-a, --active-sensing   include active sensing bytes\n"
+		"-c, --clock            include clock bytes\n");
 }

 static void version(void)
@@ -406,7 +407,7 @@ static void add_send_hex_data(const char *str)

 int main(int argc, char *argv[])
 {
-	static const char short_options[] = "hVlLp:s:r:S::dt:a";
+	static const char short_options[] = "hVlLp:s:r:S::dt:ac";
 	static const struct option long_options[] = {
 		{"help", 0, NULL, 'h'},
 		{"version", 0, NULL, 'V'},
@@ -419,10 +420,12 @@ int main(int argc, char *argv[])
 		{"dump", 0, NULL, 'd'},
 		{"timeout", 1, NULL, 't'},
 		{"active-sensing", 0, NULL, 'a'},
+		{"clock", 0, NULL, 'c'},
 		{ }
 	};
 	int c, err, ok = 0;
 	int ignore_active_sensing = 1;
+	int ignore_clock = 1;
 	int do_send_hex = 0;

 	while ((c = getopt_long(argc, argv, short_options,
@@ -463,6 +466,9 @@ int main(int argc, char *argv[])
 		case 'a':
 			ignore_active_sensing = 0;
 			break;
+		case 'c':
+			ignore_clock = 0;
+			break;
 		default:
 			error("Try `amidi --help' for more information.");
 			return 1;
@@ -589,7 +595,10 @@ int main(int argc, char *argv[])
 			}
 			length = 0;
 			for (i = 0; i < err; ++i)
-				if (!ignore_active_sensing || buf[i] != 0xfe)
+				if ((buf[i] != MIDI_CMD_COMMON_CLOCK &&
+				     buf[i] != MIDI_CMD_COMMON_SENSING) ||
+				    (buf[i] == MIDI_CMD_COMMON_CLOCK   && !ignore_clock) ||
+				    (buf[i] == MIDI_CMD_COMMON_SENSING && !ignore_active_sensing))
 					buf[length++] = buf[i];
 			if (length == 0)
 				continue;
