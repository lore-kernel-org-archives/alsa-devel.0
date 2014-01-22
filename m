From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC PATCH] ALSA: hda - Detect codecs on Intel
	DZ77SL-50K
Date: Wed, 22 Jan 2014 13:25:34 +0100
Message-ID: <52DFB8BE.6060005@canonical.com>
References: <1390390348-11745-1-git-send-email-david.henningsson@canonical.com>
 <s5hd2jkfdn7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CD97265066
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 13:25:34 +0100 (CET)
In-Reply-To: <s5hd2jkfdn7.wl%tiwai@suse.de>
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
Cc: kulkarniniraj@rediffmail.com, alsa-devel@alsa-project.org, 1155202@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

On 01/22/2014 12:40 PM, Takashi Iwai wrote:
> At Wed, 22 Jan 2014 12:32:28 +0100,
> David Henningsson wrote:
>>
>> From: Niraj <kulkarniniraj@rediffmail.com>
>>
>> Apparently this board seems to need some extra initialization before a proper
>> codec probe value can be read.
>>
>> BugLink: https://bugs.launchpad.net/bugs/1155202
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>> ---
>>  sound/pci/hda/hda_intel.c |    6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> Hi Takashi,
>>
>> Here's a patch from Niraj, which has found this code below to make audio work
>> on the Intel DZ77SL-50K board. Without it, no codecs will be detected.
>>
>> I'm not sure if you like it this way or if you want me or Niraj to change
>> anything, or debug further. Or maybe add a new quirk for this particular device?
> 
> Of course, I don't like this :)
> 
> The patch essentially disables the codec reset in *all* cases after a
> codec is probed.  This smells badly of a future regression.

Hmm, but I don't see how the patch *disables* any codec reset. It only
does an *extra* controller reset in some cases.

> FWIW, you can set a forced codec probe mask in probe_mask_list[].
> The bit 0x100 means to force the detection.

Yes, we tried this and it did not help. If the codecs do not show up
naturally in STATETS, then they cannot be communicated with either.

> But, before going that direction, could you clarify how this fixes the
> probing at all?  Which azx_init_chip() calls hinders the probing of an
> active codec?

It seems more like, the particular chip or board requires a special
quirky initialization sequence.

> 
> 
> thanks,
> 
> Takashi
> 
>>
>> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> index fa2879a..2bf46e9 100644
>> --- a/sound/pci/hda/hda_intel.c
>> +++ b/sound/pci/hda/hda_intel.c
>> @@ -1306,6 +1306,12 @@ static void azx_init_chip(struct azx *chip, int full_reset)
>>  
>>  	/* reset controller */
>>  	azx_reset(chip, full_reset);
>> +	if (!chip->codec_mask) {
>> +		azx_writel(chip, GCTL, 0x100);
>> +		while(azx_readl(chip, GCTL) != 0x0);
>> +		azx_writel(chip, GCTL, 0x1);
>> +		azx_reset(chip, full_reset);
>> +	}
>>  
>>  	/* initialize interrupts */
>>  	azx_int_clear(chip);
>> -- 
>> 1.7.9.5
>>
> 



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
