From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] amidi active sensing option
Date: Mon, 19 Jan 2004 11:20:55 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0401191119160.7735-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


This adds an option to amidi not to ignore active sensing bytes.


Index: alsa-utils/amidi/amidi.1
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/amidi/amidi.1,v
retrieving revision 1.1
diff -u -r1.1 amidi.1
--- alsa-utils/amidi/amidi.1	28 Oct 2003 10:53:43 -0000	1.1
+++ alsa-utils/amidi/amidi.1	19 Jan 2004 10:17:39 -0000
@@ -1,4 +1,4 @@
-.TH AMIDI 1 "27 Oct 2003"
+.TH AMIDI 1 "18 Jan 2004"

 .SH NAME
 amidi \- read from and write to ALSA RawMIDI ports
@@ -81,7 +81,9 @@
 create a Standard MIDI (.mid) file.

 .B amidi
-will filter out any Active Sensing bytes (FEh).
+will filter out any Active Sensing bytes (FEh), unless the
+.I -a
+option has been given.

 .TP
 .I -S, --send-hex="..."
@@ -90,7 +92,9 @@
 .TP
 .I -d, --dump
 Prints data received from the MIDI port as hexadecimal bytes.
-Active Sensing bytes (FEh) will not be shown.
+Active Sensing bytes (FEh) will not be shown, unless the
+.I -a
+option has been given.

 This option is useful for debugging.

@@ -102,6 +106,11 @@
 If this option has not been given, you must press Ctrl+C (or kill
 .B amidi\fR)
 to stop receiving data.
+
+.TP
+.I -a, --active-sensing
+Does not ignore Active Sensing bytes (FEh) when saving or printing
+received MIDI commands.

 .SH EXAMPLES

Index: alsa-utils/amidi/amidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/amidi/amidi.c,v
retrieving revision 1.3
diff -u -r1.3 amidi.c
--- alsa-utils/amidi/amidi.c	13 Jan 2004 16:11:56 -0000	1.3
+++ alsa-utils/amidi/amidi.c	19 Jan 2004 10:17:39 -0000
@@ -76,7 +76,8 @@
 		"-S, --send-hex=\"...\"   send hexadecimal bytes\n"
 		"-d, --dump             print received data as hexadecimal bytes\n"
 		"-t, --timeout=seconds  exits when no data has been received\n"
-		"                       for the specified duration\n");
+		"                       for the specified duration\n"
+		"-a, --active-sensing   don't ignore active sensing bytes\n");
 }

 static void version(void)
@@ -371,7 +372,7 @@

 int main(int argc, char *argv[])
 {
-	static char short_options[] = "hVlLp:s:r:S:dt:";
+	static char short_options[] = "hVlLp:s:r:S:dt:a";
 	static struct option long_options[] = {
 		{"help", 0, NULL, 'h'},
 		{"version", 0, NULL, 'V'},
@@ -383,9 +384,11 @@
 		{"send-hex", 1, NULL, 'S'},
 		{"dump", 0, NULL, 'd'},
 		{"timeout", 1, NULL, 't'},
+		{"active-sensing", 0, NULL, 'a'},
 		{ }
 	};
 	int c, err, ok = 0;
+	int ignore_active_sensing = 1;

 	while ((c = getopt_long(argc, argv, short_options,
 		     		long_options, NULL)) != -1) {
@@ -420,6 +423,9 @@
 		case 't':
 			timeout = atoi(optarg);
 			break;
+		case 'a':
+			ignore_active_sensing = 0;
+			break;
 		default:
 			error("Try `amidi --help' for more information.");
 			return 1;
@@ -528,7 +534,7 @@
 			}
 			length = 0;
 			for (i = 0; i < err; ++i)
-				if (buf[i] != 0xfe) /* drop any active sensing bytes */
+				if (!ignore_active_sensing || buf[i] != 0xfe)
 					buf[length++] = buf[i];
 			if (length == 0)
 				continue;




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
