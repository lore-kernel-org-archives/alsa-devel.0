From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH] Add extra IDs for headphone autosense
Date: Thu, 24 Nov 2005 05:54:49 +0000
Message-ID: <20051124055449.GE28070@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from vavatch.codon.org.uk (cavan.codon.org.uk [217.147.92.49])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B08251B7
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2005 06:54:52 +0100 (MET)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The following patch adds some extra IDs for the list of hardware which 
should have headphone line sense enabled by default.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

--- sound/pci/ac97/ac97_patch.c.orig	2005-11-24 05:51:52 +0000
+++ sound/pci/ac97/ac97_patch.c	2005-11-24 05:52:41 +0000
@@ -1639,8 +1639,12 @@ static void check_ad1981_hp_jack_sense(a
 {
 	u32 subid = ((u32)ac97->subsystem_vendor << 16) | ac97->subsystem_device;
 	switch (subid) {
+	case 0x0e11005a: /* HP nc4000/4010 */
 	case 0x103c0890: /* HP nc6000 */
+	case 0x103c0938: /* HP nc4220 */
 	case 0x103c099c: /* HP nx6110 */
+	case 0x103c0944: /* HP nc6220 */
+	case 0x103c0934: /* HP nc8220 */
 	case 0x103c006d: /* HP nx9105 */
 	case 0x17340088: /* FSC Scenic-W */
 		/* enable headphone jack sense */

-- 
Matthew Garrett | mjg59@srcf.ucam.org


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
