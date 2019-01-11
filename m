From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [RFC PATCH v2 1/2] ASoC: refine ASoC hdmi
	audio	suspend/resume
Date: Fri, 11 Jan 2019 05:20:23 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19527AFEB3@SHSMSX103.ccr.corp.intel.com>
References: <1546827721-25586-1-git-send-email-libin.yang@intel.com>
 <e2c257fb-e292-b23d-1f20-e5467e0d93dd@linux.intel.com>
 <96A12704CE18D347B625EE2D4A099D19527AE0B4@SHSMSX103.ccr.corp.intel.com>
 <s5hd0p71jvh.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527AE92B@SHSMSX103.ccr.corp.intel.com>
 <s5h8szui68f.wl-tiwai@suse.de> <s5h4laii46l.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527AF06F@SHSMSX103.ccr.corp.intel.com>
 <s5h4lagyagb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 06A1E2677D0
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2019 06:20:26 +0100 (CET)
In-Reply-To: <s5h4lagyagb.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


>> >On Wed, 09 Jan 2019 09:29:36 +0100,
>> >Takashi Iwai wrote:
>> >>
>> >> On Wed, 09 Jan 2019 09:16:34 +0100, Yang, Libin wrote:
>> >> >
>> >> > >-
>> >> > >-static void hdmi_codec_complete(struct device *dev)
>> >> > >+#ifdef CONFIG_PM_SLEEP
>> >> > >+static int hdmi_codec_resume(struct device *dev)
>> >> > > {
>> >> > > 	struct hdac_device *hdev = dev_to_hdac_dev(dev);
>> >> > > 	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
>> >> > >+	int ret;
>> >> > >
>> >> > >-	/* Power up afg */
>> >> > >-	snd_hdac_codec_read(hdev, hdev->afg, 0,
>> >> > >	AC_VERB_SET_POWER_STATE,
>> >> > >-
>	AC_PWRST_D0);
>> >> > >-
>> >> > >-	hdac_hdmi_skl_enable_all_pins(hdev);
>> >> > >-	hdac_hdmi_skl_enable_dp12(hdev);
>> >> > >-
>> >> > >+	ret = pm_runtime_force_resume(dev);
>> >> >
>> >> > The code hopes to call hdmi pm_runtime() whenever this resume()
>> >> > is called? If so, I'm afraid it will not work.
>> >> > pm_runtime_force_resume() calls pm_runtime with conditions.
>> >> > Sometimes pm_runtime will not be called. In my suspend/resume
>> >> > test, it shows that pm_runtime() is not called. This may cause
>> >> > the following function
>> >> > hdac_hdmi_present_sense_all_pins() not work well as there is no
>> >> > power on.
>> >>
>> >> Hm, right, maybe we should move hdac_hdmi_present_sense_all_pins()
>> >> into runtime resume.  It may be called unconditionally, but safer
>> >> to call it conditionally only after S3 or so...
>> >
>> >Now reading back the code again, no, it's correct to call
>> >hdac_hdmi_present_sense_all_pins() there.  The function doesn't
>> >access any HD-audio codec verbs but only with the i915 audio component.
>> >Hence it's safe to call there no matter whether the device is opened
>> >(thus
>> >resumed) or not.  And, it is even mandatory to call there; if a HDMI
>> >connection changed during suspend, we need to notify it right after the
>system resume.
>>
>> Yes. It seems this is safe. Thanks for clarification. SOF audio driver test
>passes.
>> No reply from our internal SST driver team. From SOF test, this patch
>> can fix the display power issue.
>
>OK, I'm going to queue this, but will delay the upstream merge for 5.0-rc3.

That great! Thanks.

>
>> BTW: I have another question. Maybe it is not related to this topic,
>> but related the general audio power sequence. I'm not sure my
>> understand is correct or not.
>> Currently, codec device's parent is the card device, right? If so, the
>> suspend sequence is:
>> codec power off (child)
>> card power off (parent)
>>
>> However, I see some cards will call trigger for suspend in card
>> suspend function. This may cause issue logically (Maybe the real cards
>> are always OK). The codec has already powered off. So if trigger()
>> operates with codec may cause issue? Even, if the codec is the master,
>> maybe the clk is off before trigger() is called. I'm not sure this is always OK.
>> (This is why I submitted the second patch.)
>
>Indeed this looks like a problem, and it's specific to ASoC.
>The legacy HD-audio codec driver has the base resume code that calls
>snd_pcm_suspend_all() for the assigned PCM streams, while ASoC calls it in
>snd_soc_suspend() that is invoked from the machine driver in general.
>
>If a codec driver has a strong dependency with the PCM state (like HD-audio
>one), it'd need to stop in its suspend callback, something like below.

Yes, below patch should be able to fix my concern. I will test it  in HDMI
audio suspend/resume with playback after I fix another issue of hdmi
audio suspend/resume of SOF.

The below patch may have a small confliction that the trigger will be 
called twice as our SOF has already call snd_pcm_suspend() in card
suspend. Anyway, this is a SOF specific issue. I will work on it later.

Regards,
Libin

>
>
>thanks,
>
>Takashi
>
>---
>diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
>index b19d7a3e7a2c..caf512d807f5 100644
>--- a/sound/soc/codecs/hdac_hdmi.c
>+++ b/sound/soc/codecs/hdac_hdmi.c
>@@ -106,6 +106,7 @@ struct hdac_hdmi_pcm {
> 	struct list_head port_list;
> 	struct hdac_hdmi_cvt *cvt;
> 	struct snd_soc_jack *jack;
>+	struct snd_pcm *snd_pcm;
> 	int stream_tag;
> 	int channels;
> 	int format;
>@@ -1792,6 +1793,7 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int
>device,
> 	mutex_init(&pcm->lock);
> 	INIT_LIST_HEAD(&pcm->port_list);
> 	snd_pcm = hdac_hdmi_get_pcm_from_id(dai->component->card,
>device);
>+	pcm->snd_pcm = snd_pcm;
> 	if (snd_pcm) {
> 		err = snd_hdac_add_chmap_ctls(snd_pcm, device, &hdmi-
>>chmap);
> 		if (err < 0) {
>@@ -2118,8 +2120,10 @@ static int hdac_hdmi_dev_remove(struct
>hdac_device *hdev)  static int hdac_hdmi_runtime_suspend(struct device
>*dev)  {
> 	struct hdac_device *hdev = dev_to_hdac_dev(dev);
>+	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
> 	struct hdac_bus *bus = hdev->bus;
> 	struct hdac_ext_link *hlink = NULL;
>+	struct hdac_hdmi_pcm *pcm;
>
> 	dev_dbg(dev, "Enter: %s\n", __func__);
>
>@@ -2127,6 +2131,12 @@ static int hdac_hdmi_runtime_suspend(struct
>device *dev)
> 	if (!bus)
> 		return 0;
>
>+	/* make sure all streams suspended before power down */
>+	list_for_each_entry(pcm, &hdmi->pcm_list, head) {
>+		if (pcm->snd_pcm)
>+			snd_pcm_suspend_all(pcm->snd_pcm);
>+	}
>+
> 	/*
> 	 * Power down afg.
> 	 * codec_read is preferred over codec_write to set the power state.
>
>
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@alsa-project.org
>http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
