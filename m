Return-Path: <SRS0=bexm=YQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831E9CA9EB6
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:07:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BCFB2084C
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="M5rY80SL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCFB2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 00A8C84C;
	Wed, 23 Oct 2019 12:06:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 00A8C84C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571825235;
	bh=kAWI0Dn8d11iBK5+ZF/UzRbA8SPNfn3HOKn5RKM2fJk=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M5rY80SLxVKE858d65wWLuhw7SBbsPKmR7alEyk/SiT8NYGhLNls7xYW8ZjnafoRo
	 yTH+nCROqdhBWYGpWHgDkl+9XVSlB2ymEd8hRLxVIMK06rvuK/235ObKvwsvojQS0y
	 8amNWzfpAGnwMrUku1r4uBtmMe3svc/68aabFlY8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 86272F80321;
	Wed, 23 Oct 2019 12:06:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3BB42F80368; Wed, 23 Oct 2019 12:06:23 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7184AF80112
 for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2019 12:06:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7184AF80112
Received: from [114.245.47.48] (helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <aaron.ma@canonical.com>)
 id 1iNDX0-0006Qg-9r; Wed, 23 Oct 2019 10:06:18 +0000
To: Kailang <kailang@realtek.com>, Takashi Iwai <tiwai@suse.de>
References: <20191022153855.14368-1-aaron.ma@canonical.com>
 <s5hpniodaq4.wl-tiwai@suse.de> <848ebd7fd86e4c05936e70f500f718e9@realtek.com>
From: Aaron Ma <aaron.ma@canonical.com>
Autocrypt: addr=aaron.ma@canonical.com; prefer-encrypt=mutual; keydata=
 mQENBFffeLkBCACi4eE4dPsgWN6B9UDOVcAvb5QgU/hRG6yS0I1lGKQv4KA+bke0c5g8clbO
 9gIlIl2bityfA9NzBsDik4Iei3AxMbFyxv9keMwcOFQBIOZF0P3f05qjxftF8P+yp9QTV4hp
 BkFzsXzWRgXN3r8hU8wqZybepF4B1C83sm2kQ5A5N0AUGbZli9i2G+/VscG9sWfLy8T7f4YW
 MjmlijCjoV6k29vsmTWQPZ7EApNpvR5BnZQPmQWzkkr0lNXlsKcyLgefQtlwg6drK4fe4wz0
 ouBIHJEiXE1LWK1hUzkCUASra4WRwKk1Mv/NLLE/aJRqEvF2ukt3uVuM77RWfl7/H/v5ABEB
 AAG0IUFhcm9uIE1hIDxhYXJvbi5tYUBjYW5vbmljYWwuY29tPokBNwQTAQgAIQUCV994uQIb
 AwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDNxCzQfVU6ntJ9B/9aVy0+RkLqF9QpLmw+
 LAf1m3Fd+4ZarPTerqDqkLla3ekYhbrEtlI1mYuB5f+gtrIjmcW27gacHdslKB9YwaL8B4ZB
 GJKhcrntLg4YPzYUnXZkHHTv1hMw7fBYw82cBT+EbG0Djh6Po6Ihqyr3auHhfFcp1PZH4Mtq
 6hN5KaDZzF/go+tRF5e4bn61Nhdue7mrhFSlfkzLG2ehHWmRV+S91ksH81YDFnazK0sRINBx
 V1S8ts3WJ2f1AbgmnDlbK3c/AfI5YxnIHn/x2ZdXj1P/wn7DgZHmpMy5DMuk0gN34NLUPLA/
 cHeKoBAF8emugljiKecKBpMTLe8FrVOxbkrauQENBFffeLkBCACweKP3Wx+gK81+rOUpuQ00
 sCyKzdtMuXXJ7oL4GzYHbLfJq+F+UHpQbytVGTn3R5+Y61v41g2zTYZooaC+Hs1+ixf+buG2
 +2LZjPSELWPNzH9lsKNlCcEvu1XhyyHkBDbnFFHWlUlql3nSXMo//dOTG/XGKaEaZUxjCLUC
 8ehLc16DJDvdXsPwWhHrCH/4k92F6qQ14QigBMsl75jDTDJMEYgRYEBT1D/bwxdIeoN1BfIG
 mYgf059RrWax4SMiJtVDSUuDOpdwoEcZ0FWesRfbFrM+k/XKiIbjMZSvLunA4FIsOdWYOob4
 Hh0rsm1G+fBLYtT+bE26OWpQ/lSn4TdhABEBAAGJAR8EGAEIAAkFAlffeLkCGwwACgkQzcQs
 0H1VOp6p5Af/ap5EVuP1AhFdPD3pXLNrUUt72W3cuAOjXyss43qFC2YRjGfktrizsDjQU46g
 VKoD6EW9XUPgvYM+k8BJEoXDLhHWnCnMKlbHP3OImxzLRhF4kdlnLicz1zKRcessQatRpJgG
 NIiD+eFyh0CZcWBO1BB5rWikjO/idicHao2stFdaBmIeXvhT9Xp6XNFEmzOmfHps+kKpWshY
 9LDAU0ERBNsW4bekOCa/QxfqcbZYRjrVQvya0EhrPhq0bBpzkIL/7QSBMcdv6IajTlHnLARF
 nAIofCEKeEl7+ksiRapL5Nykcbt4dldE3sQWxIybC94SZ4inENKw6I8RNpigWm0R5w==
