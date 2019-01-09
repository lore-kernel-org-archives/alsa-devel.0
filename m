From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [RFC PATCH v2 1/2] ASoC: refine ASoC hdmi audio
 suspend/resume
Date: Wed, 9 Jan 2019 08:16:34 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19527AE92B@SHSMSX103.ccr.corp.intel.com>
References: <1546827721-25586-1-git-send-email-libin.yang@intel.com>
 <e2c257fb-e292-b23d-1f20-e5467e0d93dd@linux.intel.com>
 <96A12704CE18D347B625EE2D4A099D19527AE0B4@SHSMSX103.ccr.corp.intel.com>
 <s5hd0p71jvh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A92F2665E5
 for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2019 09:16:38 +0100 (CET)
In-Reply-To: <s5hd0p71jvh.wl-tiwai@suse.de>
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

Hi Takashi,

>-----Original Message-----
>From: Takashi Iwai [mailto:tiwai@suse.de]
>Sent: Tuesday, January 8, 2019 7:15 PM
>To: Yang, Libin <libin.yang@intel.com>
>Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>; alsa-
>devel@alsa-project.org; broonie@kernel.org;
>liam.r.girdwood@linux.intel.com; Lin, Mengdong <mengdong.lin@intel.com>
>Subject: Re: [alsa-devel] [RFC PATCH v2 1/2] ASoC: refine ASoC hdmi audio
>suspend/resume
>
>On Tue, 08 Jan 2019 08:53:49 +0100,
>Yang, Libin wrote:
>>
>>
>> >-----Original Message-----
>> >From: Pierre-Louis Bossart
>> >[mailto:pierre-louis.bossart@linux.intel.com]
>> >Sent: Tuesday, January 8, 2019 12:58 AM
>> >To: Yang, Libin <libin.yang@intel.com>; alsa-devel@alsa-project.org;
>> >tiwai@suse.de; broonie@kernel.org
>> >Cc: liam.r.girdwood@linux.intel.com; Lin, Mengdong
>> ><mengdong.lin@intel.com>
>> >Subject: Re: [alsa-devel] [RFC PATCH v2 1/2] ASoC: refine ASoC hdmi
>> >audio suspend/resume
>> >
>> >
>> >On 1/6/19 8:22 PM, libin.yang@intel.com wrote:
>> >> From: Libin Yang <libin.yang@intel.com>
>> >>
>> >> hdmi_codec_prepare() will trigger hdmi runtime resume, which will
>> >> set the bitmask of hdev->addr. And skl_suspend() will clear the
>> >> bitmask of HDA_CODEC_IDX_CONTROLLER. HDMI codec idx is not the
>same
>> >> as HDA_CODEC_IDX_CONTROLLER, which means i915 power will not be
>> >released
>> >> when suspend.
>> >>
>> >> On the other hand, hdmi_codec_prepare() don't need to call
>> >> pm_runtime_get_sync() to wake up the audio subsystem (HDMI auido)
>> >> for setting the codec registers. Turning display power on with
>> >> snd_hdac_display_power() is enough.
>> >>
>> >> Let's use S3 without playback as an example:
>> >> hdmi_codec_prepare() invokes the runtime resume of codec =>
>> >>    snd_hdac_display_power(bus, hdev->addr, true) skl runtime resume
>> >> skl_suspend() =>
>> >>    snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, false);
>> >>
>> >> THis means hdev->addr will never release the display power when
>> >> suspend.
>> >>
>> >> The new sequence will be:
>> >> hdmi_codec_prepare() =>
>> >>    snd_hdac_display_power(bus, hdev->addr, true)
>> >>    snd_hdac_display_power(bus, hdev->addr, false) skl runtime
>> >> resume skl suspned
>> >
>> >I for one find this RFC difficult to follow. The documentation of
>> >"Power management sequences" seems obsolete after Takashi's changes,
>> >you may want to start with an update of the documentation which might
>> >help point out what is broken in the sequences. I also don't see the
>> >point in trying to bypass the runtime_pm code in codec_prepare and
>> >codec_complete. if we have the display on/off sequence only in
>> >probe/remove and suspend/resume it makes it easy to track states, and
>> >I wonder if it makes sense anyways to be in suspend with the display
>> >on or vice-versa in D0 with the display off. Simple state machines always
>win.
>>
>> Thanks for comments. I will modify the documentation of "Power
>> Management sequences" when I submit the formal patch. The rough flow
>> is described in my patch description. Do you think I need add more
>> details?
>>
>> Actually, the HDMI driver is a little stranger. pm runtime resume of
>> HDMI is not called even prepare() return 0. What I understand is that
>> the runtime resume should be called. I asked a friend of mine who is
>> familiar with kernel power management. He also can't tell why. Maybe
>> our ALSA experts know why :).
>>
>> My patch is based on hdmi codec pm runtime resume not being called.
>>
>> The normal flow of suspend should be:
>> Pm runtime resume => power up
>> Pm suspend => power down.
>> Unfortunately, our ASoC HDMI codec driver doesn't have pm suspend
>> Callback (maybe this is why HDMI runtime resume is not called?)
>>
>> In original code, the hdmi prepare() will call pm_runtime_get_sync()
>> which will trigger hdmi pm runtime resume, which will turn on display
>power:
>> snd_hdac_display_power(hdev->bus, hdev->addr, true). And there is no
>> chance to turn off the 'hdev->addr' display power before suspend,
>> which is wrong.
>
>Well, the problem is that HD-audio controller takes the display power
>unnecessarily at suspend and resume.  Since the refactoring, this is
>superfluous and confuses the system.
>
>Also, I see no reason to stick with prepare and complete PM calls in
>hdac_hdmi driver; the display power is managed in each domain now, so we
>shouldn't rely on the refcount done by the controller driver any longer.
>
>Below is an untested patch I cooked up for simplification and fix for this issue.
>Could you check whether this works at all?

