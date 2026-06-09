Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F870CD8CAD
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2026 18:40:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 92559601D2;
	Tue,  9 Jun 2026 20:40:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 92559601D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781030448;
	bh=UpiXHEBEm42qzWTrO7+SRmpywJkZnQ85pgUerIaCJ3w=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=GDIuQnP1um8684Rww6BUHGY0gXZrYHSUGMWsSmiOuEWpGZJhpul0EDn5h7OcZZPYf
	 tY16Ub7tVg1GcvDz0EvoE8DRd7WqU/QezrV3mc2q6tCIX+Y3ZO2AO6MG/vNHbo2skB
	 aOrHrC8Ir9ckfYC2xb4VyHtUSee7sdmlG860gfgE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2952CF805FB; Tue,  9 Jun 2026 20:40:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D9560F80448;
	Tue,  9 Jun 2026 20:40:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 101EFF80496; Tue,  9 Jun 2026 20:40:09 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=194.164.54.141
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781030408;
	b=jNC0Y8HxMpm+VaaHb2QRTxyCb7fyoJb1uGBCzA0nSXDUSBTrj43DqfFts/FXn+Co8W4W
	 82+pA6gnMdWzA3guFNsGuu3JrOp58GhaUCY2+Y1FgQZ4cx9Z7MlN6C+wG2gp1FmQpsMVK
	 nmdn0ZAX3ieidviR8o/kG8oblmVnmddvX8P4ftU5w8XG0CnwIw8Yq4czdaZ6IVyi7Hy2X
	 +jTQlZuSXB+lRNNpuUc/f8UdaYQ4A76XWT/mdNc6k5KpXu+2k2gff+o8YFG3oxafFJTlH
	 F0ULLxI6dTHFn9krvN+IfTIydNBecG+pkUh0muP/lmCJ+Za5nKJQ1NRRR6J/nyF3FYw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781030408;
	h=Message-ID:DKIM-Signature:DKIM-Signature:Date:MIME-Version:Subject:
	 From:To;
	bh=UpiXHEBEm42qzWTrO7+SRmpywJkZnQ85pgUerIaCJ3w=;
	b=knq3/oscjYiRqAZUDjb7NwwySOb6NTzkuuuOJ122G+7tzfbDljAq74cvfup78Cbrud7p
	 865YkZ7KSQNp5MmnVytXriJOwvl0gQoMGjDui0L7vh84Qrsab9y9GGVNWICDQpNJcQWr2
	 DA08LSxU3AzymvwMMNWa+vIJbpaYTU51SrUz6nJlSPeus2+TN2/ozOeJDSgPKE65O34S3
	 hsjuPAZZMw1BceCyArkKpVoaJMRUBX+xuhb/rk1gh70Nqc+vjNk6lmra3QGmDcbEX/H5k
	 la/oBl6zUqoAojPwb4F8yGkroxXVBZczLgL0ZDkYkXtHzrPM7ZLPRZEvZNH6fw3hdyw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=furst.blue header.i=@furst.blue header.a=ed25519-sha256
 header.s=dkim-ed25519 header.b=b6P8rvKG;
	dkim=pass header.d=furst.blue header.i=@furst.blue header.a=rsa-sha256
 header.s=dkim-rsa header.b=OMEut6d0;
	arc=none smtp.remote-ip=194.164.54.141
