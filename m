From: Kailang <kailang@realtek.com>
Subject: Re: Restore default value for alc283
Date: Tue, 18 Mar 2014 14:29:01 +0800
Message-ID: <759D52FCC5AB4BD694448E265AF4F3F1@realtek.com.tw>
References: <D81AAF74416842738C1CABAFD266B47A@realtek.com.tw><s5hmwgpt9on.wl%tiwai@suse.de><99206B7BABC942DC81FB1A88A4633B8F@realtek.com.tw>
 <s5hiorcdo9f.wl%tiwai@suse.de>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 19816261A99
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 07:29:03 +0100 (CET)
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

Hi Takashi,

alc282 had two fixed.
1. depop for D0/D3.
2. Restore default value for alc282

Could i create two patches or just merge in one patch?
Many Thanks.

BR,
Kailang

> At Tue, 18 Mar 2014 11:25:43 +0800,
> Kailang wrote:
>> 
>> Hi Takashi,
>> 
>> Sorry!
>> I can't find the record in 
>> http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/log/.
>> Could you know why?
> 
> I waited for the test result in bug 71861.
>   https://bugzilla.kernel.org/show_bug.cgi?id=71861
> Now it's pushed out.
> 
> 
> thanks,
> 
> Takashi
> 
>> 
>> BR,
>> Kailang
>> 
>> 
>> > At Mon, 17 Mar 2014 14:23:24 +0800,
>> > Kailang wrote:
>> >>
>> >> Hi Takashi,
>> >>
>> >> Attachment is the patch for fix below issue.
>> >>
>> >> Restore the registers to prevent the abnormal digital power supply
>> >> rising ratio/sequence to the codec and causing the incorrect default
>> >> codec register restoration during initialization.
>> >
>> > Thanks, applied.
>> >
>> >
>> > Takashi
>> >
>> >>
>> >> Many Thanks.
>> >>
>> >> BR,
>> >> Kailang
>> >> [2 0000-restore-default-for-alc283.patch <application/octet-stream 
>> >> (quoted-printable)>]
>> >>
>> >
>> > ------Please consider the environment before printing this e-mail. 
>> 
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
