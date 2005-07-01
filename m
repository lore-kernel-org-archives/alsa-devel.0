From: Matt <matt@embeddedalley.com>
Subject: [PATCH][1/2] hda: enable unsolicited responses
Date: Fri, 1 Jul 2005 08:48:01 -0700
Message-ID: <20050701084801.A12830@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
To: tiwai@suse.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patch enables unsolicited responses on the HDA controller. Without
the UREN bit set, the controller will not place unsolicited responses
in a RIRB.

Signed-off-by: Matt <matt@embeddedalley.com>

Index: alsa-kernel/pci/hda/hda_intel.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/hda_intel.c,v
retrieving revision 1.12
diff -u -r1.12 hda_intel.c
--- alsa-kernel/pci/hda/hda_intel.c	13 Jun 2005 13:16:39 -0000	1.12
+++ alsa-kernel/pci/hda/hda_intel.c	1 Jul 2005 14:34:10 -0000
@@ -178,6 +178,9 @@
 #define ICH6_INT_CTRL_EN	0x40000000	/* controller interrupt enable bit */
 #define ICH6_INT_GLOBAL_EN	0x80000000	/* global interrupt enable bit */
 
+/* GCTL unsolicited response enable bit */
+#define ICH6_GCTL_UREN		(1<<8)
+
 /* GCTL reset bit */
 #define ICH6_GCTL_RESET		(1<<0)
 
@@ -562,6 +565,9 @@
 		return -EBUSY;
 	}
 
+	/* Accept unsolicited responses */
+	azx_writel(chip, GCTL, azx_readl(chip, GCTL) | ICH6_GCTL_UREN);
+
 	/* detect codecs */
 	if (! chip->codec_mask) {
 		chip->codec_mask = azx_readw(chip, STATESTS);


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
