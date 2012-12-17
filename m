From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Fix clicking noise on Thinkpad
	T61/R61i
Date: Mon, 17 Dec 2012 16:33:10 +0100
Message-ID: <50CF3B36.2050906@canonical.com>
References: <1355331724-2758-1-git-send-email-david.henningsson@canonical.com>
 <s5hr4mvdwfa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 20BEA264F3C
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2012 16:33:12 +0100 (CET)
In-Reply-To: <s5hr4mvdwfa.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, 886975@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

On 12/12/2012 06:15 PM, Takashi Iwai wrote:
> At Wed, 12 Dec 2012 18:02:04 +0100,
> David Henningsson wrote:
>>
>> The bug reporter reports that setting the speaker pin to
>> D3 before turning off its pinctl fixes the clicking noise on
>> powersave for Thinkpad T61.
>>
>> Thanks to c4pp4 for doing most of the work with this bug, including
>> reporting and testing, and writing preliminary patches.
>>
>> BugLink: https://bugs.launchpad.net/bugs/886975
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>> ---
>>   sound/pci/hda/patch_conexant.c |   36 ++++++++++++++++++++++++++++++++----
>>   1 file changed, 32 insertions(+), 4 deletions(-)
>>
>> Note: c4pp4 pointed out that in his case, only the speaker needed to go to
>> D3 before pinctl, but noticed no regressions from the below implementation,
>> so I made the fixup more generic (easier to reuse later).
>
> Well, if going to D3 is already achieved there, there is no point to
> call snd_hda_shutup_pins().  snd_hda_shutup_pins() itself is for
> reducing the click noise while the codec is going down to D3.
>
> Thus, for this particular machine, simply disable
> snd_hda_shutup_pins() call from suspend, and make D3 call in
> reboot_notify.

Looking at the bug report, c4pp4 has just reported back that reverting 
the old commit 697c373e34613609cb5 improves the situation - there are 
less clicks compared to the current situation.

Quoting c4pp4 below:

"The patch [697c373e34613609cb5] in fact caused click noise hell because 
the initial click noise is still alive and in addition there were born 
new click noises, louder click noise and double click noise. They start 
to appear when using power-save mode, when suspending computer and when 
rebooting computer."

So maybe revert that patch?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
