From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: HDMI Repoll after pm?
Date: Thu, 10 Dec 2015 14:28:16 +0100
Message-ID: <56697DF0.20502@canonical.com>
References: <56694A4F.8070104@canonical.com> <s5htwnq7hpf.wl-tiwai@suse.de>
 <5669774F.3060709@canonical.com> <s5hk2ommoh6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 780E526530B
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2015 14:28:15 +0100 (CET)
In-Reply-To: <s5hk2ommoh6.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 2015-12-10 14:18, Takashi Iwai wrote:
> On Thu, 10 Dec 2015 13:59:59 +0100,
> David Henningsson wrote:
>>
>>
>>
>> On 2015-12-10 10:53, Takashi Iwai wrote:
>>> On Thu, 10 Dec 2015 10:47:59 +0100,
>>> David Henningsson wrote:
>>>>
>>>> Hi Takashi,
>>>>
>>>> A recent change in sound.git seems to have introduced some repoll after
>>>> pm. Is this an intentional change? I don't think it's wrong per se (it
>>>> stops after 6 repolls), but it breaks my hda-emu tester when "list" does
>>>> not return the expected input.
>>>
>>> Hm, there is no such an intended change.
>>
>> After testing some more, I've found that reverting e90247f9 (Split ELD
>> update code from hdmi_present_sense) fixes the issue, so it seems like
>> this commit indeed contains a functional change...
>
> Thanks for chasing it.

It's almost unreal...my tester framework finally caught a bug (that you 
didn't catch before I saw it!). I cannot believe it, it only took, like, 
three years or so :-)

> Does the following patch work better?

It certainly does. Thanks!

Tested-by: David Henningsson <david.henningsson@canonical.com>

>
>
> Takashi
>
> ---
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 35a78a6f87a6..2a7d29a07f31 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -1605,6 +1605,7 @@ static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
>   	 */
>   	int present;
>   	bool ret;
> +	bool do_repoll = false;
>
>   	snd_hda_power_up_pm(codec);
>   	present = snd_hda_pin_sense(codec, pin_nid);
> @@ -1629,9 +1630,11 @@ static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
>   						    eld->eld_size) < 0)
>   				eld->eld_valid = false;
>   		}
> +		if (!eld->eld_valid && repoll)
> +			do_repoll = true;
>   	}
>
> -	if (!eld->eld_valid && repoll)
> +	if (do_repoll)
>   		schedule_delayed_work(&per_pin->work, msecs_to_jiffies(300));
>   	else
>   		update_eld(codec, per_pin, eld);
>

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
