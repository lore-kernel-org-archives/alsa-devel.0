From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: HDA HDMI audio doesn't work on Intel Geminilake
 machines
Date: Fri, 3 Nov 2017 14:03:22 +0530
Message-ID: <20171103083320.GB8581@subhransu-desktop>
References: <717967d0-a0bb-18fc-aa6c-80f52dccb350@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 07BBD266A0C
 for <alsa-devel@alsa-project.org>; Fri,  3 Nov 2017 09:47:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <717967d0-a0bb-18fc-aa6c-80f52dccb350@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hui Wang <hui.wang@canonical.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Nov 02, 2017 at 12:40:46PM +0530, Hui Wang wrote:
> We have several Geminilake laptop and desktop machines, on these 
> machines, the HW configs are same and are as shown below:
> 
> the HDA controller: 00:0e.0 Audio device [0403]: Intel Corporation 
> Device [8086:3198] (rev 01)
> the HDMI codec: Vendor Id: 0x8086280d
> VGA controller: 00:02.0 VGA compatible controller [0300]: Intel 
> Corporation Device [8086:3184] (rev 01) (prog-if 00 [VGA controller])
> 
> The problem is if we boot the system without plugging the HDMI monitor, 
> the Linux kernel can't find HDMI codec at all. If we plug the HDMI 
> monitor before booting up, the kernel can find the HDMI codec, but there 
> are many errors (as shown below) and the HDMI audio can't play any sound.

Please create a bugzilla. Share the logs after applying the attached test
patch. Note to enable the debug logs.

> 
> Codec: Intel Geminilake HDMI
> Address: 2
> AFG Function Id: 0x1 (unsol 0)
> Vendor Id: 0x8086280d
> Subsystem Id: 0x80860101
> Revision Id: 0x100000
> No Modem Function Group found
> Default PCM:
> N/A
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A
> State of AFG node 0x01:
>    Power: setting=UNKNOWN, actual=UNKNOWN, Error, Clock-stop-OK, 
> Setting-reset
> Invalid AFG subtree
> --endcollapse--
> 
> [   25.504069] snd_hda_intel 0000:00:0e.0: azx_get_response timeout, 
> switching to polling mode: last cmd=0x20bf8100
> [   26.516125] snd_hda_intel 0000:00:0e.0: No response from codec, 
> disabling MSI: last cmd=0x20bf8100
> [   27.528058] snd_hda_intel 0000:00:0e.0: azx_get_response timeout, 
> switching to single_cmd mode: last cmd=0x20bf8100
> [   27.528259] azx_single_wait_for_response: 12 callbacks suppressed
> [   27.547927] snd_hda_codec_hdmi hdaudioC0D2: Unable to sync register 
> 0x2f0d00. -5
> 
> 
> We have tested the latest mainline kernel, but the testing result is the 
> same.
> 
> So does the existing kernel driver support the HDMI audio well for 
> Geminilake? If it does, what is wrong with those machines, HW issue or 

Hi,

Yes HDMI audio is tested on Geminilake. Can you please share information on
model you are testing? Also what is the BIOS version you are using?

> BIOS issue?

Yes this may be a BIOS issue as well.

Regards,
Subhransu

> 
> 
> Thanks in advance.
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 

--GvXjxJ+pjyke8COw
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-TEST-Read-CDCLK-PW2-and-other-reg-from-Audio-driver.patch"

>From 10444c1630a1958658f45dcf176cb1e268e98dcb Mon Sep 17 00:00:00 2001
From: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Date: Mon, 23 Oct 2017 19:48:31 -0700
Subject: [PATCH] TEST: Read CDCLK, PW2 and other reg from Audio driver

Add Infrastructure to read i915 PW2/CDCLK and rest of reg from audio

Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 drivers/gpu/drm/i915/intel_audio.c | 18 ++++++++++++++++++
 include/drm/i915_component.h       |  2 ++
 include/sound/hda_i915.h           |  3 +++
 sound/hda/hdac_i915.c              | 16 ++++++++++++++++
 sound/pci/hda/hda_controller.c     |  3 +++
 sound/soc/intel/skylake/skl.c      |  4 ++++
 6 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/i915/intel_audio.c b/drivers/gpu/drm/i915/intel_audio.c
index 27743be5b768..864f0430a95c 100644
--- a/drivers/gpu/drm/i915/intel_audio.c
+++ b/drivers/gpu/drm/i915/intel_audio.c
@@ -698,6 +698,23 @@ static void i915_audio_component_put_power(struct device *kdev)
 	intel_display_power_put(kdev_to_i915(kdev), POWER_DOMAIN_AUDIO);
 }
 
