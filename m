From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: move alc892 to patch_alc882
Date: Wed, 9 Apr 2014 12:53:48 +0800
Message-ID: <CAN8cciaUMQgc_gq7Pm8HfU41PcQUDjMDwAhMQ5DfWXPO0Hkb4g@mail.gmail.com>
References: <2259125E6B6048C7B3DB0DD2F5BBD60D@realtek.com.tw>
 <CAN8ccibu5kUnZoSbYXXZitXABzPA7C2SXvTZYanJoDDbekVCgA@mail.gmail.com>
 <s5hsipqdh4n.wl%tiwai@suse.de>
 <5C8998C298284925B0366DDAC8B6717F@realtek.com.tw>
 <s5hmwfxmt5o.wl%tiwai@suse.de>
 <A1BA38FF1354405FAD7D43DEC4C1DEC8@realtek.com.tw>
 <CAN8cciZDRX5ocMsQY2HEps5kBHyYytzku5KMRi2qJE7Ok0L5Bg@mail.gmail.com>
 <CD6BB756DB7E4CE5BE9458B1523DBC82@realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f182.google.com (mail-qc0-f182.google.com
 [209.85.216.182])
 by alsa0.perex.cz (Postfix) with ESMTP id C7158261A74
 for <alsa-devel@alsa-project.org>; Wed,  9 Apr 2014 06:53:49 +0200 (CEST)
Received: by mail-qc0-f182.google.com with SMTP id e16so2219774qcx.13
 for <alsa-devel@alsa-project.org>; Tue, 08 Apr 2014 21:53:48 -0700 (PDT)
In-Reply-To: <CD6BB756DB7E4CE5BE9458B1523DBC82@realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kailang <kailang@realtek.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>>>> >> >> >
>>>> >> > The original was patch to patch_alc662.
>>>> >> > Move it into patch_alc882.
>>>> >> >
>>>> >> >
>>>> >> is there any reason not including those PCI QUIRK for alc892 ?
>>>> > > Because it's not clarified why this must be applied.
>>>> > I'm waiting for the updated patch from Kailang.
>>>> >
>>>> Sorry!
>>>> I just aligned the channel count.
>>>> So, move the alc892 to patch_alc882.
>>>
>>>
>>>
>>> As I already asked, could you resubmit the patch with the proper
>>> changelog?  You have to clarify why the patch is needed and how it's
>>> solved in the patch changelog.
>>>
>>
>> Yes, but it maybe doesn't solve any thing.
>> But I remember I solve 8ch issue which run for patch_alc882.
>> I will check alc892 for run with patch_alc882.
>> Thanks.
>>
>
>>
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/patch_realtek.c?id=e16fb6d1408bca0c0b36d490688eba3dc924b1fd
>
>
>> + { 0x10ec0892, 0xffff, 0x8020, "ALC661" },
>> + { 0x10ec0892, 0xffff, 0x8011, "ALC661" },
>> + { 0x10ec0892, 0xffff, 0x4011, "ALC656" },
>> Seem some codec were renamed as alc661 and alc656
>
>
> Yes, it's the same body. IC mark shows different.
>

Can the driver assume all desktop with alc8xx codecs support multistreaming
playback ?

It seem that alc6xx does not support multistreaming playback
