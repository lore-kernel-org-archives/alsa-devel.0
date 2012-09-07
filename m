From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Remove ignore_misc_bit
Date: Fri, 07 Sep 2012 13:26:35 +0200
Message-ID: <5049D9EB.5070301@canonical.com>
References: <1346995544-6754-1-git-send-email-david.henningsson@canonical.com>
 <s5hligmw3s0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id CC3BA2616BD
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2012 13:26:36 +0200 (CEST)
In-Reply-To: <s5hligmw3s0.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, 939161@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

On 09/07/2012 12:01 PM, Takashi Iwai wrote:
> At Fri,  7 Sep 2012 07:25:44 +0200,
> David Henningsson wrote:
>>
>> The purpose of this flag is unclear. If the problem is that some machines
>> have broken misc/NO_PRESENCE bits, they should be fixed by pin fixups.
>>
>> In addition, this causes jack detection functionality to be flawed on
>> the M31EI, where there are two jacks without jack detection (which is
>> properly marked as NO_PRESENCE), but due to ignore_misc_bit, these
>> jacks are instead being reported as being present but always unplugged.
>>
>> BugLink: https://bugs.launchpad.net/bugs/939161
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>
> So this will fix this one case but will break some others certainly.
> It's a difficult to judge, but more removal is better, so I'll take
> this.

Ok. Do you have a sense for how many machines that will regress due to 
this patch? If it is common to set all pins to the wrong value, maybe 
its the M31EI that is the exception.

> But I still wonder why PulseAudio cares the headphone jack state even
> though this has only one output at all?

When seeing the system as a whole, there can be other outputs on other 
cards - HDMI, USB etc. If somebody e g plugs a USB headset in it will be 
simpler for the user if PulseAudio does not also show the unplugged 3.5 
mm jack.



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
