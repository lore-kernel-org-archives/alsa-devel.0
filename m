Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AB4C5321C
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:44:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D652F601F8;
	Mon, 27 Jul 2026 09:43:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D652F601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785138239;
	bh=10+qEiQxKCjjECZXK7DGDi6qrtlLAqS1J5X/pptru/w=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=fHBFIoRfRF+MLz55BqA3MPbEN/LYUIyB0VCEjXUP4N8khej+ogA3otX3H5UmLomzp
	 tiPeRRs0/yVjzLMkA+5v4jt1oRKK92agTUUl2UIObfAj26Xy/er36NK7hiwRD7dArF
	 bwGzrhsuHupbNUHJU1TkSjha20NrqEOPS3Ryz+mc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8CB50F805F1; Mon, 27 Jul 2026 09:43:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D36BDF80610;
	Mon, 27 Jul 2026 09:43:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CD437F80526; Mon, 27 Jul 2026 09:43:31 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785138211;
	b=UBADuLHv6yTJkYc3f1/b5y9npAlQgaUBDOOvoch5bAwXbC2ivTalZQbeaE7F6PgtDFf4
	 wD0E+AkpdrcTc020LkAhMX5Avp+EjmqfURrcp0ZQQB1sDrB0nwwvSeowaRl4e5bVpKDGB
	 +eM4X01jm5kOSH9eQ9VErsaYfpIaD+TTdxmrN8NOSOSiKToqQCsAtAtbUWo1PcPqHHQLl
	 JeKpihqaEsWthHzPggNc1YPovJ3Eyat5pAfbghmZDKpUFmuyySRau2a+PGIxN+OGyAvsw
	 oJP2fT+uI2vw/RcgWhF2bheGUhrlN+nXqGrAaaBQZUjvMEHZuwITo6x85knRmzkQKBw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785138211;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=10+qEiQxKCjjECZXK7DGDi6qrtlLAqS1J5X/pptru/w=;
	b=gUTsZXYm00l0zJRe6MeB2BHGE9lxCfR38s8zGA/MWv1dWWy2AH6depwbWlIgs0He/cN1
	 kRaRir2gOxTYkWFciml0OtSS2XGa1VflS+LlhE0CBugj/I9qx4ofvXiO4Eh/9ZFkRdtHt
	 1KO0Lsg3YlNi7wnppxcEgnGgj1pWzPq0D80VntrxOhsukqcJcqnS94jvAMGc22f5TWBYX
	 9svxtqnOO0Wth44kWgVLZwpc816C5jEhW39mDpTSv19FFs9IV+Q1jyWzXW3Fbi2I7oWD+
	 +qjkJFlrUCoK1O4NALecyrz0hsvCTggcpfsCp6PC1N1ksHXoGtaGKSgm5ddxX8gNnzQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 227F0F800AC
	for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2026 09:43:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 227F0F800AC
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c615be74195100-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/517@alsa-project.org>
References: <alsa-project/alsa-lib/pr/517@alsa-project.org>
Subject: pcm_meter: give the s16 scope a level for DSD streams
Date: Mon, 27 Jul 2026 09:43:31 +0200 (CEST)
Message-ID-Hash: CE2LDKODSEUEA2Y3CFAU236VNC6FXY66
X-Message-ID-Hash: CE2LDKODSEUEA2Y3CFAU236VNC6FXY66
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CE2LDKODSEUEA2Y3CFAU236VNC6FXY66/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtbGliIHB1bGwgcmVxdWVzdCAjNTE3IHdhcyBlZGl0ZWQgZnJvbSBH
anVqdToKCj4gKipEZXBlbmRzIG9uICM1MTYqKiAoYHBjbV9tZXRlcjogbGV0IHRoZSBzMTYgc2Nv
cGUgZGVncmFkZSBpbnN0ZWFkIG9mIGtpbGxpbmcgdGhlDQo+IGNhbGxlcmApIOKAlCBib3RoIHRv
dWNoIHRoZSBzYW1lIGBzd2l0Y2hgLCBzbyB0aGlzIGlzIHN0YWNrZWQgb24gaXQgdG8gYXZvaWQg
YSB0ZXh0dWFsDQo+IGNvbmZsaWN0LiBPbmx5IHRoZSBzZWNvbmQgY29tbWl0IGJlbG9uZ3MgdG8g
dGhpcyBQUi4NCg0KIyMgVGhlIHByb2JsZW0NCg0KVGhlIHMxNiBzY29wZSBoYXMgbm8gY29udmVy
c2lvbiBmb3IgRFNELCBzbyBgczE2X2VuYWJsZSgpYCByZWplY3RzIGl0IGFuZCB0aGUgczE2IGJ1
ZmZlcg0KY2FycmllcyBub3RoaW5nIGZvciBhIGZvcm1hdCB0aGF0IGlzIGluY3JlYXNpbmdseSBj
b21tb24gb24gVVNCIERBQ3MuIChCZWZvcmUgdGhlIHBhcmVudA0KUFIgdGhlIG91dGNvbWUgd2Fz
IHdvcnNlIHRoYW4gYW4gZW1wdHkgYnVmZmVyIOKAlCB0aGUgYXBwbGljYXRpb24gYWJvcnRlZC4p
DQoNCiMjIFRoZSBhcHByb2FjaA0KDQpEU0QgY2FycmllcyBubyBzYW1wbGUgdmFsdWVzLCBvbmx5
IGEgKipiaXQgZGVuc2l0eSoqOiBvdmVyIGEgc2hvcnQgd2luZG93IHRoZSBwcm9wb3J0aW9uDQpv
ZiBvbmVzICppcyogdGhlIGFtcGxpdHVkZSwgb25lIGhhbGYgYmVpbmcgc2lsZW5jZS4gT25lIFMx
NiBzYW1wbGUgcGVyIGZyYW1lIGNhbiBiZQ0KcmVjb3ZlcmVkIGJ5IGNvdW50aW5nIHRoZSBiaXRz
IG9mIHRoYXQgZnJhbWUgYW5kIHNtb290aGluZyB0aGUgcmVzdWx0IOKAlCB3aGljaCBpcyB3aGF0
IGENCnNjb3BlIG5lZWRzLCBhIGxldmVsIHJhdGhlciB0aGFuIGEgcmVjb25zdHJ1Y3Rpb24uIE5v
IGZpbHRlciBkZXNpZ24sIG5vIHJlc2FtcGxpbmcsIG5vDQpuZXcgZGVwZW5kZW5jeS4NCg0KQ291
bnRpbmcgYml0cyBpcyBpbnZhcmlhbnQgdG8gdGhlaXIgb3JkZXIsIHNvIHRoZSBMRSBhbmQgQkUg
dmFyaWFudHMgc2hhcmUgb25lIGNvZGUgcGF0aA0KYW5kIG9ubHkgdGhlIHdpZHRoIG9mIGEgZnJh
bWUgbWF0dGVycy4NCg0KVHdvIHBhcmFtZXRlcnMgc2V0IHRoZSBxdWFsaXR5LCBhbmQgYm90aCBm
b2xsb3cgdGhlIGZvcm1hdCdzIG93biBkZWZpbml0aW9uIHJhdGhlciB0aGFuDQpiZWluZyB0dW5p
bmcgY2hvaWNlczoNCg0KLSAqKnRoZSBzbW9vdGhpbmcqKiDigJQgYSBiaXQgY291bnQgaXMgbm9p
c3kgKDMyIGJpdHMgZ2l2ZSDPgyA9IDAuNS/iiJozMiksIHNvIGVhY2ggY2hhbm5lbA0KICBrZWVw
cyBhbiBleHBvbmVudGlhbCBhdmVyYWdlIHdob3NlIHRpbWUgY29uc3RhbnQgaXMgZGVyaXZlZCBm
cm9tIHRoZSByYXRlLiBJdCBpcw0KICB0aGVyZWZvcmUgYSAqZHVyYXRpb24qLCBhbmQgYmVoYXZl
cyBpZGVudGljYWxseSBmcm9tIERTRDY0IHRvIERTRDUxMjsNCi0gKip0aGUgc2NhbGUqKiDigJQg
MCBkQkZTIGluIERTRCBpcyBhIDUwJSBtb2R1bGF0aW9uIGluZGV4LCBzbyBhIGZ1bGwtc2NhbGUg
c2lnbmFsIHN3aW5ncw0KICB0aGUgZGVuc2l0eSBiZXR3ZWVuIDI1JSBhbmQgNzUlIG9ubHkuIFJl
ZmVycmluZyB0byB0aGUgd2hvbGUgMOKAkzEwMCUgcmFuZ2Ugd291bGQgcmVhZA0KICA2IGRCIGxv
dy4NCg0KIyMgVGVzdGluZw0KDQp4ODYtNjQsIERlYmlhbiAxMywgRFNELWNhcGFibGUgVVNCIERB
QywgcGxheWluZyB0aGUgKipzYW1lIG1hc3RlciBpbiBib3RoIGZvcm1hdHMqKiBhbmQNCnNhbXBs
aW5nIHRoZSBsZXZlbCBleHBvc2VkIG9uIHRoZSBzMTYgYnVmZmVyOg0KDQp8IHNvdXJjZSB8IG1p
biB8IG1heCB8IG1lYW4gfA0KfC0tLXwtLS18LS0tfC0tLXwNCnwgbmF0aXZlIERTRDY0IChgRFNE
X1UzMl9CRWAgQCA4ODIwMCkgfCAyIHwgMjEgfCA3LjEgfA0KfCBGTEFDIDk2LzI0IChgUzMyX0xF
YCBAIDk2MDAwKSB8IDIgfCAyMiB8IDcuNiB8DQoNClRoZSBzYW1lIG1hc3RlciByZWFkcyB0aGUg
c2FtZSBsZXZlbCBpbiBlaXRoZXIgZm9ybWF0IOKAlCB0aGUgcG9pbnQgYmVpbmcgdGhhdCB0aGUg
c2NhbGUgaXMNCnJpZ2h0LCBub3QgbWVyZWx5IHRoYXQgdGhlIHZhbHVlIG1vdmVzLiBUaGUgREFD
IGtlZXBzIHJlY2VpdmluZyBgRFNEX1UzMl9CRWAgYml0LXBlcmZlY3QNCnRocm91Z2hvdXQ7IGB0
eXBlIG1ldGVyYCBpcyBhIHBhc3NpdmUgdGFwIGFuZCB0aGlzIHBhdGNoIG9ubHkgZmVlZHMgdGhl
IHNjb3BlLgoKUmVxdWVzdCBVUkwgICA6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3Qv
YWxzYS1saWIvcHVsbC81MTcKUGF0Y2ggVVJMICAgICA6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNh
LXByb2plY3QvYWxzYS1saWIvcHVsbC81MTcucGF0Y2gKUmVwb3NpdG9yeSBVUkw6IGh0dHBzOi8v
Z2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS1saWIK
