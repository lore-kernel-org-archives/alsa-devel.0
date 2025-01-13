Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6209E77188
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jan 2025 08:52:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2283160287;
	Tue, 14 Jan 2025 09:52:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2283160287
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1736844773;
	bh=cNfKGnLXy9xh6jNlIjsSKM/lH49C7ButJrc9pNjIok0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=HQtaFzCmTF/hXidzrOuvRt9PYC+TCB7n/H3gsy2Rvot5DPjxoTx22IPW/wWgJDsMU
	 3O7B7f7/3ml/IG+XPIYGx1vyHyLm0VB/Gj2sbKNOtRw7OI0Nx0PGLyifEZavcNFFJD
	 AGJPHV99xbd5HnmsKeENfUxusCMWuk9A/MmQwdmc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 31FD4F805AF; Tue, 14 Jan 2025 09:52:06 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F2576F805E9;
	Tue, 14 Jan 2025 09:52:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4285CF8024C; Mon, 13 Jan 2025 17:24:37 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 83465F800ED
	for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2025 17:24:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83465F800ED
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=eaa6WZSH
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aaeef97ff02so737121166b.1
        for <alsa-devel@alsa-project.org>;
 Mon, 13 Jan 2025 08:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736785460; x=1737390260;
 darn=alsa-project.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4RNMXJoSlNAsDthEL7GrP8/twpDoJdm/wqZQmG0HeqM=;
        b=eaa6WZSHOB9fT+qPsmA9RpFbAdC/VKXWkH6N729OdU6VUytCVgYq/nWhCObO+edFTI
         qEsKq8sYluOO04IEaclI4d8crHEZ7/Cc0wy/4tFL5X9eMX+Opir7OSlZZQQBpENB8mt8
         pz3B80Q6CkS0m56gMbHL2LzzJHf/Q7u0x4QTImO82jEea2LckOnVGIMyiBJ28mSRt/yO
         Nyyx2qOG1OXRpWtwbHmSxjljKh2SVywFkmIE4Y2CA1U10mRrNbuf9n9BzI+NsK9E6x8J
         yZ0lx9CUnu8wBjMKfvCSSOn/tmtWsv4lNQSu4lXLxqOQavTw6VWYYGuDzdbXXhjN3xLU
         ntew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736785460; x=1737390260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4RNMXJoSlNAsDthEL7GrP8/twpDoJdm/wqZQmG0HeqM=;
        b=H44yM3u+9HS17U83dj6n4yjbWRCrvsnAqOr/aCIwHiA5Tph6kPVB2vXffD6pXWoggz
         w+zJ1AEgpViB6x4sp6yR25RUxKOMeRLJgnCeubvQuBbyN3LzSdaxlYVADgdT9NoMK8Bm
         ZHCyayzHFa/M4Uxw/R9v6WXW0luhaxhm1i101z0tzIYxYhQ0o8d85HEGCxXa86TcZhB2
         iGDHLcILw+0Yv9WG6RUsj9EabcMGbwGvL7SNFnCTS0jL5Z+mL4SEdoZZm7KHf45iEO1+
         /lojWu0g1RzMAQAzTEoRCH/HmJDEeVIYSAIcGOeunYEGIH6ndLEHewwXzYZeRFB2JDV8
         XzWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv/3lFgrtkGCDCMV7I0ylHQ6NCqg++GvLVrISsyEPZZ4BabBxPGd3/9LTpiAi4TtDVZm7ASLXqZ+jZ@alsa-project.org
X-Gm-Message-State: AOJu0YyXqsRF5TNoNy2J0GFSbTEjjhWNPrRfD6AmPe/SM5TrSgSWsVUp
	UiU/msF6cW/aHSwFNJg4QXir0eAj3yltvdnhaKtBX9WXEHaeYpBy
