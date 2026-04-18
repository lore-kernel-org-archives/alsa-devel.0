Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8993AF99C90
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Apr 2026 19:59:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 92C1F601E2;
	Sat, 18 Apr 2026 21:59:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 92C1F601E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776542391;
	bh=V/0JnFuPflrCkTih5poHefbpwzvGWy3ECFZ+xKx5ijA=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Jw/VZpLGyc40VmYi3tLR8vnvHc/LZ8VJYWjecULSBu5PsEdmWgLVMutmV5RktNZsW
	 ta6WygWR+4K9Pan/aIKjrpAZQ5X7YQRRqv28KJqzS90+e+06nRdIMTUKG3UIlaLAyw
	 f+5LRfEjI0MM70oENVN9Qgpuo7NgqiW9CGldl/dw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8740FF8061B; Sat, 18 Apr 2026 21:59:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5519EF80613;
	Sat, 18 Apr 2026 21:59:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AB0AFF804CF; Sat, 18 Apr 2026 16:31:29 +0200 (CEST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9F811F8001F
	for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2026 16:31:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F811F8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=R0erK8mD
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-79a74765703so14657547b3.3
        for <alsa-devel@alsa-project.org>;
 Sat, 18 Apr 2026 07:31:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776522685; cv=none;
        d=google.com; s=arc-20240605;
        b=UDObIxJGtQOO+YUMih+lZcQQ5XvOT3ejNdsLxQlHQ3fx3Ghq8tw/WKkVkXvrW4NPUB
         m2Oc8ifiQZ6j+EFt/dmPD4G+uUAPxvmelpy0cS8mck37CUM2YMak74TQjLSlQFk2bMfT
         H/tvkmpkZTigczi+K3KRwDhzqpednpbNT0VjVYywCpwq26RQ115n43BuneHdbakaFFcv
         +jiXmEzJYtiHxGyx6i8IHZ+cvbjsYreVeTcjAhL7e+5r/UXk5hWuF739rwcBvP8lzohq
         Lu1BYBLxRNTtsZ9joYKT2UANwGq6tg1rf+du18ZUXuWq1ev4zgHFBfvXV+x2YHd0AkGB
         v2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=nWfjr2ggjsuARLXezBsHO1WwhoKgm+kp+dxCH+t+kA4=;
        fh=s1h8N4U4ASgl2diPi2yKjEmsLSTuwbZjYBDYrAXLUvw=;
        b=adQP0Osy2gDXtBbqRq7Qk3Q2HiNtRfg62DHQgmUUDOL9EAYyAzV6Zdt18HVHJtyQrB
         2E8xY7/YGt+WprDwX180upXidR4dyCfY8dTktqkgSFfIuEmm0NUdrwUru/+SjsLGsJhp
         7afWGi9R293nE9rlIvhB1qE1L2vfb5aXu8D14zlNCH1Fz3bEIUHKMvKDDcmqvp+SRcUI
         Y1P0hFHrCoFqpXf9FCxLB/35tzbs6lTylLLjZx4mDYOM1qJktH5fcmO/EmMoz+XAZef8
         ZHEN04xP3bYqJKlo89w/z2fsgLxFoBiSScoCPVyjaJVJUruZxmPGupd9Nn5HtGSJifIn
         LtiA==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776522685; x=1777127485;
 darn=alsa-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nWfjr2ggjsuARLXezBsHO1WwhoKgm+kp+dxCH+t+kA4=;
        b=R0erK8mDoHx/wWVdYFvF0hNsOpWKERlhbmu2Y8/Og54ThsoB/LX3O27VVEQxpFhqgc
         YE5/ndIeEGcLp+1hxLjQVISBsjAFyFxS2T7/0r41P6eivoaFZNXZY8SRBLtMJUWPUjXc
         dkw2cUhZuWLdHPFJZO4XdIxc/gvQpMVjmcQmBkAoeFk/g7jjJzucgG3gtzmeU3IXoHIX
         /Ps1tuux2/Ivs2TW42e5uavnbfbOWIE8bCqh59fwav33SLcQsX75GsKryRtfL2vfWT/0
         NGNFWpreJHvemIn3a61O25dwCZIF0e5dnsusltYqVhB/mljHYKH6nHLYM67QDDyqUKY7
         9FHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776522685; x=1777127485;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWfjr2ggjsuARLXezBsHO1WwhoKgm+kp+dxCH+t+kA4=;
        b=I7ZPadAK9x20D4I2/aij8lxCQMLszVSOOC/9PvhDjNTvD6HugXUYcnhW6VF4s3cFY9
         2kQy/gmuA71cW28hYbukgbjvCEdc7NM9u4E4/cj9Wfj/Uk52WhsvqJh+3alwHUHJ2bl1
         4rMOVxeKDUr2T0oeGtAUEqBdBaGMZ8Q7+W7aAS9/z4YGb/XmfnbDGKqOoqG5SOo7lkRn
         1PoxeCpqJZA2gdf8QhHKc69Js7joVqzHmteQrL7hSPt6TuHxmiMvlWAuJN5ZMXZCnuYs
         z0KNWDm1MtiHUdMa2UMlgySe9G+QuiOBb4QtYB1SGWvOlSbDo9Eaw9Y+3NpQRDC2pUMW
         hsaQ==
X-Gm-Message-State: AOJu0YwBRs0tk1s4k51OeEVtYU+0nngJnB+7AmYqaqvx+IExEbeQh10E
	+Hl0E/m26oU76KeoxGNRkePIrNWaRtO79AF6Y2zzZO1AVLQ3A7lrtm7GNZzWiCpYRT1Q9cAQWTd
	KuKtd9tln7NOGrf5K7OUnj6wDdcGJcB2CgTuL
X-Gm-Gg: AeBDievHYKxpvVHPAD95T+/qdIFDBmKzvPY/clSDK0h4ZR42vhkskPE6QfLwp+tbcqB
	335LqqzejVSrjo0HQUc4ALDiRxUgQ5YspGuITgBnfHlmpEp84C6m0+df2ZtlUVmVw1eqDSdmVd1
	qgI1LnH8npBYg/kXWVOK0njhedHsBHCoYkJuIXTM7NljBSKCR3P1j1sFJxO+J1RTrgKehlPHonQ
	jCvWkD8olCsWEgMrUkqAmMorHN/cY2qOrO5WwhoP1Rmaj95xqriCznmRO2CJUEziGEARnZcCWkp
	Y0P1LqluW8+6dYKEjXo=
X-Received: by 2002:a05:690c:4805:b0:79a:c98d:2b99 with SMTP id
 00721157ae682-7b9ed06ac49mr74065037b3.50.1776522684633; Sat, 18 Apr 2026
 07:31:24 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?QXlkxLFuIFQuIEJha8Sxcg==?= <aydintb@gmail.com>
Date: Sat, 18 Apr 2026 17:30:48 +0300
X-Gm-Features: AQROBzBL2Be5p1kTGOmCH7TdA9dnshb6ICeYWUTDQo2-ZdvrRhCd9_wTwOHcSsw
Message-ID: 
 <CAE+AOV9O5zaUdbNEd7FcoaVwQVWZWn2xGk4=_VPs9rsTb7iqjQ@mail.gmail.com>
Subject: 
 =?UTF-8?Q?=5BBUG=5D_TAS2781_=28TXNW2781=29_Firmware_is_NULL_=2F_IRQ_inde?=
	=?UTF-8?Q?x_0_not_found_on_ASUS_ROG_Strix_SCAR_18_G835LX_=E2=80=94_regressio?=
	=?UTF-8?Q?n_in_6=2E19=2B?=
To: alsa-devel@alsa-project.org
X-MailFrom: aydintb@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: EYIMYV7S2HL3FV2PFLEX7NHFNSVE5ZVW
X-Message-ID-Hash: EYIMYV7S2HL3FV2PFLEX7NHFNSVE5ZVW
X-Mailman-Approved-At: Sat, 18 Apr 2026 19:59:00 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EYIMYV7S2HL3FV2PFLEX7NHFNSVE5ZVW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

KlRpdGxlOiogVEFTMjc4MSBzbWFydCBhbXBsaWZpZXI6IHRhc2RldmljZV9wcm1nX2xvYWQ6IEZp
cm13YXJlIGlzIE5VTEwgb24NCkFTVVMgUk9HIFN0cml4IFNDQVIgMTggRzgzNUxYIOKAlCByZWdy
ZXNzaW9uIGludHJvZHVjZWQgYmV0d2VlbiBrZXJuZWwgNi4xOA0KYW5kIDYuMTkNCg0KKkhhcmR3
YXJlOioNCg0KICAgLSBMYXB0b3A6IEFTVVMgUk9HIFN0cml4IFNDQVIgMTggRzgzNUxYLVMtQTE1
Mw0KICAgLSBDUFU6IEludGVsIENvcmUgVWx0cmEgOSAyNzVIWA0KICAgLSBBdWRpbyBjb2RlYzog
UmVhbHRlayBBTEMyODUgKFN1YnN5c3RlbSBJRDogMHgxMDQzM2YxMCkNCiAgIC0gU21hcnQgYW1w
bGlmaWVyczogM3ggVGV4YXMgSW5zdHJ1bWVudHMgVEFTMjc4MSAodmlhIEkyQywgZGV2aWNlDQog
ICBUWE5XMjc4MTowMCkNCiAgIC0gT1M6IENhY2h5T1MgKEFyY2gtYmFzZWQpDQogICAtIFdvcmtp
bmcga2VybmVsOiA2LjE4LjIyLTEtY2FjaHlvcy1sdHMNCiAgIC0gQnJva2VuIGtlcm5lbHM6IDYu
MTkuMTItMS1jYWNoeW9zLCA3LjAuMC0xLWNhY2h5b3MNCiAgIC0gQWxzbyBicm9rZW4gb24gQ2Fj
aHlPUyBsaXZlIFVTQiAob2xkZXIga2VybmVsLCBleGFjdCB2ZXJzaW9uIHVua25vd24pDQoNCipQ
cm9ibGVtIGRlc2NyaXB0aW9uOiogQnVpbHQtaW4gc3BlYWtlcnMgcHJvZHVjZSBleHRyZW1lbHkg
bG93IHZvbHVtZSB3aXRoDQpoZWF2eSBkaXN0b3J0aW9uL25vaXNlLiBIZWFkcGhvbmUgamFjayB3
b3JrcyBjb3JyZWN0bHkuIFRoZSBBU1VTIGJvb3QgY2hpbWUNCihwbGF5ZWQgYXQgZmlybXdhcmUg
bGV2ZWwpIGFsc28gd29ya3MgY29ycmVjdGx5IHRocm91Z2ggc3BlYWtlcnMsDQpjb25maXJtaW5n
IHRoZSBzcGVha2VycyBhcmUgcGh5c2ljYWxseSBmdW5jdGlvbmFsLg0KDQpUaGUgcHJvYmxlbSBp
cyBub3QgcHJlc2VudCBvbiBrZXJuZWwgNi4xOC4yMi1MVFMgYW5kIHJlYXBwZWFycyBvbiA2LjE5
Ky4NCg0KKlJlbGV2YW50IGRtZXNnIG91dHB1dDoqDQpTZXJpYWwgYnVzIG11bHRpIGluc3RhbnRp
YXRlIHBzZXVkbyBkZXZpY2UgZHJpdmVyIFRYTlcyNzgxOjAwOiBlcnJvcg0KLUVOWElPOiBJUlEg
aW5kZXggMCBub3QgZm91bmQNClNlcmlhbCBidXMgbXVsdGkgaW5zdGFudGlhdGUgcHNldWRvIGRl
dmljZSBkcml2ZXIgVFhOVzI3ODE6MDA6IGVycm9yDQotRU5YSU86IElSUSBpbmRleCAwIG5vdCBm
b3VuZA0KU2VyaWFsIGJ1cyBtdWx0aSBpbnN0YW50aWF0ZSBwc2V1ZG8gZGV2aWNlIGRyaXZlciBU
WE5XMjc4MTowMDogZXJyb3INCi1FTlhJTzogSVJRIGluZGV4IDAgbm90IGZvdW5kDQpTZXJpYWwg
YnVzIG11bHRpIGluc3RhbnRpYXRlIHBzZXVkbyBkZXZpY2UgZHJpdmVyIFRYTlcyNzgxOjAwOiBJ
bnN0YW50aWF0ZWQNCjMgSTJDIGRldmljZXMuDQp0YXMyNzgxLWhkYSBpMmMtVFhOVzI3ODE6MDAt
dGFzMjc4MS1oZGEuMDogdGFzZGV2aWNlX3BybWdfbG9hZDogRmlybXdhcmUgaXMNCk5VTEwNCg0K
U2VyaWFsIGJ1cyBtdWx0aSBpbnN0YW50aWF0ZSBwc2V1ZG8gZGV2aWNlIGRyaXZlciBUWE5XMjc4
MTowMDogZXJyb3INCi1FTlhJTzogSVJRIGluZGV4IDAgbm90IGZvdW5kU2VyaWFsIGJ1cyBtdWx0
aSBpbnN0YW50aWF0ZSBwc2V1ZG8NCmRldmljZSBkcml2ZXIgVFhOVzI3ODE6MDA6IGVycm9yIC1F
TlhJTzogSVJRIGluZGV4IDAgbm90IGZvdW5kU2VyaWFsDQpidXMgbXVsdGkgaW5zdGFudGlhdGUg
cHNldWRvIGRldmljZSBkcml2ZXIgVFhOVzI3ODE6MDA6IGVycm9yIC1FTlhJTzoNCklSUSBpbmRl
eCAwIG5vdCBmb3VuZFNlcmlhbCBidXMgbXVsdGkgaW5zdGFudGlhdGUgcHNldWRvIGRldmljZSBk
cml2ZXINClRYTlcyNzgxOjAwOiBJbnN0YW50aWF0ZWQgMyBJMkMgZGV2aWNlcy50YXMyNzgxLWhk
YQ0KaTJjLVRYTlcyNzgxOjAwLXRhczI3ODEtaGRhLjA6IHRhc2RldmljZV9wcm1nX2xvYWQ6IEZp
cm13YXJlIGlzIE5VTEwNCg0KKkFuYWx5c2lzOioNCg0KICAgLSBBbGwgMyBUQVMyNzgxIGFtcGxp
ZmllciBjaGlwcyBhcmUgZGV0ZWN0ZWQgb24gdGhlIEkyQyBidXMgKA0KICAgL3N5cy9idXMvaTJj
L2RldmljZXMvIHNob3dzIGFsbCAzKQ0KICAgLSBUaGUgZHJpdmVyIChzbmRfaGRhX3Njb2RlY190
YXMyNzgxX2kyYykgbG9hZHMgYnV0IGZhaWxzIHdpdGggLUVOWElPOg0KICAgSVJRIGluZGV4IDAg
bm90IGZvdW5kIGZvciBhbGwgMyBjaGlwcyBkdXJpbmcgaW5pdGlhbGl6YXRpb24NCiAgIC0gRGVz
cGl0ZSBJUlEgZmFpbHVyZSwgZGV2aWNlcyBhcmUgaW5zdGFudGlhdGVkIOKAlCBidXQgdGhlIGRy
aXZlciB0aGVuDQogICBmYWlscyB0byBsb2FkIGZpcm13YXJlIChGaXJtd2FyZSBpcyBOVUxMKQ0K
ICAgLSBGaXJtd2FyZSBmaWxlcyBhcmUgcHJlc2VudCBhbmQgdmFsaWQ6DQogICAvdXNyL2xpYi9m
aXJtd2FyZS90aS9hdWRpby90YXMyNzgxL1RBUzJYWFgzRjEwMC5iaW4uenN0IGFuZA0KICAgVEFT
MlhYWDNGMTAxLmJpbi56c3QgKDcuM0tCIGVhY2gsIG5vdCBicm9rZW4gc3ltbGlua3MpDQogICAt
IFdpdGhvdXQgcHJvcGVyIGFtcGxpZmllciBpbml0aWFsaXphdGlvbiwgYXVkaW8gYnlwYXNzZXMg
dGhlDQogICBEU1AvYW1wbGlmaWVyIGVudGlyZWx5LCByZXN1bHRpbmcgaW4gdGhlIGRpc3RvcnRl
ZCBsb3ctdm9sdW1lIG91dHB1dA0KICAgLSBUaGUgSVJRIGZhaWx1cmUgc3VnZ2VzdHMgbWlzc2lu
ZyBvciBpbmNvbXBsZXRlIEFDUEkgX0RTRCBwcm9wZXJ0aWVzDQogICBmb3IgdGhlIFRBUzI3ODEg
ZGV2aWNlcyDigJQgc2ltaWxhciB0byBrbm93biBpc3N1ZXMgd2l0aCBDUzM1TDQxIG9uIG90aGVy
DQogICBBU1VTIFJPRyBsYXB0b3BzIOKAlCBidXQgdGhpcyB3b3JrZWQgb24ga2VybmVsIDYuMTgs
IHN1Z2dlc3RpbmcgYSByZWdyZXNzaW9uDQogICBpbiBob3cgdGhlIGRyaXZlciBoYW5kbGVzIG1p
c3NpbmcgSVJRIHJlc291cmNlcyBpbiA2LjE5Kw0KDQoqV2hhdCB3b3JrczoqDQoNCiAgIC0gSGVh
ZHBob25lIGphY2sgKGFuYWxvZyBvdXRwdXQgdmlhIEFMQzI4NSwgYnlwYXNzZXMgVEFTMjc4MSkN
CiAgIC0gU3BlYWtlcnMgb24ga2VybmVsIDYuMTguMjItTFRTDQogICAtIEFTVVMgYm9vdCBjaGlt
ZSB0aHJvdWdoIHNwZWFrZXJzIChmaXJtd2FyZS1sZXZlbCwgYnlwYXNzZXMgT1MgYXVkaW8NCiAg
IHN0YWNrKQ0KDQoqV2hhdCBkb2Vzbid0IHdvcms6Kg0KDQogICAtIFNwZWFrZXIgb3V0cHV0IG9u
IGtlcm5lbCA2LjE5LnggYW5kIDcuMC54DQoNCipNb2R1bGVzIGludm9sdmVkOioNCg0KICAgLSBz
bmRfaGRhX3Njb2RlY190YXMyNzgxX2kyYw0KICAgLSBzbmRfaGRhX3Njb2RlY190YXMyNzgxX3Nw
aQ0KICAgLSBzbmRfaGRhX3Njb2RlY190YXMyNzgxDQogICAtIHNuZF9zb2NfdGFzMjc4MV9mbXds
aWINCg0KKlN1Z2dlc3RlZCBiaXNlY3QgcmFuZ2U6KiBCZXR3ZWVuIGtlcm5lbCA2LjE4IGFuZCA2
LjE5LCBzcGVjaWZpY2FsbHkNCmNoYW5nZXMgdG8gc25kX2hkYV9zY29kZWNfdGFzMjc4MSBvciB0
aGUgc2VyaWFsIGJ1cyBtdWx0aS1pbnN0YW50aWF0ZQ0KZHJpdmVyIChkcml2ZXJzL3BsYXRmb3Jt
L3g4Ni9zZXJpYWwtbXVsdGktaW5zdGFudGlhdGUuYykgcmVsYXRlZCB0byBJUlENCmhhbmRsaW5n
Lg0K
