From: Libin Yang <libin.yang@linux.intel.com>
Subject: Re: [PATCH v3 0/5] ALSA: hda - hdmi support dynmaic
 pcm assignment
Date: Fri, 11 Dec 2015 14:14:57 +0800
Message-ID: <566A69E1.4060102@linux.intel.com>
References: <1449712332-106365-1-git-send-email-libin.yang@linux.intel.com>
 <s5h8u52mmif.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2079226571B
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2015 07:17:21 +0100 (CET)
In-Reply-To: <s5h8u52mmif.wl-tiwai@suse.de>
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
Cc: libin.yang@intel.com, mengdong.lin@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On 12/10/2015 10:00 PM, Takashi Iwai wrote:
> On Thu, 10 Dec 2015 02:52:07 +0100,
> libin.yang@linux.intel.com wrote:
>>
>> From: Libin Yang <libin.yang@linux.intel.com>
>>
>> The patches are trying to support dynamically binding PCM to pin
>> in HDMI/DP audio.
>>
>> The pin will not bind to any PCM if there is not monitor connected.
>> When there is a monitor connected to the port (pin), driver will
>> try to find a proper PCM to assign to the port and setup the pin
>> if necessary.
>
> Could you rebase your work on the branch topic/hdmi-jack?  It contains
> the upcoming changes for ELD notify callback.  This would impact on
> your patchset, likely require a slight adjustment.

Sure, I will rebase the patches on the branch hdmi-jack.

>
> Also, do you have the applicable MST audio patchset for drm/i915 side,
> too?  I'd like to test it together with the new patchset.

Oh, yes, I have sent the patches to intel-gfx mailing list. Sorry to 
forget to CC you. I have CCed you and ALSA mailing list the patches in 
that thread now.

The drm/i915 patches are ported from Dave's patch.

Best Regards,
Libin

>
>
> thanks,
>
> Takashi
>
>>
>> Libin Yang (5):
>>    ALSA: hda - hdmi begin to support dynamic PCM assignment
>>    ALSA: hda - hdmi playback without monitor in dynamic pcm bind mode
>>    ALSA: hda - hdmi operate spdif based on pcm
>>    ALSA: hda - hdmi dynamically bind PCM to pin when monitor hotplug
>>    ALSA: hda - hdmi setup pin when monitor hotplug in pcm dynamic
>>      assignment mode
>>
>>   sound/pci/hda/hda_codec.h  |   1 +
>>   sound/pci/hda/patch_hdmi.c | 369 ++++++++++++++++++++++++++++++++++++++++++---
>>   2 files changed, 347 insertions(+), 23 deletions(-)
>>
>> --
>> 1.9.1
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
