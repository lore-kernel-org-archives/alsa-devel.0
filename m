From: Chris Ball <cjb@mrao.cam.ac.uk>
Subject: [PATCH] intel8x0: Add quirk for Optiplex GX270.
Date: Thu, 12 Jan 2006 22:23:56 +0000
Message-ID: <yd3hd89qe4j.fsf@islay.ra.phy.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

This patch adds a quirk entry for the Dell Optiplex GX270, on which
the volume is set by the headphone control, not the master control.

Signed-off-by: Chris Ball <cjb@mrao.cam.ac.uk>

Index: pci/intel8x0.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/intel8x0.c,v
retrieving revision 1.233
diff -u -r1.233 intel8x0.c
--- pci/intel8x0.c      4 Jan 2006 12:21:11 -0000       1.233
+++ pci/intel8x0.c      11 Jan 2006 22:51:13 -0000
@@ -1787,6 +1787,12 @@
        },
        {
                .subvendor = 0x1028,
+               .subdevice = 0x0151,
+               .name = "Dell Optiplex GX270",  /* AD1981B */
+               .type = AC97_TUNE_HP_ONLY
+       },
+       {
+               .subvendor = 0x1028,
                .subdevice = 0x012c,
                .name = "Dell Precision 650",   /* AD1981A */
                .type = AC97_TUNE_HP_ONLY



-- 
Chris Ball   <cjb@mrao.cam.ac.uk>   <http://www.mrao.cam.ac.uk/~cjb/>



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
