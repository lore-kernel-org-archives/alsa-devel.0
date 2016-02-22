From: Martin Kepplinger <martink@posteo.de>
Subject: Re: [BUG] [REGRESSION] [BISECTED] -rc1 breaks audio
 over HDMI for i915
Date: Mon, 22 Feb 2016 15:02:56 +0100
Message-ID: <56CB1510.4010503@posteo.de>
References: <56B98888.5000702@posteo.de> <s5h4mdixg4n.wl-tiwai@suse.de>
 <56BB7187.1020108@posteo.de> <s5hegcjipk4.wl-tiwai@suse.de>
 <56BDD990.1070900@posteo.de> <s5hegcif37m.wl-tiwai@suse.de>
 <56BE0044.9080500@posteo.de> <s5h37sxgazv.wl-tiwai@suse.de>
 <56CAE1C5.4070107@posteo.de> <s5hr3g52fud.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A619D2606BA
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 15:04:27 +0100 (CET)
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
 by mout01.posteo.de (Postfix) with ESMTPS id 03E5F20A16
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 15:04:25 +0100 (CET)
In-Reply-To: <s5hr3g52fud.wl-tiwai@suse.de>
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
Cc: libin.yang@intel.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, han.lu@intel.com, treding@nvidia.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Am 2016-02-22 um 11:34 schrieb Takashi Iwai:
> On Mon, 22 Feb 2016 11:24:05 +0100,
> Martin Kepplinger wrote:
>>
>> Am 2016-02-12 um 17:16 schrieb Takashi Iwai:
>>> On Fri, 12 Feb 2016 16:54:44 +0100,
>>> Martin Kepplinger wrote:
>>>>
>>>> Am 2016-02-12 um 14:49 schrieb Takashi Iwai:
>>>>> On Fri, 12 Feb 2016 14:09:36 +0100,
>>>>> Martin Kepplinger wrote:
>>>>>>
>>>>>> Am 2016-02-11 um 10:06 schrieb Takashi Iwai:
>>>>>>> On Wed, 10 Feb 2016 18:21:11 +0100,
>>>>>>> Martin Kepplinger wrote:
>>>>>>>>
>>>>>>>> Am 2016-02-09 um 12:44 schrieb Takashi Iwai:
>>>>>>>>> On Tue, 09 Feb 2016 07:34:48 +0100,
>>>>>>>>> Martin Kepplinger wrote:
>>>>>>>>>>
>>>>>>>>>> The following change:
>>>>>>>>>>
>>>>>>>>>> 788d441 ALSA: hda - Use component ops for i915 HDMI/DP audio jack handling
>>>>>>>>>>
>>>>>>>>>> breaks audio over HDMI on my snd_hda_intel laptop. It is the first bad
>>>>>>>>>> commit.
>>>>>>>>>>
>>>>>>>>>> This was merged for -rc1 and isn't fixed until now, so I got nervous.
>>>>>>>>>> There are
>>>>>>>>>> no errors in the log that stand out. I'm no sound or alsa developer, and
>>>>>>>>>> just reverting it isn't easy since there is stuff depending on this.
>>>>>>>>>>
>>>>>>>>>> I'm happy to test possible fixes and hope v4.5 not to ship with such a big
>>>>>>>>>> regression ;)
>>>>>>>>>
>>>>>>>>> Could you give a bit more detail about your hardware?  At best, give
>>>>>>>>> alsa-info.sh output (run with --no-upload option).  Also, give the
>>>>>>>>> output of dmesg, too.
>>>>>>>>>
>>>>>>>>> In addition, what shows /proc/asound/card*/eld#*.* files?  Does any of
>>>>>>>>> it show the proper connection state and ELD?
>>>>>>>>
>>>>>>>> alsa-info and dmesg are appended, and
>>>>>>>>
>>>>>>>> root@laptop:/home/martin/dev# cat /proc/asound/card*/eld#*
>>>>>>>> monitor_present		0
>>>>>>>> eld_valid		0
>>>>>>>
>>>>>>> OK, then could you put some debug print in intel_pin_eld_notify() in
>>>>>>> sound/pci/hda/patch_hdmi.c?  This is the callback to be called by i915
>>>>>>> driver at enabling / disabling HDMI/DP audio.
>>>>>>
>>>>>> intel_pin_eld_notify() is called during HDMI plugin with
>>>>>>
>>>>>> audio_ptr: ffff880242ea8800, port 1
>>>>>>
>>>>>> and doesn't return early.
>>>>>
>>>>> OK, so it was processed but the ELD wasn't updated by some reason.
>>>>>
>>>>>>> (Also, to be sure, check whether snd_hdac_i915_register_notifier() in
>>>>>>>  sound/hda/hda_i915.c is called, too.)
>>>>>>
>>>>>> snd_hdac_i915_register_notifier() is called during boot.
>>>>>>
>>>>>>>
>>>>>>> If intel_pin_eld_notify() is registered but never called, it implies
>>>>>>> something wrong in i915 driver side.  If it gets called, we need to
>>>>>>> track down: what port value was passed there, and how
>>>>>>> hdmi_present_sense() and sync_eld_via_acomp() behave there.
>>>>>>
>>>>>> I'll try to look at said path, if you have no other idea in the meantime.
>>>>>
>>>>> Put some debug prints in sync_eld_via_acomp(), e.g. check whether
>>>>> snd_hdac_acomp_get_eld() returns an error or snd_hdmi_parse_eld()
>>>>> returns an error.  If you got an error, track down more deeply.
>>>>>
>>>>> For example, the former function is defined in sound/hda/hdac_i915.c,
>>>>> and it calls the function i915_audio_component_get_eld() in
>>>>> drivers/gpu/drm/i915/intel_audio.c.  You can follow what returns an
>>>>> error.
>>>>>
>>>>> Similarly, the latter function is defined in sound/pci/hda/hda_eld.c.
>>>>> Usually you see a kernel message for parse errors, so I guess this
>>>>> isn't the case, though.
>>>>>
>>>>
>>>> no error in either of the functions. size is always 0, after boot and
>>>> after HDMI plugin. is that normal?
>>>
>>> No, it means that no connection is reported back.  Check the call of
>>> i915_audio_component_get_eld() as mentioned in the above.
>>> Does it return 0?  Also I suppose monitor_present is set to false?
>>> If so, it implies that intel_audio_codec_enable() isn't called.
>>>
>>> When the above is true, boot with drm.debug=0x0e, and give the kernel
>>> messages.
>>>
>>
>> The above is true and -rc5 didn't fix the problem. I append "dmesg|grep
>> drm" with drm.debug=0x0e. HDMI is plugged in at about 90 seconds in.
> 
> And how about my questions in the previous mail?  Does
> i915_audio_component_get_eld() is called and returns 0?
> And is monitor_present set true or false?

i915_audio_component_get_eld() returns 0 and monitor_present is 0.
> 
> If i915_audio_component_get_eld() is called but returns zero, track
> the code flow there.  It means either intel_encoder is NULL or
> intel_dig_port->audio_connector is NULL.

intel_dig_port->audio_connector is NULL!

(when called during boot and during HDMI plugin)

I'll follow it more, but I'm just posting in case anyone finds the
mistake early.

thanks!

> 
> 
> Takashi
> 
