Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008AFC46CD2
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jan 2024 18:54:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0FFC6EE6;
	Tue,  2 Jan 2024 19:54:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0FFC6EE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1704221657;
	bh=W7WluWnLd2+ye3nUeyJGSgdbLTM4HABDfTaUaDegwfc=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=eis58HMVkNTM3lYCLcApvGRdQFp8Zj+/qneYyRc3xpQrJNdcso6HOy7lF06yAHkHl
	 KJMWSZQpJRMiQCszjYdsAIDGgD/GxeA3RLQyQuyZWLKmDH2yugbQUwgYN+Yh2ZYzhH
	 ov9Xg4d9JNOmXdYSkXLUHhyPAkEFXDqrHJO0bhPk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 58BB8F807A6; Tue,  2 Jan 2024 19:51:02 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5959CF808C5;
	Tue,  2 Jan 2024 19:51:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A1148F80153; Thu, 21 Dec 2023 19:01:05 +0100 (CET)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com
 [IPv6:2607:f8b0:4864:20::92e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DB124F800BD
	for <alsa-devel@alsa-project.org>; Thu, 21 Dec 2023 19:00:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DB124F800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=Cvaa+WHx
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-7cc242dad2bso232820241.1
        for <alsa-devel@alsa-project.org>;
 Thu, 21 Dec 2023 10:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703181657; x=1703786457;
 darn=alsa-project.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0zgqhz3gU0ngKgXXY84DKw25FNO497Ngp+gIFMzuC7w=;
        b=Cvaa+WHx0c1A6MRlwW3nRiTF8/QGeF3CPrCjRlaFemyNVJwd4d1HTrYEpf4aVffVhh
         KvgNXOqLAsgqgVdLMxwFOEadrfy2qBRkmhxLtd8jqiYSnvyrF/mkQol2VzF0R0z9wrbR
         jeOf38ysmPqnyBsHJSX9OYSxVaCkN/WFTFAU4QIIx2NDubZ0AgVQ9c9pihas8dElZTyG
         KBO2J844o52G8FImWZMNxU5QJO3P7gCnkqxqwvBjMglTYQeqAg+6osTY3/VQKz080M8q
         ZIEnHdveoOKU0ofdfqXP8WzRVyEWu1vFth9pkSLzAVRKico7/sEHjNASN6vENg09yD75
         Jl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703181657; x=1703786457;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0zgqhz3gU0ngKgXXY84DKw25FNO497Ngp+gIFMzuC7w=;
        b=lZuFEtf7SYt/1dIvwvFIStXHK7PIjRO2dceSW/QFfL+9op/s3lhANUIZ/JH0wO1s0B
         Pnk1HKhsFfCM551cVPRNOimZ6z9FhiKDvK+gLQq7fqDkqPugwqc+za44XqSh3c9+v/S2
         IFUCXOkFn4FV4Bqm4KTL3bnkR4ust82a9/XvbS/fAvnPpUvF6z+Nl5DPFiVqxp7NiWKb
         mMaxJ1R4yHXI/3CtaBLvhXS5K3q1nVenNupnMEZg2KZ6rHcE8shjgsKbYMYPvgRbNV11
         /0sXM9BZs1/n7oT4A9OIzYokq5Luq9NNBO7MbhF6Wg5uQUT4pTQs9JFxYLP8PYYJsnIf
         3ceg==
X-Gm-Message-State: AOJu0Yxy+RJg9dhXZ2dF3QeelF/GFs2svn7exj/T1b/sFpIuSoXp4C2e
	SRbUL33M94ws5CGdwbAsyP0XYRF5pKOJMPKV5tVmrMHNaPE=
X-Google-Smtp-Source: 
 AGHT+IFrLKY5Rq9Xe7zM7cDVOxKuiSFALGN9bj2aLyZ445I0C4VOAcm0c85ei4E+0WU3cNDoZqJF9VXUQdCdg+isBBA=
X-Received: by 2002:a05:6122:221f:b0:4b7:1507:5c07 with SMTP id
 bb31-20020a056122221f00b004b715075c07mr9585vkb.9.1703181657364; Thu, 21 Dec
 2023 10:00:57 -0800 (PST)
MIME-Version: 1.0
References: 
 <CAGTfBuhGbEXgSDfpwUoGo8wAV9Huh1nfN9o+j27hWG+85vzCkA@mail.gmail.com>
In-Reply-To: 
 <CAGTfBuhGbEXgSDfpwUoGo8wAV9Huh1nfN9o+j27hWG+85vzCkA@mail.gmail.com>
From: R Guerra <xbox360liveteam21@gmail.com>
Date: Thu, 21 Dec 2023 18:00:46 +0000
Message-ID: 
 <CAGTfBujLtpVXwOK1aiwuJBA+ZoazOv7uCey6P5trtigiCY4jUQ@mail.gmail.com>
Subject: Re: Re: [PATCH] ALSA: hda/realtek: the bass speaker can't output
 sound on Yoga 9i
To: alsa-devel@alsa-project.org
X-MailFrom: xbox360liveteam21@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: O5U4DPVHVX427KN4BS3TK4ETUBFHHWBS
X-Message-ID-Hash: O5U4DPVHVX427KN4BS3TK4ETUBFHHWBS
X-Mailman-Approved-At: Mon, 01 Jan 2024 13:18:25 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.9
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/O5U4DPVHVX427KN4BS3TK4ETUBFHHWBS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

QnR3LCBJ4oCZbSB1c2luZyBNYW5qYXJvLg0K
