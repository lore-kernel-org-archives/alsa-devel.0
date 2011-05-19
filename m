From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: HDA: Add jack detection for HDMI
Date: Thu, 19 May 2011 11:55:21 +0200
Message-ID: <4DD4E909.80108@canonical.com>
References: <4DD27C43.3050509@canonical.com> <s5hfwod5nz0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040806040506060705070005"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 73CF410397D
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 11:55:24 +0200 (CEST)
In-Reply-To: <s5hfwod5nz0.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040806040506060705070005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 2011-05-17 17:46, Takashi Iwai wrote:
> At Tue, 17 May 2011 15:46:43 +0200,
> David Henningsson wrote:
>>
>> Just as for headphones and microphone jacks, this patch adds reporting
>> of HDMI jack status through the input layer.
>>
>> I considered making additional SND_JACK_* constants for HDMI and
>> Displayport instead of going with SND_JACK_VIDEOOUT, but it didn't seem
>> worth the additions, and breakage of compiling with old kernels, etc.
>> Let me know if you think otherwise and I'll prepare a second patch for
>> that.
>
> Did you test it with the actual machine, right?
> If it's working, I'm fine to add it.

To be honest; it's partially working, or rather it's working in the 
sense that it follows the eld proc file. It's also working in hda-emu.

I've tried it on one Nvidia (with binary drivers), and one Intel 
Graphics and well, and both seem to have the same problem essentially: 
There is no hotplug event coming in (through hdmi_unsol_event) when a 
monitor is removed. But with this patch in perhaps the graphics driver 
writers will feel more motivated to fix it? :-)

Note that the hotplug event is not coming in when you actually plug the 
cable but when you detect displays and/or apply the monitor 
configuration change.

I'm attaching a new version of the patch according to your preference, 
in hopes that it will be in 2.6.40.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------040806040506060705070005
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Add-jack-detection-for-HDMI.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-ALSA-HDA-Add-jack-detection-for-HDMI.patch"

>From 0be95828e59250af983c86b3ec49d1ea81d8ec82 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Thu, 19 May 2011 11:46:03 +0200
Subject: [PATCH] ALSA: HDA: Add jack detection for HDMI

Just as for headphones and microphone jacks, this patch adds reporting
of HDMI jack status through the input layer.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_codec.c  |    2 ++
 sound/pci/hda/patch_hdmi.c |   11 +++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

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
index 6eb209d..7348296 100644
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
@@ -912,6 +915,7 @@ static void hdmi_present_sense(struct hda_codec *codec, hda_nid_t pin_nid,
 static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 {
 	struct hdmi_spec *spec = codec->spec;
+	int err;
 
 	if (spec->num_pins >= MAX_HDMI_PINS) {
 		snd_printk(KERN_WARNING
@@ -919,6 +923,12 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 		return -E2BIG;
 	}
 
+	err = snd_hda_input_jack_add(codec, pin_nid,
+				     SND_JACK_VIDEOOUT, NULL);
+	if (err < 0)
+		return err;
+	snd_hda_input_jack_report(codec, pin_nid);
+
 	hdmi_present_sense(codec, pin_nid, &spec->sink_eld[spec->num_pins]);
 
 	spec->pin[spec->num_pins] = pin_nid;
@@ -1120,6 +1130,7 @@ static void generic_hdmi_free(struct hda_codec *codec)
 
 	for (i = 0; i < spec->num_pins; i++)
 		snd_hda_eld_proc_free(codec, &spec->sink_eld[i]);
+	snd_hda_input_jack_free(codec);
 
 	kfree(spec);
 }
-- 
1.7.4.1


--------------040806040506060705070005
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040806040506060705070005--
