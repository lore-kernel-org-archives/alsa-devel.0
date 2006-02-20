From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: [PATCH] hda/alc260: tweak test model input mux labels, fix a comment
Date: Mon, 20 Feb 2006 10:47:44 +1030 (CST)
Message-ID: <200602200017.k1K0HiRP021736@auster.physics.adelaide.edu.au>
References: <20060219205100.E38D7885EA@sc8-sf-spam1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060219205100.E38D7885EA@sc8-sf-spam1.sourceforge.net> from "alsa-devel-request@lists.sourceforge.net" at Feb 19, 2006 12:50:05 PM
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

This small patch adds clarity to the input mux labels used when the ALC260
test mode is activated.  The problem is that the ALC260's input muxes have
slight differences in how they interpret certain connection IDs, and they
even have a different number of input signals.  This patch takes the easy
way out and simply describes both interpretations where needed.

As noted in a comment in the source, the correct way of dealing with this is
to extend the alc_spec.input_mux field to allow the option of having
different mux setups for each ADC.  This involves a reasonable amount of
work and care since the changes will affect code for all of the realtek
codecs.  I'll try to look into adding this at some point, but in the meantime
this patch at least gives the test model full access to both ADC muxes if
needed.

Note that the issue of differing input muxes doesn't affect any ALC260
models which currently give access to the second ADC since none of them use
the affected connection IDs (0x5, 0x6, 0x7) for signals which one would
sensibly want to record.

The patch also includes a minor correction to a comment related to the
Fujitsu S702x input mux.

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
+		{ "HP-OUT pin (cap2 only) },
         },
 };
 static struct snd_kcontrol_new alc260_test_mixer[] = {


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
