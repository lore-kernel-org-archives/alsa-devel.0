Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84A5C6FD1F
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Mar 2024 14:08:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D0EA279C;
	Wed, 20 Mar 2024 15:07:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D0EA279C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1710943682;
	bh=Y6mEQ/hFHTShTOWNUHTojQ/qnx61oBbZk6LyN0SEfHM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=PaM+x+3o38zrDneuDCwO2iJqqjy46mM3UovCOkwIvC15yY2vBwl9jaXjkagAf3Kn+
	 3Mxtuwsy2UJO4TdC/lPI01kobh7MmGEoGQ8XAcTnhWJEcg9mCfLvNQ7DZlxErONR/3
	 pk75JncwrGtduwqzABqOJi+XpDT05Y8PxGsaMOS4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0C211F897D0; Wed, 20 Mar 2024 15:01:07 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B98FF897E6;
	Wed, 20 Mar 2024 15:01:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 75A49F804E7; Wed, 20 Mar 2024 09:52:50 +0100 (CET)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::225])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id ABF3CF80088
	for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2024 09:52:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ABF3CF80088
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=d5+yCEKF
Received: by mail.gandi.net (Postfix) with ESMTPSA id E68581C000D;
	Wed, 20 Mar 2024 08:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710924758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxoLGnpPdcI2kqvbcSNFfRIJr6iOEENAEB9wuOb1S70=;
	b=d5+yCEKFkAGewcctxM5DOA0phfHQIWulV63wZ7RifzHZ74xKJxu2hr/yHHcVexxkmJz564
	ueoVBoSPeJ84KVaE5hidOSM6p51WiderjDbSZHUwDBvbrAvDwpX+Tsrmst6Wl95/EwE4ZW
	rOxG33jRYTGdF3pDl65J9e2UOB17D7l+djRToJRh3x+A0+kCKO1lvMbzUE+W+N6c2msjSu
	L7UV4T6ir0s6IhaFcRbIPa3bp9PLejvORCQ7xjYQJEWiXjMaJmDRCqx7rz13ol0EceEjJe
	kUNDmRWVVWXtJEUopKTaDVNb3moXPR7RXtIuDiNXQwaNs6OeyRFMyPAc4Lf+JA==
Message-ID: <0bb26153-8bcb-475f-8892-5eb925fec538@bootlin.com>
Date: Wed, 20 Mar 2024 09:52:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] ASoC: ti: davinci-i2s: Opitonally drive DX pin
 during capture streams
Content-Language: en-US
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, herve.codina@bootlin.com,
 christophercordahi@nanometrics.ca
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
 <20240315112745.63230-14-bastien.curutchet@bootlin.com>
 <00182d1d-ef29-457f-9e3e-6e9b57592118@gmail.com>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <00182d1d-ef29-457f-9e3e-6e9b57592118@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com
X-MailFrom: bastien.curutchet@bootlin.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: JOQAWHNJT3QGC53MYJOVMV3MIPGSWBRV
X-Message-ID-Hash: JOQAWHNJT3QGC53MYJOVMV3MIPGSWBRV
X-Mailman-Approved-At: Wed, 20 Mar 2024 13:59:42 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JOQAWHNJT3QGC53MYJOVMV3MIPGSWBRV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Péter,

On 3/19/24 19:29, Péter Ujfalusi wrote:
> 
> 
> On 15/03/2024 13:27, Bastien Curutchet wrote:
>> The McBSP's DX pin that outputs serial data during playback streams can
>> be used during capture streams to repeatedly output a chosen pattern.
>> For instance, this can be useful to drive an active-low signal during
>> captures (by choosing <0> as output pattern).
> 
> Are there really any other use of this than to pull down or up the DX
> pin (0 or 0xffff)
I don't know, indeed today I can only think about these two patterns.
I tried to do something in a 'generic' way so it can evolve if needed.

> If you just use the pin as GPIO then you don't need to change anything
> in the driver, The playback would not erach the pin, so no need to block it.
> 
>> Enable this behaviour when the device-tree property 'ti,drive-dx' is
>> present. DX pin is driven with the provided pattern every time a
>> capture stream is launched.
> 
> It is an interesting use of the hardware... You are controlling an
> external device (light an LED when capture is on)?

Yes I control the chip select pin of the ADC that is sending data to DR 
pin, that's why I need the DX pin to be synchronized with capture
streams.

>> This property is not compatible with classic playback stream so
>> davinci_i2s_trigger() returns an error if a playback stream is started
>> while 'ti,drive-dx' flag is present.
> 
> Propbaly add the .startup() callback and block the playback right there?
> 

Ok, TBH my mastery of the sound subsystem is not high enough to have an
opinion of where this should go so I'll trust you on this.

>>
>> This has been tested on a board designed of a DAVINCI/OMAP-L138 where
>> the DX pin is linked to the chip select pin of the converters of the
>> capture side.
> 
> Isn't the DX will be pulled down as soon as the McBSP is enabled?
> Can you just re-configure the PUPD_SEL for the pin group to make the pin
> to be pulled the other way?
> 

Well, the acquisition chain in my use case is a bit convoluted. The DX
pin's main purpose is to drive ADC chip select but it is also connected
to other components and all this needs synchronization upon captures.


I'll integrate your feedback about the code in next iteration, thank
you.


Best regards,
Bastien
