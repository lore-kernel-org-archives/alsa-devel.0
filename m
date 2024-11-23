Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2025EE6ADD3
	for <alsa-devel@archiver.kernel.org>; Sat, 23 Nov 2024 00:27:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F37041933;
	Sat, 23 Nov 2024 01:27:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F37041933
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1732321667;
	bh=EAgpozZB5AUZYtpmuqukNi0aM1WqiH8l2VVbndPm/rQ=;
	h=Date:From:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=gwBpwHoiYm7Vzf5shEZdrajCCEQdSo/SvH3bkFOY8/sZLOReNzgTYxqjTqp/R34zd
	 R7ymA+r48knC0KUXjFvHDBB5sRDmAuByY24a2QM29CclXVXdIlnBIGMeUHXce2Sga7
	 +nyasRWwqpttoGP7xf7HHko40TNprd3hMzzW6uqw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A82DDF805C6; Sat, 23 Nov 2024 01:27:12 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 007E9F805C1;
	Sat, 23 Nov 2024 01:27:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 517DCF80533; Sat, 23 Nov 2024 01:27:07 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EF85EF80134
	for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2024 01:27:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF85EF80134
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=Zt9p/ntj
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43163667f0eso23811415e9.0
        for <alsa-devel@alsa-project.org>;
 Fri, 22 Nov 2024 16:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732321624; x=1732926424;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kE9lzpaWGB3GrQBgjCi5NresOAQ1yTY/kwHUh3H0Aw8=;
        b=Zt9p/ntjbGwQ6dDMc4IPB7LI1OaqOOL3hmX92N6tz2rk7CU/WVxrcqVOBw4y9VCfty
         F3hbrq3yDND8hZfvPxHkWpT+9Jf6u+nlMD7HfwzLYMbvoXsWRA5B77icjrjFINTTIoPr
         39TxArz5lSnWjr8SblgAQ7R9RkUBVUUBBynY5Z611+UWooL2TzFepSlrAqXGkKVm7lHj
         ZL28RafrSv31KbPwpM4KfYsHcGQ3CsjJ6jvuKLW1r26gPNaxQpCNrN+lJDcff9nS4nuJ
         MRrbE+5m8JzMl2gZW9NVWgtQP/8iTYsu4B9GReNSYubvxU7zLwd/iBW2ZuYpzx/aLhak
         KZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732321624; x=1732926424;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kE9lzpaWGB3GrQBgjCi5NresOAQ1yTY/kwHUh3H0Aw8=;
        b=S5N+88fYRD9kBIc9X9joG9kJlMTU/KN/bTh8sF7MJnwnE0JG/Y4R3mFjIuFgxHU3Mq
         1N9M2GndyGZxDdvUj4pSIwhT42Swez/nVfbWF3wGSof4D49HJnAwYGw9ixq5MOQCteJd
         ZgpF2MvAoMr0pfusDi9+vu9e5FZFdH0k5PzTpEhO8shJjDpR9PdjPtN4e3q7sooaX/se
         sQ9FsibteA3+PI7Tmjob1V5xzycjtdiGqFFg7Gi21PL5dPtt9+mXp1i8GI3ftcxoztXL
         M5ComR5F5nd09qLhyUVhHdmhn1PEbOVchA+AONTQzIJpuOkUcwss65KnhSYqN0M1b2G2
         D5Qw==
X-Gm-Message-State: AOJu0YxUJ9JDdg3EvaOXon2OHI7kqP5sNZg0ydlV1HR7WkDTxg+L99EP
	mrYBkzMXdNh1gdL+JY/MZ9IHrQRr4y/BxVEC+2rzVRmXxATk4QhxDVTddg==
X-Gm-Gg: ASbGncszSVqzp3KBrOMPRJooOHxZwUzwlnggyJH8XlreIFFguoM6FEnahCJYAWT3c75
	FBkmfn6nWf9d5RqIxp08P+6jeb/nqivzV4WH3iDsVNu/glNJYyu9QiXbTM+wq5aO6TFwqhrjNND
	LzJbW2dZvIKpFPAHINMoBzq2h76B0Gf0gCFB9YQbK3cMON9OEYuAAUoiGKG98k2yMMzYSwzFjGK
	GFLCnmwBYrDbzdTh6SyNoHD2TgeqGcXO63vOxnZZU6uwclIxqV7FxNuTDVagqUdfLMtQZCCX2Hz
	J2dix98q/mdqmYa/bQSzlSpxa8kl
X-Google-Smtp-Source: 
 AGHT+IFFF6aiSmcyyQELh+uoBZt8AtdHlY+k4KNF8S7xfJdL+ikeaq1jROWY3rorMrOtf+XnJbbzUg==
X-Received: by 2002:a05:600c:3507:b0:431:612f:189b with SMTP id
 5b1f17b1804b1-433ce4264c0mr42089185e9.12.1732321623490;
        Fri, 22 Nov 2024 16:27:03 -0800 (PST)
Received: from ?IPV6:2a02:8071:3484:bc0:caf7:50ff:fe30:727e?
 ([2a02:8071:3484:bc0:caf7:50ff:fe30:727e])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbedebfsm3719045f8f.100.2024.11.22.16.27.02
        for <alsa-devel@alsa-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 16:27:02 -0800 (PST)
Message-ID: <d9d0aa58-02cf-4f52-8798-e987c1e7c05a@gmail.com>
Date: Sat, 23 Nov 2024 01:27:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: schorpp <thomas.schorpp@gmail.com>
Subject: [BUG] HDA Intel PCH, HDMI , HDA Intel PCH, ALC886 Digital, no IEC958
 / HDMI output/passthrough to AVR
To: alsa-devel@alsa-project.org
X-Priority: 4 (Low)
Content-Language: en-US, de-DE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: 5WWIAC37ZV63A6PT24S2QLPYANDUKWUR
X-Message-ID-Hash: 5WWIAC37ZV63A6PT24S2QLPYANDUKWUR
X-MailFrom: thomas.schorpp@gmail.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5WWIAC37ZV63A6PT24S2QLPYANDUKWUR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

> 
> [BUG] HDA Intel PCH, HDMI , HDA Intel PCH, ALC886 Digital, no IEC958 / HDMI output/passthrough to AVR
> 
> ALSA versions 1.0.25...current
> 
> Kernel Driver versions 3.12.40...6.x
> 
> Hardware:
> 
> DFI Mainboard MB330-CRM
> 
> https://www.dfi.com/de/product/index/273#specification
> 
> Reproducible Always
> 
> Steps to reproduce and full report:
> 
> https://www-vdr--portal-de.translate.goog/forum/index.php?thread/136519-gel%C3%B6st-xineliboutput-config-f%C3%BCr-dd-passthrough-zu-avr-und-5-1-surround-headset/&postID=1375883&_x_tr_sl=de&_x_tr_tl=en&_x_tr_hl=de&_x_tr_pto=wapp#post1375883

Output of alsa-info.sh is here

http://alsa-project.org/db/?f=fc4734deddd9a92331692bf94b15cf84b7722cd4

> 
> Software crosscheck with CM106 USB Soundbox iec958: works OK.
> 
> Where to start in the drivers source code to fix it?
> 
> y
> tom
> 
> 

