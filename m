Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDADAC5516F
	for <alsa-devel@archiver.kernel.org>; Sun,  2 Aug 2026 02:28:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74BD8601FD;
	Sun,  2 Aug 2026 04:28:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74BD8601FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785637715;
	bh=Qbk+Ni+hbkaxBFtk8QhKsMmJhKB2I7VMY65jQtvHQ5I=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=LajP4PM873m+UUJslsgD4hGH/yF592Sp/zON7DEEObnuSpOr9GFv7bNTnJTN20q4p
	 XM+GpPaoL8Ua+BThh6aTSh40Wa06nfriGiIfjnShAv+Y8SonvI3yvqni26D2gVjsnv
	 XiU7Jm6kjoyNB81AUeVLVlmOXXhxtzZFU+Eh52NE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B6897F80600; Sun,  2 Aug 2026 04:28:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5DA87F80600;
	Sun,  2 Aug 2026 04:28:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 067ECF804F3; Sun,  2 Aug 2026 04:27:54 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=185.205.69.214
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785637669;
	b=Wgwprt2joj2hxx2neCduJC9DsJmX9aGJl0XhVtk66LxZyZ1/OPblOFMtziw3R4iRBVXK
	 2WRngv1a55wxSm5tjUltbfWsAv1gTubxJi4TEL7cDzMSSJ4tlCPlWF4vmQGClfbgY/Gvy
	 GNKwHmB1TJKc4TTSxs/lIrl4pQB0a+rG52zMNbhEEM1w4Aq1VyjYa5YVIef5o/H6MZ1XL
	 h3r/UsrSHFv1QQ4NU7gcPdXvH6BNQv8upZmQy1GfqolOtTsXkerBGqM7Ao3XOWgx6uBt1
	 kgkIbnvmAkYAg4X9L+dWJZh/oyrxG+71RmpRWDzqrEv46IjwoED5AxHWCJBX2nFd6mw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785637669;
	h=DKIM-Signature:Date:From:To:Message-ID:Subject:MIME-Version;
	bh=D0AT26bbRIEirQhCKdlSkF2etr295m6mXAQ6w8m4BPE=;
	b=PsaGIvDTny2/QV1PL9d4YOrtcjM3IDzq2/jVHVqIhwcg7czJG0CqS4vDXCpiE4CZYAzE
	 ow2j1x4lAqtgkFo4erNAptM/lUOGxhoM9tgeh4y+AERuroB/SnFImN+1X3X9YR26as2yu
	 pHTnDMrFHZ/0S/dMuCLyyYdYfS656yauN3P/U4pzaiNVe7MbG519dUCL2oPkLZIHco7sM
	 pi0NGKRNKf67N8bPJG5hkERHpHBwsUfSyZb13AbBTrSYvmjNFCfKMDajmca2Nll5AhSwn
	 VC+Wyk88FbXbTyN6blUuZkhL39qEVqCQusLlAnuB2qVwPcp2eqUgKSUNAqn//UGBmhw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=tuta.io header.i=@tuta.io header.a=rsa-sha256 header.s=s1
 header.b=gPt6rfLj;
	arc=none smtp.remote-ip=185.205.69.214
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 50A84F8024C
	for <alsa-devel@alsa-project.org>; Sun,  2 Aug 2026 04:27:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50A84F8024C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=tuta.io header.i=@tuta.io header.a=rsa-sha256
 header.s=s1 header.b=gPt6rfLj
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id 74C2F16B07805
	for <alsa-devel@alsa-project.org>; Sun,  2 Aug 2026 04:27:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785637667;
	s=s1; d=tuta.io;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=kQncIegbdHRYAP9oQqENpglNvmyKYxbkXWQSi9lFEC8=;
	b=gPt6rfLj1z1XcAgO9/ZtoiYg+3MmWeP7xPH2l/LzU8vvG+UzdiiMIPnXG6Md9NUs
	5JFMM+oX02nu6V4qyYDcMrEz7WVuWHvqMqkZRhrcMLGVKqlfbiFsuAwg3O4dE8X+j2h
	jEjuE+z6SqBMBnQtTN1w1vvd7ZzS2Be26JzHPxDFe2ii2ZRZ/Y66TRdT0S91/Drw1Km
	7OUZ/2Zy+uBar4Y4rQkDhhuvl2m40jK0Fnd2Ks+dP+RQUtTZfN9rsMDqTOc3vh3EZA8
	AZtpAXnLSDdgfgMXH2e90Kew7Vm4QetzdCvkINhAFRI1CDpt0y+JWOkpGvV/osPxGyO
	CqjRSYF/7A==
