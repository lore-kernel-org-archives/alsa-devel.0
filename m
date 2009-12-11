From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 2/5] intelhdmi - accept DisplayPort pin
Date: Fri, 11 Dec 2009 12:28:34 +0800
Message-ID: <20091211043213.011544485@intel.com>
References: <20091211042832.691808920@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id DFB73243D3
	for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2009 05:32:42 +0100 (CET)
Content-Disposition: inline; filename=alsa-parse-allow-dp.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>, Shane W <shane-alsa@csy.ca>
List-Id: alsa-devel@alsa-project.org

HDA036 spec states:
  DP (Display Port) indicates whether the Pin Complex Widget supports
  connection to a Display Port sink.  Supported if set to 1. Note that
  it is possible for the pin widget to support more than one digital
  display connection type, e.g. HDMI and DP bit are both set to 1.

Also export the DP pin cap in procfs.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/hda_codec.h       |    3 +++
 sound/pci/hda/hda_proc.c        |    2 ++
 sound/pci/hda/patch_intelhdmi.c |    2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

--- sound-2.6.orig/sound/pci/hda/hda_codec.h	2009-12-02 10:11:41.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_codec.h	2009-12-02 10:11:47.000000000 +0800
@@ -255,6 +255,9 @@ enum {
  *       in HD-audio specification
  */
 #define AC_PINCAP_HDMI			(1<<7)	/* HDMI pin */
+#define AC_PINCAP_DP			(1<<24)	/* DisplayPort pin, can
+						 * coexist with AC_PINCAP_HDMI
+						 */
 #define AC_PINCAP_VREF			(0x37<<8)
 #define AC_PINCAP_VREF_SHIFT		8
 #define AC_PINCAP_EAPD			(1<<16)	/* EAPD capable */
--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c	2009-12-02 10:11:39.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c	2009-12-02 10:11:47.000000000 +0800
@@ -344,7 +344,7 @@ static int intel_hdmi_parse_codec(struct
 			break;
 		case AC_WID_PIN:
 			caps = snd_hda_param_read(codec, nid, AC_PAR_PIN_CAP);
-			if (!(caps & AC_PINCAP_HDMI))
+			if (!(caps & (AC_PINCAP_HDMI | AC_PINCAP_DP)))
 				continue;
 			if (intel_hdmi_add_pin(codec, nid) < 0)
 				return -EINVAL;
--- sound-2.6.orig/sound/pci/hda/hda_proc.c	2009-12-02 10:11:41.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_proc.c	2009-12-02 10:11:47.000000000 +0800
@@ -246,6 +246,8 @@ static void print_pin_caps(struct snd_in
 			snd_iprintf(buffer, " HDMI");
 		}
 	}
+	if (caps & AC_PINCAP_DP)
+		snd_iprintf(buffer, " DP");
 	if (caps & AC_PINCAP_TRIG_REQ)
 		snd_iprintf(buffer, " Trigger");
 	if (caps & AC_PINCAP_IMP_SENSE)
