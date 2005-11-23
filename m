From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] sound/: possible cleanups
Date: Wed, 23 Nov 2005 01:44:06 +0100
Message-ID: <20051123004406.GF3963__10746.929041534$1132706800$gmane$org@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id ACBB9185
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2005 01:44:06 +0100 (MET)
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
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch contains the following possible cleanups:
- core/init.c: make the needlessly global snd_generic_device_release()
  static
- pci/hda/hda_proc.c should #include "hda_local.h" for including the
  prototype of it's global function snd_hda_codec_proc_new()
- core/rawmidi.c: make the needlessly global and EXPORT_SYMBOL'ed
  function snd_rawmidi_info() static


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 sound/core/init.c        |    2 +-
 sound/core/rawmidi.c     |    4 ++--
 sound/pci/hda/hda_proc.c |    1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

--- linux-2.6.15-rc1-mm2-full/sound/core/rawmidi.c.old	2005-11-22 22:37:15.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/sound/core/rawmidi.c	2005-11-22 22:37:45.000000000 +0100
@@ -528,7 +528,8 @@
 	return err;
 }
 
-int snd_rawmidi_info(snd_rawmidi_substream_t *substream, snd_rawmidi_info_t *info)
+static int snd_rawmidi_info(snd_rawmidi_substream_t *substream,
+			    snd_rawmidi_info_t *info)
 {
 	snd_rawmidi_t *rmidi;
 	
@@ -1672,7 +1673,6 @@
 EXPORT_SYMBOL(snd_rawmidi_transmit);
 EXPORT_SYMBOL(snd_rawmidi_new);
 EXPORT_SYMBOL(snd_rawmidi_set_ops);
-EXPORT_SYMBOL(snd_rawmidi_info);
 EXPORT_SYMBOL(snd_rawmidi_info_select);
 EXPORT_SYMBOL(snd_rawmidi_kernel_open);
 EXPORT_SYMBOL(snd_rawmidi_kernel_release);
--- linux-2.6.15-rc1-mm2-full/sound/core/init.c.old	2005-11-22 22:38:41.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/sound/core/init.c	2005-11-22 22:39:09.000000000 +0100
@@ -694,7 +694,7 @@
 	},
 };
 
-void snd_generic_device_release(struct device *dev)
+static void snd_generic_device_release(struct device *dev)
 {
 }
 
--- linux-2.6.15-rc1-mm2-full/sound/pci/hda/hda_proc.c.old	2005-11-22 22:41:36.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/sound/pci/hda/hda_proc.c	2005-11-22 22:41:48.000000000 +0100
@@ -26,6 +26,7 @@
 #include <linux/pci.h>
 #include <sound/core.h>
 #include "hda_codec.h"
+#include "hda_local.h"
 
 static const char *get_wid_type_name(unsigned int wid_value)
 {



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
