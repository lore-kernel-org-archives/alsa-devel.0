Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2B4C0015E
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Aug 2023 16:58:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 98E447F1;
	Tue, 15 Aug 2023 18:57:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 98E447F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692118708;
	bh=DbP0x9fikpp3jGMWBv1jNIM/Af7TyedQ9GKdziQbEXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kZfMFeG88RiE5NEAzYKCSdqvrkdcQGR9OPrbBVATAAdD3e2jNft+wR8cv20dSuV0X
	 lB2uyzfnXeP2DUIOz/3oYDix8TRUoQ1ez10xl/Ao4K7VcV5JGzyE8LxnbhXVsRXo3Z
	 FEPfWh0q8klAoHzDJJe23BVlZSI8AgiuX4W65tDQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EAEE7F8016D; Tue, 15 Aug 2023 18:57:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 74449F8016D;
	Tue, 15 Aug 2023 18:57:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C2DD3F8016D; Tue, 15 Aug 2023 18:57:03 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BB4E5F80074
	for <alsa-devel@alsa-project.org>; Tue, 15 Aug 2023 18:56:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB4E5F80074
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20221208 header.b=bLvHqYJs
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-56530cfee38so3361427a12.2
        for <alsa-devel@alsa-project.org>;
 Tue, 15 Aug 2023 09:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692118616; x=1692723416;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iKfqfUucAOGEmwM0DLIc6HoGDpvPJKwodZvu8FzOt9Y=;
        b=bLvHqYJsRJbI9BuAq4v6+AQyMUqQ3oYKTGCj3FTJrXrVg/7Z5AHh1MoynaglU3KcSW
         zGpTHPraQw7x97GGKIoq3yeznp7J8BmEwW97VL0Jyale2ULzCSZQxtSMScY8y/6JdJC1
         pGyL07rJjFyaU0cbX3Ag7mSKEnt/pIMHfjzodOq6R6wRlNx8NpJQWdzir2co2cxSHYpQ
         RCAm93hDRCJt11oSaOKnmWVFexL77NGCz1w4Bp61tu8f4XtKLq0enqdIhyD7blb1UJLu
         72WyybiloXt5oTU9IabmEhPzOVq5+7LhfNlZpfFmdBjuECZLh0ZXxhZnR/P8hu8kPZvf
         Q3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692118616; x=1692723416;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iKfqfUucAOGEmwM0DLIc6HoGDpvPJKwodZvu8FzOt9Y=;
        b=GNbgRPjrw8LzE44o+pgjLukHN0DXJzj7f55jQWLjz89ciQDbrS5HS/6mJDPvOYDd4c
         pb2zU4CYefqoljlvvS9OCklKAxOszegpWCInGJ6lWNWqCdnowChz+v6Y5otoIGLZkkXF
         7vd+W54EoPhONwmvXjjL12F4zYWz4SKEmSWATWoyWM6QQQwKslQxa/3DlO4jxxrQqBHN
         MOWVYmf66RySXztgLLguIPK/YAW5dSGbrbIdYjITE0O/XcC38rHO7676OEbIZDr6gFzL
         fQvxkwPgaqm1uZJq085JFneISS/HcZqHlI0f7W39hPZoBe1zcOxYTLxJu/3vTCOLLydW
         WPqg==
X-Gm-Message-State: AOJu0YwOkcbNnxyElPgWYmudlEnFd3XlLTAgD52OdxtcYhBywdRaEdxs
	CF7ButjTuxx7HOFWWHRhfnhb167Q+vVf0v1JaSDpBeMidMzDW8/5zea5TA==
X-Google-Smtp-Source: 
 AGHT+IHAM5TzsRYswL4ZTwmEPiQUfne2ULXDgQACr+/JRdy5VKU6hqpISPNvsajFiOmdnHSrKlBP2+IFmoau5ZX4J1I=
X-Received: by 2002:a17:90a:7b8f:b0:268:f45:c10a with SMTP id
 z15-20020a17090a7b8f00b002680f45c10amr9192212pjc.26.1692118615879; Tue, 15
 Aug 2023 09:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <ZNuDLk5hgmfKrZg6@arch>
 <850c5b2c-265e-a565-8a88-58a88f8fb4e8@linux.intel.com>
