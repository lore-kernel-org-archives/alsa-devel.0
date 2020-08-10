Return-Path: <SRS0=hypa=BU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812A3C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Aug 2020 06:35:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F11172065C
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Aug 2020 06:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NMM056NQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F11172065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7A16015F2;
	Mon, 10 Aug 2020 08:34:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7A16015F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597041346;
	bh=RtYdiWmqtP/gclysvZtx/PjjFyrJQm7m/24cYtVGNHg=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NMM056NQqx3wKmp//y6pGg3MHnlVF6MKxQGHNZDZmv/rmebm2s6UE4oMwmgjTE5MR
	 1BtatJ1GCneWm8qbYetjdOoLy46iwQzyQ1u7JEVz4ZH4E0icFDLcEGHilixtIkU773
	 9977sCEdJl4kMrzaAqJZMMmp5HTLbAJtKkOj+qMk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 19C87F801DB;
	Mon, 10 Aug 2020 08:34:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AB951F8022B; Mon, 10 Aug 2020 08:34:55 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0306F80085
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2020 08:34:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0306F80085
Received: from [114.253.245.60] (helo=[192.168.0.104])
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1k51OP-0007Gs-Gk; Mon, 10 Aug 2020 06:34:45 +0000
Subject: Re: [PATCH] ALSA: hda - fix the micmute led status for Lenovo
 ThinkCentre AIO
To: Takashi Iwai <tiwai@suse.de>
References: <20200810021659.7429-1-hui.wang@canonical.com>
 <s5hd03z6min.wl-tiwai@suse.de>
From: Hui Wang <hui.wang@canonical.com>
Message-ID: <c8ca5bd3-d9a1-6269-e088-6bc6e3936876@canonical.com>
Date: Mon, 10 Aug 2020 14:34:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <s5hd03z6min.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


On 2020/8/10 下午2:30, Takashi Iwai wrote:
> On Mon, 10 Aug 2020 04:16:59 +0200,
> Hui Wang wrote:
>> After installing the Ubuntu Linux, the micmute led status is not
>> correct. Users expect that the led is on if the capture is disabled,
>> but with the current kernel, the led is off with the capture disabled.
>>
>> We tried the old linux kernel like linux-4.15, there is no this issue.
>> It looks like we introduced this issue when switching to the led_cdev.
> The behavior can be controlled via "Mic Mute-LED Mode" enum kcontrol.
> Which value does it have now?  If it's "Follow Capture", that's the
> correct behavior.  OTOH, if it's "Follow Mute", the LED polarity is
> indeed wrong.

It is "Follow Mute",  if I change it to "Follow Capture" manually, the 
led status becomes correct.

Thanks.

>
>
> thanks,
>
> Takashi
>
>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>> ---
>>   sound/pci/hda/patch_realtek.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>> index daedcc0adc21..09d93dd88713 100644
>> --- a/sound/pci/hda/patch_realtek.c
>> +++ b/sound/pci/hda/patch_realtek.c
>> @@ -4414,6 +4414,7 @@ static void alc233_fixup_lenovo_line2_mic_hotkey(struct hda_codec *codec,
>>   {
>>   	struct alc_spec *spec = codec->spec;
>>   
>> +	spec->micmute_led_polarity = 1;
>>   	alc_fixup_hp_gpio_led(codec, action, 0, 0x04);
>>   	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
>>   		spec->init_amp = ALC_INIT_DEFAULT;
>> -- 
>> 2.17.1
>>
