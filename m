From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - delay resume haswell hdmi
 codec in system resume
Date: Mon, 15 Apr 2013 09:02:48 +0200
Message-ID: <516BA618.5050104@canonical.com>
References: <1364321572-2634-1-git-send-email-mengdong.lin@intel.com>
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
 <5165412C.7050306@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F83826C6@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id E3E66261734
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 09:02:52 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F83826C6@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

On 04/14/2013 03:48 PM, Lin, Mengdong wrote:
> Hi David and Takashi,
>
> I'm sorry for the late response. I was assigned other tasks this week
>
> We don't have a better solution for this issue now, still trying.
> The delay_resume() ops for a codec can help not delaying the unsol event. So our patch can solve the problem after system suspend/resume if the cable is connected.
> But I'm afraid that if the HDMI/DP cable removed during system suspend and connected again sometime after system is resumed,
> and if the codec access happens before the cable is connected, waiting for unsol event can be time out and codec cannot be properly resumed.
> And if runtime power saving is also disabled, the audio driver has no chance to resume the codec again. I cannot verify such hot-plug case during system/suspend now because my Haswell machines cannot reach a stable S3 and then resume.
> But we do observed a similar bug: if cable is connected after boot, the pin is in D3 with right channel muted, as the codec is initialized before unsol event comes.
> Audio driver cannot find a suitable time out to wait for the usnsol event as we don't know when the cable will be connected.

Takashi's latest suggestion was to enable unsol events, and nothing 
else, directly on S3 resume. See suggested patch below.

Will that not help here? Then we would at least get some unsol events on 
hotplug I assume?

> We'll try if we can fix this dependency issue in Gfx driver side, and by sync Gfx and audio driver processing.
>
> And we cannot implement pm domain atm. Last Thursday, we have a meeting with Gfx team, for Gfx power well support and audio dependency on Gfx.
> Linux PM maintainer Rafael also attended the meeting. He suggested us not use pm domain now because it cannot fully support PCI devices (PM domains ops will override PCI bus ops). We will use and extend the existing private gfx driver API to control the powerwell and sequence the initialization/suspend/resume events between gfx and audio for internal releases. Once this is working well with the private API, we will then look at either implementing this functionality as PM domain or PM runtime depending on the best fit and upstream.
>
> I'm working on HD-A RTD3 for legacy audio in one or two weeks. After that, I'll continue to work on this issue.

The dependency on the Gfx driver, is it both codec-wide and per pin? It 
seems to be at least per pin, which means that whenever we plug 
something in, we need to redo our initialization of that pin after the 
Gfx driver has finished, is that correct?


>
> Thanks
> Mengdong
>
>>>> I'm going to make one more try to explain what I think won't work
>>>> with this scheme.
>>>>
>>>> 1. System wakes up from S3 suspend/resume.
>>>> 2. No initialization is performed because resume is delayed.
>>>> 3. HDMI/DP cable is plugged into the system.
>>>> 4. Because unsol events are not enabled (due to the lack of
>>>> initialization), userspace is not notified that HDMI/DP cable has
>>>> been plugged in.
>>>> 5. Userspace now has the wrong idea about whether HDMI/DP cable is
>>>> plugged in or not.
>>>
>>> Well, we can enable only unsol event without setting to D0.
>>
>> Yes, this can work. My point is that we can't just do nothing on S3 resume.
>>
>> It seems Mengdong is not around today. While pm domain synchronisation and
>> more advanced patches are discussed and written, I might try to deploy the
>> attached patch in Ubuntu as an intermediate solution. Feel free to do the same
>> if you wish.
>>
>>> For example, instead of adding codec->support_delay_resume, add a new
>>> codec ops, codec->patch_ops.delay_resume().  For HDMI codecs, this
>>> callback just calls
>>>
>>> 	spec->ready_to_resume = 0;
>>>
>>> 	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
>>> 		struct hdmi_spec_per_pin *per_pin;
>>> 		hda_nid_t pin_nid;
>>> 		struct hda_jack_tbl *jack;
>>>
>>> 		per_pin = &spec->pins[pin_idx];
>>> 		pin_nid = per_pin->pin_nid;
>>> 		jack = snd_hda_jack_tbl_get(codec, pin_nid);
>>> 		if (jack)
>>> 			snd_hda_codec_write(codec, pin_nid, 0,
>>> 				 AC_VERB_SET_UNSOLICITED_ENABLE,
>>> 				 AC_USRSP_EN | jack->tag);
>>> 	}
>>>
>>> and returns.  The rest would work almost as is.  The pin-detection
>>> itself should work even in D3 for this chip.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