In-Reply-To: <850c5b2c-265e-a565-8a88-58a88f8fb4e8@linux.intel.com>
From: Curtis Malainey <cujomalainey@google.com>
Date: Tue, 15 Aug 2023 09:56:44 -0700
Message-ID: 
 <CAOReqxjbjkhkqfvTWs9i5NxK6QAsk42Daw1pA_1+b1zG5mbKmQ@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: hda: intel-dsp-cfg: Add Chromebook quirk to
 ADL/RPL
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Brady Norander <bradynorander@gmail.com>, alsa-devel@alsa-project.org,
	broonie@kernel.org, cezary.rojewski@intel.com,
	amadeuszx.slawinski@linux.intel.com, perex@perex.cz, tiwai@suse.de,
	cujomalainey@chromium.org
Message-ID-Hash: 65JPYL5ZD3DQ7CHBXV6VQXSQX7MX265Y
X-Message-ID-Hash: 65JPYL5ZD3DQ7CHBXV6VQXSQX7MX265Y
X-MailFrom: cujomalainey@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.8
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/65JPYL5ZD3DQ7CHBXV6VQXSQX7MX265Y/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

T24gVHVlLCBBdWcgMTUsIDIwMjMgYXQgODo1NuKAr0FNIFBpZXJyZS1Mb3VpcyBCb3NzYXJ0IDwN
CnBpZXJyZS1sb3Vpcy5ib3NzYXJ0QGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQoNCj4NCj4NCj4g
T24gOC8xNS8yMyAwODo1MiwgQnJhZHkgTm9yYW5kZXIgd3JvdGU6DQo+ID4gQWxkZXJMYWtlIGFu
ZCBSYXB0b3JMYWtlIENocm9tZWJvb2tzIGN1cnJlbnRseSB1c2UgdGhlIEhEQSBkcml2ZXIgYnkN
Cj4gPiBkZWZhdWx0LiBBZGQgYSBxdWlyayB0byB1c2UgdGhlIFNPRiBkcml2ZXIgb24gdGhlc2Ug
cGxhdGZvcm1zLCB3aGljaCBpcw0KPiA+IG5lZWRlZCBmb3IgZnVuY3Rpb25hbCBpbnRlcm5hbCBh
dWRpby4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJyYWR5IE5vcmFuZGVyIDxicmFkeW5vcmFu
ZGVyQGdtYWlsLmNvbT4NCj4NCj4gVGhhbmtzIGZvciB0aGUgcGF0Y2gNCj4NCj4gQWNrZWQtYnk6
IFBpZXJyZS1Mb3VpcyBCb3NzYXJ0IDxwaWVycmUtbG91aXMuYm9zc2FydEBsaW51eC5pbnRlbC5j
b20+DQo+DQoNCk5vdyB0aGF0IEkgYW0gbG9va2luZyBjbG9zZXIgYXQgdGhlIHBhdGNoLCBJIGFt
IHZlcnkgY3VyaW91cyB3aHkgd2UgYXJlIG5vdA0KaGl0dGluZyB0aGUgZm9sbG93aW5nIGNhc2Ug
YW5kIHVzaW5nIFNPRg0KDQogICAgICAgICB7DQoNCg0KDQoNCiAgICAgICAgICAgICAgICAgLmZs
YWdzID0gRkxBR19TT0YgfCBGTEFHX1NPRl9PTkxZX0lGX0RNSUNfT1JfU09VTkRXSVJFLA0KDQoN
Cg0KDQogICAgICAgICAgICAgICAgIC5kZXZpY2UgPSBQQ0lfREVWSUNFX0lEX0lOVEVMX0hEQV9B
RExfUCwNCg0KDQoNCg0KICAgICAgICAgfSwNCiAgICAgICAgIHsNCg0KDQoNCg0KICAgICAgICAg
ICAgICAgICAuZmxhZ3MgPSBGTEFHX1NPRiB8IEZMQUdfU09GX09OTFlfSUZfRE1JQ19PUl9TT1VO
RFdJUkUsDQoNCg0KDQoNCiAgICAgICAgICAgICAgICAgLmRldmljZSA9IFBDSV9ERVZJQ0VfSURf
SU5URUxfSERBX0FETF9OLA0KDQoNCg0KDQogICAgICAgICB9LA0KZXRjLg0KDQpUaGlzIG1ha2Vz
IG1lIHdvbmRlciBpZiBtYXliZSB0aGUgRE1JQyBkZXRlY3Rpb24gaXMgYWN0dWFsbHkgYnJva2Vu
Lg0KDQpDdXJ0aXMNCg==
