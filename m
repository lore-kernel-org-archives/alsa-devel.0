From: Jason Gaston <jason.d.gaston@intel.com>
Subject: [PATCH 2.6.19-rc6][RESEND] hda_intel: ALSA HD Audio
	patch for Intel ICH9
Date: Tue, 21 Nov 2006 16:57:47 -0800
Message-ID: <200611211657.47852.jason.d.gaston@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 103472A8
	for <alsa-devel@alsa-project.org>; Wed, 22 Nov 2006 01:57:57 +0100 (MET)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: perex@suse.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, jason.d.gaston@intel.com
List-Id: alsa-devel@alsa-project.org

This patch adds the Intel ICH9 HD Audio controller DID's for ALSA.

Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>

--- linux-2.6.19-rc6/sound/pci/hda/hda_intel.c.orig	2006-11-21 07:06:26.000000000 -0800
+++ linux-2.6.19-rc6/sound/pci/hda/hda_intel.c	2006-11-21 07:10:03.000000000 -0800
@@ -83,6 +83,7 @@
 			 "{Intel, ICH7},"
 			 "{Intel, ESB2},"
 			 "{Intel, ICH8},"
+			 "{Intel, ICH9},"
 			 "{ATI, SB450},"
 			 "{ATI, SB600},"
 			 "{ATI, RS600},"
@@ -1710,6 +1711,8 @@
 	{ 0x8086, 0x27d8, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ICH }, /* ICH7 */
 	{ 0x8086, 0x269a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ICH }, /* ESB2 */
 	{ 0x8086, 0x284b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ICH }, /* ICH8 */
+	{ 0x8086, 0x293e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ICH }, /* ICH9 */
+	{ 0x8086, 0x293f, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ICH }, /* ICH9 */
 	{ 0x1002, 0x437b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ATI }, /* ATI SB450 */
 	{ 0x1002, 0x4383, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ATI }, /* ATI SB600 */
 	{ 0x1002, 0x793b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ATIHDMI }, /* ATI RS600 HDMI */

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
