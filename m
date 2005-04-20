From: "Ronny V. Vindenes" <s864@ii.uib.no>
Subject: [PATCH] via82xx on MSI K8T Neo-FIS2R
Date: Wed, 20 Apr 2005 21:18:02 +0200
Message-ID: <1114024682.15369.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-LYD0OHF+gesgTfU4XjQr"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from vintereik.ii.uib.no (vintereik.ii.uib.no [129.177.16.237])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8A2CE1DD
	for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2005 21:18:26 +0200 (MEST)
Received: from 213-145-178-72.dd.nextgentel.com ([213.145.178.72]:56803 helo=[10.24.72.108])
	by vintereik.ii.uib.no with esmtpsa (TLSv1:RC4-MD5:128)
	(Exim 4.43)
	id 1DOKiP-0004Xe-6l
	for alsa-devel@alsa-project.org; Wed, 20 Apr 2005 21:18:25 +0200
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
List-Id: alsa-devel@alsa-project.org


--=-LYD0OHF+gesgTfU4XjQr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Add PCI id to enable dxs_support=5 for this mobo.

-- 
Ronny V. Vindenes <s864@ii.uib.no>

--=-LYD0OHF+gesgTfU4XjQr
Content-Description: 
Content-Disposition: inline; filename=via62xx-msi-k8t-neo-fis2r.diff
Content-Type: text/x-patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: alsa-kernel/pci/via82xx.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/via82xx.c,v
retrieving revision 1.145
diff -u -r1.145 via82xx.c
--- alsa-kernel/pci/via82xx.c	15 Apr 2005 12:51:48 -0000	1.145
+++ alsa-kernel/pci/via82xx.c	20 Apr 2005 19:06:00 -0000
@@ -2169,6 +2169,7 @@
 		{ .vendor = 0x1297, .device = 0xa232, .action = VIA_DXS_ENABLE }, /* Shuttle ?? */
 		{ .vendor = 0x1297, .device = 0xc160, .action = VIA_DXS_ENABLE }, /* Shuttle SK41G */
 		{ .vendor = 0x1458, .device = 0xa002, .action = VIA_DXS_ENABLE }, /* Gigabyte GA-7VAXP */
+		{ .vendor = 0x1462, .device = 0x0080, .action = VIA_DXS_SRC }, /* MSI K8T Neo-FIS2R */
 		{ .vendor = 0x1462, .device = 0x3800, .action = VIA_DXS_ENABLE }, /* MSI KT266 */
 		{ .vendor = 0x1462, .device = 0x5901, .action = VIA_DXS_NO_VRA }, /* MSI KT6 Delta-SR */
 		{ .vendor = 0x1462, .device = 0x7023, .action = VIA_DXS_NO_VRA }, /* MSI K8T Neo2-FI */

--=-LYD0OHF+gesgTfU4XjQr--



-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
