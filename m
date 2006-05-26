From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002165]: Fix mixer map for Hercules
	Gamesurround Muse LT usb soundcard.
Date: Fri, 26 May 2006 23:37:55 +0200
Message-ID: <050788f21a5244ea5add96da546f205e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2A605171
	for <alsa-devel@alsa-project.org>;
	Fri, 26 May 2006 23:37:56 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2165> 
======================================================================
Reported By:                jereynaud
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   2165
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             05-26-2006 23:37 CEST
Last Modified:              05-26-2006 23:37 CEST
======================================================================
Summary:                    Fix mixer map for Hercules Gamesurround Muse LT usb
soundcard.
Description: 
Add correct support for this sound card :
add a new map in usbmixer_maps.c

Signed-off-by: Jean-Emmanuel REYNAUD <je.reynaud@laposte.net>


--- linux-2.6.16.18/sound/usb/usbmixer_maps.c   2006-05-22
20:04:35.000000000 +0200
+++ linux-2.6.16.18.new/sound/usb/usbmixer_maps.c       2006-05-26
22:35:03.000000000 +0200
@@ -219,6 +219,43 @@
 };

 /*
+ * Hercules Gamesurround USB.
+ * USB_IN[1] --------------+-+->MU[15]-->FU[9]--> Spk-OUT[6]
+ *                         | |
+ * Mic-IN[2] --+-->FU[10]------+----->SU[8]-----> USB_OUT[7]
+ *             |           | | |
+ *             +-->FU[13]--+ | |
+ *                           | |
+ * Lin-IN[3] --+-->FU[11]------+
+ *             |             |
+ *             +-->FU[14]----+
+ */
+static struct usbmix_name_map hercules_gamesurround_muse_pocket_lt_map[]
= {
+       /* 1: IT pcm */
+       /* 2: IT mic */
+       /* 3: IT line */
+       /* 6: OT speaker */
+       /* 7: OT pcm capture */
+       { 8, "Capture Source" }, /* SU, Capture Source */
+       { 9, "Master Playback" }, /* FU, default Speaker 1 */
+       { 10, "Mic Capture" }, /* FU, default Auto Gain Input */
+       { 11, "Line Capture" }, /* FU, default PCM Capture */
+       { 13, "Mic Playback" }, /* FU, default Mic Playback */
+       { 14, "Line Playback" }, /* FU, default Speaker */
+       /* 15: MU */
+       { 0 } /* terminator */
+};
+static struct usbmix_selector_map
hercules_gamesurround_muse_pocket_lt_selectors_map[] = {
+       {
+               .id = 8, /* Capture Source */
+               .count = 2,
+               .names = (const char*[]) {"Mic", "Line"}
+       },
+       { 0 } /* terminator */
+};
+
+
+/*
  * Control map entries
  */

@@ -256,6 +293,13 @@
                .id = USB_ID(0x0c45, 0x1158),
                .map = justlink_map,
        },
+       {
+               /* Hercules Gamesurround Muse Pocket LT*/
+               .id = USB_ID(0x06f8, 0xc000),
+               .map = hercules_gamesurround_muse_pocket_lt_map,
+               .selector_map =
hercules_gamesurround_muse_pocket_lt_selectors_map,
+               .ignore_ctl_error = 1,
+       },
        { 0 } /* terminator */
 };


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-26-06 23:37 jereynaud      New Issue                                    
======================================================================
