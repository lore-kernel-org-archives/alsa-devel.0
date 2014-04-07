From: Kailang <kailang@realtek.com>
Subject: Re: move alc892 to patch_alc882
Date: Mon, 7 Apr 2014 17:19:21 +0800
Message-ID: <A1BA38FF1354405FAD7D43DEC4C1DEC8@realtek.com.tw>
References: <2259125E6B6048C7B3DB0DD2F5BBD60D@realtek.com.tw><CAN8ccibu5kUnZoSbYXXZitXABzPA7C2SXvTZYanJoDDbekVCgA@mail.gmail.com><s5hsipqdh4n.wl%tiwai@suse.de><5C8998C298284925B0366DDAC8B6717F@realtek.com.tw>
 <s5hmwfxmt5o.wl%tiwai@suse.de>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id CDF5E26087B
 for <alsa-devel@alsa-project.org>; Mon,  7 Apr 2014 11:19:27 +0200 (CEST)
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



> At Mon, 7 Apr 2014 14:04:34 +0800,
> Kailang wrote:
>> 
>> 
>> > At Sat, 5 Apr 2014 14:52:24 +0800,
>> > Raymond Yau wrote:
>> >> 
>> >> Hi Takashi,
>> >> 
>> >> >
>> >> > The original was patch to patch_alc662.
>> >> > Move it into patch_alc882.
>> >> >
>> >> >
>> >> is there any reason not including those PCI QUIRK for alc892 ?
>> > 
>> > Because it's not clarified why this must be applied.
>> > I'm waiting for the updated patch from Kailang.
>> > 
>> 
>> Sorry!
>> I just aligned the channel count.
>> So, move the alc892 to patch_alc882.
> 
> As I already asked, could you resubmit the patch with the proper
> changelog?  You have to clarify why the patch is needed and how it's
> solved in the patch changelog.
>

Yes, but it maybe doesn't solve any thing.
But I remember I solve 8ch issue which run for patch_alc882.
I will check alc892 for run with patch_alc882.
Thanks.

> 
> Takashi
> 
> 
>> 
>> > 
>> > Takashi
>> > 
>> > ------Please consider the environment before printing this e-mail.
>>