This patch makes the flow more clear now. Thanks for help.

I have done the test on sof audio driver.
Because SOF has issue of suspend when playback, I didn't do the test
of suspend with hdmi playing. I only test the audio suspend/resume
without playing anything.

The test result is:
Suspend/resume works well.
And after suspend/resume, playback works well.

However, I don't have platform to test SST driver. I tried to setup 
the environment for SST driver test, but failed. I will continue to 
setup the SST environment. On the meantime, I will ask Intel internal
team to help on SST driver test if they are willing to help.

And please see my comments below.

[...]

>-
>-static void hdmi_codec_complete(struct device *dev)
>+#ifdef CONFIG_PM_SLEEP
>+static int hdmi_codec_resume(struct device *dev)
> {
> 	struct hdac_device *hdev = dev_to_hdac_dev(dev);
> 	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
>+	int ret;
>
>-	/* Power up afg */
>-	snd_hdac_codec_read(hdev, hdev->afg, 0,
>	AC_VERB_SET_POWER_STATE,
>-							AC_PWRST_D0);
>-
>-	hdac_hdmi_skl_enable_all_pins(hdev);
>-	hdac_hdmi_skl_enable_dp12(hdev);
>-
>+	ret = pm_runtime_force_resume(dev);

The code hopes to call hdmi pm_runtime() whenever this resume()
is called? If so, I'm afraid it will not work. pm_runtime_force_resume()
calls pm_runtime with conditions. Sometimes pm_runtime will not
be called. In my suspend/resume test, it shows that pm_runtime() is
not called. This may cause the following function
hdac_hdmi_present_sense_all_pins() not work well as there is no
power on.

Regards,
Libin

>+	if (ret < 0)
>+		return ret;
> 	/*
> 	 * As the ELD notify callback request is not entertained while the
> 	 * device is in suspend state. Need to manually check detection of @@
