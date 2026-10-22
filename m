Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F975606A319
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=KlSx77Vt;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=tuta.io header.i=@tuta.io header.a=rsa-sha256 header.s=s1 header.b=wSkRBuYV
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A95F601CE;
	Thu, 22 Oct 2026 12:19:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A95F601CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792664370;
	bh=VryhQQNbzRH99Wc0e973w0bVt85bpGCvxDhnDY+1feo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KlSx77Vtk8EaLSyAqLg5BH3/5+vtENxBlcDuOUMwS9z1KzDnSWpVyNMaxlptlqJst
	 akkKNDrJ1SN8tqD/qWP6BW0jjdkb6BHjYgEsZL2QmPpErX+SR/65u/g+pLailZydKt
	 KLQfDzYLPZRe5x2AwThP7ihsmAhJ0WMcQo8kthgE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0221CF805FD; Thu, 22 Oct 2026 12:18:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7504BF805F3;
	Thu, 22 Oct 2026 12:18:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7CF33F804CC; Thu, 22 Oct 2026 12:18:50 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=1.1 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 18164F800F3
	for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2026 12:18:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18164F800F3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=tuta.io header.i=@tuta.io header.a=rsa-sha256
 header.s=s1 header.b=wSkRBuYV
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id 72D0219A54E7E
	for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2026 12:18:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792664323;
	s=s1; d=tuta.io;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=eLsCzcuImw8LMdbzjJJD0ufMYNlpPIZCsnj1k4NYWBw=;
	b=wSkRBuYVywb/uryvKLrOxvZlwcMHEEQkG6RNdCmlONkiAFqJ0mT0/qHbVnEWx/l0
	I7JUnLKWWgGQiGlnKgbdeVSqDYrPIPCJv3Y1pK8N+x4ydhawRyAt6J6UAmdhKpVEHBh
	Mks1rFR+cSWPDc71dm72sRuVe7L38tGTnS/QLSjX2+q0MQoiAukFYoGp8MDcIzjgKei
	GjsOgMh4Nw6o0Zc/VkfnmQgK7LQfaIVzfmczw4lnUytNZD3ZTABpRJXvf+ZGWLLJBv+
	bUyFrmL5V57xLPqNNi802a2EJnNpNr7FZ3AbXVQxvyHUteiCI8uToc8o+kwLrCcXSMP
	5yNwMS5Ntw==
Date: Thu, 22 Oct 2026 12:18:43 +0200 (CEST)
From: richardh@tuta.io
To: Masaru Nomiya <nomiya@ab.auone-net.jp>
Cc: Alsa Devel <alsa-devel@alsa-project.org>
Message-ID: <P4Y6cMz--F-9@tuta.io>
In-Reply-To: <87mrtem42s.wl-nomiya@ab.auone-net.jp>
References: 
 <178972559304.30.15231273321927646247@mailman-core.alsa-project.org>
 <P1rBm0b--F-9@tuta.io> <87mrtem42s.wl-nomiya@ab.auone-net.jp>
Subject: Re: Help: unsubscribe
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Feedback-ID: 
 01546680d2e6a4859a61b20542b097ed7373b2856ff867a73774a10fd7e5de6743ca3cb7b70af8fccef279ede3aee002242fd8af3b0bc3208bb05f920a859c4107:TurnOnPrivacy!:tutamail
Message-ID-Hash: NWYPVQAHX5EBG4GJEMNTU54LWCHW3H3A
X-Message-ID-Hash: NWYPVQAHX5EBG4GJEMNTU54LWCHW3H3A
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NWYPVQAHX5EBG4GJEMNTU54LWCHW3H3A/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
X-Spam-Level: *

