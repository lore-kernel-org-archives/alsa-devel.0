From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Add jack detection for HDMI
Date: Tue, 17 May 2011 15:46:43 +0200
Message-ID: <4DD27C43.3050509@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030905020802080904050601"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id D50A11038E0
	for <alsa-devel@alsa-project.org>;
	Tue, 17 May 2011 15:46:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030905020802080904050601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Just as for headphones and microphone jacks, this patch adds reporting
of HDMI jack status through the input layer.

I considered making additional SND_JACK_* constants for HDMI and 
Displayport instead of going with SND_JACK_VIDEOOUT, but it didn't seem 
worth the additions, and breakage of compiling with old kernels, etc. 
Let me know if you think otherwise and I'll prepare a second patch for 
that.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------030905020802080904050601
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Add-jack-detection-for-HDMI.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-ALSA-HDA-Add-jack-detection-for-HDMI.patch"

>From d47239ae3d352b898649d0c15869dedd032ccbd7 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 17 May 2011 15:39:19 +0200
Subject: [PATCH] ALSA: HDA: Add jack detection for HDMI

Just as for headphones and microphone jacks, this patch adds reporting
of HDMI jack status through the input layer.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_codec.c  |    2 ++
 sound/pci/hda/patch_hdmi.c |   15 +++++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index c63f376..8edd998 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -5055,6 +5055,8 @@ static const char *get_jack_default_name(struct hda_codec *codec, hda_nid_t nid,
 		return "Line-out";
 	case SND_JACK_HEADSET:
 		return "Headset";
+	case SND_JACK_VIDEOOUT:
+		return "HDMI/DP";
 	default:
 		return "Misc";
 	}
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 6eb209d..16c1505 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -33,6 +33,7 @@
 #include <linux/slab.h>
 #include <linux/moduleparam.h>
 #include <sound/core.h>
+#include <sound/jack.h>
 #include "hda_codec.h"
 #include "hda_local.h"
 
@@ -720,6 +721,8 @@ static void hdmi_intrinsic_event(struct hda_codec *codec, unsigned int res)
 				  &spec->sink_eld[index]);
 		/* TODO: do real things about ELD */
 	}
+
+	snd_hda_input_jack_report(codec, tag);
 }
 
 static void hdmi_non_intrinsic_event(struct hda_codec *codec, unsigned int res)
@@ -919,6 +922,17 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 		return -E2BIG;
 	}
 
+#ifdef CONFIG_SND_HDA_INPUT_JACK
+	{
+		int err;
+		err = snd_hda_input_jack_add(codec, pin_nid,
+					     SND_JACK_VIDEOOUT, NULL);
+		if (err < 0)
+			return err;
+		snd_hda_input_jack_report(codec, pin_nid);
+	}
+#endif
+
 	hdmi_present_sense(codec, pin_nid, &spec->sink_eld[spec->num_pins]);
 
 	spec->pin[spec->num_pins] = pin_nid;
@@ -1120,6 +1134,7 @@ static void generic_hdmi_free(struct hda_codec *codec)
 
 	for (i = 0; i < spec->num_pins; i++)
 		snd_hda_eld_proc_free(codec, &spec->sink_eld[i]);
+	snd_hda_input_jack_free(codec);
 
 	kfree(spec);
 }
-- 
1.7.4.1


--------------030905020802080904050601
Content-Type: text/x-patch;
 name="0001-hda-emu-update-jack.h-to-match-latest-kernel-version.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-hda-emu-update-jack.h-to-match-latest-kernel-version.pa";
 filename*1="tch"

>From cdc4030a2028efdd1c36f2dc37402ea6971e1b12 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 17 May 2011 15:43:01 +0200
Subject: [PATCH] hda-emu: update jack.h to match latest kernel version

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 include/sound/jack.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/sound/jack.h b/include/sound/jack.h
index 77247d0..a6a4f21 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -12,6 +12,9 @@ enum snd_jack_types {
 	SND_JACK_MICROPHONE	= 0x0002,
 	SND_JACK_HEADSET	= SND_JACK_HEADPHONE | SND_JACK_MICROPHONE,
 	SND_JACK_LINEOUT	= 0x0004,
+	SND_JACK_MECHANICAL	= 0x0008, /* If detected separately */
+	SND_JACK_VIDEOOUT	= 0x0010,
+	SND_JACK_AVOUT		= SND_JACK_LINEOUT | SND_JACK_VIDEOOUT,
 };
 
 struct snd_jack {
-- 
1.7.4.1


--------------030905020802080904050601
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030905020802080904050601--
