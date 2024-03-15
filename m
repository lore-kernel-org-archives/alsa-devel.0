Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87BFC54E60
	for <alsa-devel@archiver.kernel.org>; Sun, 17 Mar 2024 09:05:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F3D82392;
	Sun, 17 Mar 2024 10:05:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F3D82392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1710666322;
	bh=7+fJfBST5IdB1sgP/eTQYRwwxuAf0nFH5htcIsMtVUI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=h4acGZ4ILPMJd0XTUSNb0FNnEHfOXLccYlLalS+rQOaYyN1DU4R0LzkOK149Ho+Nz
	 UXhDLvuVxkvDIzs518WrQvT82Y8QSOEkh5FvugjiR67LzgTfDhQBtrQTlcWIjmCnA7
	 dUZOH/9aINrGLY8ht4MGIOYGfJvRY7l65NhCKoD8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 30584F80570; Sun, 17 Mar 2024 10:03:08 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BE128F806D1;
	Sun, 17 Mar 2024 10:03:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D11E1F8028D; Fri, 15 Mar 2024 15:45:30 +0100 (CET)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 657CEF80093
	for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2024 15:45:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 657CEF80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=KWDBifJA
Received: by mail.gandi.net (Postfix) with ESMTPSA id A85231BF20C;
	Fri, 15 Mar 2024 14:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710513925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCzVTi/8qiIkWIQuMQeabN+Upuh5rS0d0MiWy39obn8=;
	b=KWDBifJAeamjCj4tFGXOKgrfAdJ+TaLvUBsIFlZSmEqiozMYaPqkiTjZKk+6rPwCnKloM7
	tCnUNg4sxFveR6d7CK8E47hqVzEvvypk7BtvNEW3jHLxBdCOrFXrO4s1KNYGVjvxZEtkMX
	SA29cZrOEH6nQ3hGtJ69pjG0SxbvbDwb+F4naOcJKjsU2SIdcr2AkLJwa8m/kJkxkdBZob
	ZovQHltOeOJMR00N20S1O4tlOMtDtJ/TCRtE3PUQAk3MpBehBg1GMFLROjSzPG/u3J2VzW
	OYDeQ+H/rCftP6Mfp7AA0EOz9xvxO/DjZj7Xg9PnMTgpKXCe3mNbtvKDYJUFXA==
Message-ID: <13faa6c8-ad4f-4f81-935a-5ea74621d373@bootlin.com>
Date: Fri, 15 Mar 2024 15:45:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] ASoC: ti: davinci-i2s: Enable unexpected frame
 pulses detection
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Ujfalusi
 <peter.ujfalusi@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, herve.codina@bootlin.com,
 christophercordahi@nanometrics.ca
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
 <20240315112745.63230-10-bastien.curutchet@bootlin.com>
 <51866f62-460d-4035-bcf1-b9f03cf9be0b@sirena.org.uk>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <51866f62-460d-4035-bcf1-b9f03cf9be0b@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: bastien.curutchet@bootlin.com
X-MailFrom: bastien.curutchet@bootlin.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: YUNGBNTUI4SNYA4IZVTAOR3V2XYZ2O6W
X-Message-ID-Hash: YUNGBNTUI4SNYA4IZVTAOR3V2XYZ2O6W
X-Mailman-Approved-At: Sun, 17 Mar 2024 08:56:29 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YUNGBNTUI4SNYA4IZVTAOR3V2XYZ2O6W/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Mark,

On 3/15/24 15:09, Mark Brown wrote:
> On Fri, Mar 15, 2024 at 12:27:41PM +0100, Bastien Curutchet wrote:
> 
>> McBSP can generate an SYNCERR when unexpected frame pulses are
>> detected. The driver always disables this feature and ignore the
>> unexpected frame pulses.
> 
> What does "unexpected" mean?

Unexpected frame sync pulse is defined in datasheet as a sync pulse that 
occurs <N> bit clocks earlier than the last transmitted bit of the 
previous frame. The <N> can be configured through registers.

> 
>> Enable the generation of SYNCERR by the McBSP according to the
>> 'ti,enable-sync-err' device-tree property.
> 
> Why would this be optional, and how is this reported - I'm not seeing
> any interrupt handling updates?

It is possible to deliberately ignore them and that is what is done 
today in the driver.
This is reported as a status bit in a register. An interrupt can indeed 
be generated from this but I'm not using it (now at least).
I use the fact that McBSP automatically drops previous element and 
starts a new reception when an unexpected frame pulse occurs.


Best regards,
Bastien
