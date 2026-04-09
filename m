Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50798F3ED5C
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Apr 2026 20:26:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 71EB360224;
	Sat, 11 Apr 2026 22:25:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 71EB360224
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775939158;
	bh=z8pDb73H8UHzTcWnajRaYwKjKgwUses/C12ySsRezHY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=TuD9+U7mXtZkUUTZ4bKio3LKdNXVnBvam/ZUkL+F/k67g4WbL1yq6Bapsht41zozH
	 Q9C4kRu80exgAv2ybaqQD/9Dm2KWxUdYjyIHNh8ElzK6jtM8zDlEWbg6hXPzm+k4Hz
	 +o7H2vL0YKYQ2vXMeGunMN8Pa2S5Et4NnAyJmgbs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 573ACF80614; Sat, 11 Apr 2026 22:25:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ED303F8060A;
	Sat, 11 Apr 2026 22:25:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 045B3F8052D; Thu,  9 Apr 2026 13:00:23 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com
 [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E5409F800BA
	for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2026 13:00:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5409F800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QYdt06an
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-12c287eb77fso1824458c88.1
        for <alsa-devel@alsa-project.org>;
 Thu, 09 Apr 2026 04:00:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775732418; cv=none;
        d=google.com; s=arc-20240605;
        b=NFDgsbMZDLwcAR0gTTjDJ+CIxhaBhMPnCy2KHzgTzVJnLiFSqf4dC74lnpQxWHmygm
         9elLfQldXDBLuZgkEgMMqtfZvrpMkw4FPzj0u6JPJ3GmS/9Cg0RaPCPFsWkKNVBJr1ie
         +OP/ZZhBh3HSdiJGU5Zwn1x0v4f0I/ONFbkFrps35Et0kMh4J9L/KbXdpNMwl15jIMBl
         0jN1pLHBoP/Cq5TRojorYyIDpkpYSopVcgIyKqiBQ+zRLbyJ+QHrHt5rROM5v0AaxFYT
         EKVgCbUBQga9/SlPEzKjhYND2oz+8QuK136suna2F2+Y906uXiRU7rGIhinFhzLDCrHP
         u7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=S/x1KsRVv1k8pa0hj7ZzqLw5x61qMgepYhfCzPYz7as=;
        fh=yoEXir074R2qAcsxnEeZogvTGOK8vLm1mNKn0zYlZQg=;
        b=ctZanJ6q080yVly9BxPDG4VqV+xxUcpWFOIDKkWgHmYA8KpZPFPAMCmbhm+00rUVZl
         LXdWxTUs8NQH4lSGAYlv8E0+q7+pXiMG+JMzEoEia+PAK3cTRpTfGAJcyrRLhR6Qszqz
         o/yYsYyd4JWXEFO/ZrVbhiwYlpxgFMBeVaF/HGGK4a5XLOf5UT3DDM6NFD1nDO5QMUZH
         wuimM9SQxwTZ6WHGXpr4Sry6pjk7VhHBum62/3EtO4yOzbMjt6JMtouHTlABDiIfKIxq
         qCHklRWdm4mQb26vKk+iwdR3prCuugY7bql4TIInh/E1aUNnH9eWD0SsMxI9aK1xOgNO
         m9zA==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775732418; x=1776337218;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S/x1KsRVv1k8pa0hj7ZzqLw5x61qMgepYhfCzPYz7as=;
        b=QYdt06anLk/pnx2sxH+h1Ety02aJJugr/aQTYlQInKCpDLaUWRcCRIPuc0+ppJEehM
         N8e+KYzHsza4LjqL5skf5wJUI2KkUMU43Bue2gdnvqRBqw3t7u9VFRWAHb0qUjmbImST
         7Ud5YMcV2jdee5UzLlCskQRmiQsWqPL9zhgu6hgirFqlX3+nFkD/aD9A8QDoes1udTjZ
         IrvjLLGqaJHK8JXuZHjLkQEQ/J40dojxVOIOCY1JKmYp8rKf5O1MdG/D//frr9jZaTV6
         3DnO1bdk5JVpwE7rS2GQ2IwKNaIGCPSsY2EoQ8FEyyGQBG692WrOgwVh4sKFI9HgYVGf
         q8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775732418; x=1776337218;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/x1KsRVv1k8pa0hj7ZzqLw5x61qMgepYhfCzPYz7as=;
        b=f0p5Yr3MukodKFntOYYWaRvFy274hSx/FtAuSmgbvL22n2LQTg/UGBVzpwQWTFUuH/
         bvhNyGgad0gjmxTp2qfGwNWzGwcFpIP/JD+fnHEK/rDWOD71doEQ66saDIW0i8o8Qpcq
         Icgfpi5QzAzDMpgaepHUiqPAIF2FuyMH2ew5qIflsxcBeRWC9bajfyicZO2vZ3OvCJY6
         m4m6Kq8+Jerw4zIxFt7rJsXPehlhmlAPBVtf0Tg1iv216YYAHj4rn055v7AVWKPMUjry
         2AKrFOSep5mKjiQMW8I7RcG3xUuPDPiyWeLgj2K+cH19WcovMJGKG2Wd7ZUJ3yE7zFGa
         zQFw==
X-Gm-Message-State: AOJu0YwFMAS4AnEcv9MA89VlJ+ps9PwrbRqmw9M1R+fi3yyGPaWC+zzc
	0N8vXFT4Q2PIjHQFxJJdS7GrLPJ+iqzO8EusK84zT1Ej4F5KIPKfZAsYGOzgZc1UOe0XJ90fokS
	CECKsQGBr3YXZuIBJuTg+dTybghEfGYY=
X-Gm-Gg: AeBDieufWif0+I9DU63uuP5AlIANJ46eJGI+0qruvhjtrrEKLXDroWi2GzQfaQdIOPO
	n7Xe16xetjQQr3QrlNcZrCAXMelB+lGTz1YjzEx69qaDwEooaNqgZB32upookibhGCzpvxUlNrF
	geD4EkYDYdNNIiz6cvcLe4COE+9fQs0HdE0pUO/ga3KRrE1wajHMDjNarQMr14rA9HuGTqKhud9
	amVh69NDzKs74PobFdq2tgA/+OCucZ9C/9kin8hM61A8+85f0UHQHKTrVEcSYmtNjJ3PA6YMuLm
	9xHOVRw=
X-Received: by 2002:a05:7301:10c2:b0:2c5:3b87:2ff0 with SMTP id
 5a478bee46e88-2d40c013b03mr1733690eec.12.1775732412977; Thu, 09 Apr 2026
 04:00:12 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CAGid3wpdk1NK0mij2f4bwWOchdJE81ipyifx5yxxOB0W=Bm3_g@mail.gmail.com>
 <874ilkjvjy.wl-tiwai@suse.de>
In-Reply-To: <874ilkjvjy.wl-tiwai@suse.de>
From: Joseph Ferrero <joeferrero14@gmail.com>
Date: Thu, 9 Apr 2026 04:00:00 -0700
X-Gm-Features: AQROBzD66KNE2tTOK3qCWdBt_pAQisq5UmcqUnJ_OIyo5Xgz10fMj75_nki2MYY
Message-ID: 
 <CAGid3wrjASQQCkVyj1LwqgSo40qSggqwRqWH6mUVdK3TyvS6+Q@mail.gmail.com>
Subject: Re: [REGRESSION] ALSA: hda/realtek: Gigabyte quirk misconfigures
 front combo jack mic pin as HP out on ALC897
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, shumingf@realtek.com
X-MailFrom: joeferrero14@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: GKWK2SYRSHT7H67MEZMOJKNTXIGYTPF7
X-Message-ID-Hash: GKWK2SYRSHT7H67MEZMOJKNTXIGYTPF7
X-Mailman-Approved-At: Sat, 11 Apr 2026 20:25:07 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GKWK2SYRSHT7H67MEZMOJKNTXIGYTPF7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGkgVGFrYXNoaSwNCg0KVGhhbmtzIGZvciBsZXR0aW5nIG1lIGtub3cgYWJvdXQgdGhlIHJldmVy
dC4gVGhhbmtzIGZvciBhbGwgdGhlIHdvcmsgeW91IGRvDQpvbiB0aGUgTGludXgga2VybmVsIHNp
ci4NCg0KVGhhbmtzLA0KSm9zZXBoIEZlcnJlcm8NCg0KDQpPbiBUaHUsIEFwciA5LCAyMDI2IGF0
IDM6MDjigK9BTSBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+IHdyb3RlOg0KDQo+IE9uIFR1
ZSwgMDcgQXByIDIwMjYgMTg6MTk6MTYgKzAyMDAsDQo+IEpvc2VwaCBGZXJyZXJvIHdyb3RlOg0K
PiA+DQo+ID4gSGksDQo+ID4NCj4gPiBBZnRlciB1cGdyYWRpbmcgZnJvbSBrZXJuZWwgNi4xOS4x
MCB0byA2LjE5LjExLCB0aGUgZnJvbnQgcGFuZWwgY29tYm8NCj4gamFjaw0KPiA+IG9uIG15IEdp
Z2FieXRlIFo4OTBNIEdBTUlORyBYIG5vIGxvbmdlciBwcm92aWRlcyBtaWNyb3Bob25lIGlucHV0
LiBUaGUNCj4gPiBoZWFkcGhvbmUgb3V0cHV0IG9uIHRoZSBzYW1lIGphY2sgc3RpbGwgd29ya3Mu
IFJldmVydGluZyB0byA2LjE5LjEwDQo+ID4gcmVzdG9yZXMgbWljIGZ1bmN0aW9uYWxpdHkuDQo+
ID4NCj4gPiBJIHN1c3BlY3QgdGhlIGZvbGxvd2luZyBjb21taXQgaW50cm9kdWNlZCBpbiA2LjE5
LjExOg0KPiA+DQo+ID4gICBBTFNBOiBoZGEvcmVhbHRlazogQWRkIHF1aXJrIGZvciBHaWdhYnl0
ZSBUZWNobm9sb2d5IHRvIGZpeCBoZWFkcGhvbmUNCj4gPg0KPiA+IEhhcmR3YXJlOg0KPiA+ICAg
Qm9hcmQ6IEdpZ2FieXRlIFo4OTBNIEdBTUlORyBYDQo+ID4gICBDb2RlYzogUmVhbHRlayBBTEM4
OTcgKGNhcmQgMSwgL3Byb2MvYXNvdW5kL2NhcmQxL2NvZGVjIzApDQo+ID4gICBTdWJzeXN0ZW0g
SWQ6IDB4MTQ1OGExOTQNCj4gPiAgIENvbnRyb2xsZXI6IEludGVsIDgwMCBTZXJpZXMgQUNFIChI
REEgSW50ZWwgUENIKQ0KPiA+DQo+ID4gV29ya2Fyb3VuZDoNCj4gPiAgIERvd25ncmFkZSB0byBs
aW51eCA2LjE5LjEwLg0KPg0KPiBUaGUgcmV2ZXJ0IG9mIHRoZSBjaGFuZ2UgYWJvdmUgaXMgYWxy
ZWFkeSBpbiB0aGUgbmV4dCBwbGFubmVkIFBSIGZvcg0KPiA3LjAuDQo+DQo+DQo+IHRoYW5rcywN
Cj4NCj4gVGFrYXNoaQ0KPg0K
