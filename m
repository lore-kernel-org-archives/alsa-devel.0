From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH V2] ASoC: fix hdmi codec driver contest in
 S3
Date: Tue, 26 Mar 2019 07:58:34 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19527FB25E@SHSMSX103.ccr.corp.intel.com>
References: <1553235896-8185-1-git-send-email-libin.yang@intel.com>
 <s5hpnqjp9es.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527F9BB6@SHSMSX103.ccr.corp.intel.com>
 <s5hh8bvb5ba.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527F9D9F@SHSMSX103.ccr.corp.intel.com>
 <s5hbm22psfz.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527FAAA5@SHSMSX103.ccr.corp.intel.com>
 <s5h4l7r9shp.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527FAE2A@SHSMSX103.ccr.corp.intel.com>
 <s5hbm1z81em.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527FB1A0@SHSMSX103.ccr.corp.intel.com>
 <s5hr2aum6i5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 63CE4F801D9
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2019 08:58:40 +0100 (CET)
In-Reply-To: <s5hr2aum6i5.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,


>-----Original Message-----
>From: Takashi Iwai [mailto:tiwai@suse.de]
>Sent: Tuesday, March 26, 2019 3:37 PM
>To: Yang, Libin <libin.yang@intel.com>
>Cc: alsa-devel@alsa-project.org; broonie@kernel.org
>Subject: Re: [alsa-devel] [PATCH V2] ASoC: fix hdmi codec driver contest in S3
>
>On Tue, 26 Mar 2019 06:42:15 +0100,
>Yang, Libin wrote:
>(snip)
>> Hi Takashi,
>> Below is my draft patch, which doesn't work with
>> pm_runtime_get_sync(). Is there anything wrong in my code?
>(snip)
>> And the dmesg is:
>> [   36.087224] HDMI HDA Codec ehdaudio0D2: in hdmi_codec_resume 1890
>ylb
>> [   36.087230] HDMI HDA Codec ehdaudio0D2: in
>hdac_hdmi_runtime_resume 2122 ylb 1
>> [   36.087335] HDMI HDA Codec ehdaudio0D2: in
>hdac_hdmi_cvt_output_widget_event 812 ylb
>> [   40.097586] HDMI HDA Codec ehdaudio0D2: in
>hdac_hdmi_runtime_resume 2135 ylb 2
>> [   40.097766] HDMI HDA Codec ehdaudio0D2: in
>hdac_hdmi_pin_output_widget_event 767 ylb
>> [   45.108632] HDMI HDA Codec ehdaudio0D2: in
>hdac_hdmi_pin_mux_widget_event 857 ylb
>>
>> >From the dmesg, hdac_hdmi_cvt_output_widget_event()
>> is called between "ylb 1" and "ylb 2" in runtime_resume().
>> This means xxx_event() registers setting runs before display power is
>> turned on.
>
>OK, now I understood what went wrong.  It's a similar issue as we've hit for
>the legacy HD-audio and figured out recently.
>
>If my understanding is correct, the problem is the call of
>pm_runtime_force_resume() in PM resume callback combined with an async
>work.  pm_runtime_force_resume() sets the runtime state immediately to
>RPM_ACTIVE even before finishing the task.  The code seems assuming blindly
>that there is no other conflicting task while S3/S4 resume, but this is a
>problem.  That's why the next pm_runtime_get_sync() wasn't blocked but just
>went through; since the RPM flag was already set to RPM_ACTIVE in
>pm_runtime_force_resume(), it thought as if it were already active, while the
>real runtime resume code was still processing the callback.

Yes, exactly right. And I have checked dev->power.runtime_status, it's
RPM_ACTIVE when xxx_event() calls pm_runtime_get_sync().

>
>In the case of legacy HD-audio, we "fixed" the problem by avoiding the trigger
>of async work at resume, but let it be triggered from runtime resume.  In ASoC
>case, however, it's no option.
>
>Maybe a possible solution in the sound driver side would be to move from
>system suspend/resume to ASoC component suspend/resume.  The runtime
>suspend/resume can be kept as is, and call pm_runtime_force_suspend and
>resume from the component suspend/resume callbacks.  Since the
>component callbacks are certainly processed before DAPM events, this should
>assure the order.

