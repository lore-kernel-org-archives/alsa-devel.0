From: Marko Kreen <marko@l-t.ee>
Subject: [patch] via82xx: Enable DXS on ABIT KV8 Pro
Date: Thu, 18 Nov 2004 19:05:57 +0200
Message-ID: <20041118170557.GA14412@l-t.ee>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Enable DXS for via audio chip on ABIT KV8 Pro.

Works for me.

lspci -v:
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.  VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
        Subsystem: ABIT Computer Corp.: Unknown device 1413
        Flags: medium devsel, IRQ 22
        I/O ports at e000 [size=256]
        Capabilities: <available only to root>

-- 
marko


diff -urp linux-2.6.9/sound/pci/via82xx.c linux-2.6/sound/pci/via82xx.c
--- linux-2.6.9/sound/pci/via82xx.c	2004-11-18 18:52:13.000000000 +0200
+++ linux-2.6/sound/pci/via82xx.c	2004-11-08 12:27:27.000000000 +0200
@@ -2100,6 +2100,7 @@ static int __devinit check_dxs_list(stru
 		{ .vendor = 0x1297, .device = 0xc160, .action = VIA_DXS_ENABLE }, /* Shuttle SK41G */
 		{ .vendor = 0x1458, .device = 0xa002, .action = VIA_DXS_NO_VRA }, /* Gigabyte GA-7VAXP (FIXME: or DXS_ENABLE?) */
 		{ .vendor = 0x147b, .device = 0x1401, .action = VIA_DXS_ENABLE }, /* ABIT KD7(-RAID) */
+		{ .vendor = 0x147b, .device = 0x1413, .action = VIA_DXS_ENABLE }, /* ABIT KV8 Pro */
 		{ .vendor = 0x14ff, .device = 0x0403, .action = VIA_DXS_ENABLE }, /* Twinhead mobo */
 		{ .vendor = 0x1462, .device = 0x3800, .action = VIA_DXS_ENABLE }, /* MSI KT266 */
 		{ .vendor = 0x1462, .device = 0x7120, .action = VIA_DXS_ENABLE }, /* MSI KT4V */



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
