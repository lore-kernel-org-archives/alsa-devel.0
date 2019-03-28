From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH V2] ASoC: fix hdmi codec driver contest in
 S3
Date: Thu, 28 Mar 2019 07:10:34 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19527FD4E4@SHSMSX103.ccr.corp.intel.com>
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
 <96A12704CE18D347B625EE2D4A099D19527FB2CE@SHSMSX103.ccr.corp.intel.com>
 <s5hlg12m2xr.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527FB419@SHSMSX103.ccr.corp.intel.com>
 <s5hef6t7uj3.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527FCBCA@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9DCB6F80769
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 08:10:38 +0100 (CET)
In-Reply-To: <96A12704CE18D347B625EE2D4A099D19527FCBCA@SHSMSX103.ccr.corp.intel.com>
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
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>, "'broonie@kernel.org'" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

>>> >> >In the case of legacy HD-audio, we "fixed" the problem by
>>> >> >avoiding the trigger of async work at resume, but let it be
>>> >> >triggered from runtime resume.  In ASoC case, however, it's no option.
>>> >> >
>>> >> >Maybe a possible solution in the sound driver side would be to
>>> >> >move from system suspend/resume to ASoC component
>>suspend/resume.
>>> >> >The runtime suspend/resume can be kept as is, and call
>>> >> >pm_runtime_force_suspend and resume from the component
>>> >suspend/resume
>>> >> >callbacks.  Since the component callbacks are certainly processed
>>> >> >before DAPM events, this should assure the order.
>>> >>
>>> >> I tried to move display power setting from runtime suspend/resume
>>> >> to component suspend/resume. I found there may be another issue:
>>> >> playback will NOT call component suspend/resume.
>>> >> This  means we will never have chance to set the display power if
>>> >> we don't do the S3.
>>> >
>>> >The runtime suspend/resume are fine and need to be kept, I suppose.
>>> >The only problem is the system suspend/resume callbacks that call
>>> >pm_runtime_force_*().  Just moving these two to component would work?
>>> >
>>>
>>> Let's see the flow of the suspend:
>>> 1. Component suspend is called. It will call snd_hdac_display_power()
>>> to turn off the display power.
>>
>>No, what I meant was to make the component suspend calling
>>pm_runtime_force_suspend() instead of the system suspend.
>>Ditto for the component resume calling pm_runtime_force_resume().
>
>It seems this component suspend/resume method works well.
>I will do more test and send out the patch later.

I did some stress test. And I found if I remove the debug message,
the issue can still be reproduced with component suspend/resume
added. If I add the debug message, it will be much better.
I'm not sure whether my patch is wrong or not. I've set the bus_control = 1
in the dai driver.

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 5eeb0fe..505efd9 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1900,9 +1900,31 @@ static int hdmi_codec_resume(struct device *dev)
 #define hdmi_codec_resume NULL
 #endif

+static int hdmi_component_suspend(struct snd_soc_component *component)
+{
+       struct hdac_hdmi_priv *hdmi = snd_soc_component_get_drvdata(component);
+       struct hdac_device *hdev = hdmi->hdev;
+
+       pm_runtime_force_suspend(&hdev->dev);
+
+       return 0;
+}
+
+static int hdmi_component_resume(struct snd_soc_component *component)
+{
+       struct hdac_hdmi_priv *hdmi = snd_soc_component_get_drvdata(component);
+       struct hdac_device *hdev = hdmi->hdev;
+
+       pm_runtime_force_resume(&hdev->dev);
+
+       return 0;
+}
+
 static const struct snd_soc_component_driver hdmi_hda_codec = {
        .probe                  = hdmi_codec_probe,
        .remove                 = hdmi_codec_remove,
+       .suspend                = hdmi_component_suspend,
+       .resume                 = hdmi_component_resume,
        .use_pmdown_time        = 1,
        .endianness             = 1,
        .non_legacy_dai_naming  = 1,

>

Regards,
Libin
