Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A6EC61DA4
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Feb 2023 14:02:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42BC282A;
	Tue, 14 Feb 2023 15:01:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42BC282A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1676383358;
	bh=Ykf9H8knl2Wue6d7Jq18a7oZOln2cEwjq7rvW24rQX0=;
	h=Date:Subject:To:References:From:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nt1Z6RlbKrZUqs/TGLVcYKqeFH3o6A3b04NLryd8URiYhe/Q4B5PqFqR7MSYSkzyI
	 2zVg2dKBUa8XshwbOJQgZt3KH8Hk4MLNA9enFz0oU380nTY1T3dfiMyAsd5er7D8E1
	 St1rha6lBDY2X+qpe8oSK8VrgQJkko5Syca+0rlM=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CCAB6F8001E;
	Tue, 14 Feb 2023 15:01:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2EB5CF801C0; Tue, 14 Feb 2023 15:01:18 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 514E8F8001E
	for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2023 15:01:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 514E8F8001E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20210705 header.b=kc3tVqVH
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CAD153F131
	for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2023 14:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1676383262;
	bh=YiY2TFvhepOf5fzf5OKz0Zyj41ghiQS4kSQBEjqb9fI=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To;
	b=kc3tVqVHX05O+OYZKLoRqh/uGlVcj4cTpNHdyw/z7tCKq2PjSC0W/NDOI1MjpQVL5
	 Z27m+Z/D5XNjLb7t6QGNXAK5TuRGEXzAwatYxCSPViM0GSsGO7Wn30HuMW9nTGCSFt
	 24IhuQZ9XbdAQoMIviJVW1m8MQ8eOknC2YtXjaV0rZm0vqrdtRhwKgGNrZ3a2Nny9Z
	 /GkOCXCme52a1wOwlFlT8yV/d+wGZQ4WHDxxw1fYYDidE0dFtwTsAW9c9pWTYqmTJU
	 7k/NGEi9LSEj9QcRSppy0Kt+jTu9CJ7v7P460ckKkuCBkoEN9ejeWEnaCF2kcZAZkf
	 DunMLxAehSyeA==
Received: by mail-pf1-f199.google.com with SMTP id
 z14-20020a056a00240e00b0059395f5a701so8048513pfh.13
        for <alsa-devel@alsa-project.org>;
 Tue, 14 Feb 2023 06:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YiY2TFvhepOf5fzf5OKz0Zyj41ghiQS4kSQBEjqb9fI=;
        b=tieNqiOmVnV72ioCNIqb26uolZgfg/rBPJqAdvLH0/Ckn4nvKEqMgfSdt7d4bT0mIZ
         gsm4K2job6sZOfJpfrm9LKceUTErm2okNAiETSSY5s5Fl1PZuinMoHqNZvjZ9bOeTwoA
         1Hj2TLwl5x+tFa4AsaXccv6vYX+X/w05SgQFtL4Q7L125JNHmj71G4YC8Qvh2fCzpvBW
         MALOXRqLg+n0EIK/MAt5Rt5wbw45nvgzV+LFTZ/R4EIaojGtnECzhFCP9mQGN2sEPWj0
         zXSJeGA6diI9+VKk3wUiAKzIZkaB3dD2LswinG8/xyCO9OqgpzEA4KI9py3EF29SwYiR
         DEIA==
X-Gm-Message-State: AO0yUKWKPqtU+znWz/RmX2+C6O+omFalw/yO2+du0fISszy3W5riu9ar
	h3T5pSk81Q1zYLizNhl94X2QZJeE2DhVqekpBOwoH5fti+07XDuiVFJisPwT0a4yzACrr5/7gkD
	XkRTpld0lk+ECTIlc2633fF7z7leZcpY+FB1OIXjt
X-Received: by 2002:a17:90b:1d87:b0:233:e710:119b with SMTP id
 pf7-20020a17090b1d8700b00233e710119bmr2568479pjb.43.1676383261443;
        Tue, 14 Feb 2023 06:01:01 -0800 (PST)
