From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [alsa-devel] [PATCH] drm/i915: Add private api for
 power well usage -- alignment between graphic team and audio team
Date: Fri, 03 May 2013 14:02:04 +0200
Message-ID: <5183A73C.1030205@canonical.com>
References: <1B1032E88FFFDA4898B04D530F28DEDB53CAB7@SHSMSX101.ccr.corp.intel.com>
	<CAKMK7uGZ1eK1MngbihR_+xUZZXsFQGEV3=NH1Ohjf7S0i9s2-g@mail.gmail.com>
	<1B1032E88FFFDA4898B04D530F28DEDB53CB7C@SHSMSX101.ccr.corp.intel.com>
	<20130426145708.GN6169@phenom.ffwll.local>
	<s5h61z91g2l.wl%tiwai@suse.de>
	<20130426154207.GP6169@phenom.ffwll.local>
	<s5hzjwlz46s.wl%tiwai@suse.de>
	<20130426171737.GR6169@phenom.ffwll.local>
	<46B810F6945F7C4788E11DCE57EC4890109D3608@SHSMSX102.ccr.corp.intel.com>
	<20130427113529.GT6169@phenom.ffwll.local>
	<20130429080219.05108857@jbarnes-desktop>
	<517F9D11.3020905@canonical.com> <1367332882.2460.14.camel@loki>
	<51827CF2.9090507@canonical.com>
	<46B810F6945F7C4788E11DCE57EC4890109D596D@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <46B810F6945F7C4788E11DCE57EC4890109D596D@SHSMSX102.ccr.corp.intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: "Wang, Xingchao" <xingchao.wang@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zanoni,
	Paulo R" <paulo.r.zanoni@intel.com>, Takashi Iwai <tiwai@suse.de>, Daniel Vetter <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Wang Xingchao <xingchao.wang@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Li,
	Jocelyn" <jocelyn.li@intel.com>, "Hindman,
	Gavin" <gavin.hindman@intel.com>, "Barnes,
	Jesse" <jesse.barnes@intel.com>, "Lin, Mengdong" <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

On 05/03/2013 10:28 AM, Wang, Xingchao wrote:
> Hi David,
>
> Thank you very much for your draft patch.
> I have some more work on a new patchset, some ideas are from your patch.

Thanks.

> Here's a brief introduction of attached patchset:
>
> 1. a new bus type in /sound/had_bus.c, used to bind the single module and codec device
> It looks like ac97_bus.c

I don't understand why this is needed. It does not look like it's used 
from the gfx side either, or anything like that?

> 2. add a new device node in "struct hda_codec", it's used to register for new bus type.
>
> 3. a new single module hdmi_i915, which compiled in only when DRM_I915 and CODEC_HDMI enabled.
> It stores the private API for gfx part.
> There's no support to probe haswell hdmi codec only yet. Power well will be used only for haswell display audio.
>
> 4. power well API implementation in gfx side.
>
> Please feel free to add your idea and I will help test your patch too.

Ok. So the patch I wrote would (if it works) be combined with your patch 
3, which implements the gfx side. The gfx side is not my area of expertise.

The proposed way in my patch would be more elegant since it does not 
introduce any i915 related code in hda_codec* files.

Still, Takashi is the boss here so he has the final say :-)

