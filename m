From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: move alc892 to patch_alc882
Date: Thu, 10 Apr 2014 09:44:49 +0800
Message-ID: <CAN8cciYzHn78zmZBbYt-k6CW+EpD+PDPDu+AUR_zaG8xLcmZWA@mail.gmail.com>
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
Received: from mail-qg0-f42.google.com (mail-qg0-f42.google.com
 [209.85.192.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 65276261A40
 for <alsa-devel@alsa-project.org>; Thu, 10 Apr 2014 03:44:50 +0200 (CEST)
Received: by mail-qg0-f42.google.com with SMTP id q107so3266672qgd.15
 for <alsa-devel@alsa-project.org>; Wed, 09 Apr 2014 18:44:49 -0700 (PDT)
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
> Thanks.
>

AFAIK, 8ch is not yet supported by generic driver for those desktop
motherboard

1) with 5 jacks at rear panel  (retask line in as side)
2) 10 channel codec with 3 jacks at rear panel(retask front HP as side)
