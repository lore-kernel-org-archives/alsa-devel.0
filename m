Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1830CA9EC7
	for <alsa-devel@archiver.kernel.org>; Sun, 11 Oct 2026 04:53:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D164F601FF;
	Sun, 11 Oct 2026 06:52:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D164F601FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791694388;
	bh=gLvdouBbzNxttu8qt7S/wVb3Zh3uUbfaFJGErqOPtXQ=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=pDbVngAjVAImP2vXMrUoRmBw41eYQ7+bNZP6BWDWzkVXKvG8UDpen3N47i/lM+0fU
	 6xoal3zxXy3FZQ0stSYkGzRP25Z6PBAjP28ZoaTah2IxiMnGOvAx81xhrAEKvre/e6
	 WlJ1TTsH8xIZyLod+oyMAg3Dc22/lhZb6I74XPw4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5EF55F805FB; Sun, 11 Oct 2026 06:52:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B64B9F80602;
	Sun, 11 Oct 2026 06:52:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3807F80551; Sun, 11 Oct 2026 06:52:27 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=185.205.69.214
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791694343;
	b=nglBOGo98lLVUPrXCGuCcmGQ8WYFqsTpR7DMs7UAU+ZPisXBNn746bybKLKuJbObUg0d
	 Yq7fsrsruBmpuzOCmNB1DAD+3HoTw9z4x/9mzGt0y2ctPeAMYTHgUhiyVrWaM3p7J0CJL
	 oh4iA3eHEFNp7wQO7IhyIlTs63OXdl+bw7shmcADFXQKlgw2FtUoO5y3yAp7eTDmJsotY
	 Ow1ZWv8pYq3VWL7DOOuuY+Ry9XaBaHuI5yuXYZ2trUBoLOjeRCFr4m9B9TB0ANRn9yhd9
	 uU7W5ndgyXwHK8CrQtVi3GqQ3eMNxVWLY5/Y0d0un6kXbNBJRjMOzlivbL349Bcva7w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791694343;
	h=DKIM-Signature:Date:From:To:Message-ID:Subject:MIME-Version;
	bh=/NLk8PD4OdHoK9uA8yR4AlNjEiGgoSCSQJEoUkG3qKU=;
	b=ofUMojqwIoOr0VUcrTdupuPuWfmMetkLKMmwbrQlHwt84fNcx9l4bldi6NZhMtOINLtn
	 m8HAlb61jrlA0gnpgKDqerZkD9AGknUZkAbEgyyb3rbDVWF2B9gguc+h3AEIKbjiFAK6J
	 2YjGO9Q2fJRLe/TvTU5X2EsZHg1L01+HW2yosBeXIl3XSBN2xkc0pONz9aH61x4bgjG3m
	 I8h8A8/d1IVAC33HwnZVUk94WMXMTmCtRL+Cf88WYu6vDWw83N0VONCq8nj4WbV0hbwHS
	 ega3AcL6mplB7T1wvsQ+HdwjdWasxRn4Ju7yydBcA0vOcLfDRevZBJo0MB+hgUkVarQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=tuta.io header.i=@tuta.io header.a=rsa-sha256 header.s=s1
 header.b=Kzql7aO9;
	arc=none smtp.remote-ip=185.205.69.214
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 862BCF804B4
	for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2026 06:52:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 862BCF804B4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=tuta.io header.i=@tuta.io header.a=rsa-sha256
 header.s=s1 header.b=Kzql7aO9
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id 85FC7193983A5
	for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2026 06:52:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791694341;
	s=s1; d=tuta.io;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=2XFGoMeCkoDTaRuBFNHerjqgYInVoZrnt+AlM7MTBnI=;
	b=Kzql7aO9xaonyyjsmIewv3JyGuiJRr7Si7bfEM+L5vOZXPxZV/5ogU+8qXUXquzw
	cua/g+b/tke82RS85Ls7jwT+vM67ZKHX3Lxe7pz3WGP91oexXled6faXbFfdsuffppH
	D1Dzy5UQFaUfYpcS3yxNKfLMgA3vwHCSCsGPEegrkA+WGpMP5u6UXoGkKysul7x0xXe
	VNk4LdpR7qlCgybmapKJHzxUmfJQwKglCmV+ofiuz8ZrieCaQyJ2wpG7LicNZE31j+k
	2aPjQheDiH997mPLKBiVo9H5nsiFJoVsm7MC+sH360oFBul/I9BZrrSq4S4ZLeGTp9Y
	5Gd3xAwqHg==
Date: Sun, 11 Oct 2026 06:52:21 +0200 (CEST)
From: richardh@tuta.io
To: Alsa Devel <alsa-devel@alsa-project.org>
Message-ID: <P3dIRUv----9@tuta.io>
In-Reply-To: 
 <179167052709.30.15840441464360824678@mailman-core.alsa-project.org>
