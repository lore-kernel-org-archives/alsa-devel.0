From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - fix broken HDMI jack detection
	after S3
Date: Wed, 22 Aug 2012 15:46:59 +0200
Message-ID: <5034E2D3.1080701@canonical.com>
References: <1345636901-9386-1-git-send-email-david.henningsson@canonical.com>
 <s5hy5l7yv4l.wl%tiwai@suse.de> <5034D2F5.3050406@canonical.com>
 <s5hvcgbytg6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E6C5266129
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 15:46:57 +0200 (CEST)
In-Reply-To: <s5hvcgbytg6.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, 1040030@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

On 08/22/2012 02:58 PM, Takashi Iwai wrote:
> At Wed, 22 Aug 2012 14:39:17 +0200,
> David Henningsson wrote:
>>
>> On 08/22/2012 02:22 PM, Takashi Iwai wrote:
>>> At Wed, 22 Aug 2012 14:01:41 +0200,
>>> David Henningsson wrote:
>>>>
>>>> The HDMI codec (an NVIDIA one in this case) forgot that its pins
>>>> were unsol enabled, while it was suspended. Therefore jack detection
>>>> was broken after S3.
>>>> With this patch, we reenable the unsol events on resume,
>>>> and also do an extra check afterwards, to see if the HDMI monitor was
>>>> plugged/unplugged while in S3.
>>>>
>>>> Cc: stable@kernel.org (3.3+)
>>>> BugLink: https://bugs.launchpad.net/bugs/1040030
>>>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>>>> ---
>>>>    sound/pci/hda/patch_hdmi.c |   13 +++++++++++++
>>>>    1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
>>>> index 8f23374..6a3ac05 100644
>>>> --- a/sound/pci/hda/patch_hdmi.c
>>>> +++ b/sound/pci/hda/patch_hdmi.c
>>>> @@ -1315,6 +1315,16 @@ static int generic_hdmi_init(struct hda_codec *codec)
>>>>    	return 0;
>>>>    }
>>>>
>>>> +#ifdef CONFIG_PM
>>>> +static int generic_hdmi_resume(struct hda_codec *codec)
>>>> +{
>>>> +	snd_hda_codec_resume_cache(codec);
>>>> +	snd_hda_jack_set_dirty_all(codec);
>>>> +	snd_hda_jack_report_sync(codec);
>>>> +	return 0;
>>>
>>> Hm, is this really needed?
>>>
>>> snd_hda_jack_set_dirty_all() is already called in
>>> hda_call_codec_resume(), and snd_hda_jack_report_sync() is called in
>>> the init callback.
>>
>> The tester (who has the hardware) has gone for the day, so I can't
>> really verify different scenarios right now, but after having looked at
>> hda_call_codec_resume I see what you mean...
>>
>> I do notice one difference though - the order.
>> snd_hda_codec_resume_cache, which is what writes the unsol_enable verbs,
>> should probably be before the set_dirty_all / report_sync. If not for
>> anything else, so for the race condition of somebody plugging/unplugging
>> the monitor after checking the jack but before the unsol is enabled.
>
> Calling snd_hda_jack_report_sync() in init means that all jacks are
> checked at first, then the caches are resumed.  So this won't change
> ENABLE_UNSOL verb setups.

I'm not sure I'm following. Here's the order in hda_call_codec_resume:

snd_hda_jack_set_dirty_all()
generic_hdmi_init -> snd_hda_jack_report_sync() - get_pin_sense
snd_hda_codec_resume_cache() - set_unsol_enable

With the (theoretical?) race condition being a change of pin sense 
between snd_hda_jack_report_sync() and snd_hda_codec_resume_cache(), 
which will not be picked up.

The patch changed the order to:

snd_hda_codec_resume_cache() - set_unsol_enable
snd_hda_jack_set_dirty_all()
snd_hda_jack_report_sync() - get_pin_sense

Which eliminates that race condition.

> The bug report doesn't give any details, so it's hard to guess what
> actually doesn't work.  alsa-info.sh output before and after suspend
> would be helpful to understand.

Sorry about that. The machine is not yet released, that's why.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