I have worked out another patch. This patch decouples the xxx_event() and
runtime suspend/resume. This means in whichever case, xxx_event() can make
sure display power is in the correct status. What do you think?
On the same time, I will try the component suspend/resume. My understanding
is that snd_hdac_display_power() should be called either in runtime_suspend/
resume or in component suspend/resume. 

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 5eeb0fe..2acb7f1 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -144,7 +144,9 @@ struct hdac_hdmi_priv {
        int num_pin;
        int num_cvt;
        int num_ports;
+       int power_cnt;
        struct mutex pin_mutex;
+       struct mutex power_mutex;
        struct hdac_chmap chmap;
        struct hdac_hdmi_drv_data *drv_data;
        struct snd_soc_dai_driver *dai_drv;
@@ -286,6 +288,79 @@ static struct hdac_hdmi_pcm *get_hdmi_pcm_from_id(struct hdac_hdmi_priv *hdmi,
        return NULL;
 }

+#define INTEL_VENDOR_NID_0x2 0x02
+#define INTEL_VENDOR_NID_0x8 0x08
+#define INTEL_VENDOR_NID_0xb 0x0b
+#define INTEL_GET_VENDOR_VERB 0xf81
+#define INTEL_SET_VENDOR_VERB 0x781
+#define INTEL_EN_DP12          0x02 /* enable DP 1.2 features */
+#define INTEL_EN_ALL_PIN_CVTS  0x01 /* enable 2nd & 3rd pins and convertors */
+
+static void hdac_hdmi_skl_enable_all_pins(struct hdac_device *hdev)
+{
+       unsigned int vendor_param;
+       struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
+       unsigned int vendor_nid = hdmi->drv_data->vendor_nid;
+
+       vendor_param = snd_hdac_codec_read(hdev, vendor_nid, 0,
+                               INTEL_GET_VENDOR_VERB, 0);
+       if (vendor_param == -1 || vendor_param & INTEL_EN_ALL_PIN_CVTS)
+               return;
+
+       vendor_param |= INTEL_EN_ALL_PIN_CVTS;
+       vendor_param = snd_hdac_codec_read(hdev, vendor_nid, 0,
+                               INTEL_SET_VENDOR_VERB, vendor_param);
+       if (vendor_param == -1)
+               return;
+}
+
+static void hdac_hdmi_skl_enable_dp12(struct hdac_device *hdev)
+{
+       unsigned int vendor_param;
+       struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
+       unsigned int vendor_nid = hdmi->drv_data->vendor_nid;
+
+       vendor_param = snd_hdac_codec_read(hdev, vendor_nid, 0,
+                               INTEL_GET_VENDOR_VERB, 0);
+       if (vendor_param == -1 || vendor_param & INTEL_EN_DP12)
+               return;
+
+       /* enable DP1.2 mode */
+       vendor_param |= INTEL_EN_DP12;
+       vendor_param = snd_hdac_codec_read(hdev, vendor_nid, 0,
+                               INTEL_SET_VENDOR_VERB, vendor_param);
+       if (vendor_param == -1)
+               return;
+
+}
+
+static void put_display_power(struct hdac_device *hdev)
+{
+       struct hdac_bus *bus = hdev->bus;
+       struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
+
+       mutex_lock(&hdmi->power_mutex);
+       hdmi->power_cnt--;
+       if (hdmi->power_cnt == 0)
+               snd_hdac_display_power(bus, hdev->addr, false);
+       mutex_unlock(&hdmi->power_mutex);
+}
+
+static void get_display_power(struct hdac_device *hdev)
+{
+       struct hdac_bus *bus = hdev->bus;
+       struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
+
+       mutex_lock(&hdmi->power_mutex);
+       if (hdmi->power_cnt == 0) {
+               snd_hdac_display_power(bus, hdev->addr, true);
+               hdac_hdmi_skl_enable_all_pins(hdev);
+               hdac_hdmi_skl_enable_dp12(hdev);
+       }
+       hdmi->power_cnt++;
+       mutex_unlock(&hdmi->power_mutex);
+}
+
 static unsigned int sad_format(const u8 *sad)
 {
        return ((sad[0] >> 0x3) & 0x1f);
@@ -749,17 +824,21 @@ static int hdac_hdmi_pin_output_widget_event(struct snd_soc_dapm_widget *w,
        struct hdac_hdmi_port *port = w->priv;
        struct hdac_device *hdev = dev_to_hdac_dev(w->dapm->dev);
        struct hdac_hdmi_pcm *pcm;
+       int ret = 0;

        dev_dbg(&hdev->dev, "%s: widget: %s event: %x\n",
                        __func__, w->name, event);

+       get_display_power(hdev);
        pcm = hdac_hdmi_get_pcm(hdev, port);
        if (!pcm)
                return -EIO;

        /* set the device if pin is mst_capable */
-       if (hdac_hdmi_port_select_set(hdev, port) < 0)
+       if (hdac_hdmi_port_select_set(hdev, port) < 0) {
+               put_display_power(hdev);
                return -EIO;
+       }

        switch (event) {
        case SND_SOC_DAPM_PRE_PMU:
@@ -771,7 +850,8 @@ static int hdac_hdmi_pin_output_widget_event(struct snd_soc_dapm_widget *w,

                hdac_hdmi_set_amp(hdev, port->pin->nid, AMP_OUT_UNMUTE);

-               return hdac_hdmi_setup_audio_infoframe(hdev, pcm, port);
+               ret = hdac_hdmi_setup_audio_infoframe(hdev, pcm, port);
+               break;

        case SND_SOC_DAPM_POST_PMD:
                hdac_hdmi_set_amp(hdev, port->pin->nid, AMP_OUT_MUTE);
@@ -784,8 +864,9 @@ static int hdac_hdmi_pin_output_widget_event(struct snd_soc_dapm_widget *w,
                break;

        }
+       put_display_power(hdev);

-       return 0;
+       return ret;
 }

 static int hdac_hdmi_cvt_output_widget_event(struct snd_soc_dapm_widget *w,
@@ -803,6 +884,7 @@ static int hdac_hdmi_cvt_output_widget_event(struct snd_soc_dapm_widget *w,
        if (!pcm)
                return -EIO;

+       get_display_power(hdev);
        switch (event) {
        case SND_SOC_DAPM_PRE_PMU:
                hdac_hdmi_set_power_state(hdev, cvt->nid, AC_PWRST_D0);
@@ -831,6 +913,7 @@ static int hdac_hdmi_cvt_output_widget_event(struct snd_soc_dapm_widget *w,
                break;

        }
+       put_display_power(hdev);

        return 0;
}
@@ -850,15 +933,20 @@ static int hdac_hdmi_pin_mux_widget_event(struct snd_soc_dapm_widget *w,

        mux_idx = dapm_kcontrol_get_value(kc);

+       get_display_power(hdev);
        /* set the device if pin is mst_capable */
-       if (hdac_hdmi_port_select_set(hdev, port) < 0)
+       if (hdac_hdmi_port_select_set(hdev, port) < 0) {
+               put_display_power(hdev);
                return -EIO;
+       }

        if (mux_idx > 0) {
                snd_hdac_codec_write(hdev, port->pin->nid, 0,
                        AC_VERB_SET_CONNECT_SEL, (mux_idx - 1));
        }

+       put_display_power(hdev);
+
        return 0;
 }

@@ -1339,52 +1427,6 @@ static int hdac_hdmi_add_pin(struct hdac_device *hdev, hda_nid_t nid)
        return 0;
 }

-#define INTEL_VENDOR_NID_0x2 0x02
-#define INTEL_VENDOR_NID_0x8 0x08
-#define INTEL_VENDOR_NID_0xb 0x0b
-#define INTEL_GET_VENDOR_VERB 0xf81
-#define INTEL_SET_VENDOR_VERB 0x781
-#define INTEL_EN_DP12          0x02 /* enable DP 1.2 features */
-#define INTEL_EN_ALL_PIN_CVTS  0x01 /* enable 2nd & 3rd pins and convertors */
-
-static void hdac_hdmi_skl_enable_all_pins(struct hdac_device *hdev)
-{
-       unsigned int vendor_param;
-       struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
-       unsigned int vendor_nid = hdmi->drv_data->vendor_nid;
-
-       vendor_param = snd_hdac_codec_read(hdev, vendor_nid, 0,
-                               INTEL_GET_VENDOR_VERB, 0);
-       if (vendor_param == -1 || vendor_param & INTEL_EN_ALL_PIN_CVTS)
-               return;
-
-       vendor_param |= INTEL_EN_ALL_PIN_CVTS;
-       vendor_param = snd_hdac_codec_read(hdev, vendor_nid, 0,
-                               INTEL_SET_VENDOR_VERB, vendor_param);
-       if (vendor_param == -1)
-               return;
-}
-
-static void hdac_hdmi_skl_enable_dp12(struct hdac_device *hdev)
-{
-       unsigned int vendor_param;
-       struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
-       unsigned int vendor_nid = hdmi->drv_data->vendor_nid;
-
-       vendor_param = snd_hdac_codec_read(hdev, vendor_nid, 0,
-                               INTEL_GET_VENDOR_VERB, 0);
-       if (vendor_param == -1 || vendor_param & INTEL_EN_DP12)
-               return;
-
-       /* enable DP1.2 mode */
-       vendor_param |= INTEL_EN_DP12;
-       vendor_param = snd_hdac_codec_read(hdev, vendor_nid, 0,
-                               INTEL_SET_VENDOR_VERB, vendor_param);
-       if (vendor_param == -1)
-               return;
-
-}
-
static const struct snd_soc_dai_ops hdmi_dai_ops = {
        .startup = hdac_hdmi_pcm_open,
        .shutdown = hdac_hdmi_pcm_close,
@@ -1473,9 +1515,6 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_device *hdev,
        struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
        int ret;

-       hdac_hdmi_skl_enable_all_pins(hdev);
-       hdac_hdmi_skl_enable_dp12(hdev);
-
        num_nodes = snd_hdac_get_sub_nodes(hdev, hdev->afg, &nid);
        if (!nid || num_nodes <= 0) {
                dev_warn(&hdev->dev, "HDMI: failed to get afg sub nodes\n");
@@ -2032,12 +2071,13 @@ static int hdac_hdmi_dev_probe(struct hdac_device *hdev)
        INIT_LIST_HEAD(&hdmi_priv->cvt_list);
        INIT_LIST_HEAD(&hdmi_priv->pcm_list);
        mutex_init(&hdmi_priv->pin_mutex);
+       mutex_init(&hdmi_priv->power_mutex);

        /*
         * Turned off in the runtime_suspend during the first explicit
         * pm_runtime_suspend call.
         */
-       snd_hdac_display_power(hdev->bus, hdev->addr, true);
+       get_display_power(hdev);

        ret = hdac_hdmi_parse_and_map_nid(hdev, &hdmi_dais, &num_dais);
        if (ret < 0) {
@@ -2058,7 +2098,7 @@ static int hdac_hdmi_dev_probe(struct hdac_device *hdev)

 static int hdac_hdmi_dev_remove(struct hdac_device *hdev)
 {
-       snd_hdac_display_power(hdev->bus, hdev->addr, false);
+       put_display_power(hdev);

        return 0;
}
@@ -2094,7 +2134,7 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)

        snd_hdac_ext_bus_link_put(bus, hlink);

-       snd_hdac_display_power(bus, hdev->addr, false);
+       put_display_power(hdev);

        return 0;
 }
@@ -2119,11 +2159,7 @@ static int hdac_hdmi_runtime_resume(struct device *dev)

        snd_hdac_ext_bus_link_get(bus, hlink);

-       snd_hdac_display_power(bus, hdev->addr, true);
-
-       hdac_hdmi_skl_enable_all_pins(hdev);
-       hdac_hdmi_skl_enable_dp12(hdev);
-
+       get_display_power(hdev);
        /* Power up afg */
        snd_hdac_codec_read(hdev, hdev->afg, 0, AC_VERB_SET_POWER_STATE,
                                                        AC_PWRST_D0);

>
>
>thanks,
>
>Takashi
