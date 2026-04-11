Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB7AF3ED5C
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Apr 2026 20:26:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21EAF60231;
	Sat, 11 Apr 2026 22:26:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21EAF60231
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775939192;
	bh=DxtOieUPTpBjqu3a5JgIsBtePjDudWmh40qMJYkPndk=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=S/9zjNA8uOfN74e2KYiFtHqTncSI02nOuxakpBqJoFvkCayCcAIfwJV6ao+bk628Z
	 Ymrx4zEg+KhYDEbObibKwbe1SHSs7u8MlbZEN2YY2PkykUbTCyNLgRiQ2gUXhVdYMq
	 Fb6KY54IbzsJ66rSGA1flGwBp4MsTz05ZN7rd2VU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 243FCF80609; Sat, 11 Apr 2026 22:26:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5857BF805E7;
	Sat, 11 Apr 2026 22:26:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A69CFF80527; Sat, 11 Apr 2026 16:39:46 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 56CC0F8021D
	for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2026 16:39:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 56CC0F8021D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=S0tSzTER
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2b2dca513c3so6800945ad.0
        for <alsa-devel@alsa-project.org>;
 Sat, 11 Apr 2026 07:39:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775918379; cv=none;
        d=google.com; s=arc-20240605;
        b=QqwRqhyLoNMj0TVg6sTaTiJIa5n6JScsb87frmkKZ4r01Xud+PJGd4WfF1uOKBrqe0
         lSmkgMH6y9QdhA3vcFLaulaJbGrixNVpu+S4u4wG4Q3JV8nsduhOA2wPudfVjD8E+gRK
         CfLCCpUYQtzsrrlgu8Qyf4AcoEpSsq8E8ETYXHU0odYww0ecom8/Ux3dtu8pTIVzjxAG
         nFdYDd7HJLND27GXd3crFXQQIQI0euaKFZIBHahNex5YEVqhlqxSnv3myLuCzQUnMoqS
         Fh7gqhX0LnM9peL6jt1dK280Pn5FB5ArKL/uR5njcAS8T86e9+XT9/kVOQA9SUHUS8td
         T6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=KhN6qkgbe2muGCLcJOVRGN8sHaH7no5gngKRejMlHyk=;
        fh=s1h8N4U4ASgl2diPi2yKjEmsLSTuwbZjYBDYrAXLUvw=;
        b=e1x9iXd3VOrwVoPhkJbJjFB661wrPNhRfNAXc9K3OpPMuf7EqcBj/RKBrE2RpDk0yJ
         6y5fPWXHs0BxbGgjTnbptC0IM0ebyvXrbbXqNNopR6WZdRUvw8vGr1PZN6D+Im5nF7IX
         xf8pnjECxOuLNC2HVBVYQJ/HQDJNjIunMmZtSTXlpOBLYjc1KZnmWUxK8UlCdWS+cA/y
         s/nl3kdbcFuFNxW48f0cZlOKAXM6PQFXrjsbxcZFuktwIWo7iwuQ0Kql7edf5ES1HbXn
         xw5Ofgaa4sVwUQ385oB1P67MDMBzfklVfy14UVtc3g3Vrio9z4I5YgLv79z9YgLvJeRR
         kXAg==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775918379; x=1776523179;
 darn=alsa-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KhN6qkgbe2muGCLcJOVRGN8sHaH7no5gngKRejMlHyk=;
        b=S0tSzTERUYO87sdMQkaNO3DT2F63TzpE8H5Tr22/rgtVvFf/W+dNaCesYdxmi+Od1/
         HRDMrVdsJS1BaQFoeyXox3K247N8kfnTBRAJSUbIm/bcVfOY49MKojVZVt8FgDoQf7JH
         B9RmR6Kw945Qqw4rA0AbE1Xi6K4SWpkaQBj7MObx44ISEGmeKvZpNUoIZepSBnNLNCUr
         8NUX6RNmwRYMpHWijTl5y5LEXqoOoH6Ly2Vqycw8gEZWw4o72MA4jYRqsBHroJtXU+qZ
         ROmpboAMGXoPwpxzaB5a4HW6tlDaJSvslqZtqIQCohKhg5iGo7tmCpCR+ebyEbLlfdA3
         W7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775918379; x=1776523179;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhN6qkgbe2muGCLcJOVRGN8sHaH7no5gngKRejMlHyk=;
        b=pG4Ob5tnHcaoqmWkhvVpWbt2OZGeoTftCeSbTYb9u0TabQOr5YQuPNhyVlH3lDsE+v
         XDSax0onEcMIRBkQDzWPlNrl+3X1wN34tE3b87jT8qhf6HV3IKl04i0JHIlEPeTgq+g4
         7uNwsSKWeQU76HjE9gCFZtinrdYgXveHCnSmzDG/Digho/KqR8otd7D2c9b13a2qmlS5
         +v8/9YUMTzqg5NRLxt6Py4SFQpQkxB39h1B2dW9RbxU3sjWPH8rNJKOeeHsQCwnaaKSs
         Sn90XXFkL+Jz1Op4m+SWxAqg3YKfeRRVnmeypYuaA0Qhth+9rr0ekbHftjKbOmWN8b17
         tk0w==
