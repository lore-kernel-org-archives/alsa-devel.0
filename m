From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [RFC PATCH v2 1/2] ASoC: refine ASoC hdmi audio
 suspend/resume
Date: Thu, 10 Jan 2019 05:30:14 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19527AF06F@SHSMSX103.ccr.corp.intel.com>
References: <1546827721-25586-1-git-send-email-libin.yang@intel.com>
 <e2c257fb-e292-b23d-1f20-e5467e0d93dd@linux.intel.com>
 <96A12704CE18D347B625EE2D4A099D19527AE0B4@SHSMSX103.ccr.corp.intel.com>
 <s5hd0p71jvh.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527AE92B@SHSMSX103.ccr.corp.intel.com>
 <s5h8szui68f.wl-tiwai@suse.de> <s5h4laii46l.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 312C1267445
 for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2019 06:30:17 +0100 (CET)
In-Reply-To: <s5h4laii46l.wl-tiwai@suse.de>
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


>-----Original Message-----
>From: Takashi Iwai [mailto:tiwai@suse.de]
>Sent: Wednesday, January 9, 2019 5:14 PM
>To: Yang, Libin <libin.yang@intel.com>
>Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>; alsa-
>devel@alsa-project.org; broonie@kernel.org;
>liam.r.girdwood@linux.intel.com; Lin, Mengdong <mengdong.lin@intel.com>
>Subject: Re: [alsa-devel] [RFC PATCH v2 1/2] ASoC: refine ASoC hdmi audio
>suspend/resume
>
>On Wed, 09 Jan 2019 09:29:36 +0100,
>Takashi Iwai wrote:
>>
>> On Wed, 09 Jan 2019 09:16:34 +0100,
>> Yang, Libin wrote:
>> >
>> > >-
>> > >-static void hdmi_codec_complete(struct device *dev)
>> > >+#ifdef CONFIG_PM_SLEEP
>> > >+static int hdmi_codec_resume(struct device *dev)
>> > > {
>> > > 	struct hdac_device *hdev = dev_to_hdac_dev(dev);
>> > > 	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
>> > >+	int ret;
>> > >
>> > >-	/* Power up afg */
>> > >-	snd_hdac_codec_read(hdev, hdev->afg, 0,
>> > >	AC_VERB_SET_POWER_STATE,
>> > >-							AC_PWRST_D0);
>> > >-
>> > >-	hdac_hdmi_skl_enable_all_pins(hdev);
>> > >-	hdac_hdmi_skl_enable_dp12(hdev);
>> > >-
>> > >+	ret = pm_runtime_force_resume(dev);
>> >
>> > The code hopes to call hdmi pm_runtime() whenever this resume() is
>> > called? If so, I'm afraid it will not work.
>> > pm_runtime_force_resume() calls pm_runtime with conditions.
>> > Sometimes pm_runtime will not be called. In my suspend/resume test,
>> > it shows that pm_runtime() is not called. This may cause the
>> > following function
>> > hdac_hdmi_present_sense_all_pins() not work well as there is no
>> > power on.
>>
>> Hm, right, maybe we should move hdac_hdmi_present_sense_all_pins()
>> into runtime resume.  It may be called unconditionally, but safer to
>> call it conditionally only after S3 or so...
>
>Now reading back the code again, no, it's correct to call
>hdac_hdmi_present_sense_all_pins() there.  The function doesn't access any
>HD-audio codec verbs but only with the i915 audio component.
>Hence it's safe to call there no matter whether the device is opened (thus
>resumed) or not.  And, it is even mandatory to call there; if a HDMI connection
>changed during suspend, we need to notify it right after the system resume.

Yes. It seems this is safe. Thanks for clarification. SOF audio driver test passes. 
No reply from our internal SST driver team. From SOF test, this patch can fix
the display power issue.

BTW: I have another question. Maybe it is not related to this topic, but
related the general audio power sequence. I'm not sure my understand
is correct or not.
Currently, codec device's parent is the card device, right? If so, the suspend
sequence is:
codec power off (child)
card power off (parent)

However, I see some cards will call trigger for suspend in card suspend
function. This may cause issue logically (Maybe the real cards are always
OK). The codec has already powered off. So if trigger() operates with
codec may cause issue? Even, if the codec is the master, maybe the clk
is off before trigger() is called. I'm not sure this is always OK.
(This is why I submitted the second patch.)

Regards,
Libin
