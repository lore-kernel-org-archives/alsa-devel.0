From: Martin Kepplinger <martink@posteo.de>
Subject: Re: [BUG] [REGRESSION] [BISECTED] -rc1 breaks audio
 over HDMI for i915
Date: Mon, 22 Feb 2016 19:58:18 +0100
Message-ID: <56CB5A4A.90906@posteo.de>
References: <56B98888.5000702@posteo.de> <s5h4mdixg4n.wl-tiwai@suse.de>
 <56BB7187.1020108@posteo.de> <s5hegcjipk4.wl-tiwai@suse.de>
 <56BDD990.1070900@posteo.de> <s5hegcif37m.wl-tiwai@suse.de>
 <56BE0044.9080500@posteo.de> <s5h37sxgazv.wl-tiwai@suse.de>
 <56CAE1C5.4070107@posteo.de> <s5hr3g52fud.wl-tiwai@suse.de>
 <56CB1510.4010503@posteo.de> <s5hd1ro3kbf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 58433260698
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 19:59:43 +0100 (CET)
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
 by mout01.posteo.de (Postfix) with ESMTPS id 8683520AAF
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 19:59:42 +0100 (CET)
In-Reply-To: <s5hd1ro3kbf.wl-tiwai@suse.de>
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

Am 2016-02-22 um 15:12 schrieb Takashi Iwai:
> On Mon, 22 Feb 2016 15:02:56 +0100,
> Martin Kepplinger wrote:
>>> And how about my questions in the previous mail?  Does
>>> i915_audio_component_get_eld() is called and returns 0?
>>> And is monitor_present set true or false?
>>
>> i915_audio_component_get_eld() returns 0 and monitor_present is 0.
>>>
>>> If i915_audio_component_get_eld() is called but returns zero, track
>>> the code flow there.  It means either intel_encoder is NULL or
>>> intel_dig_port->audio_connector is NULL.
>>
>> intel_dig_port->audio_connector is NULL!
>>
>> (when called during boot and during HDMI plugin)
> 
> Interesting.  The relevant code flow should be like:
> 
>   intel_audio_codec_enable()
>   -> acomp->audio_ops->pin_eld_notify()
>     -> intel_pin_eld_notify()
>       -> check_presence_and_report()
>         -> hdmi_present_sense()
> 	  -> sync_eld_via_acomp()
> 	    -> snd_hdac_acomp_get_eld()
> 	      -> i915_audio_component_get_eld()
> 
> So, at first, check whether intel_dig_port in both
> intel_audio_codec_enable() and i915_audio_component_get_eld() points
> to the same object address.  The audio_connector must be set in
> intel_audio_codec_enable(), thus basically it must be non-NULL at
> i915_audio_component_get_eld(), too.
> 

intel_dig_port is *not* the same object in these 2 places. During
plugin, see:

[  146.934091] in intel_audio_codec_enable: intel_dig_port is
ffff8800a1f54000
[  146.934121] in i915_audio_component_get_eld: intel_dig_port is
ffff880244f7d000

sorry for the slow responses. I'll try to go back that direction unless
again someone comes up with other suggestions.

                            martin
