From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: [PATCH] hda/alc260: take 2: tweak test model input mux labels, fix a comment
Date: Mon, 20 Feb 2006 16:46:06 +1030 (CST)
Message-ID: <200602200616.k1K6G6h0014967@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi all

Ok, call it a brain-fade - there's a missing quote and 0x7 in the input mux
enumeration change I posted earlier today.  Here's the corrected patch.

Refer to the previous post for further info and the motivation for
this patch.

Thanks to Rimas for pointing out the error.

Regards
  jonathan

--- patch_realtek.c-orig	2006-02-10 10:10:31.000000000 +1030
+++ patch_realtek.c	2006-02-20 10:31:36.000000000 +1030
@@ -2414,8 +2414,8 @@
 	},
 };
 
-/* On Fujitsu S702x laptops capture only makes sense from Mic/LineIn jack
- * and the internal CD lines.
+/* On Fujitsu S702x laptops capture only makes sense from Mic/LineIn jack,
+ * headphone jack and the internal CD lines.
  */
 static struct hda_input_mux alc260_fujitsu_capture_source = {
 	.num_items = 3,
@@ -2790,16 +2790,26 @@
 static hda_nid_t alc260_test_adc_nids[2] = {
 	0x04, 0x05,
 };
+/* This is a bit messy since the two input muxes in the ALC260 have slight
+ * variations in their signal assignments.  The ideal way to deal with this
+ * is to extend alc_spec.input_mux to allow a different input MUX for each
+ * ADC.  For the purposes of the test model it's sufficient to just list
+ * both options for affected signal indices.  The separate input mux
+ * functionality only needs to be considered if a model comes along which
+ * actually uses signals 0x5, 0x6 and 0x7 for something which makes sense to
+ * record.
+ */
 static struct hda_input_mux alc260_test_capture_source = {
-	.num_items = 7,
+	.num_items = 8,
 	.items = {
 		{ "MIC1 pin", 0x0 },
 		{ "MIC2 pin", 0x1 },
 		{ "LINE1 pin", 0x2 },
 		{ "LINE2 pin", 0x3 },
 		{ "CD pin", 0x4 },
-		{ "LINE-OUT pin", 0x5 },
-		{ "HP-OUT pin", 0x6 },
+		{ "LINE-OUT pin (cap1), Mixer (cap2)", 0x5 },
+		{ "HP-OUT pin (cap1), LINE-OUT pin (cap2)", 0x6 },
+		{ "HP-OUT pin (cap2 only)", 0x7 },
         },
 };
 static struct snd_kcontrol_new alc260_test_mixer[] = {


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
