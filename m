Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6B3FA3743
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Sep 2024 11:10:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A7C46E0F;
	Fri, 13 Sep 2024 13:10:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A7C46E0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1726225825;
	bh=q9QVcDnUO6ef7BN/o/SJve91/yT+mIjcG2MWVsf/y0c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ciMVK5pop+7KbYfZYIMMbGXIL/NEMfrocl33cjujXljlc5V2fD3+DFvn0rQvBcA8+
	 O4MpWN13CWM/5RVNx1WvXYBezI7ZZmNVE7CTATo4KUS9Bls3FeThRZhs5ukEatESp2
	 fliTpr7hWIhQEYO3VL+8H5BB6Nn7d4z+eO+MajfM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C5BA9F805D9; Fri, 13 Sep 2024 13:09:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 20C22F805E2;
	Fri, 13 Sep 2024 13:09:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B2D70F8016C; Fri,  6 Sep 2024 19:47:49 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 04FE8F80107
	for <alsa-devel@alsa-project.org>; Fri,  6 Sep 2024 19:47:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04FE8F80107
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20230601 header.b=BtnSDy4S
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42ca580f4c8so95e9.0
        for <alsa-devel@alsa-project.org>;
 Fri, 06 Sep 2024 10:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725644866; x=1726249666;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lQb0TO7993zK5C2BTxU+zoBSpAG4+bl+jhdo5Oy2IvA=;
        b=BtnSDy4SlldsdWabhbCvj789zTAhiKsSJWY6vQzizWrIYzMFVKXGdJ/m7kD3Uw/3Ng
         VLmHD52cSZf8N1EWNsrKy6uROS3BXSLN7z//ZQVTz8WPk8KLE+fBF/kb9FkusYn+P+JG
         Hric/LuVVE/HhXxS15BdvnaATBxC1Q29+vxvLUsbixzHr6lXKvURHomKHiU3TTGPcjam
         UvO3647IcAl42P6PLB9JKtmfKadiuk7DgFZdibJGxuef9gIAYJVfTVJMAIcUE73wMIEm
         SJYCYwPjG82dvr9eCfXWHVDXqrFai5mVLJ6iBX74vU6Dj2O4K5LvFy3COlgbv6gc66wZ
         lEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725644866; x=1726249666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQb0TO7993zK5C2BTxU+zoBSpAG4+bl+jhdo5Oy2IvA=;
        b=akvR28iznWV6wV5UWh5DJUSSNcjINyT/VDYydGElh/LUaatMWoFqTfQA7oDUhA4Mhb
         MBgSDTzZIwXdVeGypg/+p+tOOSsAEW+WqhURhachbF+i4WSIMLpSrE//7u+7iXrh/aut
         4hth+Nl5tl8dAjQ4DO7vWVojz/mpm7oB9l/oH/x44wFWOSq4/YkY7ez7wG8fWvcUvqTF
         k32mm1I7xiGSPHY2L/eGPOPEleayXNDVk7uaoYz/tMTmqtAdl+pCNA4U2zn8swBdlW3m
         CnncjO18z+zLnHHjnnuElZf5gTaZT7IJDTom7xibVi8EjUw5JmlXmZpnEvcaSYrogikA
         uPJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwWUT8AfZk/EtCCGkM9J2jM5DtIz5IGOuwmUkuncSh77+KVFreEj6wWKnZTa82oYpNPr/NYY5XvGaS@alsa-project.org
X-Gm-Message-State: AOJu0Yy8Cm0HsDkAuQHRLA5xehaieF0NbS+6FHRB4NOaYjObN2MoAAnk
	+1CUpwTKiiZ5qUbySFpUnGbfOS1kniHOUUTIYLvCA5Uz6GygilvXUlIZLBNu1H3bAgaC1N9zrGx
	h/3oz87BAT2s0EVSScsuqjWC4KOa+IdtnA1M=
X-Gm-Gg: ASbGncvYCJjusZuoG0i1zBaKvTTKF0h/wCQolUcqrwuWHjNkQQkCS5wjSPyr7efr2FZ
	DHQt3IrzTvm9v5agb+7TkWPrUxgGVI+84UIiCUQQd5dNQdtk7tV+71sebWA==
X-Google-Smtp-Source: 
 AGHT+IHaXYesgdTa2zrVDK/ImdruxZNlwcL8CUKuo7JERdYwqfWJo+EeWwoXyZC51s10TKXrHB0roVVVfwWMknj+CZA=
X-Received: by 2002:a05:600c:254:b0:424:a2ae:8d1d with SMTP id
 5b1f17b1804b1-42cacd3ab7cmr25045e9.2.1725644864614; Fri, 06 Sep 2024 10:47:44
 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CAFs7P=jk=wfo0nbHzqd1NrGX3NKpOezD4-u=nAMqzq7mq4Lidg@mail.gmail.com>
 <CAFs7P=jPqv2Zr6Fnw584TKhj5joBRt7X7gMidE4MiK1ABAMiRQ@mail.gmail.com>
In-Reply-To: 
 <CAFs7P=jPqv2Zr6Fnw584TKhj5joBRt7X7gMidE4MiK1ABAMiRQ@mail.gmail.com>
From: Joshua Pius <joshuapius@google.com>
Date: Fri, 6 Sep 2024 13:47:08 -0400
Message-ID: 
 <CAFs7P=jtd1caEyQqmw0L-Up_y_Cpv8YX4aO7MOkg8Zm0NKeBsw@mail.gmail.com>
Subject: Re: [PATCH] ALSA: Add logitech Audio profile quirk
To: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
 alsa-devel@alsa-project.org
Cc: devicetree@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-doc@vger.kernel.org
X-MailFrom: joshuapius@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: HJVENFBJNAKADIU2XU5TMTLCZRPJSAFQ
X-Message-ID-Hash: HJVENFBJNAKADIU2XU5TMTLCZRPJSAFQ
X-Mailman-Approved-At: Fri, 13 Sep 2024 11:09:29 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.9
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HJVENFBJNAKADIU2XU5TMTLCZRPJSAFQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

T24gVGh1LCBBdWcgMjksIDIwMjQgYXQgMTowNOKAr1BNIEpvc2h1YSBQaXVzIDxqb3NodWFwaXVz
QGdvb2dsZS5jb20+IHdyb3RlOg0KDQo+DQo+DQo=
