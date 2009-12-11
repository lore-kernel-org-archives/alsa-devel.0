From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 5/5] intelhdmi - dont power off HDA link
Date: Fri, 11 Dec 2009 12:28:37 +0800
Message-ID: <20091211043213.436814565@intel.com>
References: <20091211042832.691808920@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id A10BF1037EA
	for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2009 05:32:43 +0100 (CET)
Content-Disposition: inline; filename=hdmi-dont-power-off-controller.patch
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

For codecs without EPSS support (G45/IbexPeak), the hotplug event will
be lost if the HDA is powered off during the time. After that the pin
presence detection verb returns inaccurate info.

So always power-on HDA link for !EPSS codecs.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/hda_codec.h       |    1 +
 sound/pci/hda/hda_intel.c       |    2 ++
 sound/pci/hda/patch_intelhdmi.c |   11 +++++++++++
 3 files changed, 14 insertions(+)

--- sound-2.6.orig/sound/pci/hda/hda_intel.c	2009-12-10 12:45:24.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_intel.c	2009-12-10 20:10:51.000000000 +0800
@@ -2079,6 +2079,8 @@ static void azx_power_notify(struct hda_
 			power_on = 1;
 			break;
 		}
+		if (c->power_keep_link_on)
+			power_save_controller = 0;
 	}
 	if (power_on)
 		azx_init_chip(chip);
--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c	2009-12-10 12:56:41.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c	2009-12-10 20:19:32.000000000 +0800
@@ -391,6 +391,17 @@ static int intel_hdmi_parse_codec(struct
 		}
 	}
 
+	/*
+	 * G45/IbexPeak don't support EPSS: the unsolicited pin hot plug event
+	 * can be lost and presence sense verb will become inaccurate if the
+	 * HDA link is powered off at hot plug or hw initialization time.
+	 */
+#ifdef CONFIG_SND_HDA_POWER_SAVE
+	if (!(snd_hda_param_read(codec, codec->afg, AC_PAR_POWER_STATE) &
+	      AC_PWRST_EPSS))
+	codec->power_keep_link_on = 1;
+#endif
+
 	return 0;
 }
 
--- sound-2.6.orig/sound/pci/hda/hda_codec.h	2009-12-10 12:45:24.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_codec.h	2009-12-10 20:10:51.000000000 +0800
@@ -819,6 +819,7 @@ struct hda_codec {
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	unsigned int power_on :1;	/* current (global) power-state */
 	unsigned int power_transition :1; /* power-state in transition */
+	unsigned int power_keep_link_on :1; /* don't power off HDA link */
 	int power_count;	/* current (global) power refcount */
 	struct delayed_work power_work; /* delayed task for powerdown */
 	unsigned long power_on_acct;