X-Gm-Message-State: AOJu0YzVGCFXLBWPOq247i7qOTlAHZAFJuzbX5SeODHrEI+iht+fGdvO
	QHbxjRHUCY5vKabxRyyd2gWGT4cPIRVH8E+944/x5ErCGDNVmFW8OIGoKgOZJtIdJGvCfsECCpC
	YvzNnZg1G5zAyS9m7yRSPm3fv1Btf5UqPq1qL
X-Gm-Gg: AeBDiesvUC8gO3OEjrJTWmffGk91fhCoAYaICT6d6vRsyJcFXxjJOQPfR43xuVXgNbq
	oI6jmPBtqOOI4Az6LRz5QLbcUgNye7kJwhXg38dBWC1W1jDTFRwHM888hilSivfSHPVWIAVP3uE
	Zjpx2xyzQe88SnMSq6olHWWvRri6gbaGDcMXwgWX178tk2Brft1aLwllyeO+nbQp1WW4hgtN+/A
	0pFcKqfhWLF5/dsIlLQs60JS7zGd0Ot7NOZRKJDj1z2kB1L/0CZ97RA7GHT8rGlADxR22PKIDtB
	+LhUfMxvAUCJwT63D3BIVwQ4lDoWRUVW2dbgnA4QDT14eZOU1FzZilaH5UD/5gvpK49w2VdWDJT
	FZF2F7q9gv5HNSBowBkM0gNQv
X-Received: by 2002:a17:902:d50c:b0:2b2:b117:1d5d with SMTP id
 d9443c01a7336-2b2d5a4b5c7mr76038655ad.33.1775918378436; Sat, 11 Apr 2026
 07:39:38 -0700 (PDT)
MIME-Version: 1.0
From: Ezequiel Rifos <renzorifosezequiel20@gmail.com>
Date: Sat, 11 Apr 2026 11:39:27 -0300
X-Gm-Features: AQROBzAfBJ9t_H_K9pPYG7sSvZvXMfVAM7WjjpWcxzOD_Tt4iHkxAKYSn4XWwyQ
Message-ID: 
 <CAEVzTF499MBveBpv=k7VtMkupmWq-ZUWTz_+oLAgG3ASFAqtfw@mail.gmail.com>
Subject: [ALSA] Acer Aspire AL16-31P (ALC269VC, 0x2782:0x1718) - external
 amplifier at I2C1/0x33 uninitialized, internal speakers silent