Received: from mail.furst.blue (mail.furst.blue [194.164.54.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2DFACF801F5
	for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2026 20:40:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2DFACF801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass header.d=furst.blue header.i=@furst.blue header.a=ed25519-sha256
 header.s=dkim-ed25519 header.b=b6P8rvKG;
	dkim=pass (2048-bit key,
 unprotected) header.d=furst.blue header.i=@furst.blue header.a=rsa-sha256
 header.s=dkim-rsa header.b=OMEut6d0
Received: from k8s-mail.magi.furst.blue (unknown [192.168.208.120])
	by mail.furst.blue (Postfix) with ESMTPS id 69D0440100;
	Tue,  9 Jun 2026 18:40:06 +0000 (UTC)
Message-ID: <49b6cb61-c543-4406-97b6-359f17df4ecf@furst.blue>
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=furst.blue;
	s=dkim-ed25519; t=1781030405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WfVC72U8nzHtw68Khio/RtLNpAjjngr6uRPvUkBE0fI=;
	b=b6P8rvKGrsR/OzyPk8Jer5skqo9EEc+lanCdH1+x/vTUUBqJuhbKEqJ8qGuTgqg7e8hEqb
	kAdD13qsgDVoqvDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=furst.blue;
 s=dkim-rsa;
	t=1781030405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WfVC72U8nzHtw68Khio/RtLNpAjjngr6uRPvUkBE0fI=;
	b=OMEut6d0usu5o/uQ6DP1maRyLa0LVM5KXlDswRSZ/t2oKmmkvI5/qiETz5a6jeuBySuvye
	iE2UytouXHHgggnhVSL6j0XlTHQAE3GAsjXq6RirOIAPFC3y+/Fm5h/bNbFjQeXFjSg5BD
	dZ/dc10oVuYrm1D72mEcWC6TWZaTkUTw+WQHyhIc6Zp6J9HzabjM1ulo/icFkfb1aT3684
	vDF2oVCDZaxB6e33lWy9OTAMwMxGj9OeeFAIXTba0vwZuipwEh8IKAsnv1XPCRF93388pC
	ZFHnda3855qXIpHBYUJTv9/X8Uxh2/od4wC3mBp9d/vjioWOx9cfQglHVM9l1w==
Date: Tue, 9 Jun 2026 20:40:04 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for HP 255 15.6 inch G9
 Notebook PC
From: =?UTF-8?Q?F=C3=BCrst_Blumier?= <seal@furst.blue>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, perex@perex.cz
References: <20260507202754.16114-1-seal@furst.blue>
 <0dac82c6-da2a-4026-b528-51f64462a895@furst.blue>
Content-Language: en-US
Autocrypt: addr=seal@furst.blue; keydata=
 xjMEZnGe2hYJKwYBBAHaRw8BAQdAOX5vCJ+QnmVReHfH8+NqkzBFvIcTR42RIeIHoY9CZaXN
 HmZ1cnN0Ymx1bWllciA8c2VhbEBmdXJzdC5ibHVlPsKZBBMWCgBBAhsDBQkJZgGABQsJCAcC
 AiICBhUKCQgLAgQWAgMBAh4HAheAFiEE89i5w6ekW/F8ZbsfVKkhrDknlWUFAmZxqpYACgkQ
 VKkhrDknlWV1oQEAgnWTswdAkkcwNZNXo0LAtfsleOB5okUFr0fEseRLJwsBAI3Og5dDSpNQ
 1xIa05iJAzg/1+C3AfNfU4us8qoFGgMAzjgEZnGe2hIKKwYBBAGXVQEFAQEHQIUNNfN1ae50
 Q/RQzKsy0fr5wJWjLE4xPmT+L3SLHUBFAwEIB8J+BBgWCgAmFiEE89i5w6ekW/F8ZbsfVKkh
 rDknlWUFAmZxntoCGwwFCQlmAYAACgkQVKkhrDknlWUx4AD/WRXlSkp2ELGoagn60sUAcEyV
 8Tia5gYmym097VCItxkA/29NIlwUo+f9LUaIwa+GAclV85NpA4l2xS6gIErXu7wE
In-Reply-To: <0dac82c6-da2a-4026-b528-51f64462a895@furst.blue>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID-Hash: I35L6QU5OTLJU74O26LGWH4E5JEZW6LC
X-Message-ID-Hash: I35L6QU5OTLJU74O26LGWH4E5JEZW6LC
X-MailFrom: seal@furst.blue
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/I35L6QU5OTLJU74O26LGWH4E5JEZW6LC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

I haven't heard back in a month about this so I wanted to ask if there 
are any changes you'd like to see or if I have to submit the patch 
differently, since this is the first time I'm contributing here.

If you'd like me to resubmit the patch, I can do that as well. Thank you 
for your work!

Best,

Fürst Blumier

On 5/11/26 8:16 PM, Fürst Blumier wrote:
> Hi,
>
> Sorry, this is my first time contributing to a project like this, so 
> it looks like my message body is missing and I just submitted the 
> patch. Please bear with me and let me know if I did anything wrong.
>
> This patch fixes an issue with the headphone jack detection on my HP 
> 255 15.6 inch G9 Notebook PC. Specifically with this patch plugging 
> and unplugging the headphone jack now correctly switches audio sinks 
> on pulseaudio and also fixes the LED of the mute button not lighting 
> up at all.
>
> This has been tested on my own hardware under kernel 7.0.3-arch1-2. If 
> you need any more information or need me to change something please 
> let me know!
>
> Thank you for your time and work.
>
> On 5/7/26 10:27 PM, furstblumier wrote:
>> Signed-off-by: furstblumier <seal@furst.blue>
>> ---
>>   sound/hda/codecs/realtek/alc269.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/sound/hda/codecs/realtek/alc269.c 
>> b/sound/hda/codecs/realtek/alc269.c
>> index 11d0ea8ed..08c8b17b7 100644
>> --- a/sound/hda/codecs/realtek/alc269.c
>> +++ b/sound/hda/codecs/realtek/alc269.c
>> @@ -7063,6 +7063,7 @@ static const struct hda_quirk 
>> alc269_fixup_tbl[] = {
>>       SND_PCI_QUIRK(0x103c, 0x89da, "HP Spectre x360 14t-ea100", 
>> ALC245_FIXUP_HP_SPECTRE_X360_EU0XXX),
>>       SND_PCI_QUIRK(0x103c, 0x89e7, "HP Elite x2 G9", 
>> ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
>>       SND_PCI_QUIRK(0x103c, 0x8a0f, "HP Pavilion 14-ec1xxx", 
>> ALC287_FIXUP_HP_GPIO_LED),
>> +    SND_PCI_QUIRK(0x103c, 0x8a1b, "HP 255 15.6 inch G9 Notebook PC", 
>> ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
>>       SND_PCI_QUIRK(0x103c, 0x8a1f, "HP Laptop 14s-dr5xxx", 
>> ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
>>       SND_PCI_QUIRK(0x103c, 0x8a20, "HP Laptop 15s-fq5xxx", 
>> ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
>>       SND_PCI_QUIRK(0x103c, 0x8a25, "HP Victus 16-d1xxx (MB 8A25)", 
>> ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