X-Google-Smtp-Source: 
 AK7set8Nuc1Gb3uiJCI74WfdbVCfYzQ8Vy3tJKZlyF7Q1/z1v6CC0EpQcqR5NaBKZcoKyg17+9z7fg==
X-Received: by 2002:a17:90b:1d87:b0:233:e710:119b with SMTP id
 pf7-20020a17090b1d8700b00233e710119bmr2568434pjb.43.1676383260928;
        Tue, 14 Feb 2023 06:01:00 -0800 (PST)
Received: from [192.168.50.191] (1-163-107-120.dynamic-ip.hinet.net.
 [1.163.107.120])
        by smtp.gmail.com with ESMTPSA id
 b8-20020a17090a550800b0022c0a05229fsm9296395pji.41.2023.02.14.06.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 06:01:00 -0800 (PST)
Message-ID: <a87c02f3-fa76-e4fb-d151-c566b5d5145a@canonical.com>
Date: Tue, 14 Feb 2023 22:00:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable mute/micmute LEDs support
 for HP Laptops
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
References: <87y1p08rxp.wl-tiwai@suse.de>
 <20230214103757.36624-1-andy.chi@canonical.com> <87sff88p2c.wl-tiwai@suse.de>
From: Andy Chi <andy.chi@canonical.com>
In-Reply-To: <87sff88p2c.wl-tiwai@suse.de>
Message-ID-Hash: CX743RZHEHHN62EIURXBAQKNVGWMLDK6
X-Message-ID-Hash: CX743RZHEHHN62EIURXBAQKNVGWMLDK6
X-MailFrom: andy.chi@canonical.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Content-Filtered-By: Mailman/MimeDel 3.3.8
CC: Takashi Iwai <tiwai@suse.com>, Tim Crawford <tcrawford@system76.com>,
 Stefan Binding <sbinding@opensource.cirrus.com>,
 Meng Tang <tangmeng@uniontech.com>, Philipp Jungkamp <p.jungkamp@gmx.net>,
 =?UTF-8?Q?Kacper_Michaj=c5=82ow?= <kasper93@gmail.com>,
 Gabriele Mazzotta <gabriele.mzt@gmail.com>,
 Yuchi Yang <yangyuchi66@gmail.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CX743RZHEHHN62EIURXBAQKNVGWMLDK6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

DQpPbiAyLzE0LzIzIDE5OjI3LCBUYWthc2hpIEl3YWkgd3JvdGU6DQo+IE9uIFR1ZSwgMTQgRmVi
IDIwMjMgMTE6Mzc6NTYgKzAxMDAsDQo+IEFuZHkgQ2hpIHdyb3RlOg0KPj4gT24gSFAgTGFwdG9w
cywgcmVxdWlyZXMgdGhlIHNhbWUgQUxDMjQ1X0ZJWFVQX0NTMzVMNDFfU1BJXzJfSFBfR1BJT19M
RUQgcXVpcmsgdG8NCj4+IG1ha2UgaXRzIGF1ZGlvIExFRHMgd29yay4NCj4gV2VsbCwgdGhpcyBx
dWlyayBpcyBub3Qgb25seSBhYm91dCBtdXRlL21pYyBMRUQgYnV0IHJhdGhlciBtYWlubHkgZm9y
DQo+IGVuYWJsaW5nIHRoZSBDaXJydXMgYW1wLiAgSSBzdXBwb3NlIHRoZSBzcGVha2VyIGRpZG4n
dCB3b3JrIHdpdGhvdXQNCj4gdGhpcyBxdWlyaywgdG9vPw0KQWgsIHJpZ2h0LiBJJ2xsIHNlbmQg
b3V0IHYzLiBTb3JyeSBmb3IgdGhhdC4NCj4NCj4NCj4gVGFrYXNoaQ==
