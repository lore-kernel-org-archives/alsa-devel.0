From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Remove speaker clicks on
	CX20549
Date: Mon, 18 Feb 2013 10:22:19 +0100
Message-ID: <5121F2CB.7000504@canonical.com>
References: <1360838199-3906-1-git-send-email-david.henningsson@canonical.com>
 <s5hd2w3upmk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B6D88264F07
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 10:22:21 +0100 (CET)
In-Reply-To: <s5hd2w3upmk.wl%tiwai@suse.de>
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

On 02/14/2013 12:00 PM, Takashi Iwai wrote:
> At Thu, 14 Feb 2013 11:36:39 +0100,
> David Henningsson wrote:
>>
>> This chip needs the speaker pin to go to D3 to avoid clicks,
>> so default_power_filter does not work here.
>>
>> This was found on Thinkpad R61i/T61i but I guess it applies to
>> the entire chip. If not, quirks should be set for at least
>> PCI SSID 17aa:20ac.
>>
>> Thanks to c4pp4 for testing.
>>
>> BugLink: https://bugs.launchpad.net/bugs/886975
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>
> Thanks, applied now.
>
> Just wonder, though, whether rather setting
> spec->gen.power_down_unused = 1 works.  When it's set, the generic
> parser applies the own power filter, and it doesn't have the EAPD
> check either (plus it does more aggressive power-down of unused
> widgets).
>
> Or, maybe we just drop the EAPD check, and move it to specific fixup.
> AFAIK, it was required only for old Gateway laptops.

If gen.power_down_unused is what is believed to get the best power 
savings (by powering down more sub-areas of the chip), maybe a 
reasonable strategy to be to carefully move towards making 
gen.power_down_unused the default, first for the stuff that we have hw 
for and can test, or the new chips that we add, and if that works out 
fine we could try activate it for older chips too.

What do you think?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
