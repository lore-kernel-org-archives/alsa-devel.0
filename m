From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] drm/i915: Add private api for power well
 usage -- alignment between graphic team and audio team
Date: Thu, 02 May 2013 16:49:22 +0200
Message-ID: <51827CF2.9090507@canonical.com>
References: <1B1032E88FFFDA4898B04D530F28DEDB53CAB7@SHSMSX101.ccr.corp.intel.com>
 <CAKMK7uGZ1eK1MngbihR_+xUZZXsFQGEV3=NH1Ohjf7S0i9s2-g@mail.gmail.com>
 <1B1032E88FFFDA4898B04D530F28DEDB53CB7C@SHSMSX101.ccr.corp.intel.com>
 <20130426145708.GN6169@phenom.ffwll.local> <s5h61z91g2l.wl%tiwai@suse.de>
 <20130426154207.GP6169@phenom.ffwll.local> <s5hzjwlz46s.wl%tiwai@suse.de>
 <20130426171737.GR6169@phenom.ffwll.local>
 <46B810F6945F7C4788E11DCE57EC4890109D3608@SHSMSX102.ccr.corp.intel.com>
 <20130427113529.GT6169@phenom.ffwll.local>
 <20130429080219.05108857@jbarnes-desktop> <517F9D11.3020905@canonical.com>
 <1367332882.2460.14.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030005020702060408040906"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id D7B942651FC
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2013 16:49:33 +0200 (CEST)
In-Reply-To: <1367332882.2460.14.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zanoni,
 Paulo R" <paulo.r.zanoni@intel.com>, Takashi Iwai <tiwai@suse.de>, Daniel Vetter <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Wysocki,
 Rafael J" <rafael.j.wysocki@intel.com>, Wang Xingchao <xingchao.wang@linux.intel.com>, "Wang,
 Xingchao" <xingchao.wang@intel.com>, "Li, Jocelyn" <jocelyn.li@intel.com>, "Hindman, Gavin" <gavin.hindman@intel.com>, Jesse Barnes <jesse.barnes@intel.com>, Daniel Vetter <daniel@ffwll.ch>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030005020702060408040906
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/30/2013 04:41 PM, Liam Girdwood wrote:
> On Tue, 2013-04-30 at 12:29 +0200, David Henningsson wrote:
>> On 04/29/2013 05:02 PM, Jesse Barnes wrote:
>>> On Sat, 27 Apr 2013 13:35:29 +0200
>>> Daniel Vetter <daniel@ffwll.ch> wrote:
>>>
>>>> On Sat, Apr 27, 2013 at 09:20:39AM +0000, Wang, Xingchao wrote:
>>>>> Let me throw a basic proposal on Audio driver side,  please give your comments freely.
>>>>>
>>>>> it contains the power well control usage points:
>>>>> #1: audio request power well at boot up.
>>>>> I915 may shut down power well after bootup initialization, as there's no monitor connected outside or only eDP on pipe A.
>>>>> #2: audio request power on resume
>>>>> After exit from D3 mode, audio driver quest power on. This may happen at normal resume or runtime resume.
>>>>> #3: audio release power well control at suspend
>>>>> Audio driver will let i915 know it doensot need power well anymore as it's going to suspend. This may happened at normal suspend or runtime suspend point.
>>>>> #4: audio release power well when module unload
>>>>> Audio release power well at remove callback to let i915 know.
>>>>
>>>> I miss the power well grab/dropping at runtime from the audio side. If the
>>>> audio driver forces the power well to be on the entire time it's loaded,
>>>> that's not good, since the power well stuff is very much for runtime PM.
>>>> We _must_ be able to switch off the power well whenever possible.
>>>
>>> Xingchao, I'm not an audio developer so I'm probably way off.
>>>
>>> But what we really need is a very small and targeted set of calls into
>>> the i915 driver from say the HDMI driver in HDA.  It looks like the
>>> prepare/cleanup pair in the pcm_ops structure might be the right place
>>> to put things?  If that's too fine grained, you could do it at
>>> open/close time I guess, but the danger there is that some app will
>>> keep the device open even while it's not playing.
>>>
>>> If that won't work, maybe calling i915 from hda_power_work in the
>>> higher level code would be better?
>>>
>>> For detecting whether to call i915 at all, you can filter on the PCI
>>> IDs (just look for an Intel graphics device and if present, try to get
>>> the i915 symbols for the power functions).
>>>
>>> --- a/sound/pci/hda/hda_codec.c
>>> +++ b/sound/pci/hda/hda_codec.c
>>> @@ -3860,6 +3860,8 @@ static unsigned int hda_call_codec_suspend(struct hda_code
>>>                   codec->patch_ops.suspend(codec);
>>>           hda_cleanup_all_streams(codec);
>>>           state = hda_set_power_state(codec, AC_PWRST_D3);
>>> +       if (i915_shared_power_well)
>>> +               i915_put_power_well(codec->i915_data);
>>>           /* Cancel delayed work if we aren't currently running from it. */
>>>           if (!in_wq)
>>>                   cancel_delayed_work_sync(&codec->power_work);
>>> @@ -4807,6 +4809,9 @@ static void __snd_hda_power_up(struct hda_codec *codec, bo
>>>                   return;
>>>           spin_unlock(&codec->power_lock);
>>>
>>> +       if (i915_shared_power_well)
>>> +               i915_get_power_well(codec->i915_data);
>>
>> Is it wise that a _get function actually has side effects? Perhaps _push
>> and _pop or something else would be better semantics.
>>
>
> I think the intention here is to model on the PM runtime subsystem where
> we can get/put the reference count on a PM resource. I'd expect with
> this API that i915_get_power_well() will increment the count and prevent
> the shared PM resource from being powered OFF.

Ok, I stand corrected.

>
>>> +
>>>           cancel_delayed_work_sync(&codec->power_work);
>>>
>>>           spin_lock(&codec->power_lock);
>>>
>>> With some code at init time to get the i915 symbols you need to call
>>> and whether or not the shared power well is present...
>>>
>>> Takashi, any other ideas?
>>>
>>> The high level goal here should be for the audio driver to call into
>>> i915 with get/put power well around the sequences where it needs the
>>> power to be up (reading/writing registers, playing audio), but not
>>> across the whole time the driver is loaded, just like you already do
>>> with the powersave work functions, e.g. hda_call_codec_suspend.
>>
>> I think this sounds about right. The question is how to avoid a
>> dependency on the i915 driver when it's not necessary, such as when the
>> HDMI codec is AMD or Nvidia.
>>
>> The most obvious way to me seems to be to create a new
>> snd-hda-codec-hdmi-haswell module (that depends on both i915 and
>> snd-hda-codec-hdmi), and then let that call into i915 and codec-hdmi
>> drivers as necessary, e g using the set_power_state callback for the
>> i915 stuff.
>>
>> But maybe there's something smarter to do here, as I'm not experienced
>> in mending kernel pieces together :-)
>>
>
> Interesting idea, we could have something similar to the AC97 ad-hoc
> device support where we could load other HW specific AC97 modules (like
> touchscreen controllers) without breaking the generic nature of the base
> driver. e.g. the WM9712 AC97 touchscreen driver could connect to the
> generic AC97 audio driver (get it's device struct ac97 *) and perform
> AC97 register IO, ac97 API calls etc.

Nobody objected, so I wrote a very draft patch, which is attached to 
this email. It probably does not even compile, but should show how I 
envision things could be mended together. Do you think it could work?

Also, I tried to find the patch set for the i915 side, but couldn't find 
any while looking on the intel-gfx mailinglist  (which I'm not 
subscribed to) - only comments on those patches. Where can the latest 
version of the i915 patches be found?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

--------------030005020702060408040906
Content-Type: text/x-patch;
 name="0001-ALSA-hda-implement-i915-power-well-callbacks.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-ALSA-hda-implement-i915-power-well-callbacks.patch"

>From 66d9a3fd80f1dc0471949680a076c7696a869adc Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Thu, 2 May 2013 16:38:54 +0200
Subject: [PATCH] ALSA: hda - implement i915 power well callbacks

Draft patch

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/Kconfig           |   14 ++++++++++
 sound/pci/hda/Makefile          |    4 +++
 sound/pci/hda/patch_hdmi.c      |   19 ++++++++++---
 sound/pci/hda/patch_hdmi.h      |    6 ++++
 sound/pci/hda/patch_hdmi_i915.c |   58 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 97 insertions(+), 4 deletions(-)
 create mode 100644 sound/pci/hda/patch_hdmi.h
 create mode 100644 sound/pci/hda/patch_hdmi_i915.c

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 80a7d44..18226de 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -152,6 +152,20 @@ config SND_HDA_CODEC_HDMI
 	  snd-hda-codec-hdmi.
 	  This module is automatically loaded at probing.
 
+config SND_HDA_CODEC_HDMI_I915
+	bool "Build HDMI/DisplayPort HD-audio codec support for i915 cards"
+	depends on SND_HDA_CODEC_HDMI
+	depends on DRM_I915
+	default y
+	help
+	  Say Y here to include full HDMI and DisplayPort HD-audio codec
+	  support for Intel graphics cards based on the i915 driver.
+
+	  When the HD-audio driver is built as a module, the codec
+	  support code is also built as another module,
+	  snd-hda-codec-hdmi-i915.
+	  This module is automatically loaded at probing.
+
 config SND_HDA_CODEC_CIRRUS
 	bool "Build Cirrus Logic codec support"
 	default y
diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index 24a2514..ed0b2de 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -21,6 +21,7 @@ snd-hda-codec-ca0132-objs :=	patch_ca0132.o
 snd-hda-codec-conexant-objs :=	patch_conexant.o
 snd-hda-codec-via-objs :=	patch_via.o
 snd-hda-codec-hdmi-objs :=	patch_hdmi.o hda_eld.o
+snd-hda-codec-hdmi-i915-objs :=	patch_hdmi_i915.o
 
 # common driver
 obj-$(CONFIG_SND_HDA_INTEL) := snd-hda-codec.o
@@ -59,6 +60,9 @@ endif
 ifdef CONFIG_SND_HDA_CODEC_HDMI
 obj-$(CONFIG_SND_HDA_INTEL) += snd-hda-codec-hdmi.o
 endif
+ifdef CONFIG_SND_HDA_CODEC_HDMI_I915
+obj-$(CONFIG_SND_HDA_INTEL) += snd-hda-codec-hdmi-i915.o
+endif
 
 # this must be the last entry after codec drivers;
 # otherwise the codec patches won't be hooked before the PCI probe
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 32930e6..4fbbc1e 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1892,8 +1892,7 @@ static const struct hda_fixup hdmi_fixups[] = {
 	},
 };
 
-
-static int patch_generic_hdmi(struct hda_codec *codec)
+int initialize_hdmi_patch_ops(struct hda_codec *codec, struct hda_codec_ops *ops)
 {
 	struct hdmi_spec *spec;
 
@@ -1916,12 +1915,26 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 		return -EINVAL;
 	}
 	codec->patch_ops = generic_hdmi_patch_ops;
+#ifdef CONFIG_PM
+	if (ops != NULL) {
+		if (ops->suspend)
+			codec->patch_ops.suspend = ops->suspend;
+		if (ops->resume)
+			codec->patch_ops.resume = ops->resume;
+	}
+#endif
 	generic_hdmi_init_per_pins(codec);
 
 	init_channel_allocations();
 
 	return 0;
 }
