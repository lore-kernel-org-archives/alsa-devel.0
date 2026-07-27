Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72738C5321C
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:43:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9DC35601FF;
	Mon, 27 Jul 2026 09:43:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9DC35601FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785138218;
	bh=R7rWJCGaniwERLwZAQVmFGOOs6qTQTIYQn9AVyuNr6g=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Z+cO1ou5cCpYzC/yN9DMQDmU7Jdo6XJLC+ozpGRCHp3DlKh2SOiuyrfjuHyLMPgIA
	 DM37Gi3GM+IZ20UeSNGCvder8MbIiH6QMm9ilWpYKGNftUgk+T77JoepREVVnYDW3E
	 rdrVVHbim7t21ZRnQ9teI8jqKLjPs74qg9JMCq/U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A0672F80589; Mon, 27 Jul 2026 09:43:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 55A1BF805F7;
	Mon, 27 Jul 2026 09:43:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 077D3F80526; Mon, 27 Jul 2026 09:42:55 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785138174;
	b=ekkyoq93Vl7Ss3Lzcub48mJew5dS8+BHEFOKIhbsHanzJw22FvfaQkCJidRp1UYCtc3v
	 koKcw0imA2SKq0i/1MKiCrz/HfjEY2KXEakXiHvE9A5Df+Z2S/jdZCRF2ZRkY1EhH6snP
	 c3Xi19ovnsX4Z+7QvVAZ+Y2qrAvscIXrpehMl1hOuOS1wC1VclHNm+YFDex5tnCcJ1kt7
	 AS+Dq/HMtZtLcDKB9VuN8hlLPvnrctj6kwonsys/r3zgLZuDIR4C8VJ5maBg5sqlm0Wqx
	 UDzkvkQVNfKwbUIkn2bFdhPh6Q8qeBH92U6b16vNrkIEjKjUEBEQg+56WXxX1IkSFuQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785138174;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=R7rWJCGaniwERLwZAQVmFGOOs6qTQTIYQn9AVyuNr6g=;
	b=CVNbcOuVHw8TcYSmFHVx+LSNWXMXe/jH7hxFpbTj0qgR8Vcjel/dDW+AR+nVyLWNd/4x
	 eh5cQ3KbovmYhk48/LICTrZnxVm6l/NS/d8WQiVXcOeqzOqUSxxlyF2b7Y+r0/qpdSXab
	 mPtIbqX0T7+feCA/n4034W/5tY1ZIyu8nz18U8C8FcXgvAfFgnIf35uN/PLX7TFlZo7W+
	 jsZXMEZgUmUag7c09DQMrephrSd+djK+yfGo/QO0P5xBM+g4ZLDoD6bJNcis0zX7DkinU
	 HWDV9Rnebjpqtj7wxKlDD+JpomMQrMhuqL7/kt8gPE9MVeFMFTgw+5dONwQcTYKcqrQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id E67A5F800BA
	for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2026 09:42:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E67A5F800BA
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c615b5a865af00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/516@alsa-project.org>
References: <alsa-project/alsa-lib/pr/516@alsa-project.org>
Subject: pcm_meter: let the s16 scope degrade instead of killing the caller
Date: Mon, 27 Jul 2026 09:42:54 +0200 (CEST)
Message-ID-Hash: AC3HDYCNOMIUIVLQGZ5NA2BVUDQA4XYQ
X-Message-ID-Hash: AC3HDYCNOMIUIVLQGZ5NA2BVUDQA4XYQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AC3HDYCNOMIUIVLQGZ5NA2BVUDQA4XYQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtbGliIHB1bGwgcmVxdWVzdCAjNTE2IHdhcyBlZGl0ZWQgZnJvbSBH
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
IGl0cyBvd24NCmNhbGxlci4gQW55IG91dC1vZi10cmVlIHNjb3BlIHJlYWNoaW5nIHRoZSBidWZm
ZXIgdGhyb3VnaCB0aGUgc2FtZSBkb2N1bWVudGVkIGFjY2Vzc29yDQpmYWlscyBpZGVudGljYWxs
eSwgYW5kIGEgbXVzaWMgcGxheWVyIGFib3J0cyBtaWQtcGxheWJhY2sgdGhlIG1vbWVudCBhIERT
RCB0cmFjayBzdGFydHMuDQoNCk5vdGUgdGhlIGZhaWx1cmUgaXMgKm5vdCogRFNELXNwZWNpZmlj
IOKAlCBhbnkgZm9ybWF0IG91dHNpZGUgdGhlIDE3IHRoZSBzd2l0Y2ggbGlzdHMNCnRyaWdnZXJz
IGl0LCBpbmNsdWRpbmcgYFMyNF8zTEVgLCB3aGljaCBwbGVudHkgb2YgVVNCIERBQ3MgZXhwb3Nl
IG5hdGl2ZWx5LiBBIGNoYWluIHRoYXQNCmhhcHBlbnMgdG8gaGF2ZSBhIGBwbHVnYCBpbiBmcm9u
dCBvZiB0aGUgbWV0ZXIgaXMgbWVyZWx5IGx1Y2t5Lg0KDQojIyBUaGUgZml4DQoNCkFsbG9jYXRl
IHRoZSBidWZmZXIgYW55d2F5IGFuZCBsZWF2ZSBpdCB6ZXJvZWQsIHNvIHRoZSBhY2Nlc3NvciBh
bHdheXMgcmV0dXJucyB2YWxpZA0KbWVtb3J5IGFuZCB0aGUgczE2IGJ1ZmZlciBjYXJyaWVzIHNp
bGVuY2UgZm9yIGEgZm9ybWF0IHRoZSBjb252ZXJzaW9uIGNhbm5vdCBleHByZXNzLg0KQ2FsbGVy
cyBuZWVkIG5vIGNoYW5nZSwgYW5kIG5vbmUgY2FuIGJlIG1hZGUgdG8gYWJvcnQg4oCUIHdoaWNo
IG1hdHRlcnMsIHNpbmNlIHJldHVybmluZw0KYE5VTExgIGluc3RlYWQgd291bGQgb25seSBtb3Zl
IGFuIHVuZml4ZWQgY2FsbGVyIGZyb20gYFNJR0FCUlRgIHRvIGBTSUdTRUdWYC4gVGhlDQpjb25k
aXRpb24gaXMgbm93IHJlcG9ydGVkIG9uY2UgdGhyb3VnaCBgU05ERVJSKClgIGluc3RlYWQgb2Yg
YmVpbmcgc3dhbGxvd2VkLg0KDQojIyBUZXN0aW5nDQoNCng4Ni02NCwgRGViaWFuIDEzLCBVU0Ig
REFDIHdpdGggYSBuYXRpdmUgRFNEIHBhdGgsIE1QRCBwbGF5aW5nIGEgRFNENjQgYC5kc2ZgIHdp
dGgNCmBkb3A9bm9gIHRocm91Z2ggYSBgdHlwZSBtZXRlcmAgUENNIHdpdGggYSBzY29wZSBhdHRh
Y2hlZDoNCg0KLSAqKmJlZm9yZSoqOiBNUEQgYWJvcnRzIG9uIHRoZSBhc3NlcnRpb24gYW5kIHBs
YXliYWNrIGRpZXMNCi0gKiphZnRlcioqOiB0aGUgREFDIHJlY2VpdmVzIGBEU0RfVTMyX0JFIEAg
ODgyMDBgIGJpdC1wZXJmZWN0LCBNUEQgc3RheXMgdXAgYW5kIGlzDQogIG5ldmVyIHJlc3RhcnRl
ZCwgdGhlIHMxNiBidWZmZXIgaXMgZXhwb3NlZCB6ZXJvLWZpbGxlZCwgYW5kIHRoZSBsb2cgY2Fy
cmllcw0KICBgczE2IHNjb3BlOiBubyBTMTYgY29udmVyc2lvbiBmb3IgZm9ybWF0IERTRF9VMzJf
QkUsIHNjb3BlcyB3aWxsIHJlYWQgc2lsZW5jZWANCg0KIyMgTGVmdCBhbG9uZQ0KDQpUaGUgbmVp
Z2hib3VyaW5nIGBTMTZgICsgYE1NQVBfTk9OSU5URVJMRUFWRURgIGJyYW5jaCBhc3NpZ25zIGBz
MTYtPmJ1ZmAgYW5kIHRoZW4gYWxzbw0KcmV0dXJucyBgLUVJTlZBTGAsIHJlYWNoaW5nIHRoZSBz
YW1lIGRlYWQgZW5kLiBJdCBsb29rcyB1bmZpbmlzaGVkIHJhdGhlciB0aGFuDQpkZWxpYmVyYXRl
LCBzbyB0aGlzIHBhdGNoIGRvZXMgbm90IHRvdWNoIGl0IOKAlCBoYXBweSB0byBmb2xsb3cgdXAg
aWYgeW91IGNhbiBjb25maXJtIHRoZQ0KaW50ZW50LgoKUmVxdWVzdCBVUkwgICA6IGh0dHBzOi8v
Z2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS1saWIvcHVsbC81MTYKUGF0Y2ggVVJMICAgICA6
IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS1saWIvcHVsbC81MTYucGF0Y2gK
UmVwb3NpdG9yeSBVUkw6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS1saWIK
