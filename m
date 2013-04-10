From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - delay resume haswell hdmi
 codec in system resume
Date: Wed, 10 Apr 2013 12:38:36 +0200
Message-ID: <5165412C.7050306@canonical.com>
References: <1364321572-2634-1-git-send-email-mengdong.lin@intel.com>
 <s5hmwtd2ksk.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F837402E@SHSMSX101.ccr.corp.intel.com>
 <s5hk3og3o47.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F83752F5@SHSMSX101.ccr.corp.intel.com>
 <51629295.1000701@canonical.com> <s5h4nfh1fsh.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F83786D8@SHSMSX101.ccr.corp.intel.com>
 <5162AB7D.40103@canonical.com> <s5hzjx9z10c.wl%tiwai@suse.de>
 <5162B60C.6000509@canonical.com> <s5htxnhyzvu.wl%tiwai@suse.de>
 <5162C671.90405@canonical.com> <s5hhajhyvww.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F83789F5@SHSMSX101.ccr.corp.intel.com>
 <5163B90C.20107@canonical.com> <s5hhajg175u.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F837A47F@SHSMSX101.ccr.corp.intel.com>
 <5163DC21.9020702@canonical.com> <s5hmwt8xdf2.wl%tiwai@suse.de>
 <5164F8CF.6040905@canonical.com> <s5h7gkb0wfa.wl%tiwai@suse.de>
 <5165006F.5070207@canonical.com> <s5hzjx6zxld.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030607030805090604090009"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CDBF265F58
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2013 12:38:39 +0200 (CEST)
In-Reply-To: <s5hzjx6zxld.wl%tiwai@suse.de>
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
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030607030805090604090009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 04/10/2013 08:52 AM, Takashi Iwai wrote:
> At Wed, 10 Apr 2013 08:02:23 +0200,
> David Henningsson wrote:
>>
>> On 04/10/2013 07:47 AM, Takashi Iwai wrote:
>>> At Wed, 10 Apr 2013 07:29:51 +0200,
>>> David Henningsson wrote:
>>>>
>>>> On 04/09/2013 11:26 AM, Takashi Iwai wrote:
>>>>> At Tue, 09 Apr 2013 11:15:13 +0200,
>>>>> David Henningsson wrote:
>>>>>>
>>>>>> [1  <text/plain; ISO-8859-1 (7bit)>]
>>>>>> On 04/09/2013 10:18 AM, Lin, Mengdong wrote:
>>>>>>>> -----Original Message-----
>>>>>>>> From: Takashi Iwai [mailto:tiwai@suse.de]
>>>>>>>> Sent: Tuesday, April 09, 2013 3:43 PM
>>>>>>>> To: David Henningsson
>>>>>>>> Cc: Lin, Mengdong; alsa-devel@alsa-project.org; Girdwood, Liam R
>>>>>>>> Subject: Re: [alsa-devel] [PATCH] ALSA: hda - delay resume haswell hdmi codec
>>>>>>>> in system resume
>>>>>>>
>>>>>>>>>>> I've been answering the power_save questions a little bit uncertain
>>>>>>>>>>> so far, and that's because I don't really know. I've not
>>>>>>>>>>> investigated power management much.
>>>>>>>>>>>
>>>>>>>>>>> But the person with the hardware reports that this problem happens
>>>>>>>>>>> when on AC power only. And that makes sense with your observations
>>>>>>>>>>> about power_save - there could very well be something that turns
>>>>>>>>>>> power_save off when on AC power and on when on battery power.
>>>>>>>>>>>
>>>>>>>>>>> So, if it's just a matter of re-initializing the pin, what do you
>>>>>>>>>>> think about this solution:
>>>>>>>>>>>
>>>>>>>>>>>        - Resume as normal (this will enable unsol events)
>>>>>>>>>>>        - Any time an unsol event comes in, have a haswell specific
>>>>>>>>>>> function that checks relevant pins to see that is still in D0 and
>>>>>>>>>>> mute state correct. If not, correct it.
>>>>>>>>>>>        - This check could possibly also be done in the prepare hook for
>>>>>>>>>>> extra safety.
>>>>>>>>>>
>>>>>>>>>> It won't work reliably.  The problem is that the codec might be set
>>>>>>>>>> up wrongly if it's used before the unsol event comes up.  For
>>>>>>>>>> example, a PCM resume may be performed immediately after the normal
>>>>>>>>>> resume is finished.  Meanwhile the first unsol may arrive much later than
>>>>>>>> that.
>>>>>>>>>
>>>>>>>>> Right, but if this will only mean a few samples (max 300 ms?) will
>>>>>>>>> never reach the HDMI cable, it might be the least bad workaround.
>>>>>>>
>>>>>>> I've tried enabling the unsol event on system resume, the unsol event will arrive in 70~80ms for HDMI and about 10ms for DP.
>>>>>>>
>>>>>>>> It's not only about the missing few samples.  The whole setup isn't reliable at
>>>>>>>> that point, and you don't know what to re-setup for the
>>>>>>>> *running* stream.
>>>>>>>>
>>>>>>>>>> Thus we need to delay the resume operation in anyway.  And if so,
>>>>>>>>>> there is no merit to perform the normal resume operation at the
>>>>>>>>>> first step.
>>>>>>>>>
>>>>>>>>> The normal resume operation enables unsol events, which is important,
>>>>>>>>> otherwise we don't get the unsol notification from when the gfx
>>>>>>>>> pipeline has finished.
>>>>>>>>
>>>>>>>> It seems that the intrinsic unsol event is always issued once when the unsol
>>>>>>>> event is enabled, according to Intel.  So, you won't miss it.
>>>>>>>>
>>>>>>>> But heck, we need more test coverage, obviously.
>>>>>>>>
>>>>>>>>> I guess the question here is how much of the codec setup is really
>>>>>>>>> destroyed by the gfx driver? Is it just a pin in D3 and a right
>>>>>>>>> channel mute, or is it much more that needs to be re-done after the
>>>>>>>>> gfx driver has finished?
>>>>>>>>
>>>>>>>> I'm afraid it's too native to assume that...
>>>>>>>
>>>>>>> Actually, we're not sure how much setting are destroyed, although it seems only the pin power state and mute status are affected.
>>>>>>
>>>>>> I made a test patch (attached), sprinkled with printk, and asked the
>>>>>> person with hw to test it. He said it fixed the issue. Now, I'm sure he
>>>>>> did a simple playback test only, rather than having streams running
>>>>>> during S3 or anything like that.
>>>>>>
>>>>>> The patch simply sets the pin to D0 and the copies the mute value from
>>>>>> the left channel to the right channel. The printk's confirmed this happened.
>>>>>>
>>>>>> But at least it should show that not too much of the settings are
>>>>>> destroyed...or would that be jumping to conclusions too early?
>>>>>
>>>>> In your test case, the whole stream setup is called after the gfx
>>>>> power up.  It's much different from the case where the stream is
>>>>> resumed before the gfx power up.  This is the biggest concern.
>>>>>
>>>>> That being said, the PCM can't be prepared before the gfx chip gets
>>>>> ready.
>>>>
>>>> Shall we have another stab at this today...
>>>>
>>>> I think we need to figure out what actually happens if we do start a
>>>> stream before gfx is initialized. Mengdong, could you give more
>>>> information on this?
>>>>
>>>> If it's something we can easily recover from (e g by just executing a
>>>> few verbs in the unsol event handler), that might be the best option.
>>>>
>>>> If it's not, then we might need the wait event to synchronise the PCM
>>>> start with the unsol event handler. But there is still no need to delay
>>>> rest of the chip initialization/resume for that.
>>>
>>> .... if the graphics / audio resume serialization is implemented.
>>> Currently not, so we take a brute-force way.
>>>
>>>> But part of this is also that we're discussing two different symptoms
>>>> here. I've only seen the D3 + right channel mute problem so far. We can
>>>> easily recover from that, as my workaround patch shows.
>>>> Takashi was seeing the fg node being D3 (?). I have not seen that
>>>> problem, does Mengdong know if it also exists on the latest hardware
>>>> revision?
>>>
>>> As mentioned, you can't see it from user-space.  If you access, the
>>> codec is always woken up.
>>>
>>>
>>> Actually, I prefer the delayed resume to band-aiding the broken setup
>>> afterwards.  The delayed resume mechanism was proved to work well for
>>> long time (it was so as default).  We switched to the full resume just
>>> because of a few other devices.
>>>
>>> So, the biggest concern in the scheme Mengdong suggested is only about
>>> the reliability of the unsol event.
>>
>> I'm going to make one more try to explain what I think won't work with
>> this scheme.
>>
>> 1. System wakes up from S3 suspend/resume.
>> 2. No initialization is performed because resume is delayed.
>> 3. HDMI/DP cable is plugged into the system.
>> 4. Because unsol events are not enabled (due to the lack of
>> initialization), userspace is not notified that HDMI/DP cable has been
>> plugged in.
>> 5. Userspace now has the wrong idea about whether HDMI/DP cable is
>> plugged in or not.
>
> Well, we can enable only unsol event without setting to D0.

