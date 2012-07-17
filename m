From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Sound issues with ALC269VB-based hardware
Date: Tue, 17 Jul 2012 17:40:14 +0200
Message-ID: <5005875E.90009@canonical.com>
References: <20120717151109.66d239a5@destiny.ordissimo>
 <s5htxx6jum7.wl%tiwai@suse.de> <s5hmx2yjtoj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id D94A22651FE
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2012 17:40:11 +0200 (CEST)
In-Reply-To: <s5hmx2yjtoj.wl%tiwai@suse.de>
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

On 07/17/2012 05:25 PM, Takashi Iwai wrote:
> At Tue, 17 Jul 2012 17:05:36 +0200,
> Takashi Iwai wrote:
>>
>> At Tue, 17 Jul 2012 15:11:09 +0200,
>> Anisse Astier wrote:
>>>
>>> Hi,
>>>
>>> So I have this hardware that has a few issues (all tested with tiwai/sound for-next)
>>>
>>> Audio out/speakers:
>>>   - Audio does not work by default. It needs plugging a jack in either headphone or mic.
>>>   - disabling "Enable Automute" does make it work. But then it doesn't mute when jack is plugged (obviously).
>>>
>>> Mic:
>>>   - needs model=laptop-dmic so that working "Internal Mic 1" appears
>>>   - "Internal Mic" is useless.
>>>   - no jack sense, need to select manually "Internal Mic 1" or "Mic" (external) as Input Source
>>>
>>> Please find alsa-info.sh with and without model=laptop-dmic in attachement.
>>
>> All sounds like that your BIOS setup is broken.
>>
>> You have two internal mics on 0x12 and 0x19.  Judging from your
>> comment, the pin 0x12 seems bogus.
>
> BTW, this revealed a bug in the latest code.  Since phantom jack
> renaming, the account of ctl name index seems broken.  With this
> setup, the driver ended up with the duplicated internal mic phantom
> jack controls.
>
> So I applied the patch below now.

While the new checking is more robust, I fail to see how it happens, and 
what the phantom jacks have anything to do with it?
Both inputs and outputs should be sent to add_jack_kctl in type order, 
phantom or not.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