+EXPORT_SYMBOL_HDA(initialize_i915_hdmi)
+
+static int patch_generic_hdmi(struct hda_codec *codec)
+{
+	return initialize_hdmi_patch_ops(codec, NULL);
+}
 
 /*
  * Shared non-generic implementations
@@ -2559,7 +2572,6 @@ static const struct hda_codec_preset snd_hda_preset_hdmi[] = {
 { .id = 0x80862804, .name = "IbexPeak HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x80862805, .name = "CougarPoint HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x80862806, .name = "PantherPoint HDMI", .patch = patch_generic_hdmi },
-{ .id = 0x80862807, .name = "Haswell HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x80862880, .name = "CedarTrail HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x808629fb, .name = "Crestline HDMI",	.patch = patch_generic_hdmi },
 {} /* terminator */
@@ -2612,7 +2624,6 @@ MODULE_ALIAS("snd-hda-codec-id:80862803");
 MODULE_ALIAS("snd-hda-codec-id:80862804");
 MODULE_ALIAS("snd-hda-codec-id:80862805");
 MODULE_ALIAS("snd-hda-codec-id:80862806");
-MODULE_ALIAS("snd-hda-codec-id:80862807");
 MODULE_ALIAS("snd-hda-codec-id:80862880");
 MODULE_ALIAS("snd-hda-codec-id:808629fb");
 
