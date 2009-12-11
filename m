From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH 5/5] intelhdmi - dont power off HDA link
Date: Fri, 11 Dec 2009 20:15:11 +0800
Message-ID: <20091211121511.GA12374@localhost>
References: <20091211042832.691808920@intel.com>
	<20091211043213.436814565@intel.com> <s5hhbryoum3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 2DA54244C0
	for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2009 13:15:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hhbryoum3.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shane W <shane-alsa@csy.ca>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 11, 2009 at 03:08:52PM +0800, Takashi Iwai wrote:
> At Fri, 11 Dec 2009 12:28:37 +0800,
> Wu Fengguang wrote:
> > 
> > For codecs without EPSS support (G45/IbexPeak), the hotplug event will
> > be lost if the HDA is powered off during the time. After that the pin
> > presence detection verb returns inaccurate info.
> > 
> > So always power-on HDA link for !EPSS codecs.
> > 
> > Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
> 
> I think it'd be better to add a flag to hda_bus than hda_codec like
> the patch below (the change in patch_intelhdmi.c is not included).
> It's a bit ugly to change the module parameter from the driver side.

Good suggestion, thanks! Here is the updated patch.

---
intelhdmi - don't power off HDA link

For codecs without EPSS support (G45/IbexPeak), the hotplug event will
be lost if the HDA is powered off during the time. After that the pin
presence detection verb returns inaccurate info.

So always power-on HDA link for !EPSS codecs.

KarL offers the fact and Takashi recommends to flag hda_bus. Thanks!

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/hda_codec.h       |    1 +
 sound/pci/hda/hda_intel.c       |    3 ++-
 sound/pci/hda/patch_intelhdmi.c |   11 +++++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

--- sound-2.6.orig/sound/pci/hda/hda_intel.c	2009-12-11 12:46:18.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_intel.c	2009-12-11 20:12:31.000000000 +0800
@@ -2082,7 +2082,8 @@ static void azx_power_notify(struct hda_
 	}
 	if (power_on)
 		azx_init_chip(chip);
-	else if (chip->running && power_save_controller)
+	else if (chip->running && power_save_controller &&
+		 !bus->power_keep_link_on)
 		azx_stop_chip(chip);
 }
 #endif /* CONFIG_SND_HDA_POWER_SAVE */
--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c	2009-12-11 12:46:22.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c	2009-12-11 20:07:59.000000000 +0800
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
+		codec->bus->power_keep_link_on = 1;
+#endif
+
 	return 0;
 }
 
--- sound-2.6.orig/sound/pci/hda/hda_codec.h	2009-12-11 12:46:21.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_codec.h	2009-12-11 20:13:18.000000000 +0800
@@ -639,6 +639,7 @@ struct hda_bus {
 	unsigned int rirb_error:1;	/* error in codec communication */
 	unsigned int response_reset:1;	/* controller was reset */
 	unsigned int in_reset:1;	/* during reset operation */
+	unsigned int power_keep_link_on:1; /* don't power off HDA link */
 };
 
 /*
