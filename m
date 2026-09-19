Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4884C982DE
	for <alsa-devel@archiver.kernel.org>; Sat, 19 Sep 2026 01:07:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 892B660211;
	Sat, 19 Sep 2026 03:07:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 892B660211
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789780038;
	bh=dDtu633nqqsnlmQW/LR+c9v+G3qRg+alQ1tWkgS6BdA=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=dOsJjOHNoAJGpv8wizcjicVO12C/QM3dXQqq8XrCzYd+WA8bzbWErgEZkMwSXLCE3
	 dbn7lBE2dCwLGpL4k9Y/HA5ZCJd4L3n6qYR61I9nGA+ULVwqfirt1myptkGHWXO4sa
	 O/87GtQwM4ytJXb3ebi89ncxVi4gCIrRc1mPAhaI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 06BD9F80557; Sat, 19 Sep 2026 03:06:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 53ABEF805FA;
	Sat, 19 Sep 2026 03:06:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 395FDF80557; Sat, 19 Sep 2026 03:06:38 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=185.205.69.214
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789779994;
	b=ncx31I/lOpo4PVQ3Xjn4YvcgWu8Z3AiotWvne9hp220JoOqhClhDsZuev/dCnwtYwjuy
	 +TohVAUy/YTknAn7P+rh1L+UYS8oI4jH0LlmB9Zl2lOraFlGvxOxXjaPgrkNDTeJpG6GN
	 jlIWC2rsFTTZ74B424QizSyn/bWebASt+EpJ+4evsjR/pppR9mIL2Lj31QMUMnknXrYS+
	 uKqvY2049QmO95WhQo+AcD599jwipYGlrs1ub1QEzEPOkTeikhqtTyQ/4fCWqeFaLQn7C
	 ih9hJ7ntqUbUgqTC8SFdiZ08AvaCY6rBIhGA/kj+UU6NKXzMk3TpXAdN7myUcEXFcvQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789779994;
	h=DKIM-Signature:Date:From:To:Message-ID:Subject:MIME-Version;
	bh=c/e2k4NoKgp5m/hbmvnc7euZIFgAs0wxlpjI8Odo7Mg=;
	b=oM7dvlxoCeoQTJqO1wUREfcQqdH02sKmS3ZGVtrNDopXDI71oyqKx2o428Iz+z391ikb
	 mdM0BaM7dWcAg5rKCS1Gtqprl7Hlld08iPry0i8h5UJTlxo/uk1qADcJrbbPyhC0IyOxX
	 EKLOu6ZhukxNVkOJnOnbMVP6fryqjv1RsoOHsKlgxo+pJq/kGQssCKpzbS8vU8c8y28H/
	 uDRUAolR8MOPPwlYlTB4h2/fq6ma0UyR0hh8yBHmBhGCK24ph2Dvd7LoctutZWuk6Iggv
	 u7IQzLvS96R+qWIw2ZIe8ZytsD/FnaAialgMznZnSOPsv29Wv8zWhZshrrJak3xYEUw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=tuta.io header.i=@tuta.io header.a=rsa-sha256 header.s=s1
 header.b=a8M3AQV3;
	arc=none smtp.remote-ip=185.205.69.214
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 23760F80448
	for <alsa-devel@alsa-project.org>; Sat, 19 Sep 2026 03:06:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 23760F80448
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=tuta.io header.i=@tuta.io header.a=rsa-sha256
 header.s=s1 header.b=a8M3AQV3
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id 238AC186740DA
	for <alsa-devel@alsa-project.org>; Sat, 19 Sep 2026 03:06:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789779992;
	s=s1; d=tuta.io;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=RWviku0Lgp+I0JnGEhxfSuSZTJjHJSqtxrjlT4D5ydE=;
	b=a8M3AQV3se1MAOWjGSO8LmhqpdlRYDeSAQkxjZPb8/mBvbrKN1VVBp6guGDV/hd2
	fEkKAfKkxPhfBrk3ITutPcEUpDmWVksiZijTEIz5mRtJecvwhBke6vN5AuyVe5ECi5Z
	CCQ3LT8nsGlwYK1gnuqdQusn5O1ap7RpSVjTsFa9dJ14kvjv1VpApCsw/Rl9oM1leIv
	iA9e9o43DfiTkmrKxnwCcVva0KdVk5ZLiJEY72CfhS7tZ/a5LUm3DpVj6WtKvNP5mvR
	fdQd/y0hFnVakw0C+DI3htQwMpk+tvGnZRCu2jWw3TSiGbtskdzEuV5qq1QNYSE0rzk
	aQNNEjq2OA==
