From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Introduce "Headset Mic" name
Date: Thu, 21 Mar 2013 14:42:14 +0100
Message-ID: <514B0E36.3050701@canonical.com>
References: <1363861977-8382-1-git-send-email-david.henningsson@canonical.com>
 <s5h620lc9ru.wl%tiwai@suse.de> <514AE527.3010106@canonical.com>
 <514AE784.4070406@canonical.com> <s5h1ub9c7gd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 3277C26511D
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2013 14:42:14 +0100 (CET)
In-Reply-To: <s5h1ub9c7gd.wl%tiwai@suse.de>
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

On 03/21/2013 12:34 PM, Takashi Iwai wrote:
> At Thu, 21 Mar 2013 11:57:08 +0100,
> David Henningsson wrote:
>>
>> On 03/21/2013 11:47 AM, David Henningsson wrote:
>>> On 03/21/2013 11:44 AM, Takashi Iwai wrote:
>>>> The definition of spec->headset_jack is missing?
>>>
>>> It was added in sigmatel_spec in Oct 2012. If you prefer, I could send
>>> the changes to patch_sigmatel in a separate patch?
>>
>> Btw; this change for patch_sigmatel is just a first example. I intend to
>> add more headset mics later, and this fixup also makes it easier for
>> others to submit such patches.
>>
>> But if I get this name into the kernel now I can also add it to
>> PulseAudio before the 4.0 freeze, which is quite soon.
>
> It's rather a new feature, so I'll push it to 3.10.

That's fine. Did you apply v2 of the patch(es)?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