X-Gm-Gg: ASbGncskFU6k1aGYAW5bOEP2OkbqQtg39yP48rHWI5dwVBty3XFP9oSqo7BsvGTQgbk
	7Cd/O3WM3e8yincpawNrRAeFXB+3FA8BKh023Val9HLRr4AjnYE2HibLx8qcPBp26bxJZqjndKd
	1MSmKZYier5pqvpt4R1gsJWbAkrsgcioI8ClGbqwtL8XyeNWM9z1JjnPsUD861IvBD6XnX5Ymy5
	rzz98Hum0heK6/EeWQ2npZ/2oYCDYKL6f3gouKtaMVD7KSINzq8LNW3T3mdUFCmCmXiMw==
X-Google-Smtp-Source: 
 AGHT+IGj2Ek+R+vKBPVyf74QZTI0MH2EW+YfhMRR26E+09AjC6EgU3PutjaTzgoz2yBN27NVfWVPMw==
X-Received: by 2002:a17:907:7faa:b0:aa6:832b:8d76 with SMTP id
 a640c23a62f3a-ab2ab6766c4mr2053667366b.12.1736785459950;
        Mon, 13 Jan 2025 08:24:19 -0800 (PST)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ab2c95647efsm518799966b.117.2025.01.13.08.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 08:24:19 -0800 (PST)
Message-ID: <9cc6c2ad-0811-482d-91c8-d162bd7f09f4@gmail.com>
Date: Mon, 13 Jan 2025 18:24:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] soc: audio-graph-card2: use correct endpoint when
 getting link parameters
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, tony@atomide.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Pavel Machek <pavel@ucw.cz>, Merlijn Wajer <merlijn@wizzup.org>
References: <20241220071126.1066691-1-ivo.g.dimitrov.75@gmail.com>
 <db8321e3-e9c8-4f1e-8ebd-78d286320d55@gmail.com>
 <f4a65ffc-7f0d-4d45-83b9-2377cb00f3b1@sirena.org.uk>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <f4a65ffc-7f0d-4d45-83b9-2377cb00f3b1@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MailFrom: ivo.g.dimitrov.75@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: B7DNQOW7FDPOPGEKTGWWDC4OLCLXD4HG
X-Message-ID-Hash: B7DNQOW7FDPOPGEKTGWWDC4OLCLXD4HG
X-Mailman-Approved-At: Tue, 14 Jan 2025 08:51:47 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/B7DNQOW7FDPOPGEKTGWWDC4OLCLXD4HG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,


On 13.01.25 г. 15:40 ч., Mark Brown wrote:
> On Mon, Jan 13, 2025 at 07:55:30AM +0200, Ivaylo Dimitrov wrote:
>> ping
> 
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so
> on so unless there is some reason for urgency (like critical bug fixes)
> please allow at least a couple of weeks for review.  If there have been
> review comments then people may be waiting for those to be addressed.
> 
> Sending content free pings adds to the mail volume (if they are seen at
> all) which is often the problem and since they can't be reviewed
> directly if something has gone wrong you'll have to resend the patches
> anyway, so sending again is generally a better approach though there are
> some other maintainers who like them - if in doubt look at how patches
> for the subsystem are normally handled.
> 
> Please don't top post, reply in line with needed context.  This allows
> readers to readily follow the flow of conversation and understand what
> you are talking about and also helps ensure that everything in the
> discussion is being addressed.

I understand people are busy, but I also see community sent patches 
being treated with low priority, or being silently ignored too often 
lately, but lets not go into that.

I sent that RFC patch on 20.12.2024, today is 13.10.2025 - if this is 
not a reasonable time, well, what is? By the same time I sent 2 other 
patches and they are already in -next. In the meanwhile I see patches 
sent in the morning to be reviewed till the end of the day - not 
critical bugfixes patches but new functionality.

Also, I don't understand how the ping was content free, given that it 
was on top of the original patch, unless I don't get what "content free" 
is supposed to mean, possible, I am not native English speaker.


Regards,
Ivo
