Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E166FC25B7A
	for <alsa-devel@archiver.kernel.org>; Wed, 15 May 2024 13:05:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5862F84D;
	Wed, 15 May 2024 15:05:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5862F84D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1715778338;
	bh=rPRT0MsdY9af2mGauqLnrYy4g8q//Ph0rBvWLrVQuCs=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=tUo1BDczJy2AbGbsAutqsI3mkExn5yag+Kp25nqksghEYf1kDcDpbr3018a413AJF
	 TVWps2YO7i80IISjt8Wu2qP/Bzt3mXiRGh+2AeLwBf7NGtLUWv5972taWlAx8yoBw6
	 OcGDmoRNxz39oqBL86fr0wndR866yIXzF/nYHw9o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B5212F805AA; Wed, 15 May 2024 15:05:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C71EF8057E;
	Wed, 15 May 2024 15:05:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B89C0F80224; Wed, 15 May 2024 15:03:35 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E0139F800E2
	for <alsa-devel@alsa-project.org>; Wed, 15 May 2024 15:03:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E0139F800E2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=baylibre-com.20230601.gappssmtp.com
 header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256
 header.s=20230601 header.b=G2a5Ke7a
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41fc2f7fbb5so37857575e9.1
        for <alsa-devel@alsa-project.org>;
 Wed, 15 May 2024 06:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715778194;
 x=1716382994; darn=alsa-project.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=vlvP4Aa3+nQGmGgcIFiojH5cc2twOueCv7IOqtUVD84=;
        b=G2a5Ke7ahRWFAlLBWOhRFo3fLm4T31FzJXYF1lIzXM57dTQC2arlVCKSxWSKSLWiI4
         8sIijom8n3yOaN//NK0NzHqujeDLAbO4ceBBQz5xYMYyPaFC7p8iQSsIkPn12mJDUWN6
         WxVWNL9e1zXD5SE1jJGUKEGGpmTUxCY1fmeK6ExBFnWiga2AqVy/UZQXRXw41SO+iqco
         BvDJrueOJHxC7jbg39TW3vGiSUlqAQHQcOKP1hif6Q3NjFzlHZCleVH8h27fSLH4P8c+
         tpFn88Psqof+WjbqJ5TX60OzaW93MqRxh9Z4+05BPyWwYPrEfTAqeE0b+x/s5wgdRi8F
         RKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715778194; x=1716382994;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlvP4Aa3+nQGmGgcIFiojH5cc2twOueCv7IOqtUVD84=;
        b=LBei1fyJ06bVZBmHGqUUqkpVAow1t0u0sDMI+VjqLDYMq9x73O4kZSk0nNRcukMLvs
         tOrK97GT2qK/MR8xA1/+crdmz371/64y6tYgc/DLZxBY7kT0YS102+3gGbSjaxrKgwAw
         pZLjHtcL37oeMSKSiOZot3DRILgiiaZVcHl0lWc8IW4drBNrHTqLFwXwuzE/RfEe6bMR
         xRDSNfFZE8P5ZixxrbDUn+tvmwVj4aEDtf0LWy2w7+eZx5tB3LtRKU6VXBtzrw3OIJbc
         Z1t2nxsysS5lqrzFvjysZLHB68RclMPRvcKJItZfz/TeNcShf6hXPeX5SBsgDAAqvvmo
         /JdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzYlLdHpvJ8Nn1ZKd2svYXeZvRIRMAbhhl8mxI0pS/OD2rMjEfnbyGF47NtBMJmClzUhMBixBPFUpTwb7VZuaR7esdzz9H0Nrg/Ow=
X-Gm-Message-State: AOJu0Yzd/EBmT4v7gBfCEQFcuArhuA7FJKngv1BqTKRgv9OvocjtWg8p
	94fmuny7/u8ixmhp3Q3h4frRYTJyOFkxr4AyFbFETlbmwdrKA0d6XjhNmuFc3E4=
X-Google-Smtp-Source: 
 AGHT+IFd1u7hHWUOgkLnsccx8x9MoqmA5KeoD0+FaBvMmlYandqrEjUD4CsLZc7fApcCVFV1xfjlyg==
X-Received: by 2002:a05:600c:4f06:b0:418:2981:c70f with SMTP id
 5b1f17b1804b1-41fbcfb8473mr168925435e9.19.1715778194502;
        Wed, 15 May 2024 06:03:14 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:2893:1a8f:5988:776a])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccbe9011sm232644255e9.7.2024.05.15.06.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 06:03:13 -0700 (PDT)
References: <87o79azh65.wl-kuninori.morimoto.gx@renesas.com>
 <20240514143116.3824376-1-jbrunet@baylibre.com>
 <46daae9b-10dc-4f49-8a25-c387d03ae87a@sirena.org.uk>
 <87seyk2dmh.wl-kuninori.morimoto.gx@renesas.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>,
 Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH RFC] ASoC: amlogic: do not use dpcm_playback/capture flags
Date: Wed, 15 May 2024 15:01:35 +0200
In-reply-to: <87seyk2dmh.wl-kuninori.morimoto.gx@renesas.com>
Message-ID: <1jpltnxm5r.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID-Hash: MSILJ6MY3MK4NTZQIWCNV3BQKGA3MRCP
X-Message-ID-Hash: MSILJ6MY3MK4NTZQIWCNV3BQKGA3MRCP
X-MailFrom: jbrunet@baylibre.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MSILJ6MY3MK4NTZQIWCNV3BQKGA3MRCP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Tue 14 May 2024 at 23:11, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> wrote:

> Hi
>
>> > dpcm_playback/capture flags are being deprecated in ASoC.
>> > Use playback/capture_only flags instead
>> > 
>> > Suggested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> > ---
>> > 
>> > Following Kuninori's series, dpcm_playback/capture will be ignored.
>> > However, properly disabling stream direction is important for Amlogic
>> > audio drivers.
>> > 
>> > I'm not too sure how this should be applied to avoid breaking bisect,
>> > before or after Kuninori's series. Maybe it should be merged into it ?
>> 
>> Probably better to integrate it I think?
>
> ASoC needs dpcm_xxx flag *before* my patch.
> Your patch is replacing it to xxx_only flag, so it should be applied
> *after* my patch. So integrate/merge is good idea, I think.

Ok. Then I guess it is up to you and Mark.
Please let me know if you need me for anything.

Cheers

>
> Thank you for your help !!
>
> Best regards
> ---
> Renesas Electronics
> Ph.D. Kuninori Morimoto


-- 
Jerome
