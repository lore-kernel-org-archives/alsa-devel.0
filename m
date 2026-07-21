Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60B5C4452B
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2026 21:56:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 93FDF601FE;
	Tue, 21 Jul 2026 23:56:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 93FDF601FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784671014;
	bh=rWVaoD5DFt55YXoXmAgVcjgA5aliARd/jvxO6b2oxiE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=DWjy3kLsis8fChWCFpXzUEdqyD1jBgPYvAefoKE6TF7Nb6qpsSBN6h9noq4DCYAtr
	 emGX/D/wUvc1n0C0HagC3d3eii0JKxkLSB5TGjBXDnIHoCMKfyB9W9WY2Bf3gUK4UG
	 0NSDXHqIUuwY1V5WS6eiS2uqJaugI17coTG5gY78=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AF087F805FE; Tue, 21 Jul 2026 23:56:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2DF93F80600;
	Tue, 21 Jul 2026 23:56:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2B40DF8053D; Tue, 21 Jul 2026 23:56:16 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784670975;
	b=l+5cp2s4hk/xv3AgrJFw6eY7pPZVXrI2yYTkqpYioRDilLNUxn5WUFZCry6P9vXho2du
	 cEPt8m5E8U+3cB7KCsCa3CQ7BIocJWePgz9hm8vMPA7hOKhJeGx6g3oNRXcK8cZ2VS4Fk
	 jEepClgocz5yDtJVe++HpJIUMluhYUKgMHhBcPaZEW4ww7vDv9j3AMrSiDxE9OOgYptIH
	 YTO0mvhVGsPiKTZ3cPYK2iF7w7SmIofic/ogBCUEE+yVQoZSfoZX/7s/iWN+LJ+Rv2y24
	 /vni/apZwOSORN2URsI4K4vjfQ4Z+SY0ldraB9K5PJUo64r8MfoeO2q5lzNGR1kpoIA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784670975;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=rWVaoD5DFt55YXoXmAgVcjgA5aliARd/jvxO6b2oxiE=;
	b=ZXjORizSkbI4UrGZhsD5W3FdGMGLuq2meTggepNlQw7UL4FTNdZr0EoSoDo9oowYhAcG
	 RJTwi2+ceMw42PtqP3Lj90yWJPxkjrP0ivUlVodnRB9OFzucbJt9ZzTg2wvtMCrw1M5Ye
	 tL8ZLzCZ4Topc3TGXwbBSm2Jq4/859MXDxsZ4EJ6EdwDS99vALDbD+5ydITuaQt9NeLgi
	 wZ3r7ENPjwQljQG7uebFb/qdjKByJeWYZrHWb4MYddm3ZS2jo0kfkzCDokfNYMGUkUD9R
	 KmW3qaanFXpg8uzk4fIykjNO705cQnknLUHLTutsiLvqf3Q82rNs6GKPQtPrYjnr4yQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 1210EF80095
	for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2026 23:56:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1210EF80095
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c46ccb67434b00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/516@alsa-project.org>
References: <alsa-project/alsa-lib/pr/516@alsa-project.org>
Subject: pcm_meter: let the s16 scope degrade instead of killing the caller
Date: Tue, 21 Jul 2026 23:56:16 +0200 (CEST)
Message-ID-Hash: 2X735FM3RHSRS6XIJPSFD3DVCRW66QRI
X-Message-ID-Hash: 2X735FM3RHSRS6XIJPSFD3DVCRW66QRI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2X735FM3RHSRS6XIJPSFD3DVCRW66QRI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtbGliIHB1bGwgcmVxdWVzdCAjNTE2IHdhcyBvcGVuZWQgZnJvbSBH
anVqdToKCiMjIFRoZSBidWcNCg0KYHMxNl9lbmFibGUoKWAgcmV0dXJucyBgLUVJTlZBTGAgZm9y
IGFueSBmb3JtYXQgaXQgY2Fubm90IGNvbnZlcnQgdG8gUzE2IOKAlCB0aGUgRFNEDQpmb3JtYXRz
LCB0aGUgMy1ieXRlIHBhY2tlZCBvbmVzIChgUzI0XzNMRWAvYFMyNF8zQkVgL2BTMjBfM0xFYCks
IGZsb2F0Lg0KYHNuZF9wY21fc2NvcGVfZW5hYmxlKClgIHJlY29yZHMgdGhhdCBhcyAibm90IGVu
YWJsZWQiIGFuZCBjYXJyaWVzIG9uOg0KDQpgYGBjDQplcnIgPSBzY29wZS0+b3BzLT5lbmFibGUo
c2NvcGUpOw0Kc2NvcGUtPmVuYWJsZWQgPSAoZXJyID49IDApOw0KYGBgDQoNCkJ1dCBldmVyeSAq
b3RoZXIqIHNjb3BlIHN0YXlzIGVuYWJsZWQsIGFuZCBzY29wZXMgcmVhY2ggdGhlIHMxNiBidWZm
ZXIgdGhyb3VnaA0KYHNuZF9wY21fc2NvcGVfczE2X2dldF9jaGFubmVsX2J1ZmZlcigpYCwgd2hp
Y2ggYXNzZXJ0cyBvbiBleGFjdGx5IHRoZSBwb2ludGVyDQpgczE2X2VuYWJsZSgpYCBuZXZlciBh
bGxvY2F0ZWQ6DQoNCmBgYA0KcGNtX21ldGVyLmM6MTIyNDogc25kX3BjbV9zY29wZV9zMTZfZ2V0
X2NoYW5uZWxfYnVmZmVyOiBBc3NlcnRpb24gJ3MxNi0+YnVmX2FyZWFzJyBmYWlsZWQuDQpgYGAN
Cg0KVGhlIGFwcGxpY2F0aW9uIGRpZXMuIFRoaXMgaXMgbm90IGh5cG90aGV0aWNhbCBhbmQgbm90
IHRoaXJkLXBhcnR5IG9ubHk6IGFsc2EtbGliJ3Mgb3duDQpgc3JjL3BjbS9zY29wZXMvbGV2ZWwu
Y2AgY2FsbHMgdGhlIGFjY2Vzc29yIHRoZSBzYW1lIHdheSwgc28gdGhlIGxpYnJhcnkgYWJvcnRz
IGl0cyBvd24NCmNhbGxlci4gRG93bnN0cmVhbSwgYGxpYnBlcHB5YWxzYWAgKHRoZSBWVS1tZXRl
ciBzY29wZSB1c2VkIGJ5IG1vT2RlIGF1ZGlvIHBsYXllcikgbWFrZXMNCmEgbXVzaWMgcGxheWVy
IGFib3J0IG1pZC1wbGF5YmFjayB0aGUgbW9tZW50IGEgRFNEIHRyYWNrIHN0YXJ0cy4NCg0KTm90
ZSB0aGUgZmFpbHVyZSBpcyAqbm90KiBEU0Qtc3BlY2lmaWMg4oCUIGFueSBmb3JtYXQgb3V0c2lk
ZSB0aGUgMTcgdGhlIHN3aXRjaCBsaXN0cw0KdHJpZ2dlcnMgaXQsIGluY2x1ZGluZyBgUzI0XzNM
RWAsIHdoaWNoIHBsZW50eSBvZiBVU0IgREFDcyBleHBvc2UgbmF0aXZlbHkuIEEgY2hhaW4gdGhh
dA0KaGFwcGVucyB0byBoYXZlIGEgYHBsdWdgIGluIGZyb250IG9mIHRoZSBtZXRlciBpcyBtZXJl
bHkgbHVja3kuDQoNCiMjIFRoZSBmaXgNCg0KQWxsb2NhdGUgdGhlIGJ1ZmZlciBhbnl3YXkgYW5k
IGxlYXZlIGl0IHplcm8sIHNvIGEgc2NvcGUgcmVhZHMgKipzaWxlbmNlKiogb24gYSBmb3JtYXQN
CnRoZSBzMTYgY29udmVyc2lvbiBjYW5ub3Qgc2VlLiBDYWxsZXJzIG5lZWQgbm8gY2hhbmdlLCBh
bmQgbm9uZSBjYW4gYmUgbWFkZSB0byBhYm9ydCDigJQNCndoaWNoIG1hdHRlcnMsIHNpbmNlIHJl
dHVybmluZyBgTlVMTGAgaW5zdGVhZCB3b3VsZCBvbmx5IG1vdmUgYW4gdW5maXhlZCBjYWxsZXIg
ZnJvbQ0KYFNJR0FCUlRgIHRvIGBTSUdTRUdWYC4gVGhlIGNvbmRpdGlvbiBpcyBub3cgcmVwb3J0
ZWQgb25jZSB0aHJvdWdoIGBTTkRFUlIoKWAgaW5zdGVhZCBvZg0KYmVpbmcgc3dhbGxvd2VkLg0K
DQojIyBUZXN0aW5nDQoNCng4Ni02NCwgRGViaWFuIDEzLCBVU0IgREFDIHdpdGggYSBuYXRpdmUg
RFNEIHBhdGgsIG1vT2RlIGF1ZGlvIHBsYXllciB3aXRoIGl0cyBWVSBtZXRlcg0Kc2NvcGUgaW4g
dGhlIGNoYWluLiBQbGF5aW5nIGEgRFNENjQgYC5kc2ZgIHdpdGggYGRvcD1ub2A6DQoNCi0gKipi
ZWZvcmUqKjogTVBEIGFib3J0cyBvbiB0aGUgYXNzZXJ0aW9uLCB0aGUgVUkgcmVwb3J0cyAiU29j
a2V0IG9wZW4gZmFpbGVkIg0KLSAqKmFmdGVyKio6IHRoZSBEQUMgcmVjZWl2ZXMgYERTRF9VMzJf
QkUgQCA4ODIwMGAgYml0LXBlcmZlY3QsIE1QRCBzdGF5cyB1cA0KICAoYE5SZXN0YXJ0czogMGAp
LCBuZWVkbGVzIHJlYWQgemVybywgYW5kIHRoZSBsb2cgY2Fycmllcw0KICBgczE2IHNjb3BlOiBu
byBTMTYgY29udmVyc2lvbiBmb3IgZm9ybWF0IERTRF9VMzJfQkUsIHNjb3BlcyB3aWxsIHJlYWQg
c2lsZW5jZWANCg0KIyMgTGVmdCBhbG9uZQ0KDQpUaGUgbmVpZ2hib3VyaW5nIGBTMTZgICsgYE1N
QVBfTk9OSU5URVJMRUFWRURgIGJyYW5jaCBhc3NpZ25zIGBzMTYtPmJ1ZmAgYW5kIHRoZW4gYWxz
bw0KcmV0dXJucyBgLUVJTlZBTGAsIHJlYWNoaW5nIHRoZSBzYW1lIGRlYWQgZW5kLiBJdCBsb29r
cyB1bmZpbmlzaGVkIHJhdGhlciB0aGFuDQpkZWxpYmVyYXRlLCBzbyB0aGlzIHBhdGNoIGRvZXMg
bm90IHRvdWNoIGl0IOKAlCBoYXBweSB0byBmb2xsb3cgdXAgaWYgeW91IGNhbiBjb25maXJtIHRo
ZQ0KaW50ZW50LgoKUmVxdWVzdCBVUkwgICA6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2pl
Y3QvYWxzYS1saWIvcHVsbC81MTYKUGF0Y2ggVVJMICAgICA6IGh0dHBzOi8vZ2l0aHViLmNvbS9h
bHNhLXByb2plY3QvYWxzYS1saWIvcHVsbC81MTYucGF0Y2gKUmVwb3NpdG9yeSBVUkw6IGh0dHBz
Oi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS1saWIK
