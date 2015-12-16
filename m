From: Libin Yang <libin.yang@linux.intel.com>
Subject: Re: [PATCH v4 0/5] ALSA: hda - hdmi support dynamic
 pcm assignment
Date: Wed, 16 Dec 2015 15:54:50 +0800
Message-ID: <567118CA.3010400@linux.intel.com>
References: <1450244565-77041-1-git-send-email-libin.yang@linux.intel.com>
 <s5hbn9qhm2v.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2729C26517C
 for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2015 08:57:21 +0100 (CET)
In-Reply-To: <s5hbn9qhm2v.wl-tiwai@suse.de>
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



On 12/16/2015 03:47 PM, Takashi Iwai wrote:
> On Wed, 16 Dec 2015 06:42:40 +0100,
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
>>
>> Libin Yang (5):
>>    ALSA: hda - hdmi begin to support dynamic PCM assignment
>>    ALSA: hda - hdmi playback without monitor in dynamic pcm bind mode
>>    ALSA: hda - hdmi operate spdif based on pcm
>>    ALSA: hda - hdmi dynamically bind PCM to pin when monitor hotplug
>>    ALSA: hda - hdmi setup pin when monitor hotplug in pcm dynamic
>>      assignment mode
>
> I updated topic/hda-mst branch with these patches.  But the patch 4
> needs more fixes, as suggested in another mail.

Thanks. Do I need to resend all the patches? Or just patch 4 and patch 5?

>
> Overall, I'd like to know whether MST audio really works in the
> current state, or not.  Do you have *any* git branch where MST audio
> is supposed to work at all?

Yes, I have all the patches in my local branch. We tested the patches 
before. But since a lot of code in mainline is changed, I need rebase 
the patches. Some patches are conflicted with the jack changes you 
made. Some also fix some unsol event issues, which seems you have made 
a lot of changes on it currently.

Regards,
Libin

>
>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