Message-ID: <892889ae-0ce1-fbf6-d19f-50a5686e84c2@canonical.com>
Date: Wed, 23 Oct 2019 18:06:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <848ebd7fd86e4c05936e70f500f718e9@realtek.com>
Content-Language: en-US
Cc: "hui.wang@canonical.com" <hui.wang@canonical.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [alsa-devel] [PATCH] ALSA: hda/realtek - Fix 2 front mics of
	codec 0x623
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 10/23/19 4:44 PM, Kailang wrote:
> 
> 
>> -----Original Message-----
>> From: Takashi Iwai <tiwai@suse.de>
>> Sent: Wednesday, October 23, 2019 12:08 AM
>> To: Aaron Ma <aaron.ma@canonical.com>
>> Cc: perex@perex.cz; Kailang <kailang@realtek.com>;
>> hui.wang@canonical.com; alsa-devel@alsa-project.org;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] ALSA: hda/realtek - Fix 2 front mics of codec 0x623
>>
>> On Tue, 22 Oct 2019 17:38:55 +0200,
>> Aaron Ma wrote:
>>>
>>> These 2 ThinkCentres installed a new realtek codec ID 0x623, it has 2
>>> front mics with the same location on pin 0x18 and 0x19.
>>>
>>> Apply fixup ALC283_FIXUP_HEADSET_MIC to change 1 front mic location to
>>> right, then pulseaudio can handle them.
>>> One "Front Mic" and one "Mic" will be shown, and audio output works
>>> fine.
>>>
>>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
>>
>> I'd like to have Kailang's review about the new codec before applying.
>>
>> Kailang, could you take a look?
> OK.
> I will post you the patch for ALC623 codec tomorrow.
> Thanks.

Cc me too.

Thank you.
Aaron

> 
>>
>>
>> thanks,
>>
>> Takashi
>>
>>> ---
>>>  sound/pci/hda/patch_realtek.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/sound/pci/hda/patch_realtek.c
>>> b/sound/pci/hda/patch_realtek.c index b000b36ac3c6..c34d8b435f58
>>> 100644
>>> --- a/sound/pci/hda/patch_realtek.c
>>> +++ b/sound/pci/hda/patch_realtek.c
>>> @@ -7186,6 +7186,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[]
>> = {
>>>  	SND_PCI_QUIRK(0x17aa, 0x312f, "ThinkCentre Station",
>> ALC294_FIXUP_LENOVO_MIC_LOCATION),
>>>  	SND_PCI_QUIRK(0x17aa, 0x313c, "ThinkCentre Station",
>> ALC294_FIXUP_LENOVO_MIC_LOCATION),
>>>  	SND_PCI_QUIRK(0x17aa, 0x3151, "ThinkCentre Station",
>>> ALC283_FIXUP_HEADSET_MIC),
>>> +	SND_PCI_QUIRK(0x17aa, 0x3178, "ThinkCentre Station",
>> ALC283_FIXUP_HEADSET_MIC),
>>> +	SND_PCI_QUIRK(0x17aa, 0x3176, "ThinkCentre Station",
>>> +ALC283_FIXUP_HEADSET_MIC),
>>>  	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80",
>> ALC269_FIXUP_DMIC_THINKPAD_ACPI),
>>>  	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210",
>> ALC283_FIXUP_INT_MIC),
>>>  	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70",
>>> ALC269_FIXUP_DMIC_THINKPAD_ACPI), @@ -9187,6 +9189,7 @@ static
>> const struct hda_device_id snd_hda_id_realtek[] = {
>>>  	HDA_CODEC_ENTRY(0x10ec0298, "ALC298", patch_alc269),
>>>  	HDA_CODEC_ENTRY(0x10ec0299, "ALC299", patch_alc269),
>>>  	HDA_CODEC_ENTRY(0x10ec0300, "ALC300", patch_alc269),
>>> +	HDA_CODEC_ENTRY(0x10ec0623, "ALC623", patch_alc269),
>>>  	HDA_CODEC_REV_ENTRY(0x10ec0861, 0x100340, "ALC660",
>> patch_alc861),
>>>  	HDA_CODEC_ENTRY(0x10ec0660, "ALC660-VD", patch_alc861vd),
>>>  	HDA_CODEC_ENTRY(0x10ec0861, "ALC861", patch_alc861),
>>> --
>>> 2.17.1
>>>
>>
>> ------Please consider the environment before printing this e-mail.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
