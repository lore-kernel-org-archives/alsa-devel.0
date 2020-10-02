Return-Path: <SRS0=qvVP=DJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD4CC4363D
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Oct 2020 09:19:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9E91206A5
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Oct 2020 09:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Gd4oxOal";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="t3N97mEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E91206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D456219FF;
	Fri,  2 Oct 2020 11:19:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D456219FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601630394;
	bh=WiqDOspKjgdxUTdcJANhY/x2hhcH3f2kcjJuf5BxYho=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gd4oxOaloviZbbyXxUpYxH1/jwVs19tHP2/okyxDzXP1agDbV6Nwoa4Y2d4+/N861
	 8dkLXsk3SHEWppEPWWEcNxt3I4NmpFirlvvOaSSUX88GOuT3+8ndvXfos0sXbAIxqZ
	 B4tsKvGaL4DprziGsQPKIVodLkyDKzYvzfgQs/XI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2EC12F801A3;
	Fri,  2 Oct 2020 11:19:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 86ADFF801F9; Fri,  2 Oct 2020 11:19:02 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A44EF801A3
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2020 11:18:52 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 931F9A003E;
 Fri,  2 Oct 2020 11:18:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 931F9A003E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1601630331; bh=vH5bk14pBl7deg6sCuCkKRwOpZPcUNic2gXWFCEF4QA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=t3N97mEjdBWhYNHy8Lji+QPXqzowxkeQkJFGdQwjeyDowdNQsRY/hzYheYHYnluZi
 Ln3P+j0HKpEwHtE5DKlAxAryMH4tpX2C/hAqX5E0S/ZObPVtTifLdifUrvQV3BRsaw
 T/WbJevzYQ6xYcw43Dc0B9po66rY0vftc3rfoIao=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri,  2 Oct 2020 11:18:46 +0200 (CEST)
Subject: Re: [PATCH] ALSA: usb-audio: fix spelling mistake "Frequence" ->
 "Frequency"
To: Takashi Iwai <tiwai@suse.de>, Colin King <colin.king@canonical.com>
References: <20181125231208.14350-1-colin.king@canonical.com>
 <s5hmupw6y6l.wl-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <8ee34833-7867-f559-0656-b4f34ea6d006@perex.cz>
Date: Fri, 2 Oct 2020 11:18:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <s5hmupw6y6l.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

Dne 26. 11. 18 v 9:27 Takashi Iwai napsal(a):
> On Mon, 26 Nov 2018 00:12:08 +0100,
> Colin King wrote:
>>
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> There are spelling mistakes in equalizer name fields, fix them.
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> In general, it's not good to rename the control names even if they are
> fixes.  But these are rather device-specific ones, and they are EQ's,
> which aren't too fatal to change, so I took it as-is now.

It seems that this patch has not found a way to kernel. It is present
in #master at git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git,
but it is not present in linux-next.

					Thanks,
						Jaroslav

> 
> 
> thanks,
> 
> Takashi
> 
> 
>> ---
>>  sound/usb/mixer_us16x08.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/sound/usb/mixer_us16x08.c b/sound/usb/mixer_us16x08.c
>> index 26ed23b18b77..4f594f9552a8 100644
>> --- a/sound/usb/mixer_us16x08.c
>> +++ b/sound/usb/mixer_us16x08.c
>> @@ -1119,7 +1119,7 @@ static const struct snd_us16x08_control_params eq_controls[] = {
>>  		.control_id = SND_US16X08_ID_EQLOWFREQ,
>>  		.type = USB_MIXER_U8,
>>  		.num_channels = 16,
>> -		.name = "EQ Low Frequence",
>> +		.name = "EQ Low Frequency",
>>  	},
>>  	{ /* EQ mid low gain */
>>  		.kcontrol_new = &snd_us16x08_eq_gain_ctl,
>> @@ -1133,7 +1133,7 @@ static const struct snd_us16x08_control_params eq_controls[] = {
>>  		.control_id = SND_US16X08_ID_EQLOWMIDFREQ,
>>  		.type = USB_MIXER_U8,
>>  		.num_channels = 16,
>> -		.name = "EQ MidLow Frequence",
>> +		.name = "EQ MidLow Frequency",
>>  	},
>>  	{ /* EQ mid low Q */
>>  		.kcontrol_new = &snd_us16x08_eq_mid_width_ctl,
>> @@ -1154,7 +1154,7 @@ static const struct snd_us16x08_control_params eq_controls[] = {
>>  		.control_id = SND_US16X08_ID_EQHIGHMIDFREQ,
>>  		.type = USB_MIXER_U8,
>>  		.num_channels = 16,
>> -		.name = "EQ MidHigh Frequence",
>> +		.name = "EQ MidHigh Frequency",
>>  	},
>>  	{ /* EQ mid high Q */
>>  		.kcontrol_new = &snd_us16x08_eq_mid_width_ctl,
>> @@ -1175,7 +1175,7 @@ static const struct snd_us16x08_control_params eq_controls[] = {
>>  		.control_id = SND_US16X08_ID_EQHIGHFREQ,
>>  		.type = USB_MIXER_U8,
>>  		.num_channels = 16,
>> -		.name = "EQ High Frequence",
>> +		.name = "EQ High Frequency",
>>  	},
>>  };
>>  
>> -- 
>> 2.19.1
>>
>>


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