SGkgTWFzYXJ1DQoNCmZvciBvdmVyIDYgbW9udGhzIEkgaGF2ZSBiZWVuIHRyeWluZyB0byB1bnN1
YnNjcmliZSBmcm9tIHRoaXMgbWFpbGluZyBsaXN0IGJ1dCBteSByZXF1ZXN0cyBnZXQgaWdub3Jl
ZC4NCg0KSSBvcmlnaW5hbGx5IHN1YnNjcmliZWQgYmVjYXVzZSBJIHdhcyBob3BpbmcgdGhpcyBj
b21tdW5pdHkgbWlnaHQgYmUgd2lsbGluZyB0byBoZWxwIHdoZXJlIEkgZ290IHN0dWNrIHdpdGgg
bXkgcHJvYmxlbSwgYnV0IHRoYXQgcmVxdWVzdCBnb3QgaWdub3JlZCB0b28uIEkgbmV2ZXIgZ290
IGFueSBhbnN3ZXIgYXQgYWxsIGJ1dCBnZXQgc3BhbW1lZCB3aXRoIGVuZGxlc3MgZS1tYWlscyBm
cm9tIHRoZSBBbHNhLWRldmVsIERpZ2VzdC4NCg0KRG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb24g
d2hhdCBJIGNhbiBkbyB0byBnZXQgdGhpcyBmbG9vZCBvZiBlLW1haWxzIHN0b3BwZWQ/DQoNCllv
dXIgYXNzaXN0YW5jZSB3aWxsIGJlIGFwcHJlY2lhdGVkLg0KDQpLaW5kIHJlZ2FyZHMNCg0KUmlj
aGFyZA0KDQoNCi0tIA0KIFNlY3VyZWQgd2l0aCBUdXRhIE1haWw6IA0KIGh0dHBzOi8vdHV0YS5j
b20vZnJlZS1lbWFpbA0KDQoNCjE5IFNlcHQgMjAyNiwgMTE6MTggYnkgbm9taXlhQGFiLmF1b25l
LW5ldC5qcDoNCg0KPiBIZWxsbywNCj4NCj4gSW4gdGhlIE1lc3NhZ2U7IA0KPg0KPiAgU3ViamVj
dCAgICA6IEhlbHA6IHVuc3Vic2NyaWJlDQo+ICBNZXNzYWdlLUlEIDogPFAxckJtMGItLUYtOUB0
dXRhLmlvPg0KPiAgRGF0ZSAmIFRpbWU6IFNhdCwgMTkgU2VwIDIwMjYgMDM6MDY6MzIgKzAyMDAg
KENFU1QpDQo+DQo+IHJpY2hhcmRoQHR1dGEuaW8gaGFzIHdyaXR0ZW46DQo+DQo+PiBIaQ0KPj4N
Cj4+IFBsZWFzZSB1bnN1YnNjcmliZSByaWNoYXJkaEB0dXRhLmlvwqBmcm9tIHlvdXIgbWFpbGlu
ZyBsaXN0Lg0KPj4NCj4NCj4gVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBhbHNhLWRl
dmVsLWxlYXZlQGFsc2EtcHJvamVjdC5vcmcNCj4NCj4gQmVzdCBSZWdhcmRzLg0KPg0KPiAtLQ0K
PiDilI/ilIHilIHilJPlvaEgICBNYXNhcnUgTm9taXlhICAgICAgICAgICAgICAgICAgICAgbWFp
bC10bzogbm9taXlhIEAgYWIuYXVvbmUtbmV0LmpwDQo+IOKUg++8vO+8j+W9oQ0KPiDilJfilIHi
lIHilJsgICAgICAgICAgIkluIG90aGVyIHdvcmRzLCBsZXR0aW5nIGFuIEFJIGRvIHlvdXIgcmVh
c29uaW5nIG1lYW5zIHlvdXINCj4gIHJlYXNvbmluZyBpcyBvbmx5IGV2ZXIgZ29pbmcgdG8gYmUg
YXMgZ29vZCBhcyB0aGF0IEFJIHN5c3RlbS4NCj4gIEFzIGFsd2F5cywgbGV0IHRoZSBwcm9tcHRl
ciBiZXdhcmUuIg0KPg0KPiAgLS0gIiJDb2duaXRpdmUgc3VycmVuZGVyIiBsZWFkcyBBSSB1c2Vy
cyB0byBhYmFuZG9uIGxvZ2ljYWwgdGhpbmtpbmciICAtLQ0KPg0KDQo=
