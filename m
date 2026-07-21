Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0C4C4452B
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:28:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 32A07601FA;
	Wed, 22 Jul 2026 00:28:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 32A07601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784672919;
	bh=E8txZtgnya1jrr76aW3V6fZ5zG/SU2Qj/6HSugmnXSg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=NWk0vLWG0JGbePLC7LWin/OC+xMavJPAO15Cu9JhvTWWCstT3yhA/ajLe2osOa7gs
	 Z2t2zISAdzqs/jTnhb8Da0B6+KpDfut8GGKDf1ahjORmhDPZ7naKBZuhtV2GK3p+zN
	 VO/Yb2I+8YtQBrw6ZAo08+Ai/FAfsqdfY42PHOP0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BEF41F805FC; Wed, 22 Jul 2026 00:28:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 117D5F805FF;
	Wed, 22 Jul 2026 00:28:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3DC4DF804B2; Wed, 22 Jul 2026 00:27:57 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784672876;
	b=cHIYAkgsRoinLyOKOJ0GUG6HGBHDI6IREok+W5q38mFRoZ63CvVFkE+3QGJHtpc63y0V
	 ZmKgemwSrJqyi9OV/quQmzgoPuW7kzU/tt3mNPClssHM/eOAycBNSj6fxLachMJm6yWQ4
	 JRH77XxvSFQG2knEzLb1SY9LS6DSt/mNq/YdWGy9aStr5YPzfT1yw0+rDYMXxDnE1c+DI
	 l5BPdHB+I3s9+FLJ0NvRMA+urm0MhXCYIQePelgT7NBssIjDkNIH/0OIqsHVQ1bGFEtBt
	 eSRc/GOlvxMd8UqAc7IVOo4Olvwk9XrbfwF+Cs6/aHGY7uO7HA71bZ36mFkUAN5JGVw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784672876;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=E8txZtgnya1jrr76aW3V6fZ5zG/SU2Qj/6HSugmnXSg=;
	b=CmujSUvMna2fxhREcbAXQaVV7ZXZTDZ8zPmoOJV05Dir2ED20MPxRRoPswQg3tb1eTe4
	 5S7oaxO7c6jiC569p/5qhkUeBMmeOymYJEtE22d3LdxmWC99onElS/XlHQVry0Atq97eW
	 VmQnPy1OupmhXI6eG8thMZ1jFsk2tCYgRyxddKdKLg/JGhhu5po30WDYbt0xhYAjSpd42
	 1F8CgFAtXz9qKhCMDtXKUaRP6gu3BySSNzz/XLr/IufD4En+JEfeXuLDwC0x+2E5Oyw1F
	 4MxuMpyVErSXFD/8p5SFNHgEwNTsOE7+SxwAZGEuoCBY8AkrCWs1Fv2jt29AjQj7X/w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 80878F80072
	for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2026 00:27:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80878F80072
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c46e85e749b800-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/517@alsa-project.org>
References: <alsa-project/alsa-lib/pr/517@alsa-project.org>
Subject: pcm_meter: give the s16 scope a level for DSD streams
Date: Wed, 22 Jul 2026 00:27:57 +0200 (CEST)
Message-ID-Hash: 4YJ3FDTNCUR2V6WJLAVUFU6AWSEROUEV
X-Message-ID-Hash: 4YJ3FDTNCUR2V6WJLAVUFU6AWSEROUEV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4YJ3FDTNCUR2V6WJLAVUFU6AWSEROUEV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtbGliIHB1bGwgcmVxdWVzdCAjNTE3IHdhcyBvcGVuZWQgZnJvbSBH
anVqdToKCj4gKipEZXBlbmRzIG9uICM1MTYqKiAoYHBjbV9tZXRlcjogbGV0IHRoZSBzMTYgc2Nv
cGUgZGVncmFkZSBpbnN0ZWFkIG9mIGtpbGxpbmcgdGhlDQo+IGNhbGxlcmApIOKAlCBib3RoIHRv
dWNoIHRoZSBzYW1lIGBzd2l0Y2hgLCBzbyB0aGlzIGlzIHN0YWNrZWQgb24gaXQgdG8gYXZvaWQg
YSB0ZXh0dWFsDQo+IGNvbmZsaWN0LiBPbmx5IHRoZSBzZWNvbmQgY29tbWl0IGJlbG9uZ3MgdG8g
dGhpcyBQUi4NCg0KIyMgVGhlIHByb2JsZW0NCg0KVGhlIHMxNiBzY29wZSBoYXMgbm8gY29udmVy
c2lvbiBmb3IgRFNELCBzbyBgczE2X2VuYWJsZSgpYCByZWplY3RzIGl0IGFuZCBzY29wZXMgc2Vl
DQpub3RoaW5nOiBuZWVkbGVzIHNpdCBzdGlsbCBvbiBhIGZvcm1hdCB0aGF0IGlzIGluY3JlYXNp
bmdseSBjb21tb24gb24gVVNCIERBQ3MuIChCZWZvcmUNCnRoZSBwYXJlbnQgUFIsIHRoZXkgZGlk
IHdvcnNlIHRoYW4gc2l0IHN0aWxsIOKAlCB0aGUgYXBwbGljYXRpb24gYWJvcnRlZC4pDQoNCiMj
IFRoZSBhcHByb2FjaA0KDQpEU0QgY2FycmllcyBubyBzYW1wbGUgdmFsdWVzLCBvbmx5IGEgKipi
aXQgZGVuc2l0eSoqOiBvdmVyIGEgc2hvcnQgd2luZG93IHRoZSBwcm9wb3J0aW9uDQpvZiBvbmVz
ICppcyogdGhlIGFtcGxpdHVkZSwgb25lIGhhbGYgYmVpbmcgc2lsZW5jZS4gT25lIFMxNiBzYW1w
bGUgcGVyIGZyYW1lIGNhbiBiZQ0KcmVjb3ZlcmVkIGJ5IGNvdW50aW5nIHRoZSBiaXRzIG9mIHRo
YXQgZnJhbWUgYW5kIHNtb290aGluZyB0aGUgcmVzdWx0IOKAlCB3aGljaCBpcyB3aGF0IGENCnNj
b3BlIG5lZWRzLCBhIGxldmVsIHJhdGhlciB0aGFuIGEgcmVjb25zdHJ1Y3Rpb24uIE5vIGZpbHRl
ciBkZXNpZ24sIG5vIHJlc2FtcGxpbmcsIG5vDQpuZXcgZGVwZW5kZW5jeS4NCg0KQ291bnRpbmcg
Yml0cyBpcyBpbnZhcmlhbnQgdG8gdGhlaXIgb3JkZXIsIHNvIHRoZSBMRSBhbmQgQkUgdmFyaWFu
dHMgc2hhcmUgb25lIGNvZGUgcGF0aA0KYW5kIG9ubHkgdGhlIHdpZHRoIG9mIGEgZnJhbWUgbWF0
dGVycy4NCg0KVHdvIHBhcmFtZXRlcnMgc2V0IHRoZSBxdWFsaXR5LCBhbmQgYm90aCBmb2xsb3cg
dGhlIGZvcm1hdCdzIG93biBkZWZpbml0aW9uIHJhdGhlciB0aGFuDQpiZWluZyB0dW5pbmcgY2hv
aWNlczoNCg0KLSAqKnRoZSBzbW9vdGhpbmcqKiDigJQgYSBiaXQgY291bnQgaXMgbm9pc3kgKDMy
IGJpdHMgZ2l2ZSDPgyA9IDAuNS/iiJozMiksIHNvIGVhY2ggY2hhbm5lbA0KICBrZWVwcyBhbiBl
eHBvbmVudGlhbCBhdmVyYWdlIHdob3NlIHRpbWUgY29uc3RhbnQgaXMgZGVyaXZlZCBmcm9tIHRo
ZSByYXRlLiBJdCBpcw0KICB0aGVyZWZvcmUgYSAqZHVyYXRpb24qLCBhbmQgYmVoYXZlcyBpZGVu
dGljYWxseSBmcm9tIERTRDY0IHRvIERTRDUxMjsNCi0gKip0aGUgc2NhbGUqKiDigJQgMCBkQkZT
IGluIERTRCBpcyBhIDUwJSBtb2R1bGF0aW9uIGluZGV4LCBzbyBhIGZ1bGwtc2NhbGUgc2lnbmFs
IHN3aW5ncw0KICB0aGUgZGVuc2l0eSBiZXR3ZWVuIDI1JSBhbmQgNzUlIG9ubHkuIFJlZmVycmlu
ZyB0byB0aGUgd2hvbGUgMOKAkzEwMCUgcmFuZ2Ugd291bGQgcmVhZA0KICA2IGRCIGxvdy4NCg0K
IyMgVGVzdGluZw0KDQp4ODYtNjQsIERlYmlhbiAxMywgRFNELWNhcGFibGUgVVNCIERBQywgcGxh
eWluZyB0aGUgKipzYW1lIG1hc3RlciBpbiBib3RoIGZvcm1hdHMqKjoNCg0KfCBzb3VyY2UgfCBt
aW4gfCBtYXggfCBtZWFuIHwNCnwtLS18LS0tfC0tLXwtLS18DQp8IG5hdGl2ZSBEU0Q2NCAoYERT
RF9VMzJfQkVgIEAgODgyMDApIHwgMiB8IDIxIHwgNy4xIHwNCnwgRkxBQyA5Ni8yNCAoYFMzMl9M
RWAgQCA5NjAwMCkgfCAyIHwgMjIgfCA3LjYgfA0KDQpUaGUgbmVlZGxlIHJlYWRzIHRoZSBzYW1l
IGxldmVsIG9uIGJvdGgg4oCUIHRoZSBwb2ludCBiZWluZyB0aGF0IHRoZSBzY2FsZSBpcyByaWdo
dCwgbm90DQptZXJlbHkgdGhhdCB0aGUgdmFsdWUgbW92ZXMuIFRoZSBEQUMga2VlcHMgcmVjZWl2
aW5nIGBEU0RfVTMyX0JFYCBiaXQtcGVyZmVjdCB0aHJvdWdob3V0Ow0KYHR5cGUgbWV0ZXJgIGlz
IGEgcGFzc2l2ZSB0YXAgYW5kIHRoaXMgcGF0Y2ggb25seSBmZWVkcyB0aGUgc2NvcGUuCgpSZXF1
ZXN0IFVSTCAgIDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLWxpYi9wdWxs
LzUxNwpQYXRjaCBVUkwgICAgIDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNh
LWxpYi9wdWxsLzUxNy5wYXRjaApSZXBvc2l0b3J5IFVSTDogaHR0cHM6Ly9naXRodWIuY29tL2Fs
c2EtcHJvamVjdC9hbHNhLWxpYgo=
