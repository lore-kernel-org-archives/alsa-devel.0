From: Libin Yang <libin.yang@linux.intel.com>
Subject: Re: [RFC PATCH 0/2] ALSA: hda - DP MST audio for Jack
 support
Date: Wed, 4 Nov 2015 14:23:14 +0800
Message-ID: <5639A452.20106@linux.intel.com>
References: <1446540176-110181-1-git-send-email-libin.yang@linux.intel.com>
 <s5hsi4nni3u.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 8013D261622
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 07:24:37 +0100 (CET)
In-Reply-To: <s5hsi4nni3u.wl-tiwai@suse.de>
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
Cc: libin.yang@intel.com, alsa-devel@alsa-project.org, mengdong.lin@linux.intel.com
List-Id: alsa-devel@alsa-project.org


On 11/04/2015 12:49 AM, Takashi Iwai wrote:
> On Tue, 03 Nov 2015 09:42:54 +0100,
> libin.yang@linux.intel.com wrote:
>>
>> From: Libin Yang <libin.yang@linux.intel.com>
>>
>> This is the patch set for Jack support for DP MST audio
>>
>> Libin Yang (2):
>>    ALSA: hda - jack support DP MST audio
>>    ALSA: hda - hdmi audio add dynamically jack binding to pin
>
> I'm somehow confused by this patch series.
> Is the unsolicited event handling itself changed for MST?  I mean, you
> cannot know which MST dev# is given beforehand, while you seem trying
> to assign such a number to the jack object.

Oh, sorry I forgot to mention that we only operate on device entry 0 
so far in the code. It's misleading.

These patches don't operate on MST audio. The full MST audio driver 
support will be implemented in the later patches. The patches help to 
prepare supporting MST audio.

The purpose of the patches is try to dynamically attach the Jack.

>
> We create all jacks statically at probe time.  And in MST case, each
> jack is still supposed to be corresponding to each PCM stream, not to
> each pin.  So I don't see how this fits with the big picture.

In the generic_hdmi_build_jack(), it will create the snd_jack based on 
the pcm. This is for the userspace. So userspace can see the Jack 
number is the same as PCM. The first Jack for the first PCM, and so 
on. And it is not attached to any pin at first.

In generic_hdmi_build_controls(), it will also create hda_jack_tbl 
based on the pin. The hda_jack_tbl will record the pin information.

When hotplug, in the hdmi_present_sense(), it will call 
xxx_jack_bind() to bind the snd_jack to hda_jack_tbl

>
> A bit more explanation is needed.

I will. Thanks.

Best Regards,
Libin

>
>
> thanks
>
> Takashi
>
>>
>>   sound/pci/hda/hda_jack.c   | 186 ++++++++++++++++++++++++++++++++++++++++-----
>>   sound/pci/hda/hda_jack.h   |  32 +++++++-
>>   sound/pci/hda/patch_hdmi.c | 116 ++++++++++++++++++++++------
>>   3 files changed, 288 insertions(+), 46 deletions(-)
>>
>> --
>> 1.9.1
>>
