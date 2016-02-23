From: Martin Kepplinger <martink@posteo.de>
Subject: Re: [BUG] [REGRESSION] [BISECTED] -rc1 breaks audio over HDMI for
 i915
Date: Tue, 23 Feb 2016 18:09:43 +0100
Message-ID: <56CC9257.2050704@posteo.de>
References: <56B98888.5000702@posteo.de> <s5h4mdixg4n.wl-tiwai@suse.de>
 <56BB7187.1020108@posteo.de> <s5hegcjipk4.wl-tiwai@suse.de>
 <56BDD990.1070900@posteo.de> <s5hegcif37m.wl-tiwai@suse.de>
 <56BE0044.9080500@posteo.de> <s5h37sxgazv.wl-tiwai@suse.de>
 <56CAE1C5.4070107@posteo.de> <s5hr3g52fud.wl-tiwai@suse.de>
 <56CB1510.4010503@posteo.de> <s5hd1ro3kbf.wl-tiwai@suse.de>
 <56CB5A4A.90906@posteo.de> <s5hpovov9wy.wl-tiwai@suse.de>
 <56CB7F98.20807@posteo.de> <s5hio1ffjp7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hio1ffjp7.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: intel-gfx@lists.freedesktop.org, david.henningsson@canonical.com, han.lu@intel.com, libin.yang@intel.com, treding@nvidia.com, perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Am 2016-02-23 um 17:57 schrieb Takashi Iwai:
> On Mon, 22 Feb 2016 22:37:28 +0100,
> Martin Kepplinger wrote:
>>
>> Am 2016-02-22 um 20:10 schrieb Takashi Iwai:
>>> On Mon, 22 Feb 2016 19:58:18 +0100,
>>> Martin Kepplinger wrote:
>>>>
>>>> Am 2016-02-22 um 15:12 schrieb Takashi Iwai:
>>>>> On Mon, 22 Feb 2016 15:02:56 +0100,
>>>>> Martin Kepplinger wrote:
>>>>>>> And how about my questions in the previous mail?  Does
>>>>>>> i915_audio_component_get_eld() is called and returns 0?
>>>>>>> And is monitor_present set true or false?
>>>>>>
>>>>>> i915_audio_component_get_eld() returns 0 and monitor_present is 0.
>>>>>>>
>>>>>>> If i915_audio_component_get_eld() is called but returns zero, track
>>>>>>> the code flow there.  It means either intel_encoder is NULL or
>>>>>>> intel_dig_port->audio_connector is NULL.
>>>>>>
>>>>>> intel_dig_port->audio_connector is NULL!
>>>>>>
>>>>>> (when called during boot and during HDMI plugin)
>>>>>
>>>>> Interesting.  The relevant code flow should be like:
>>>>>
>>>>>   intel_audio_codec_enable()
>>>>>   -> acomp->audio_ops->pin_eld_notify()
>>>>>     -> intel_pin_eld_notify()
>>>>>       -> check_presence_and_report()
>>>>>         -> hdmi_present_sense()
>>>>> 	  -> sync_eld_via_acomp()
>>>>> 	    -> snd_hdac_acomp_get_eld()
>>>>> 	      -> i915_audio_component_get_eld()
>>>>>
>>>>> So, at first, check whether intel_dig_port in both
>>>>> intel_audio_codec_enable() and i915_audio_component_get_eld() points
>>>>> to the same object address.  The audio_connector must be set in
>>>>> intel_audio_codec_enable(), thus basically it must be non-NULL at
>>>>> i915_audio_component_get_eld(), too.
>>>>>
>>>>
>>>> intel_dig_port is *not* the same object in these 2 places. During
>>>> plugin, see:
>>>>
>>>> [  146.934091] in intel_audio_codec_enable: intel_dig_port is
>>>> ffff8800a1f54000
>>>> [  146.934121] in i915_audio_component_get_eld: intel_dig_port is
>>>> ffff880244f7d000
>>>>
>>>> sorry for the slow responses. I'll try to go back that direction unless
>>>> again someone comes up with other suggestions.
>>>
>>> Thanks, this makes sense.  It implies that the digital port mapping is
>>> somehow wrong.  There are three places setting dig_port_map[], one in
>>> intel_ddi_init(), one in intel_dp_init() and another in
>>> intel_hdmi_init().  Try to check which function creates which object
>>> assigned to which port number, together with drm.debug=0x0e debug
>>> messages.
>>>
>> without using drm.debug=0x0e, but by printing the kmalloc'ed objects in
>> those 3 functions with ports, I found:
>>
>> 2 of them are running, only during boot:
>>
>> [    2.322865] intel_hdmi_init: intel_dig_port is ffff880242564000  port 1
>> [    2.322999] intel_dp_init: intel_dig_port is ffff880242f30000  port 1
>>
>> is is correct for them to have both port 1? Any more ideas?
> 
> Adding intel-gfx ML to Cc.

yes thanks, maybe people there have noticed this too. I can't be the
only one.

> 
> Martin, is the machine SandyBridge or IvyBridge?

SandyBridge.

> 
> In anyway it's PCH_SPLIT and there can call both intel_hdmi_init() and 
> intel_dp_init() for the same port although both functions map
> intel_dig_port[].  The assumption of intel_dig_port[] reverse mapping
> is that there is only a single intel_dig_port assigned to a port, but
> this doesn't look correct...
> 
> 
> Takashi
> 