+#define HSW_PWR_WELL_DRIVER                     _MMIO(0x45404)
+
+static int i915_audio_readmisc(struct device *kdev)
+{
+	struct drm_i915_private *dev_priv = kdev_to_i915(kdev);
+	uint32_t cdclk_tmp = I915_READ(CDCLK_CTL);
+	uint32_t AudChickenbit = I915_READ(HSW_AUD_CHICKENBIT);
+	uint32_t PwCtl2 = I915_READ(HSW_PWR_WELL_DRIVER);
+
+	printk("%s %d\n",__func__,__LINE__);
+	printk("%s HSW_AUD_CHICKENBIT=0x%x\n",__func__,AudChickenbit);
+	printk("%s cdclk_ctl =0x%x\n",__func__,cdclk_tmp );
+	printk("%s  cdclk_freq=0x%x\n",__func__, I915_READ(CDCLK_FREQ));
+	printk("%s PWR_WELL_CTL2 =0x%x\n",__func__, PwCtl2 );
+	return 0;
+}
+
 static void i915_audio_component_codec_wake_override(struct device *kdev,
 						     bool enable)
 {
@@ -868,6 +885,7 @@ static int i915_audio_component_get_eld(struct device *kdev, int port,
 	.get_cdclk_freq	= i915_audio_component_get_cdclk_freq,
 	.sync_audio_rate = i915_audio_component_sync_audio_rate,
 	.get_eld	= i915_audio_component_get_eld,
+	.readmisc	= i915_audio_readmisc,
 };
 
 static int i915_audio_component_bind(struct device *i915_kdev,
diff --git a/include/drm/i915_component.h b/include/drm/i915_component.h
index 545c6e0fea7d..08d055b17d4f 100644
--- a/include/drm/i915_component.h
+++ b/include/drm/i915_component.h
@@ -79,6 +79,8 @@ struct i915_audio_component_ops {
 	 */
 	int (*get_eld)(struct device *, int port, int pipe, bool *enabled,
 		       unsigned char *buf, int max_bytes);
+
+	int (*readmisc)(struct device *);
 };
 
 /**
diff --git a/include/sound/hda_i915.h b/include/sound/hda_i915.h
index 5ab972e116ec..18b98caddef6 100644
--- a/include/sound/hda_i915.h
+++ b/include/sound/hda_i915.h
@@ -17,6 +17,9 @@ int snd_hdac_acomp_get_eld(struct hdac_device *codec, hda_nid_t nid, int dev_id,
 int snd_hdac_i915_init(struct hdac_bus *bus);
 int snd_hdac_i915_exit(struct hdac_bus *bus);
 int snd_hdac_i915_register_notifier(const struct i915_audio_component_audio_ops *);
+
+int snd_hdac_readmisc(struct hdac_bus *bus);
+
 #else
 static inline int snd_hdac_set_codec_wakeup(struct hdac_bus *bus, bool enable)
 {
diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index 038a180d3f81..ddd3d555e849 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -59,6 +59,22 @@ int snd_hdac_set_codec_wakeup(struct hdac_bus *bus, bool enable)
 }
 EXPORT_SYMBOL_GPL(snd_hdac_set_codec_wakeup);
 
+int snd_hdac_readmisc(struct hdac_bus *bus)
+{
+	struct i915_audio_component *acomp = bus->audio_component;
+
+	if (!acomp || !acomp->ops)
+	{
+		printk("%s %d\n",__func__,__LINE__);
+		return -ENODEV;
+	}
+	acomp->ops->readmisc(acomp->dev);
+	printk("%s %d\n",__func__,__LINE__);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_readmisc);
+
 /**
  * snd_hdac_display_power - Power up / down the power refcount
  * @bus: HDA core bus
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index d1eb14842340..af5b8ec8372a 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -36,6 +36,7 @@
 #include <sound/core.h>
 #include <sound/initval.h>
 #include "hda_controller.h"
+#include <sound/hda_i915.h>
 
 #define CREATE_TRACE_POINTS
 #include "hda_controller_trace.h"
@@ -1194,6 +1195,8 @@ static int probe_codec(struct azx *chip, int addr)
 	int err;
 	unsigned int res = -1;
 
+	snd_hdac_readmisc(bus);
+
 	mutex_lock(&bus->cmd_mutex);
 	chip->probing = 1;
 	azx_send_cmd(bus, cmd);
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index d6b01ae165d3..874f3e83f51c 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -743,6 +743,9 @@ static int probe_codec(struct hdac_ext_bus *ebus, int addr)
 		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
 	unsigned int res = -1;
 
+	printk("%s %d\n",__func__,__LINE__);
+	snd_hdac_readmisc(bus);
+
 	mutex_lock(&bus->cmd_mutex);
 	snd_hdac_bus_send_cmd(bus, cmd);
 	snd_hdac_bus_get_response(bus, addr, &res);
@@ -750,6 +753,7 @@ static int probe_codec(struct hdac_ext_bus *ebus, int addr)
 	if (res == -1)
 		return -EIO;
 	dev_dbg(bus->dev, "codec #%d probed OK\n", addr);
+	printk("%s %d\n",__func__,__LINE__);
 
 	return snd_hdac_ext_bus_device_init(ebus, addr);
 }
-- 
1.9.1


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--GvXjxJ+pjyke8COw--
