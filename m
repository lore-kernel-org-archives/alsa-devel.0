Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBA0CD5BB1
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2026 15:14:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0841360237;
	Tue, 26 May 2026 17:14:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0841360237
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779808467;
	bh=L4Bc+D7xvI8qn/QAzbHgmVMCeUDVLiHVFMZoPI+zcuQ=;
	h=Date:To:From:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=JP5QhfQPZXV83le8YK+OZp2dUA6i+pqFfFOneuV7fLZf9rtrbJD/Pc3MhT0J3dcJf
	 BQumitpFdKi0/NJcNrLe4CynYizyzzmtc1/WCrhSrEU9MFe78fbXQjJhVtlUfK4ipC
	 ncAZnKzp7G4KSta5LHuKzmGS+LposSm23tr/oQ9c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 46AF1F80185; Tue, 26 May 2026 17:13:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F0D7F805F0;
	Tue, 26 May 2026 17:13:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D9363F80557; Mon, 25 May 2026 16:20:46 +0200 (CEST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D6B36F8047D
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2026 16:20:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6B36F8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=O0eP3+a+
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-bda62f13d90so877144766b.2
        for <alsa-devel@alsa-project.org>;
 Mon, 25 May 2026 07:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779718844; x=1780323644;
 darn=alsa-project.org;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+52G9fjYMDqJheiDRzj6p8cUopKDG9s7RCAmc5BUOJU=;
        b=O0eP3+a+ah6G3GE+A36vORoM1cPqzJ+wqoo9Yt4QnTeKgv35Ql7ErmEdbJyNE4pK2J
         PO0DF4Wf4CbMjYrIQolJltUuavyouzC3BogQcarb4WfoDHa7BlECbLmOIU2pqU/D4dSz
         VbARojMeNanaxQUr6UXGw4rMaRFsvPpxpbo8u0wxUGLzHs0pmFlUaSeHfagaPzX8t2lz
         evWT1RqV02Qf2IrbIzL+H1fXt+s8qgZlrql+NCJma+CmTPXcje43He/1hKCuPKxeI8uE
         cpe3OrDR7CbzvtGa81jKiDrTHgew9os+xrxA7Gr0zcwDmCM91x7LBZYZLBXknVV5Lkpe
         /GNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779718844; x=1780323644;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+52G9fjYMDqJheiDRzj6p8cUopKDG9s7RCAmc5BUOJU=;
        b=aZc/WBLbMo/xaXEx8w/AMZd3VQ2CC8SL9HSUlH3OJq2jvW8SOpZkmpKt21p39JQt7p
         E/4JCBC2m0f7jhje64afQtitUXPxNrJ7HeV9RPZh5aatsI/kslw+NeG+T0UiXiCwHjKP
         JNRmYxVdrbXRMjsYJyFeKGDzAXv+oKD9db7r3Gm+FF+kw8KhrTwEHAR8BJ+M+ryg8577
         2EgxqhhMJ1bFVcfkem8x09fXaFJjhx2JnrLmYPwOdp35p+XhMuIax2LtgeTqRwG3CS6B
         i+eW560x0MjEOW1LkBABDhPg1feAlkUgfppYYMSsj+tuDqWHqR0SG3QaM4X80Wj0t0l3
         C2Bw==
X-Gm-Message-State: AOJu0YwCsS8dd0nGyNOzNwCevE/snFjH+iODn8LNCVkvI6Uxif2Dt9K5
	LdwNo+stV9P0Hi3bcW2YRi4rGZjx8ZCrGeBtDgDmdirIhpxUM5qO6wqBHFdByRnQ
X-Gm-Gg: Acq92OEV1uvRCyfNpc151VKfI0iyNvlh5kkXShmmpdPDu2/YxcOC90cJ2ejHwCG6rnD
	y807Jke4i/YkE2B1VE1WEydxnzkQp+3sEPAjvy8gszT5xqSXo/6wqmybOunD6ZPEvP1f89qRFpt
	Q5kfFVHl6JFqDkU6ysIermiDHX3brf42piCDsmIVT2awpNUvLseyvV8WeW43yBdeoGFUrlzaIH0
	CBX3QLM+rF6fuAmoSgF9R0pga02YoohFA1xgkBN/KN4/9nSpxYaZLBFVpVTdcvtwmd11fT58Dvf
	fFQGkuOdy4ElLXueEOIdTfwNRVN7awzvKXJPzBAAUzfpWGqoJNSZCel0Suo818smEjr01geORL+
	qVBO8Qrk5qXCle6vU27+xbz8pQlmkEtEV3KtKqjdcpG5CI0bmU1ac12jetrejRE+KkRu8hTG4D7
	EjN4seUYwCJ242mUKv1/lkUWW3PT5Iougdd7ZDzSWCaRk=
X-Received: by 2002:a17:906:f5a3:b0:b9d:872f:f5b9 with SMTP id
 a640c23a62f3a-bdd25de3aa1mr182071866b.23.1779443712285;
        Fri, 22 May 2026 02:55:12 -0700 (PDT)
Received: from [10.150.151.103] ([176.123.27.233])
        by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc62d9520sm36645666b.50.2026.05.22.02.55.11
        for <alsa-devel@alsa-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 02:55:11 -0700 (PDT)
Message-ID: <0ae0d735-cc02-428e-a775-fca5c364455b@gmail.com>
Date: Fri, 22 May 2026 12:55:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: alsa-devel@alsa-project.org
From: Ala Al-Sanea <ala0alsanea@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Lenovo Legion 7 16ITHg6
 (17aa:3811)
X-MailFrom: ala0alsanea@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: PK6B7BNVK3YCAJQQIUNOEGAQQOJPJJM5
X-Message-ID-Hash: PK6B7BNVK3YCAJQQIUNOEGAQQOJPJJM5
X-Mailman-Approved-At: Tue, 26 May 2026 15:13:46 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PK6B7BNVK3YCAJQQIUNOEGAQQOJPJJM5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

KlN1bW1hcnkqOiBBTFNBOiBoZGEvcmVhbHRlazogQWRkIHF1aXJrIGZvciBMZW5vdm8gTGVnaW9u
IDcgMTZJVEhnNiAoUENJIA0KU1NJRCAxN2FhOjM4MTEpIOKAlCBpbnRlcm5hbCBzcGVha2VycyBz
aWxlbnQNCg0KKkhhcmR3YXJlKjoNCg0KICAqIE1hY2hpbmU6IExlbm92byBMZWdpb24gNyAxNklU
SGc2ICg4Mks2KQ0KICAqIENQVTogSW50ZWwgQ29yZSBpOS0xMTk4MEhLDQogICogQXVkaW8gY29k
ZWM6IFJlYWx0ZWsgQUxDMjg3ICh2ZW5kb3IgMHgxMGVjMDI4Nywgc3Vic3lzdGVtIDB4MTdhYTM4
NTUpDQogICogU3BlYWtlciBhbXA6IENpcnJ1cyBMb2dpYyBDUzM1TDQxIHgyIChpMmMtQ0xTQTAx
MDE6MDAsIFJldmlzaW9uIEIyKQ0KDQoqS2VybmVsKjogNi4xMisgLyA3LjAuOS1hcmNoMS0xDQoq
T1MqOiBFbmRlYXZvdXJPUyAoQXJjaC1iYXNlZCkNCg0KKlByb2JsZW0qOg0KSW50ZXJuYWwgc3Bl
YWtlcnMgcHJvZHVjZSBubyBzb3VuZC4gfGRtZXNnfCBzaG93cyB8c3BlYWtlcl9vdXRzPTB8IOKA
lCB0aGUgDQpBTEMyODcgZ2V0cyBhIGdlbmVyaWMgZml4dXAgYmVjYXVzZSBQQ0kgU1NJRCB8MTdh
YTozODExfCBoYXMgbm8gZW50cnkgaW4gDQp8YWxjMjY5X2ZpeHVwX3RibHwgaW4gfHBhdGNoX3Jl
YWx0ZWsuY3wuIFRoZSB0d28gQ1MzNUw0MSBhbXBzIGFyZSANCmRldGVjdGVkIGFuZCBpbml0aWFs
aXplZCAofGNzMzVsNDEtaGRhfCBkcml2ZXIgbG9hZHMsIGZpcm13YXJlIA0KfGNzMzVsNDEtZHNw
MS1zcGstcHJvdC0xN2FhMzg1NXwgaXMgcHJlc2VudCkgYnV0IG5ldmVyIGFjdGl2YXRlZCBiZWNh
dXNlIA0KdGhlIEhEQSBjb2RlYyBmaXh1cCBjaGFpbiBpcyBuZXZlciB0cmlnZ2VyZWQuDQoNCipF
eHBlY3RlZCo6DQp8QUxDMjg3X0ZJWFVQX0NTMzVMNDFfSTJDXzJ8IGFwcGxpZWQgZm9yIHRoaXMg
U1NJRCwgc2FtZSBhcyBuZWlnaGJvcmluZyANCkxlZ2lvbi9Zb2dhIG1vZGVscy4NCg0KKldvcmth
cm91bmQqOg0KDQp8b3B0aW9ucyBzbmQtaGRhLWludGVsIG1vZGVsPSwxN2FhOjM4NTV8DQoNCmlu
IHwvZXRjL21vZHByb2JlLmQvYWxzYS1maXguY29uZnwg4oCUIHJlc3RvcmVzIHNwZWFrZXIgb3V0
cHV0Lg0KDQoqUHJvcG9zZWQgZml4KiBpbiB8c291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmN8
Og0KDQp8U05EX1BDSV9RVUlSSygweDE3YWEsMHgzODExLCJMZW5vdm8gTGVnaW9uIDcgDQoxNklU
SGc2IixBTEMyODdfRklYVVBfQ1MzNUw0MV9JMkNfMiksfA0KDQoqQUxTQSBpbmZvKjogDQpodHRw
Oi8vYWxzYS1wcm9qZWN0Lm9yZy9kYi8/Zj1lMzI4NmNiNWE3OTU0MzYzMDZhYTU5MTY5NjgwOGE0
MzM5ZDIxMzY4IA0KPGh0dHA6Ly9hbHNhLXByb2plY3Qub3JnL2RiLz9mPWUzMjg2Y2I1YTc5NTQz
NjMwNmFhNTkxNjk2ODA4YTQzMzlkMjEzNjg+DQoNCg==