Date: Sat, 19 Sep 2026 03:06:32 +0200 (CEST)
From: richardh@tuta.io
To: Alsa Devel <alsa-devel@alsa-project.org>
Message-ID: <P1rBm0b--F-9@tuta.io>
In-Reply-To: 
 <178972559304.30.15231273321927646247@mailman-core.alsa-project.org>
References: 
 <178972559304.30.15231273321927646247@mailman-core.alsa-project.org>
Subject: Help: unsubscribe
MIME-Version: 1.0
Feedback-ID: 
 01546680d2e6a4859a61b20542b097ed7373b2856ff867a73774a10fd7e5de6743ca3cb7b70af8fccef279ede3aee002242fd8af3b0bc3208bb05f920a859c4107:TurnOnPrivacy!:tutamail
Message-ID-Hash: JUWCSWJU5WNIC6MO6OIZLBVAF7UZFJG6
X-Message-ID-Hash: JUWCSWJU5WNIC6MO6OIZLBVAF7UZFJG6
X-MailFrom: richardh@tuta.io
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JUWCSWJU5WNIC6MO6OIZLBVAF7UZFJG6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGkNCg0KUGxlYXNlIHVuc3Vic2NyaWJlIHJpY2hhcmRoQHR1dGEuaW/CoGZyb20geW91ciBtYWls
aW5nIGxpc3QuDQoNCktpbmQgcmVnYXJkcw0KDQrigItSaWNoYXJkDQoNCi0tIA0KIFNlY3VyZWQg
d2l0aCBUdXRhIE1haWw6IA0KIGh0dHBzOi8vdHV0YS5jb20vZnJlZS1lbWFpbA0KDQoNCjE4IFNl
cHQgMjAyNiwgMjA6MDAgYnkgYWxzYS1kZXZlbC1yZXF1ZXN0QGFsc2EtcHJvamVjdC5vcmc6DQoN
Cj4gU2VuZCBBbHNhLWRldmVsIG1haWxpbmcgbGlzdCBzdWJtaXNzaW9ucyB0bw0KPiAgYWxzYS1k
ZXZlbEBhbHNhLXByb2plY3Qub3JnDQo+DQo+IFRvIHN1YnNjcmliZSBvciB1bnN1YnNjcmliZSB2
aWEgZW1haWwsIHNlbmQgYSBtZXNzYWdlIHdpdGggc3ViamVjdCBvcg0KPiBib2R5ICdoZWxwJyB0
bw0KPiAgYWxzYS1kZXZlbC1yZXF1ZXN0QGFsc2EtcHJvamVjdC5vcmcNCj4NCj4gWW91IGNhbiBy
ZWFjaCB0aGUgcGVyc29uIG1hbmFnaW5nIHRoZSBsaXN0IGF0DQo+ICBhbHNhLWRldmVsLW93bmVy
QGFsc2EtcHJvamVjdC5vcmcNCj4NCj4gV2hlbiByZXBseWluZywgcGxlYXNlIGVkaXQgeW91ciBT
dWJqZWN0IGxpbmUgc28gaXQgaXMgbW9yZSBzcGVjaWZpYw0KPiB0aGFuICJSZTogQ29udGVudHMg
b2YgQWxzYS1kZXZlbCBkaWdlc3QuLi4iVG9kYXkncyBUb3BpY3M6DQo+DQo+ICAxLiBbUEFUQ0hd
IEFTb0M6IGFtZDogYWNwOiBlbmFibGUgVEFTMjc4MyBhbmQgYWRkIFJUNzEyLVZCIFNvdW5kV2ly
ZSBtYWNoaW5lDQo+ICAoU3llZCBTYWJhIEthcmVlbSkNCj4gIDIuIFJlOiBbUEFUQ0hdIEFTb0M6
IGFtZDogeWM6IEFkZCBMZW5vdm8gVGhpbmtQYWQgRTE2IEdlbiAyICgyMUpOKSB0byBxdWlya3MN
Cj4gIChNYXJrIEJyb3duKQ0KPiAgMy4gUmU6IFtQQVRDSF0gQVNvQzogYW1kOiBhY3A6IGVuYWJs
ZSBUQVMyNzgzIGFuZCBhZGQgUlQ3MTItVkIgU291bmRXaXJlIG1hY2hpbmUNCj4gIChNYXJrIEJy
b3duKQ0KPiAgNC4gUmU6IFtQQVRDSCAwMC8xMV0gQVNvQzogU09GOiBhbWQ6IFNvdW5kV2lyZSBh
bmQgUERNIHN1cHBvcnQgYW5kIGZpeGVzIGZvciBBQ1A3LkIvNy5GDQo+ICAoTWFyayBCcm93bikN
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QgLS0gYWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnDQo+IFRv
IHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gYWxzYS1kZXZlbC1sZWF2ZUBhbHNhLXByb2pl
Y3Qub3JnDQo+DQoNCg==
