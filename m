From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: ALSA problems with 2.6.18-rc3
Date: Wed, 09 Aug 2006 14:17:55 -0400
Message-ID: <200608091417.55431.gene.heskett@verizon.net>
References: <44D8F3E5.5020508@ukonline.co.uk> <44DA0D93.2080307@ukonline.co.uk>
 <1155141333.26338.186.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751294AbWHISR7@vger.kernel.org>
In-reply-to: <1155141333.26338.186.camel@mindpipe>
Content-disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Benton <b3nt@ukonline.co.uk>, Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wednesday 09 August 2006 12:35, Lee Revell wrote:
>On Wed, 2006-08-09 at 17:30 +0100, Andrew Benton wrote:
>> Lee Revell wrote:
>> > Please try to identify the change that introduced the regression. 
>> > What was the last kernel/ALSA version that worked correctly?
>>
>> The change happened between 2.6.17 and 2.6.18-rc1. Specifically,
>> 2.6.17-git4 works and 2.6.17-git5 doesn't.
>
>Takashi-san,
>
>Does this help at all?  Many users are reporting that sound broke with
>2.6.18-rc*.
>
>Lee
>
Takashi-san's suggestion earlier today of running an "alsactl -F restore" 
seems to have fixed all those diffs right up, I now have good sound with 
an emu10k1 using an audigy 2 as card-0, running kernel-2.6.18-rc4.

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
