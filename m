From: Matt Porter <mporter@embeddedalley.com>
Subject: [PATCH] Fix HDA probe_mask default
Date: Tue, 29 Nov 2005 07:39:31 -0700
Message-ID: <20051129073931.A17707@cox.net>
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
To: tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The probe_mask module parameter comment notes that the intended
default is -1. Fix it to be so, otherwise all codecs are skipped
and init fails.

Signed-off-by: Matt Porter <mporter@embeddedalley.com>

Index: alsa-kernel/pci/hda/hda_intel.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/hda_intel.c,v
retrieving revision 1.32
diff -u -r1.32 hda_intel.c
--- alsa-kernel/pci/hda/hda_intel.c	24 Nov 2005 16:03:40 -0000	1.32
+++ alsa-kernel/pci/hda/hda_intel.c	29 Nov 2005 14:34:17 -0000
@@ -52,7 +52,7 @@
 static char *id = SNDRV_DEFAULT_STR1;
 static char *model;
 static int position_fix;
-static int probe_mask;
+static int probe_mask = -1;
 
 module_param(index, int, 0444);
 MODULE_PARM_DESC(index, "Index value for Intel HD audio interface.");


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
