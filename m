Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FA5CD4840
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2026 18:16:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F353601E0;
	Mon, 11 May 2026 20:16:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F353601E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778523407;
	bh=hcXsjUNe20y0tkTtEUgfsFVHdCSG340W8tKgpDF0370=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gMN5qVoKxV2AoRo4FPw1ub3NnFJ81Zab0IWbBPC0j6/RrQ86UNnQK1X7aogEC748T
	 EP+zw3mHJXXdD8GBa0b2k/lKHFxP9fwNx7JRXK/iYOEBN0IEnrdeFwCoBfmeHYAUe5
	 vkx5NBIqbQ5D3ulIVSJTQS99IuIbyAyEcwcosFFs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8991DF805EA; Mon, 11 May 2026 20:16:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 33FC9F805E7;
	Mon, 11 May 2026 20:16:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0D1EAF80535; Mon, 11 May 2026 20:16:07 +0200 (CEST)
Received: from mail.furst.blue (mail.furst.blue [194.164.54.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3B723F80171
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2026 20:16:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B723F80171
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=furst.blue header.i=@furst.blue header.a=rsa-sha256
 header.s=dkim-rsa header.b=cGClr1Zc;
	dkim=pass header.d=furst.blue header.i=@furst.blue header.a=ed25519-sha256
 header.s=dkim-ed25519 header.b=9s/FTygM
Received: from k8s-mail.magi.furst.blue (unknown [192.168.208.130])
	by mail.furst.blue (Postfix) with ESMTPS id 8AFEB400FC;
	Mon, 11 May 2026 18:16:04 +0000 (UTC)
Message-ID: <0dac82c6-da2a-4026-b528-51f64462a895@furst.blue>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=furst.blue;
 s=dkim-rsa;
	t=1778523364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w+PTDZYr7LFaZPrlTKzk6sxRXgzWcHbj2wKeWJPxVfA=;
	b=cGClr1Zcxj/1+R4QtcwrKtvzxLfCdnchD57NYk3iAsRkpoOlDFlB0O0mbR8gWcrZqeIeYE
	q0yUq8DGcy+GzrhMML7MDVBFo+3g4q2XGJW3ZpvnlYjCm+kjK+uF0Wz078DkB6XqSKxH7+
	l0Fo/TJGIfnizvQ5+1B7VfSTf8lxGWGZkCamE+1bVsPGnbTlMALwTR5UrBdQgpmGbtJFZV
	5ojFpzrSQJrY1FZCKlkZmubME4AuMzv7HButcaumN6eFXIFnnrgOwggV4Kgig7va/zIsCu
	+avR4z5uy4Yb3L47S+/4qCs9u+olTIEM5ROkOPeaVXSQQ+7A4bsEQtEZwx6lXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=furst.blue;
	s=dkim-ed25519; t=1778523364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w+PTDZYr7LFaZPrlTKzk6sxRXgzWcHbj2wKeWJPxVfA=;
	b=9s/FTygM3/MkWwda3MNf0onbZQHJhOvmPovJSHXDQJI30JGy0Zu1Cy6IXNBwXbRcW9ckUj
	IXP/uDyMLXo+SKDQ==
Date: Mon, 11 May 2026 20:16:03 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for HP 255 15.6 inch G9
 Notebook PC
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, perex@perex.cz
References: <20260507202754.16114-1-seal@furst.blue>
Content-Language: en-US
From: =?UTF-8?Q?F=C3=BCrst_Blumier?= <seal@furst.blue>
Autocrypt: addr=seal@furst.blue; keydata=
 xjMEZnGe2hYJKwYBBAHaRw8BAQdAOX5vCJ+QnmVReHfH8+NqkzBFvIcTR42RIeIHoY9CZaXN
 HmZ1cnN0Ymx1bWllciA8c2VhbEBmdXJzdC5ibHVlPsKZBBMWCgBBAhsDBQkJZgGABQsJCAcC
 AiICBhUKCQgLAgQWAgMBAh4HAheAFiEE89i5w6ekW/F8ZbsfVKkhrDknlWUFAmZxqpYACgkQ
 VKkhrDknlWV1oQEAgnWTswdAkkcwNZNXo0LAtfsleOB5okUFr0fEseRLJwsBAI3Og5dDSpNQ
 1xIa05iJAzg/1+C3AfNfU4us8qoFGgMAzjgEZnGe2hIKKwYBBAGXVQEFAQEHQIUNNfN1ae50
 Q/RQzKsy0fr5wJWjLE4xPmT+L3SLHUBFAwEIB8J+BBgWCgAmFiEE89i5w6ekW/F8ZbsfVKkh
 rDknlWUFAmZxntoCGwwFCQlmAYAACgkQVKkhrDknlWUx4AD/WRXlSkp2ELGoagn60sUAcEyV
 8Tia5gYmym097VCItxkA/29NIlwUo+f9LUaIwa+GAclV85NpA4l2xS6gIErXu7wE
In-Reply-To: <20260507202754.16114-1-seal@furst.blue>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: VEXFRTC6FABIQSPDXAVXG6V7QHAZA5S2
X-Message-ID-Hash: VEXFRTC6FABIQSPDXAVXG6V7QHAZA5S2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VEXFRTC6FABIQSPDXAVXG6V7QHAZA5S2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

Sorry, this is my first time contributing to a project like this, so it 
looks like my message body is missing and I just submitted the patch. 
Please bear with me and let me know if I did anything wrong.

This patch fixes an issue with the headphone jack detection on my HP 255 
15.6 inch G9 Notebook PC. Specifically with this patch plugging and 
unplugging the headphone jack now correctly switches audio sinks on 
pulseaudio and also fixes the LED of the mute button not lighting up at all.

This has been tested on my own hardware under kernel 7.0.3-arch1-2. If 
you need any more information or need me to change something please let 
me know!

Thank you for your time and work.

On 5/7/26 10:27 PM, furstblumier wrote:
> Signed-off-by: furstblumier <seal@furst.blue>
> ---
>   sound/hda/codecs/realtek/alc269.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
> index 11d0ea8ed..08c8b17b7 100644
> --- a/sound/hda/codecs/realtek/alc269.c
> +++ b/sound/hda/codecs/realtek/alc269.c
> @@ -7063,6 +7063,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
>   	SND_PCI_QUIRK(0x103c, 0x89da, "HP Spectre x360 14t-ea100", ALC245_FIXUP_HP_SPECTRE_X360_EU0XXX),
>   	SND_PCI_QUIRK(0x103c, 0x89e7, "HP Elite x2 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
>   	SND_PCI_QUIRK(0x103c, 0x8a0f, "HP Pavilion 14-ec1xxx", ALC287_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8a1b, "HP 255 15.6 inch G9 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
>   	SND_PCI_QUIRK(0x103c, 0x8a1f, "HP Laptop 14s-dr5xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
>   	SND_PCI_QUIRK(0x103c, 0x8a20, "HP Laptop 15s-fq5xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
>   	SND_PCI_QUIRK(0x103c, 0x8a25, "HP Victus 16-d1xxx (MB 8A25)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