References: 
 <179167052709.30.15840441464360824678@mailman-core.alsa-project.org>
Subject: Help -  help: unsubscribe
MIME-Version: 1.0
Feedback-ID: 
 01546680d2e6a4859a61b20542b097ed7373b2856ff867a73774a10fd7e5de6743ca3cb7b70af8fccef279ede3aee002242fd8af3b0bc3208bb05f920a859c4107:TurnOnPrivacy!:tutamail
Message-ID-Hash: 7AP46IKCD6QLPR53AUN4JUG7Q2WNMN56
X-Message-ID-Hash: 7AP46IKCD6QLPR53AUN4JUG7Q2WNMN56
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7AP46IKCD6QLPR53AUN4JUG7Q2WNMN56/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGnCoA0KDQpQbGVhc2UgdW5zdWJzY3JpYmXCoHJpY2hhcmRoQHR1dGEuaW8gZnJvbSB5b3VyIG1h
aWxpbmcgbGlzdC4NCg0KTWFueSB0aGFua3MNCg0KUmljaGFyZA0KDQotLSANCiBTZWN1cmVkIHdp
dGggVHV0YSBNYWlsOiANCiBodHRwczovL3R1dGEuY29tL2ZyZWUtZW1haWwNCg0KDQoxMSBPY3Qg
MjAyNiwgMDg6MTUgYnkgYWxzYS1kZXZlbC1yZXF1ZXN0QGFsc2EtcHJvamVjdC5vcmc6DQoNCj4g
U2VuZCBBbHNhLWRldmVsIG1haWxpbmcgbGlzdCBzdWJtaXNzaW9ucyB0bw0KPiAgYWxzYS1kZXZl
bEBhbHNhLXByb2plY3Qub3JnDQo+DQo+IFRvIHN1YnNjcmliZSBvciB1bnN1YnNjcmliZSB2aWEg
ZW1haWwsIHNlbmQgYSBtZXNzYWdlIHdpdGggc3ViamVjdCBvcg0KPiBib2R5ICdoZWxwJyB0bw0K
PiAgYWxzYS1kZXZlbC1yZXF1ZXN0QGFsc2EtcHJvamVjdC5vcmcNCj4NCj4gWW91IGNhbiByZWFj
aCB0aGUgcGVyc29uIG1hbmFnaW5nIHRoZSBsaXN0IGF0DQo+ICBhbHNhLWRldmVsLW93bmVyQGFs
c2EtcHJvamVjdC5vcmcNCj4NCj4gV2hlbiByZXBseWluZywgcGxlYXNlIGVkaXQgeW91ciBTdWJq
ZWN0IGxpbmUgc28gaXQgaXMgbW9yZSBzcGVjaWZpYw0KPiB0aGFuICJSZTogQ29udGVudHMgb2Yg
QWxzYS1kZXZlbCBkaWdlc3QuLi4iVG9kYXkncyBUb3BpY3M6DQo+DQo+ICAxLiBBTFNBOiBoZGEv
cmVhbHRlazogTEcgR3JhbSAxNlQ5MFNQIChBTEMyOTggKyBBTEMxMzE4LCBTU0lEIDE4NTQ6MDUy
MSkgLSBubyBzcGVha2VyIG91dHB1dCwgbmVlZCBhbXAgaW5pdCBzZXF1ZW5jZQ0KPiAgKENvcnkg
TWF0dHNvbikNCj4gIDIuIEJhY2twb3J0IHJlcXVlc3QgZm9yIDcuMC55IGFuZCA3LjEueTogNjQ4
NWRhODU3OWUyIChBTFNBOiBoZGE6IEFkZCBMZW5vdm8gTGVnaW9uIDdpIDE2SUFYNyAxN0FBMzg3
NCBxdWlyaykNCj4gIChFbGkgRCkNCj4gIDMuIFtQQVRDSF0gQUxTQTogaGRhL3JlYWx0ZWs6IEZp
eCBpbnRlcm5hbCBtaWMgY2FwdHVyZSBvbiBBU1VTIFJPRyBGbG93IFoxMyBHWjMwMkVBDQo+ICAo
QWxleCBKYW1lcykNCj4gIDQuIHVjbTI6IE1lZGlhVGVrOiBhZGQgbXQ4MTg5LXJ0MTAxOXAtcnQ1
NjgycyAoc2t5d2Fsa2VyIENocm9tZWJvb2tzKQ0KPiAgKEdpdEh1YiBwdWxsX3JlcXVlc3QgLSBv
cGVuZWQpDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQo+IEFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0IC0tIGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9y
Zw0KPiBUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGFsc2EtZGV2ZWwtbGVhdmVAYWxz
YS1wcm9qZWN0Lm9yZw0KPg0KDQo=
