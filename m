Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D95CD37B6
	for <alsa-devel@archiver.kernel.org>; Wed, 13 May 2026 07:05:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A56B060210;
	Wed, 13 May 2026 09:05:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A56B060210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778655916;
	bh=W0WhD5bfTie0chP7Rci9yywjntq3PU3W3b7ULXT0YO0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Q9M6FCq0JySluayJ3jJwqOddsr84d+fqJpi7jFS2Rz7Iq9hNLjy1lORTOi/tte1oG
	 GZaNEtaUbZDguHkqwnmqA4OoZDr6XSyLfVzh0otbkQbTo3Gt6H5LHxPPVN6sgEsMzy
	 Q/DxLSDleLHMEpbyviKgeTNtSzvgE9pPJ9p6QZNY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E2BE7F8060C; Wed, 13 May 2026 09:04:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8564FF80612;
	Wed, 13 May 2026 09:04:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EC6BAF804CC; Tue, 12 May 2026 07:50:04 +0200 (CEST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C4AE1F80154
	for <alsa-devel@alsa-project.org>; Tue, 12 May 2026 07:50:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C4AE1F80154
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Mtdvh78K
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-bd11a3729e8so207214666b.0
        for <alsa-devel@alsa-project.org>;
 Mon, 11 May 2026 22:50:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778565000; cv=none;
        d=google.com; s=arc-20240605;
        b=PT3vWdELyw4ip4g45Bhsg8bqWwRLflhGOivpfYnqsyF10TkctkYozfVzdmXpMlZllk
         ywAZDn/8Zu+mskg6MELe+/UueYpaNpEFowFP3jDfKhEL051l3CBUNMfY4o+BLiD8m0TL
         Jslfx+a3SQ1rGQENNrJeKeRXGg1aAd+bBkBhUVNF1/yfAi2b5aZcJfMWSG+g89W6M5tr
         kA9E77GlkAG8pZId7iSIAdJpMMvioUye6XRG8dy5foSyQR961oP4TZdZMI0U3uUNVh+s
         2BZorzAgnPgHQr+Rzk0SmsyDV9jjNp9ZWNIDuB03yhouz2mu/unFGSY3ZHROmv4NdeV9
         dY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=baFO4qQETM9mk6wNubEIuvJuAJQPDx1pKsB1V9oWThk=;
        fh=BQRdV9AWD1b2udi+etg/5dxtCuejL6NkM40OS0Mb0JI=;
        b=TLcucz2T2RvvchT4OH28ynAWiDkFF8iiE1uUpr7TSdeghbYOOwfJuOhRSijyEhHFmY
         rnRoPHLYfsBEgliS59wF/25IdeEgbz3Us5WviZ0LnH7FY3hlLjUv0o/kbMmdNIze53rM
         1FjBanRdOiFDxymcAWGXwL9KI+AR19Kx1ChTD0Q2Mr+4atyhXLgPlzwhXD5JfnGAWeoL
         qjQJWYBZWGd0RI3phFgCQD52eNN/fdLtLtaxgcZCFEfYl47PU4Ww4lTtZgcG8kY/8OGB
         wovQef9khjtbQV0xLWbR8j/1rWR4GVbgYyRqO6+CIoUJDMv+WYss92sLhEo3SS8JKwew
         OXwA==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778565000; x=1779169800;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=baFO4qQETM9mk6wNubEIuvJuAJQPDx1pKsB1V9oWThk=;
        b=Mtdvh78KDXboXhlfby7T/YPxiPuu+dC631xLHYh/7Yw4kr2BOkSlMBCCM3wCs3Fmif
         y2KEnNDq0i6R22ZBK8uei6o+4ot/2/GZwQp0x3MWbylPPKKwaLy8tgDZXvsY1gqYzJsR
         gUtrV+mMigOpjQ5DWblRDPIaz8JZXhqwC9zTmmu7uxFdL/pNmDmTjOs0SpXqr8kM6Tov
         j2Co2cUtug1/ERE6sT/Et34Is2DcBdYzwnJyktcG3KbnUw1JW2ttEGozoJ7Fw57IPucV
         1niDxxu5uoP7uDMxmm25kE0LixSzldO5UbbZ6JXPrXatpamB/G+dyk+rssbQCFgFmrYH
         53Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778565000; x=1779169800;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baFO4qQETM9mk6wNubEIuvJuAJQPDx1pKsB1V9oWThk=;
        b=Kf9qaE/C9cXACZsAjaxQK97OI5hTiWFCDQsb907cICqssxKfc5uCfX9olXy+aEEvke
         UAJcsztpgX9wCECCrX1ZrhYUu7Tu4mzA1piAbUhGLtE247fgszjq/0k2n1eYAzmaNevP
         jdReSm9Ed+R4Ix4CLgKZrFg4eLgqRQx1AbXwdYqZrTp/vNdGHRHJeMejX/qWZ086am+x
         v+ylsiKpj8qNNjz88dqrmmAxSe6ektxJijNjtkhi9n+eLAyuHV5v+gugZDz07qCRwYCk
         4slsaXgS322Y3k/wGUbK2gUJ0Wto/DELHGHlrazoDtddo+zmFZ4hLBLZWuU9WydK55g9
         xaXg==
X-Gm-Message-State: AOJu0Yx+yMgQzJk7gvJfXidAoHMddSNxEeBBgbzhXxiQ/SlsR/mjaW7a
	Kv/74d9aIW0vddIKmXz+fNc5o/0uOIo/+MwehgMSMDZD5Pg4qiKtVuizqJRtc50Crb6TaCLYPsw
	3HJnS+iTXeL9aKBahcwrhDmNXi46R+AI=
X-Gm-Gg: Acq92OGdrtYpA8ItBUWA6i9CGEM0OZ8dqedwH/e6USGCjr1oiqivOXFbI5aKO4qE8gd
	L66DkoZb/1rubc5u05FqdBi8Gr7oKxa3yBWsbpNmxD61ay63PYkZl5JrA8wtCYm9F8MKTXya6Se
	LlhZkhTRazqNz+uxztpcqFP+DYqs6J5ec6LTfpFR326Nnt6ZLhBJzV57K+rhVpw7iSCPEnLqJIF
	6wszo71vxxAFhp8bmMZHNX+I0kAxfrCG9Mblt0wOh7pChT8UMtmYTS63o0Md3LeUFM9elNi9RMC
	wBXy
X-Received: by 2002:a17:907:7fa7:b0:bb8:c3a8:9ad7 with SMTP id
 a640c23a62f3a-bcc12669382mr719647366b.13.1778565000295; Mon, 11 May 2026
 22:50:00 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CAKxS5A_OhoDGvVXZUnvUtv=j0zQ5Txq8g9_ScCPw12ZKfrmxOw@mail.gmail.com>
 <2dd667af-308a-4b72-af97-707b0a493f3e@amd.com>
In-Reply-To: <2dd667af-308a-4b72-af97-707b0a493f3e@amd.com>
From: =?UTF-8?Q?Alen_Ti=C5=A1ljar?= <alen.tisljar@gmail.com>
Date: Tue, 12 May 2026 07:49:47 +0200
X-Gm-Features: AVHnY4JpmT_vxJpmb2VyfpM3zfgtDlkgH_twrEhMneQEUcv2YZ-PBdDoAKr3iLE
Message-ID: 
 <CAKxS5A_pTv7qky_+izy+wxqq7gN0XBjoqUTo9OhNCuo_BLZ4bA@mail.gmail.com>
Subject: Re: [BUG] ASoC: amd: yc: HP Notebook 255R G10 (board 8D22) missing
 from quirk table
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, Vijendar.Mukunda@amd.com
X-MailFrom: alen.tisljar@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: TQ3XE3O3FP4D6SH7LRSQ3HQP2ABO2ERZ
X-Message-ID-Hash: TQ3XE3O3FP4D6SH7LRSQ3HQP2ABO2ERZ
X-Mailman-Approved-At: Wed, 13 May 2026 07:04:23 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TQ3XE3O3FP4D6SH7LRSQ3HQP2ABO2ERZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGkgTWFyaW8sDQoNCnRoYW5rcyBmb3IgdGhlIHF1aWNrIHJlc3BvbnNlLiBJJ20gbm90IHNldCB1
cCB0byBidWlsZCBhIGN1c3RvbSBrZXJuZWwNCmxvY2FsbHkgeWV0Lg0KDQpXb3VsZCBpdCBiZSBw
b3NzaWJsZSBmb3IgeW91IHRvIHBvaW50IG1lIGF0IGEgdGVzdCBrZXJuZWwgYnVpbGQgKGUuZy4g
YQ0KREtNUyBtb2R1bGUsIG9yIGEga2VybmVsIGJ1aWxkIGZyb20geW91ciB0cmVlKSB0aGF0IEkg
Y291bGQgaW5zdGFsbCBhbmQNCnRlc3Q/DQoNCkFsdGVybmF0aXZlbHksIEknbSB3aWxsaW5nIHRv
IGZvbGxvdyBidWlsZCBpbnN0cnVjdGlvbnMgaWYgeW91IGhhdmUgYQ0KcmVjb21tZW5kZWQgd29y
a2Zsb3cuDQoNClJlZ2FyZHMsDQpBbGVuDQoNCk9uIE1vbiwgTWF5IDExLCAyMDI2LCAyMzoyOSBN
YXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCndyb3RlOg0KDQo+
DQo+DQo+IE9uIDUvMTEvMjYgMTU6NDksIEFsZW4gVGnFoWxqYXIgd3JvdGU6DQo+ID4gSGVsbG8s
DQo+ID4NCj4gPiBUaGUgaW50ZXJuYWwgbWljcm9waG9uZSBvbiB0aGUgSFAgTm90ZWJvb2sgMjU1
UiBHMTAgZG9lcyBub3Qgd29yayBvbg0KPiA+IExpbnV4IGJlY2F1c2UgdGhlIGJvYXJkIGlzIG1p
c3NpbmcgZnJvbSB0aGUgQUNQNnggRE1JIHF1aXJrIHRhYmxlIGluDQo+ID4gc291bmQvc29jL2Ft
ZC95Yy9hY3A2eC1tYWNoLmMuDQo+ID4NCj4gPiBIYXJkd2FyZToNCj4gPg0KPiA+IExhcHRvcDog
SFAgTm90ZWJvb2sgMjU1UiBHMTANCj4gPiBCb2FyZCBuYW1lOiA4RDIyIChIUCkNCj4gPiBBdWRp
byBjb3Byb2Nlc3NvcjogQU1EIEFDUC9BQ1AzWC9BQ1A2eA0KPiA+IEFuYWxvZyBjb2RlYzogUmVh
bHRlayBBTEMyMzYgKHdvcmtpbmcgZmluZSBmb3Igc3BlYWtlcnMvaGVhZHBob25lcykNCj4gPg0K
PiA+IFN5bXB0b21zOg0KPiA+DQo+ID4gSW50ZXJuYWwgbWljcm9waG9uZSBpcyBub3QgY2FwdHVy
ZWQuDQo+ID4gTm8gYWNwNnggRE1JQyBkZXZpY2UgYXBwZWFycyBpbiBhcmVjb3JkIC1sIOKAlCBv
bmx5IHRoZSBBTEMyMzYgYW5hbG9nDQo+ID4gaW5wdXRzIGFyZSBsaXN0ZWQuDQo+ID4gSW4gZG1l
c2csIHRoZSBBQ1A2eCBQQ0kgZGV2aWNlIGlzIGVuYWJsZWQuDQo+ID4NCj4gPiBUZXN0ZWQgb246
DQo+ID4NCj4gPiBVYnVudHUgMjQuMDQgTFRTIChib2FyZCA4RDIyIGlzIG5vdCBwcmVzZW50IGlu
IHRoZSBtYWlubGluZQ0KPiA+IGFjcDZ4LW1hY2guYyBhcyBvZiB0b2RheSkNCj4gPg0KPiA+IFJl
bGV2YW50IGRtZXNnIG91dHB1dDoNCj4gPg0KPiA+ICAgICAgc25kX3BjaV9hY3A2eCAwMDAwOjAz
OjAwLjU6IGVuYWJsaW5nIGRldmljZSAoMDAwMCAtPiAwMDAyKQ0KPiA+DQo+ID4gbm8gZnVydGhl
ciBBQ1A2eC9ETUlDIG1lc3NhZ2VzIGZvbGxvdw0KPiA+DQo+ID4gYXJlY29yZCAtbDoNCj4gPg0K
PiA+ICoqKiogTGlzdCBvZiBDQVBUVVJFIEhhcmR3YXJlIERldmljZXMgKioqKg0KPiA+IGNhcmQg
MTogR2VuZXJpY18xIFtIRC1BdWRpbyBHZW5lcmljXSwgZGV2aWNlIDA6IEFMQzIzNiBBbmFsb2cg
W0FMQzIzNg0KPiBBbmFsb2ddDQo+ID4gY2FyZCAxOiBHZW5lcmljXzEgW0hELUF1ZGlvIEdlbmVy
aWNdLCBkZXZpY2UgMjogQUxDMjM2IEFsdCBBbmFsb2cNCj4gPiBbQUxDMjM2IEFsdCBBbmFsb2dd
DQo+ID4NCj4gPiBTdWdnZXN0ZWQgZml4Og0KPiA+DQo+ID4gQWRkIHRoZSBmb2xsb3dpbmcgZW50
cnkgdG8geWNfYWNwX3F1aXJrX3RhYmxlW10gaW4NCj4gPiBzb3VuZC9zb2MvYW1kL3ljL2FjcDZ4
LW1hY2guYywgYW5hbG9nb3VzIHRvIGNvbW1pdCAwYzY0OThhNTlmYmINCj4gPiAoIkFTb0M6IGFt
ZDogeWM6IEFkZCBIUCAyNTUgRzEwIGludG8gcXVpcmsgdGFibGUiKSB3aGljaCBoYW5kbGVkIHRo
ZQ0KPiA+IGNsb3NlbHkgcmVsYXRlZCBIUCAyNTUgRzEwIChib2FyZCA4QjJGKToNCj4gPg0KPiA+
IHsNCj4gPiAgICAgIC5kcml2ZXJfZGF0YSA9ICZhY3A2eF9jYXJkLA0KPiA+ICAgICAgLm1hdGNo
ZXMgPSB7DQo+ID4gICAgICAgICAgRE1JX01BVENIKERNSV9CT0FSRF9WRU5ET1IsICJIUCIpLA0K
PiA+ICAgICAgICAgIERNSV9NQVRDSChETUlfQk9BUkRfTkFNRSwgIjhEMjIiKSwNCj4gPiAgICAg
IH0NCj4gPiB9LA0KPiA+DQo+ID4gSSdtIGhhcHB5IHRvIHRlc3QgYW55IHByb3Bvc2VkIHBhdGNo
IG9uIHRoaXMgaGFyZHdhcmUuIEknbSBub3QNCj4gPiBjdXJyZW50bHkgc2V0IHVwIHRvIHN1Ym1p
dCBhIGZvcm1hbCBwYXRjaCB2aWEgZ2l0IHNlbmQtZW1haWwsIGJ1dCBpZg0KPiA+IG5vIG9uZSBp
cyBhYmxlIHRvIHBpY2sgdGhpcyB1cCwgSSdtIHdpbGxpbmcgdG8gc3VibWl0IG9uZSBteXNlbGYu
DQo+ID4NCj4gPiBUaGFuayB5b3UsDQo+ID4NCj4gPiBBbGVuIFRpxaFsamFyDQo+DQo+IENhbiB5
b3UgdGVzdCB0aGUgcGF0Y2ggdGhhdCB5b3UgcHJvcG9zZWQgYWJvdmUgYW5kIHNlZSBpZiBpdCBh
Y3R1YWxseQ0KPiB3b3Jrcz8NCj4NCj4NCg==
