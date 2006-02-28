From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: [PATCH] HDA/ALC260: 3/7 - generalise some structures
Date: Tue, 28 Feb 2006 10:55:51 +1030 (CST)
Message-ID: <200602280025.k1S0PpIQ017371@auster.physics.adelaide.edu.au>
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
To: tiwai@suse.de
Cc: jwoithe@physics.adelaide.edu.au, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi

[ Resent to avoid confusion due to typo in subject of original post ]

This patch generalises a structure added for the "fujitsu" model but which
is potentially useful for other models as well.  It turns the
"alc260_fujitsu_adc_nids" array into "alc260_dual_adc_nids"; for other
models which decide to utilise the dual ADC functionality there's really
no reason why they need to define their own list of ADC nids.

The "fujitsu" model preset is adjusted accordingly.

Regards
  jonathan


--- patch_realtek.c-02-switch_pin_io_mode	2006-02-27 22:46:24.000000000 +1030
+++ patch_realtek.c	2006-02-27 22:47:09.000000000 +1030
@@ -2419,7 +2419,10 @@
 	0x05, 0x04
 };
 
-static hda_nid_t alc260_fujitsu_adc_nids[2] = {
+/* NIDs used when simultaneous access to both ADCs makes sense.  Note that
+ * alc260_capture_mixer assumes ADC0 (nid 0x04) is the first ADC.
+ */
+static hda_nid_t alc260_dual_adc_nids[2] = {
 	/* ADC0, ADC1 */
 	0x04, 0x05
 };
@@ -3285,8 +3288,8 @@
 		.init_verbs = { alc260_fujitsu_init_verbs },
 		.num_dacs = ARRAY_SIZE(alc260_dac_nids),
 		.dac_nids = alc260_dac_nids,
-		.num_adc_nids = ARRAY_SIZE(alc260_fujitsu_adc_nids),
-		.adc_nids = alc260_fujitsu_adc_nids,
+		.num_adc_nids = ARRAY_SIZE(alc260_dual_adc_nids),
+		.adc_nids = alc260_dual_adc_nids,
 		.num_channel_mode = ARRAY_SIZE(alc260_modes),
 		.channel_mode = alc260_modes,
 		.input_mux = &alc260_fujitsu_capture_source,


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