Date: Sun, 2 Aug 2026 04:27:47 +0200 (CEST)
From: richardh@tuta.io
To: Alsa Devel <alsa-devel@alsa-project.org>
Message-ID: <Oz-I3IF--F-9@tuta.io>
In-Reply-To: 
 <178549558947.30.12703011696211353296@mailman-core.alsa-project.org>
References: 
 <178549558947.30.12703011696211353296@mailman-core.alsa-project.org>
Subject: Unsubscribe: Alsa-devel Digest, Vol 233, Issue 53
MIME-Version: 1.0
Feedback-ID: 
 01546680d2e6a4859a61b20542b097ed7373b2856ff867a73774a10fd7e5de6743ca3cb7b70af8fccef279ede3aee002242fd8af3b0bc3208bb05f920a859c4107:TurnOnPrivacy!:tutamail
Message-ID-Hash: XK7AFSHKN64LHJBPLLAICCZASTAU4I7Y
X-Message-ID-Hash: XK7AFSHKN64LHJBPLLAICCZASTAU4I7Y
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XK7AFSHKN64LHJBPLLAICCZASTAU4I7Y/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGnCoA0KDQpjYW4geW91IHBsZWFzZSB1bnN1YnNjcmliZSBtZSBmcm9tIHRoaXMgbGlzdC4NCg0K
dGhhbmsgeW91wqANCg0K4oCLUmljaGFyZA0KDQotLSANCiBTZWN1cmVkIHdpdGggVHV0YSBNYWls
OiANCiBodHRwczovL3R1dGEuY29tL2ZyZWUtZW1haWwNCg0KDQozMSBKdWwgMjAyNiwgMjE6MDAg
YnkgYWxzYS1kZXZlbC1yZXF1ZXN0QGFsc2EtcHJvamVjdC5vcmc6DQoNCj4gU2VuZCBBbHNhLWRl
dmVsIG1haWxpbmcgbGlzdCBzdWJtaXNzaW9ucyB0bw0KPiAgYWxzYS1kZXZlbEBhbHNhLXByb2pl
Y3Qub3JnDQo+DQo+IFRvIHN1YnNjcmliZSBvciB1bnN1YnNjcmliZSB2aWEgZW1haWwsIHNlbmQg
YSBtZXNzYWdlIHdpdGggc3ViamVjdCBvcg0KPiBib2R5ICdoZWxwJyB0bw0KPiAgYWxzYS1kZXZl
bC1yZXF1ZXN0QGFsc2EtcHJvamVjdC5vcmcNCj4NCj4gWW91IGNhbiByZWFjaCB0aGUgcGVyc29u
IG1hbmFnaW5nIHRoZSBsaXN0IGF0DQo+ICBhbHNhLWRldmVsLW93bmVyQGFsc2EtcHJvamVjdC5v
cmcNCj4NCj4gV2hlbiByZXBseWluZywgcGxlYXNlIGVkaXQgeW91ciBTdWJqZWN0IGxpbmUgc28g
aXQgaXMgbW9yZSBzcGVjaWZpYw0KPiB0aGFuICJSZTogQ29udGVudHMgb2YgQWxzYS1kZXZlbCBk
aWdlc3QuLi4iVG9kYXkncyBUb3BpY3M6DQo+DQo+ICAxLiBnaXRodWIgZG90IGNvbSBzM2JvdW4z
dCBhZTlfYnVpbGQgQ3JlYXRpdmUgU291bmQgQmxhc3RlciBBRTkgTGludXggU3VwcG9ydA0KPiAg
KE5BIE5BKQ0KPiAgMi4gUmU6IFtQQVRDSF0gQUxTQTogaGRhL3JlYWx0ZWs6IEZpeCBzcGVha2Vy
IG11dGUgTEVEIG9uIExlbm92byBUaGlua0Jvb2sgMTQgRzgrIElQSA0KPiAgKEFzaG1pdGEgQ2hh
a3JhYm9ydHkpDQo+ICAzLiBSZTogW1BBVENIIHY2IDIvMl0gQUxTQTogY29udHJvbDogYWRkIGlv
Y3RsIHRvIHJldHJpZXZlIGZ1bGwgY2FyZCBjb21wb25lbnRzDQo+ICAoVGFrYXNoaSBJd2FpKQ0K
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBBbHNh
LWRldmVsIG1haWxpbmcgbGlzdCAtLSBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcNCj4gVG8g
dW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBhbHNhLWRldmVsLWxlYXZlQGFsc2EtcHJvamVj
dC5vcmcNCj4NCg0K
