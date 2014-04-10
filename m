From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: move alc892 to patch_alc882
Date: Thu, 10 Apr 2014 09:30:03 +0800
Message-ID: <CAN8cciZs1uOhB+J-aLC3HWCt+xcddLL8qYWKw5YcKfYrF_E_1Q@mail.gmail.com>
References: <2259125E6B6048C7B3DB0DD2F5BBD60D@realtek.com.tw>
 <CAN8ccibu5kUnZoSbYXXZitXABzPA7C2SXvTZYanJoDDbekVCgA@mail.gmail.com>
 <s5hsipqdh4n.wl%tiwai@suse.de>
 <5C8998C298284925B0366DDAC8B6717F@realtek.com.tw>
 <s5hmwfxmt5o.wl%tiwai@suse.de>
 <A1BA38FF1354405FAD7D43DEC4C1DEC8@realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f48.google.com (mail-qa0-f48.google.com
 [209.85.216.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D300261693
 for <alsa-devel@alsa-project.org>; Thu, 10 Apr 2014 03:30:05 +0200 (CEST)
Received: by mail-qa0-f48.google.com with SMTP id s7so2714521qap.7
 for <alsa-devel@alsa-project.org>; Wed, 09 Apr 2014 18:30:04 -0700 (PDT)
In-Reply-To: <A1BA38FF1354405FAD7D43DEC4C1DEC8@realtek.com.tw>
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

>>>
>>>
>>> > At Sat, 5 Apr 2014 14:52:24 +0800,
>>> > Raymond Yau wrote:
>>> >> >> Hi Takashi,
>>> >> >> >
>>> >> > The original was patch to patch_alc662.
>>> >> > Move it into patch_alc882.
>>> >> >
>>> >> >
>>> >> is there any reason not including those PCI QUIRK for alc892 ?
>>> > > Because it's not clarified why this must be applied.
>>> > I'm waiting for the updated patch from Kailang.
>>> >
>>> Sorry!
>>> I just aligned the channel count.
>>> So, move the alc892 to patch_alc882.
>>
>>
>> As I already asked, could you resubmit the patch with the proper
>> changelog?  You have to clarify why the patch is needed and how it's
>> solved in the patch changelog.
>>
>
> Yes, but it maybe doesn't solve any thing.
> But I remember I solve 8ch issue which run for patch_alc882.
> I will check alc892 for run with patch_alc882.

The driver seem assume unique PCI ssid but it seem  gigabyte motherboards
use same ssid  0x1458, 0xa002

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/patch_realtek.c?id=b2c53e206967d01fd4fb6dd525f89ae738beb2e6

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/patch_realtek.c?id=78f8baf138311be3e170526388b0530a172bdbff

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/patch_realtek.c?id=8f2392142346f2754c8292a94cc62a157ed1e093