diff --git a/sound/pci/hda/patch_hdmi.h b/sound/pci/hda/patch_hdmi.h
new file mode 100644
index 0000000..ab60c8b
--- /dev/null
+++ b/sound/pci/hda/patch_hdmi.h
@@ -0,0 +1,6 @@
+#ifndef __SOUND_HDA_PATCH_HDMI_H
+#define __SOUND_HDA_PATCH_HDMI_H
+
+int initialize_hdmi_patch_ops(struct hda_codec *codec, struct hda_codec_ops *ops);
+
+#endif
diff --git a/sound/pci/hda/patch_hdmi_i915.c b/sound/pci/hda/patch_hdmi_i915.c
new file mode 100644
index 0000000..e82a3eb
--- /dev/null
+++ b/sound/pci/hda/patch_hdmi_i915.c
@@ -0,0 +1,58 @@
+#include <drm/audio_drm.h>
+#include "patch_hdmi.h"
+
+#ifdef CONFIG_PM
+static int i915_suspend(struct hda_codec *codec)
+{
+	release_power_well(); /* Or other preferred name */
+}
+
+static int i915_resume(struct hda_codec *codec)
+{
+	request_power_well(); /* Or other preferred name */
+
+	if (codec->patch_ops.init)
+		codec->patch_ops.init(codec);
+	snd_hda_codec_resume_amp(codec);
+	snd_hda_codec_resume_cache(codec);
+}
+#endif
+
+static const struct hda_codec_ops i915_patch_ops = {
+#ifdef CONFIG_PM
+	.suspend	= i915_suspend,
+	.resume		= i915_resume,
+#endif
+}
+
+
+static int patch_i915_hdmi(struct hda_codec *codec)
+{
+	return initialize_hdmi_ops(codec, i915_patch_ops);
+}
+
+
+static const struct hda_codec_preset snd_hda_preset_hdmi[] = {
+{ .id = 0x80862807, .name = "Haswell HDMI",	.patch = patch_i915_hdmi },
+{} /* terminator */
+};
+
+MODULE_ALIAS("snd-hda-codec-id:80862807");
+
+static struct hda_codec_preset_list intel_list = {
+	.preset = snd_hda_preset_hdmi,
+	.owner = THIS_MODULE,
+};
+
+static int __init patch_hdmi_i915_init(void)
+{
+	return snd_hda_add_codec_preset(&intel_list);
+}
+
+static void __exit patch_hdmi_i915_exit(void)
+{
+	snd_hda_delete_codec_preset(&intel_list);
+}
+
+module_init(patch_hdmi_i915_init)
+module_exit(patch_hdmi_i915_exit)
-- 
1.7.9.5


--------------030005020702060408040906
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030005020702060408040906--
