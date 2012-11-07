From: David Henningsson <david.henningsson@canonical.com>
Subject: [RFC PATCH] ALSA: hda - Keep power link on for
	PantherPoint HDMI
Date: Wed,  7 Nov 2012 09:22:33 +0100
Message-ID: <1352276553-26044-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id C08DD264F3A
 for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2012 09:22:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, 1075882@bugs.launchpad.net, alsa-devel@alsa-project.org, fengguang.wu@intel.com
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On some of the PantherPoint HDMI machines we currently enable, we're seeing
trouble with unsol events, i e detecting monitor presence, especially when
on battery and after suspend/resume.

BugLink: https://bugs.launchpad.net/bugs/1075882
Tested-by: Cyrus Lien <cyrus.lien@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_hdmi.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

So far this is the workaround we have found to be working. Sometimes, it also
seems that "cat /proc/asound/cardx/codec#x" can also make the HDMI unsol event
trigger, so that the problem fixes itself.

We have not run any battery life tests to see if this causes more power consumption.

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 39ca100..3155267 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1288,13 +1288,17 @@ static int hdmi_parse_codec(struct hda_codec *codec)
 		}
 	}
 
+#ifdef CONFIG_PM
+	/* We're seeing some problems with unsolicited hot plug events on
+	 * PantherPoint after S3, if this is not enabled */
+	if (codec->vendor_id == 0x80862806)
+		codec->bus->power_keep_link_on = 1;
 	/*
 	 * G45/IbexPeak don't support EPSS: the unsolicited pin hot plug event
 	 * can be lost and presence sense verb will become inaccurate if the
 	 * HDA link is powered off at hot plug or hw initialization time.
 	 */
-#ifdef CONFIG_PM
-	if (!(snd_hda_param_read(codec, codec->afg, AC_PAR_POWER_STATE) &
+	else if (!(snd_hda_param_read(codec, codec->afg, AC_PAR_POWER_STATE) &
 	      AC_PWRST_EPSS))
 		codec->bus->power_keep_link_on = 1;
 #endif
-- 
1.7.9.5