>
> Thanks
> --xingchao
>
>> -----Original Message-----
>> From: David Henningsson [mailto:david.henningsson@canonical.com]
>> Sent: Thursday, May 02, 2013 10:49 PM
>> To: Liam Girdwood
>> Cc: Barnes, Jesse; alsa-devel@alsa-project.org; Zanoni, Paulo R; Takashi Iwai;
>> Daniel Vetter; intel-gfx@lists.freedesktop.org; Wysocki, Rafael J; Wang
>> Xingchao; Wang, Xingchao; Li, Jocelyn; Hindman, Gavin; Daniel Vetter; Lin,
>> Mengdong; ville.syrjala@linux.intel.com
>> Subject: Re: [alsa-devel] [PATCH] drm/i915: Add private api for power well
>> usage -- alignment between graphic team and audio team
>>
>> On 04/30/2013 04:41 PM, Liam Girdwood wrote:
>>> On Tue, 2013-04-30 at 12:29 +0200, David Henningsson wrote:
>>>> On 04/29/2013 05:02 PM, Jesse Barnes wrote:
>>>>> On Sat, 27 Apr 2013 13:35:29 +0200
>>>>> Daniel Vetter <daniel@ffwll.ch> wrote:
>>>>>
>>>>>> On Sat, Apr 27, 2013 at 09:20:39AM +0000, Wang, Xingchao wrote:
>>>>>>> Let me throw a basic proposal on Audio driver side,  please give your
>> comments freely.
>>>>>>>
>>>>>>> it contains the power well control usage points:
>>>>>>> #1: audio request power well at boot up.
>>>>>>> I915 may shut down power well after bootup initialization, as there's no
>> monitor connected outside or only eDP on pipe A.
>>>>>>> #2: audio request power on resume
>>>>>>> After exit from D3 mode, audio driver quest power on. This may happen
>> at normal resume or runtime resume.
>>>>>>> #3: audio release power well control at suspend Audio driver will
>>>>>>> let i915 know it doensot need power well anymore as it's going to
>> suspend. This may happened at normal suspend or runtime suspend point.
>>>>>>> #4: audio release power well when module unload Audio release
>>>>>>> power well at remove callback to let i915 know.
>>>>>>
>>>>>> I miss the power well grab/dropping at runtime from the audio side.
>>>>>> If the audio driver forces the power well to be on the entire time
>>>>>> it's loaded, that's not good, since the power well stuff is very much for
>> runtime PM.
>>>>>> We _must_ be able to switch off the power well whenever possible.
>>>>>
>>>>> Xingchao, I'm not an audio developer so I'm probably way off.
>>>>>
>>>>> But what we really need is a very small and targeted set of calls
>>>>> into the i915 driver from say the HDMI driver in HDA.  It looks like
>>>>> the prepare/cleanup pair in the pcm_ops structure might be the right
>>>>> place to put things?  If that's too fine grained, you could do it at
>>>>> open/close time I guess, but the danger there is that some app will
>>>>> keep the device open even while it's not playing.
>>>>>
>>>>> If that won't work, maybe calling i915 from hda_power_work in the
>>>>> higher level code would be better?
>>>>>
>>>>> For detecting whether to call i915 at all, you can filter on the PCI
>>>>> IDs (just look for an Intel graphics device and if present, try to
>>>>> get the i915 symbols for the power functions).
>>>>>
>>>>> --- a/sound/pci/hda/hda_codec.c
>>>>> +++ b/sound/pci/hda/hda_codec.c
>>>>> @@ -3860,6 +3860,8 @@ static unsigned int
>> hda_call_codec_suspend(struct hda_code
>>>>>                    codec->patch_ops.suspend(codec);
>>>>>            hda_cleanup_all_streams(codec);
>>>>>            state = hda_set_power_state(codec, AC_PWRST_D3);
>>>>> +       if (i915_shared_power_well)
>>>>> +               i915_put_power_well(codec->i915_data);
>>>>>            /* Cancel delayed work if we aren't currently running from it.
>> */
>>>>>            if (!in_wq)
>>>>>                    cancel_delayed_work_sync(&codec->power_work);
>>>>> @@ -4807,6 +4809,9 @@ static void __snd_hda_power_up(struct
>> hda_codec *codec, bo
>>>>>                    return;
>>>>>            spin_unlock(&codec->power_lock);
>>>>>
>>>>> +       if (i915_shared_power_well)
>>>>> +               i915_get_power_well(codec->i915_data);
>>>>
>>>> Is it wise that a _get function actually has side effects? Perhaps
>>>> _push and _pop or something else would be better semantics.
>>>>
>>>
>>> I think the intention here is to model on the PM runtime subsystem
>>> where we can get/put the reference count on a PM resource. I'd expect
>>> with this API that i915_get_power_well() will increment the count and
>>> prevent the shared PM resource from being powered OFF.
>>
>> Ok, I stand corrected.
>>
>>>
>>>>> +
>>>>>            cancel_delayed_work_sync(&codec->power_work);
>>>>>
>>>>>            spin_lock(&codec->power_lock);
>>>>>
>>>>> With some code at init time to get the i915 symbols you need to call
>>>>> and whether or not the shared power well is present...
>>>>>
>>>>> Takashi, any other ideas?
>>>>>
>>>>> The high level goal here should be for the audio driver to call into
>>>>> i915 with get/put power well around the sequences where it needs the
>>>>> power to be up (reading/writing registers, playing audio), but not
>>>>> across the whole time the driver is loaded, just like you already do
>>>>> with the powersave work functions, e.g. hda_call_codec_suspend.
>>>>
>>>> I think this sounds about right. The question is how to avoid a
>>>> dependency on the i915 driver when it's not necessary, such as when
>>>> the HDMI codec is AMD or Nvidia.
>>>>
>>>> The most obvious way to me seems to be to create a new
>>>> snd-hda-codec-hdmi-haswell module (that depends on both i915 and
>>>> snd-hda-codec-hdmi), and then let that call into i915 and codec-hdmi
>>>> drivers as necessary, e g using the set_power_state callback for the
>>>> i915 stuff.
>>>>
>>>> But maybe there's something smarter to do here, as I'm not
>>>> experienced in mending kernel pieces together :-)
>>>>
>>>
>>> Interesting idea, we could have something similar to the AC97 ad-hoc
>>> device support where we could load other HW specific AC97 modules
>>> (like touchscreen controllers) without breaking the generic nature of
>>> the base driver. e.g. the WM9712 AC97 touchscreen driver could connect
>>> to the generic AC97 audio driver (get it's device struct ac97 *) and
>>> perform
>>> AC97 register IO, ac97 API calls etc.
>>
>> Nobody objected, so I wrote a very draft patch, which is attached to this email.
>> It probably does not even compile, but should show how I envision things could
>> be mended together. Do you think it could work?
>>
>> Also, I tried to find the patch set for the i915 side, but couldn't find any while
>> looking on the intel-gfx mailinglist  (which I'm not subscribed to) - only
>> comments on those patches. Where can the latest version of the i915 patches
>> be found?
>>
>> --
>> David Henningsson, Canonical Ltd.
>> https://launchpad.net/~diwic
>>
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
