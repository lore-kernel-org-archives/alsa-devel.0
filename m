From: "Alexander Beregalov" <a.beregalov@gmail.com>
Subject: Re: [PATCH] sound/pci: supported cards update
Date: Wed, 13 Aug 2008 12:33:17 +0400
Message-ID: <a4423d670808130133p73317fd9u630ed47de2236c37@mail.gmail.com>
References: <20080812201443.GB12411@orion> <s5hhc9pl3vp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.229])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D1D924462
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Aug 2008 10:33:18 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 36so2340135wra.24
	for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2008 01:33:17 -0700 (PDT)
In-Reply-To: <s5hhc9pl3vp.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2008/8/13 Takashi Iwai <tiwai@suse.de>:
> At Wed, 13 Aug 2008 00:14:43 +0400,
> Alexander Beregalov wrote:
>>
>> diff --git a/sound/pci/ice1712/wtm.c b/sound/pci/ice1712/wtm.c
>> index a08d17c..784dfd4 100644
>> --- a/sound/pci/ice1712/wtm.c
>> +++ b/sound/pci/ice1712/wtm.c
>> @@ -508,7 +508,7 @@ struct snd_ice1712_card_info snd_vt1724_wtm_cards[] __devinitdata = {
>>       {
>>               .subvendor = VT1724_SUBDEVICE_WTM,
>>               .name = "ESI Waveterminal 192M",
>> -             .model = "WT192M",
>> +             .model = "wt192m",
>
> This change causes a regression when user already used this string.
> Keep it as is.
Right, but this name gets out from style of models naming in ice1712/.
Is it possible to fix it and how we can do it?