Yes, this can work. My point is that we can't just do nothing on S3 resume.

It seems Mengdong is not around today. While pm domain synchronisation 
and more advanced patches are discussed and written, I might try to 
deploy the attached patch in Ubuntu as an intermediate solution. Feel 
free to do the same if you wish.

> For example, instead of adding codec->support_delay_resume, add a new
> codec ops, codec->patch_ops.delay_resume().  For HDMI codecs, this
> callback just calls
>
> 	spec->ready_to_resume = 0;
>
> 	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
> 		struct hdmi_spec_per_pin *per_pin;
> 		hda_nid_t pin_nid;
> 		struct hda_jack_tbl *jack;
>
> 		per_pin = &spec->pins[pin_idx];
> 		pin_nid = per_pin->pin_nid;
> 		jack = snd_hda_jack_tbl_get(codec, pin_nid);
> 		if (jack)
> 			snd_hda_codec_write(codec, pin_nid, 0,
> 				 AC_VERB_SET_UNSOLICITED_ENABLE,
> 				 AC_USRSP_EN | jack->tag);
> 	}
>
> and returns.  The rest would work almost as is.  The pin-detection
> itself should work even in D3 for this chip.
>
>
> Takashi
>
>>
>>
>>>
>>>
>>> Takashi
>>>
>>>>
>>>>>
>>>>>> Also, a different thought: what are the possibilities that Mengdong can
>>>>>> fix the gfx driver side not to destroy the settings in the first place?
>>>>>
>>>>> The serialization with the graphics side is mandatory more or less.
>>>>> But it'd be good if the pm domain implementation would suffice...
>>>>>
>>>>>
>>>>> Takashi
>>>>>
>>>>>> --
>>>>>> David Henningsson, Canonical Ltd.
>>>>>> https://launchpad.net/~diwic
>>>>>> [2 hsw_d3_workaround.patch <text/x-patch (7bit)>]
>>>>>> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
>>>>>> index ede8215..edee301 100644
>>>>>> --- a/sound/pci/hda/patch_hdmi.c
>>>>>> +++ b/sound/pci/hda/patch_hdmi.c
>>>>>> @@ -1018,6 +1018,46 @@ static void hdmi_unsol_event(struct hda_codec *codec, unsigned int res)
>>>>>>     		hdmi_non_intrinsic_event(codec, res);
>>>>>>     }
>>>>>>
>>>>>> +static void haswell_verify_pin_D0(struct hda_codec *codec, hda_nid_t nid)
>>>>>> +{
>>>>>> +	int pwr, lamp, ramp;
>>>>>> +	printk("Haswell: Verify pin D0 on pin 0x%x\n", nid);
>>>>>> +
>>>>>> +	pwr = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_POWER_STATE, 0);
>>>>>> +	pwr = (pwr & AC_PWRST_ACTUAL) >> AC_PWRST_ACTUAL_SHIFT;
>>>>>> +	printk("Haswell: Found pin in state D%d\n", pwr);
>>>>>> +	if (pwr != AC_PWRST_D0) {
>>>>>> +		printk("Haswell: Trying to set power to D0\n");
>>>>>> +		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_POWER_STATE,
>>>>>> +				    AC_PWRST_D0);
>>>>>> +		msleep(40);
>>>>>> +		pwr = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_POWER_STATE, 0);
>>>>>> +		pwr = (pwr & AC_PWRST_ACTUAL) >> AC_PWRST_ACTUAL_SHIFT;
>>>>>> +		printk("Haswell: Found pin in state D%d\n", pwr);
>>>>>> +	}
>>>>>> +
>>>>>> +	lamp = snd_hda_codec_read(codec, nid, 0,
>>>>>> +				  AC_VERB_GET_AMP_GAIN_MUTE,
>>>>>> +				  AC_AMP_GET_LEFT | AC_AMP_GET_OUTPUT);
>>>>>> +	ramp = snd_hda_codec_read(codec, nid, 0,
>>>>>> +				  AC_VERB_GET_AMP_GAIN_MUTE,
>>>>>> +				  AC_AMP_GET_RIGHT | AC_AMP_GET_OUTPUT);
>>>>>> +	printk("Haswell: Verify mute on pin 0x%x: [0x%x 0x%x]\n", nid, lamp, ramp);
>>>>>> +	if (lamp != ramp) {
>>>>>> +		printk("Haswell: Setting r amp mute to l amp mute\n");
>>>>>> +		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_AMP_GAIN_MUTE,
>>>>>> +				    AC_AMP_SET_RIGHT | AC_AMP_SET_OUTPUT | lamp);
>>>>>> +
>>>>>> +		lamp = snd_hda_codec_read(codec, nid, 0,
>>>>>> +				  AC_VERB_GET_AMP_GAIN_MUTE,
>>>>>> +				  AC_AMP_GET_LEFT | AC_AMP_GET_OUTPUT);
>>>>>> +		ramp = snd_hda_codec_read(codec, nid, 0,
>>>>>> +				  AC_VERB_GET_AMP_GAIN_MUTE,
>>>>>> +				  AC_AMP_GET_RIGHT | AC_AMP_GET_OUTPUT);
>>>>>> +		printk("Haswell: Mute after set on pin 0x%x: [0x%x 0x%x]\n", nid, lamp, ramp);
>>>>>> +	}
>>>>>> +}
>>>>>> +
>>>>>>     /*
>>>>>>      * Callbacks
>>>>>>      */
>>>>>> @@ -1032,6 +1072,9 @@ static int hdmi_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
>>>>>>     	int pinctl;
>>>>>>     	int new_pinctl = 0;
>>>>>>
>>>>>> +	if (codec->vendor_id == 0x80862807)
>>>>>> +		haswell_verify_pin_D0(codec, pin_nid);
>>>>>> +
>>>>>>     	if (snd_hda_query_pin_caps(codec, pin_nid) & AC_PINCAP_HBR) {
>>>>>>     		pinctl = snd_hda_codec_read(codec, pin_nid, 0,
>>>>>>     					    AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
>>>>>
>>>>
>>>>
>>>>
>>>> --
>>>> David Henningsson, Canonical Ltd.
>>>> https://launchpad.net/~diwic
>>>>
>>>
>>
>>
>>
>> --
>> David Henningsson, Canonical Ltd.
>> https://launchpad.net/~diwic
>>
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

--------------030607030805090604090009
Content-Type: text/x-patch;
 name="0001-ALSA-hda-fixup-D3-pin-and-right-channel-mute-on-Hasw.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-hda-fixup-D3-pin-and-right-channel-mute-on-Hasw.pa";
 filename*1="tch"

>From ff4190603d846fae9049a7b96d76da1602542961 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Wed, 10 Apr 2013 12:26:07 +0200
Subject: [PATCH] ALSA: hda - fixup D3 pin and right channel mute on Haswell
 HDMI audio

When graphics initializes the HDMI chip, sometimes this leads to
pins going into D3 and right channel being muted. If the audio driver
finishes initialization before the graphic driver does, this situation
becomes permanent.

This is a workaround that checks for this situation and corrects it on
playback prepare. It has been verified working on at least one machine.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_hdmi.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index ede8215..32930e6 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1018,6 +1018,41 @@ static void hdmi_unsol_event(struct hda_codec *codec, unsigned int res)
 		hdmi_non_intrinsic_event(codec, res);
 }
 
+static void haswell_verify_pin_D0(struct hda_codec *codec, hda_nid_t nid)
+{
+	int pwr, lamp, ramp;
+
+	pwr = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_POWER_STATE, 0);
+	pwr = (pwr & AC_PWRST_ACTUAL) >> AC_PWRST_ACTUAL_SHIFT;
+	if (pwr != AC_PWRST_D0) {
+		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_POWER_STATE,
+				    AC_PWRST_D0);
+		msleep(40);
+		pwr = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_POWER_STATE, 0);
+		pwr = (pwr & AC_PWRST_ACTUAL) >> AC_PWRST_ACTUAL_SHIFT;
+		snd_printd("Haswell HDMI audio: Power for pin 0x%x is now D%d\n", nid, pwr);
+	}
+
+	lamp = snd_hda_codec_read(codec, nid, 0,
+				  AC_VERB_GET_AMP_GAIN_MUTE,
+				  AC_AMP_GET_LEFT | AC_AMP_GET_OUTPUT);
+	ramp = snd_hda_codec_read(codec, nid, 0,
+				  AC_VERB_GET_AMP_GAIN_MUTE,
+				  AC_AMP_GET_RIGHT | AC_AMP_GET_OUTPUT);
+	if (lamp != ramp) {
+		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_AMP_GAIN_MUTE,
+				    AC_AMP_SET_RIGHT | AC_AMP_SET_OUTPUT | lamp);
+
+		lamp = snd_hda_codec_read(codec, nid, 0,
+				  AC_VERB_GET_AMP_GAIN_MUTE,
+				  AC_AMP_GET_LEFT | AC_AMP_GET_OUTPUT);
+		ramp = snd_hda_codec_read(codec, nid, 0,
+				  AC_VERB_GET_AMP_GAIN_MUTE,
+				  AC_AMP_GET_RIGHT | AC_AMP_GET_OUTPUT);
+		snd_printd("Haswell HDMI audio: Mute after set on pin 0x%x: [0x%x 0x%x]\n", nid, lamp, ramp);
+	}
+}
+
 /*
  * Callbacks
  */
@@ -1032,6 +1067,9 @@ static int hdmi_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
 	int pinctl;
 	int new_pinctl = 0;
 
+	if (codec->vendor_id == 0x80862807)
+		haswell_verify_pin_D0(codec, pin_nid);
+
 	if (snd_hda_query_pin_caps(codec, pin_nid) & AC_PINCAP_HBR) {
 		pinctl = snd_hda_codec_read(codec, pin_nid, 0,
 					    AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
-- 
1.7.9.5


--------------030607030805090604090009
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030607030805090604090009--