To: alsa-devel@alsa-project.org
X-MailFrom: renzorifosezequiel20@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 7JA6GDJGUOQTYF4ZGR6IYF3ZDNXZGRRO
X-Message-ID-Hash: 7JA6GDJGUOQTYF4ZGR6IYF3ZDNXZGRRO
X-Mailman-Approved-At: Sat, 11 Apr 2026 20:26:01 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7JA6GDJGUOQTYF4ZGR6IYF3ZDNXZGRRO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGVsbG8sDQoNCkknbSByZXBvcnRpbmcgYSBzcGVha2VyIGlzc3VlIG9uIGFuIEFjZXIgQXNwaXJl
IEFMMTYtMzFQIHRoYXQgSSd2ZQ0KaW52ZXN0aWdhdGVkIGluIGRlcHRoLiBUaGUgcm9vdCBjYXVz
ZSBpcyBub3QgdGhlIEhEQSBjb2RlYyBidXQgYW4NCnVuaW5pdGlhbGl6ZWQgZXh0ZXJuYWwgYW1w
bGlmaWVyIG9uIHRoZSBJMkMgYnVzLg0KDQpUaGlzIGlzIGEgZm9sbG93LXVwIHRvIGtlcm5lbCBi
dWd6aWxsYSBidWcgIzIyMTIyNCwgd2hpY2ggaGFzIHJlY2VpdmVkIG5vDQphY3Rpdml0eSBzaW5j
ZSBNYXJjaCAyMDI2Lg0KDQoNCj09IEhhcmR3YXJlID09DQoNCkxhcHRvcDogICAgQWNlciBBc3Bp
cmUgQUwxNi0zMVANCkNvZGVjOiAgICAgUmVhbHRlayBBTEMyNjlWQw0KU3Vic3lzdGVtOiAweDI3
ODI6MHgxNzE4IChPRE06IFNoZW56aGVuIENodWFuZ3dlaS1SR0IgRWxlY3Ryb25pY3MpDQpLZXJu
ZWw6ICAgIDYuMTkuMTEtYXJjaDEtMSAoYWxzbyB0ZXN0ZWQgb24gbGludXgtemVuLCBzYW1lIHJl
c3VsdCkNCkFMU0EgaW5mbzoNCmh0dHA6Ly9hbHNhLXByb2plY3Qub3JnL2RiLz9mPWE4NTE2MjBi
NTJjZjYzYTVlODQ2M2MwNGY3NWJmYWUxYTU5ZmRhYmENCg0KDQo9PSBQcm9ibGVtID09DQoNCklu
dGVybmFsIHNwZWFrZXJzIHByb2R1Y2Ugbm8gc291bmQuIEhlYWRwaG9uZSBqYWNrIGFuZCBCbHVl
dG9vdGggd29yaw0KY29ycmVjdGx5Lg0KVGhlIGlzc3VlIHBlcnNpc3RzIGFjcm9zcyBhbGwga2Vy
bmVscyB0ZXN0ZWQuIFdpbmRvd3Mgd29ya3MgY29ycmVjdGx5IHZpYQ0KUlRLVkhENjQuc3lzIChS
ZWFsdGVrLCB2ZXJzaW9uIDYuMC45NjYxLjEpLg0KDQoNCj09IFJvb3QgY2F1c2U6IGV4dGVybmFs
IGFtcGxpZmllciBhdCBJMkMxLzB4MzMgPT0NCg0KQWZ0ZXIgcnVsaW5nIG91dCBIREEgY29kZWMg
aXNzdWVzLCBJIGZvdW5kIGFuIEkyQyBkZXZpY2UgYXQgYnVzIDEsIGFkZHJlc3MNCjB4MzMsIGNv
bmZpcm1lZCBieSBpMmNkZXRlY3QgYW5kIGkyY2R1bXA6DQoNCiAgaTJjZGV0ZWN0IC15IDE6DQog
IDMwOiAtLSAtLSAtLSAzMyAtLSAtLSAtLSAtLQ0KDQogIGkyY2R1bXAgLXkgMSAweDMzIGIgKHNl
bGVjdGVkIHJlZ2lzdGVycyk6DQogIDcwOiBjMSAwMCAwMCAwMCAwMCAwMCBhYiAwMCAwMCAwMCAw
MCAwMCAwMCAwMSAwMCAwNg0KICBmMDogYzEgMDAgMDAgMDAgMDAgMDAgYWIgMDAgMDAgMDAgMDAg
MDAgMDAgMDEgMDAgMDYNCg0KICBLZXkgdmFsdWVzOiByZWdbMHg3MF09MHhDMSwgcmVnWzB4NzZd
PTB4QUIsIHJlZ1sweDdGXT0weDA2DQoNClRoaXMgZGV2aWNlIGlzIHRoZSBwaHlzaWNhbCBzcGVh
a2VyIGFtcGxpZmllci4gSXQgaXMgbmV2ZXIgcG93ZXJlZCBvbiBvcg0KY29uZmlndXJlZCBieSBM
aW51eCwgc28gYWxsIHNwZWFrZXIgb3V0cHV0IGlzIHNpbGVudC4NCg0KDQo9PSBBQ1BJIGFuYWx5
c2lzID09DQoNClRoZSBEU0RUIGRlY2xhcmVzIGEgSERBQyBkZXZpY2UgdW5kZXIgX1NCLlBDMDAu
STJDMSB3aXRoIGEgZHluYW1pYyBISUQgc2V0DQphdCBfSU5JIHRpbWUgYmFzZWQgb24gTlZTIHZh
cmlhYmxlcyBJMlNDIGFuZCBJMlNCOg0KDQogIEVsc2VJZiAoKEkyU0MgPT0gT25lKSkgICB7IF9I
SUQgPSAiSU5UMzRDMiI7IENBRFIgPSAweDFDIH0NCiAgRWxzZUlmICgoSTJTQyA9PSAweDAyKSkg
IHsgX0hJRCA9ICIxMEVDMTMwOCI7IENBRFIgPSAweDEwIH0NCg0KVGhlcmUgaXMgbm8gY2FzZSBj
b3ZlcmluZyBhZGRyZXNzIDB4MzMuIFRoZSBhbXBsaWZpZXIgaGFzIG5vIEFDUEkgZGV2aWNlDQpu
b2RlIHdpdGggYSBwcm9wZXIgSElELCBzbyBubyBMaW51eCBkcml2ZXIgYmluZHMgdG8gaXQuIFRo
ZSBkZXZpY2UgZXhpc3RzDQpwaHlzaWNhbGx5IG9uIHRoZSBidXMgYnV0IGlzIGludmlzaWJsZSB0
byB0aGUgTGludXggZHJpdmVyIG1vZGVsLg0KDQpUaGUgR05WUyByZWdpb24gKGJhc2UgMHg3MzRD
QTAwMCkgY29udGFpbnMgSTJTQyBhdCBvZmZzZXQgMHg4NDkgYW5kIEkyU0IgYXQNCm9mZnNldCAw
eDg0RSwgYnV0IHRoZXNlIGNvdWxkIG5vdCBiZSByZWFkIGRpcmVjdGx5IGR1ZSB0bw0KQ09ORklH
X1NUUklDVF9ERVZNRU0uDQoNCg0KPT0gSERBIGNvZGVjIHN0YXR1cyAobm90IHRoZSBwcm9ibGVt
KSA9PQ0KDQpGb3IgY29tcGxldGVuZXNzOiB0aGUgSERBIHNpZ25hbCBwYXRoIGlzIGZ1bGx5IGNv
cnJlY3QuDQogIFBpbiAweDE0IChTcGVha2VyKTogT1VUIGVuYWJsZWQsIEVBUEQgYWN0aXZlLCBB
bXAtT3V0IHVubXV0ZWQNCiAgREFDIDB4MDM6IHN0cmVhbSBhY3RpdmUgZHVyaW5nIHBsYXliYWNr
LCBBbXAtT3V0IHVubXV0ZWQNCiAgTWl4ZXIgMHgwZDogY29ycmVjdGx5IGNvbm5lY3RlZCB0byBE
QUMgMHgwMyBhbmQgcGluIDB4MTQNCg0KVGhlIG9ubHkgYW5vbWFseSBpcyB0aGF0IHBpbiAweDE0
IGlzIGF1dG9kZXRlY3RlZCBhcyBsaW5lX291dCBpbnN0ZWFkIG9mDQpzcGVha2VyX291dCwgYnV0
IHRoaXMgZG9lcyBub3QgYWZmZWN0IHRoZSBzaWduYWwgcGF0aCBhbmQgaXMgbm90IHRoZSByb290
DQpjYXVzZS4NCg0KDQo9PSBXaGF0IHdhcyB0cmllZCBhbmQgcnVsZWQgb3V0ID09DQoNCiAgLSBz
bmQtaGRhLWludGVsIG1vZGVsIHBhcmFtZXRlcnM6IGxhcHRvcC1hbWljLCBhY2VyLCBhY2VyLWFz
cGlyZSwNCmFsYzI2OS1kbWljLCBhbGMyNjl2Yi1hbWljDQogIC0gTWFudWFsIGhkYS12ZXJiIGNv
ZWZmIHJlZ2lzdGVyIHdyaXRlcyB0byBub2RlIDB4MjANCiAgLSBNYW51YWwgcGluL0VBUEQvR1BJ
TyBjb25maWd1cmF0aW9uIHZpYSBoZGEtdmVyYg0KICAtIGhkYWphY2tyZXRhc2sgcGluIG92ZXJy
aWRlcw0KICAtIExvYWRpbmcgc25kLWhkYS1zY29kZWMtdGFzMjc4MS1pMmMgKGNoaXAgaXMgbm90
IGEgVEFTMjc4MSkNCiAgLSBsaW51eC16ZW4ga2VybmVsDQoNCg0KPT0gV2hhdCBpcyBuZWVkZWQg
PT0NCg0KICAxLiBJZGVudGlmaWNhdGlvbiBvZiB0aGUgY2hpcCBhdCBJMkMxLzB4MzMgYmFzZWQg
b24gdGhlIHJlZ2lzdGVyDQpzaWduYXR1cmUgKDB4QzEsIDB4QUIsIDB4MDYpDQogIDIuIEEgTGlu
dXggZHJpdmVyIG9yIGluaXRpYWxpemF0aW9uIHNlcXVlbmNlIGZvciB0aGlzIGFtcGxpZmllcg0K
ICAzLiBJZiB0aGUgY2hpcCBpcyBpbml0aWFsaXplZCB2aWEgQUNQSSBtZXRob2RzIHRoYXQgV2lu
ZG93cyB0cmlnZ2VycyBhbmQNCkxpbnV4IGRvZXMgbm90LCBhbiBBQ1BJIHF1aXJrIG9yIGFjcGlf
Y2FsbCBob29rIG1heSBiZSBzdWZmaWNpZW50DQoNCk5vdGU6IHRoZSBXaW5kb3dzIGNvZGVjIGR1
bXAgdG9vbCBwcm92aWRlZCBpbiB0aGUgYnVnemlsbGEgYXR0YWNobWVudCAoYnVnDQojMjIxMjI0
LCBhdHRhY2htZW50IDMwOTY5OCkgY3Jhc2hlcyBvbiB0aGlzIGhhcmR3YXJlLCBzbyBJIHdhcyB1
bmFibGUgdG8NCm9idGFpbiBhIFdpbmRvd3Mtc2lkZSBkdW1wLg0KDQpJIGFtIGF2YWlsYWJsZSB0
byBydW4gYW55IGFkZGl0aW9uYWwgdGVzdHMsIHByb3ZpZGUgZnVydGhlciBkdW1wcywgb3IgdGVz
dA0KcGF0Y2hlcy4NCg0KVGhhbmsgeW91LA0KUmVuem8gUmlmb3MNCnJlbnpvcmlmb3NlemVxdWll
bDIwQGdtYWlsLmNvbQ0K
