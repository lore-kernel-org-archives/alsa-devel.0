Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27C2CA5FCE
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2026 18:58:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BC23460277;
	Thu,  1 Oct 2026 20:58:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BC23460277
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790881119;
	bh=8zkBzs2P5Loo4nIsjA1zLzkwmP7pfZ5vuF7R4IzlKF0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=kynbjYjLg34h+sc5oxCfzP1oymaYGKcEmM1TDuf91SgaCDZPwl0RhHq+SYaXYHLOh
	 lA+0bagqf8CCMqsBIVJ6QXeWqNhsCJb0ykdbmyVU+BDw7ilYdfFebeJ5klZempOuWV
	 NPqBjMuj8ofGmU6tQuCAc8gDC4ATHU/m+2UX2U+g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B4096F80601; Thu,  1 Oct 2026 20:58:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 08D67F805F1;
	Thu,  1 Oct 2026 20:58:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 88A6CF8057F; Thu,  1 Oct 2026 20:57:58 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790881077;
	b=eYH/6m1LfXXoh8e0MYBzRYVzTz9h985iInVloHcUXs/yufAe/PlyTaek7zMJk5/vfiJt
	 5hIn3BLg6leNJczcDV4p2c/Q8edOQehgUVNwlJRy9+zWt5gtECtU7GbO8W+EiS2bbWF5f
	 jjJzJS2bIYrAeeLpo4ji4SENyKHsrefj7fjOXeSf7JNgiYiFXyOmfe2Mg/ez4gdF5GNo9
	 8puRKAW1dhkfBJI1S6FkgW4YEDLwdVF4GRUcEiZ2lVBBoHaQ1mT2b4FAzNfBpkreFRGdg
	 4MKiZoCPjErtqL0BQTzVvq0qHQDJhPcgztsIwRMlAMtuu6k0QXCoMBxH53OCOd/K/NA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790881077;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=8zkBzs2P5Loo4nIsjA1zLzkwmP7pfZ5vuF7R4IzlKF0=;
	b=V7XGra76D03b0nxLfIvZ385uezXrEeCEaHKdP66G0ZAqy0Bwcm9IV3DasQh7HwguWkHR
	 HxzqaEXJ8nhulIhODYDBf+4tXfB/AJihe2oBomJ2X4eYJSh+XN37ylRKCO8d6WX8WZ9ma
	 Fe7bZXanxaXnVkxnPI/6Q4a6uV2ygGr1haye+Xv0DNBpXLKCU2HwCuMCfwAktfxx4wcV5
	 hv7QUKH8E59znWttqmQ7RKNg3jBKO3W4+HuBf0QNkGA5+GXSQYvYRd9MaSGjt8tjScM8V
	 qs0Ji31Z6c9PnYCigH7aYUK2rfw3SIi2nRRrKiDbsHkeX/9fP9RehdYmh0ov+czzBgg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 22E15F804CC
	for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2026 20:57:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22E15F804CC
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18da7cd96acc8700-webhooks-bot@alsa-project.org>
In-Reply-To: <18da7cd96a94b800-webhooks-bot@alsa-project.org>
References: <18da7cd96a94b800-webhooks-bot@alsa-project.org>
Subject: sof-hda-dsp / HUAWEI MACHD-WXX9 (CX11880): Speaker profile mutes the
 Headphone amp, which is what drives the internal speakers
Date: Thu,  1 Oct 2026 20:57:58 +0200 (CEST)
Message-ID-Hash: 2H7H2646VBVAFTSXJGP4MBB7GUCXZFI2
X-Message-ID-Hash: 2H7H2646VBVAFTSXJGP4MBB7GUCXZFI2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2H7H2646VBVAFTSXJGP4MBB7GUCXZFI2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgaXNzdWUgIzg2MyB3YXMgb3BlbmVkIGZyb20gbWlz
dGVyY3liM3I6CgojIyBTdW1tYXJ5CgpPbiBhIEhVQVdFSSAqKk1BQ0hELVdYWDkqKiAoTWF0ZUJv
b2sgWCwgQ29uZXhhbnQgKipDWDExODgwKiopLCB0aGUgaW50ZXJuYWwgc3BlYWtlcnMgYXJlIHdp
cmVkIHRvIHRoZSAqKmhlYWRwaG9uZSoqIGFtcGxpZmllci4gVGhlIGdlbmVyYXRlZCBgSGlGaSAo
Li4uLCBTcGVha2VyKWAgcHJvZmlsZSBzd2l0Y2hlcyBvbiBgU3BlYWtlciBQbGF5YmFjayBTd2l0
Y2hgLCB3aGljaCBjb250cm9scyBub3RoaW5nIGF1ZGlibGUgb24gdGhpcyBib2FyZCwgd2hpbGUg
dGhlIGBIZWFkcGhvbmVzYCBkZXZpY2UncyBgRGlzYWJsZVNlcXVlbmNlYCBtdXRlcyBgSGVhZHBo
b25lIFBsYXliYWNrIFN3aXRjaGAg4oCUIHRoZSBhbXBsaWZpZXIgdGhhdCBhY3R1YWxseSBkcml2
ZXMgdGhlIGludGVybmFsIHNwZWFrZXJzLgoKUmVzdWx0OiB3aXRoIHRoZSBqYWNrIGVtcHR5IHRo
ZSBpbnRlcm5hbCBzcGVha2VycyBhcmUgbmVhcmx5IHNpbGVudCwgd2hpbGUgd2l0aCB0aGUgamFj
ayBpbnNlcnRlZCB0aGUgaGVhZHBob25lcyBhbmQgdGhlIGludGVybmFsIHNwZWFrZXJzIGJvdGgg
cGxheSBhdCBmdWxsIGxldmVsLgoKIyMgRW52aXJvbm1lbnQKCnwgfCB8CnwtLS18LS0tfAp8IE1h
Y2hpbmUgfCBIVUFXRUkgTUFDSEQtV1hYOSAocHJvZHVjdF9mYW1pbHkgYE1hdGVCb29rIFhgLCBi
b2FyZCBgTUFDSEQtV1hYOS1QQ0ItQjFgKSB8CnwgQ29kZWMgfCBDb25leGFudCBDWDExODgwIChg
MHgxNGYxMWY4NmApIHwKfCBEcml2ZXIgfCBgc29mLWhkYS1kc3BgIC8gYHNrbF9oZGFfZHNwX2dl
bmVyaWNgIHwKfCBEaXN0cm8gfCBBcmNoIExpbnV4IC8gT21hcmNoeSwga2VybmVsIGA3LjIuNS0z
LW9tYXJjaHlgIHwKfCBhbHNhLXVjbS1jb25mIHwgYDEuMi4xNi4xLTFgIHwKfCBhbHNhLWxpYiB8
IGAxLjIuMTYuMS0xYCB8Cnwgc29mLWZpcm13YXJlIHwgYDIwMjUuMTIuMi0xYCB8CgpLZXJuZWwg
YXV0b2NvbmZpZzoKCmBgYApzbmRfaGRhX2NvZGVjX2NvbmV4YW50IGVoZGF1ZGlvMEQwOiBhdXRv
Y29uZmlnIGZvciBDWDExODgwOiBsaW5lX291dHM9MSAoMHgxNy8weDAvMHgwLzB4MC8weDApIHR5
cGU6c3BlYWtlcgpzbmRfaGRhX2NvZGVjX2NvbmV4YW50IGVoZGF1ZGlvMEQwOiAgICBzcGVha2Vy
X291dHM9MCAoMHgwLzB4MC8weDAvMHgwLzB4MCkKc25kX2hkYV9jb2RlY19jb25leGFudCBlaGRh
dWRpbzBEMDogICAgaHBfb3V0cz0xICgweDE2LzB4MC8weDAvMHgwLzB4MCkKYGBgCgojIyBNZWFz
dXJlZCBzdGF0ZSB0cmFuc2l0aW9ucyAoMSBzIHNhbXBsaW5nIGFjcm9zcyBwbHVnL3VucGx1ZykK
CnwgamFjayB8IHBpbiAweDE2IChIUCkgUGluLWN0bHMgfCBwaW4gMHgxNyAoc3BrKSBQaW4tY3Rs
cyB8IGBTcGVha2VyYCBjdGwgfCBgSGVhZHBob25lYCBjdGwgfCBhY3RpdmUgcHJvZmlsZSB8Cnwt
LS18LS0tfC0tLXwtLS18LS0tfC0tLXwKfCBwbHVnZ2VkIHwgYDB4YzBgIChPVVQgSFApIHwgYDB4
MDBgIChvZmYpIHwgb2ZmIHwgKipvbioqIHwgSGVhZHBob25lcyB8CnwgdW5wbHVnZ2VkIHwgYDB4
YzBgIHwgYDB4NDBgIChPVVQpIHwgKipvbioqIHwgKipvZmYqKiB8IFNwZWFrZXIgfAoKIyMgRXZp
ZGVuY2UgdGhhdCB0aGUgaW50ZXJuYWwgc3BlYWtlcnMgYXJlIG5vdCBvbiB0aGUgYFNwZWFrZXJg
IHBhdGgKCi0gVG9nZ2xpbmcgYFNwZWFrZXIgUGxheWJhY2sgU3dpdGNoYCBwcm92YWJseSBtdXRl
cyB0aGUgYW1wbGlmaWVyIGl0IG93bnMg4oCUIHRoZSBjb2RlYyBhbXAgcmVnaXN0ZXIgZmxpcHMg
YDB4NGFgICh1bm11dGVkKSB0byBgMHhjYWAgKG11dGUgYml0IHNldCkg4oCUIHlldCB0aGUgaW50
ZXJuYWwgc3BlYWtlcnMga2VlcCBwbGF5aW5nLgotIEFsbCBjb2RlYyBHUElPcyBhcmUgdW5jb25m
aWd1cmVkOiBgR0VUX0dQSU9fTUFTS2AsIGBHRVRfR1BJT19ESVJFQ1RJT05gLCBgR0VUX0dQSU9f
REFUQWAgYW5kIHRoZSBzdGlja3kvd2FrZSBtYXNrcyBhbGwgcmV0dXJuIGAweDBgLiBUaGVyZSBp
cyBubyBHUElPLWJhc2VkIGV4dGVybmFsLWFtcGxpZmllciBtdXRlIHRvIGZhbGwgYmFjayBvbi4K
LSBUaGlzIG1hdGNoZXMgcmVwb3J0cyBmb3Igb3RoZXIgSHVhd2VpIGJvYXJkcyB3aXRoIHRoZSBz
YW1lIGNvZGVjL3dpcmluZzogaHR0cHM6Ly9naXRodWIuY29tL3BvcC1vcy9wb3AvaXNzdWVzLzQw
NjQgYW5kIGh0dHBzOi8vZ2l0aHViLmNvbS90aGVzb2Zwcm9qZWN0L2xpbnV4L2lzc3Vlcy8zMzUw
ICgiSGVhZHBob25lcyBhbmQgc3BlYWtlcnMgcGxheSBzaW11bHRhbmVvdXNseSB3aGVuIGhlYWRw
aG9uZXMgYXJlIHBsdWdnZWQgaW4iKS4KCiMjIFdoeSB0aGlzIGlzIGEgVUNNIGlzc3VlIGFuZCBu
b3QgYSBjb2RlYyBvbmUKClRoZSBqYWNrIGlzIGRldGVjdGVkIGNvcnJlY3RseSAoYEhlYWRwaG9u
ZSBKYWNrYCB0b2dnbGVzIG9uL29mZiwgdGhlIHBvcnQgcmVwb3J0cyBgYXZhaWxhYmxlYCwgYW5k
IFdpcmVQbHVtYmVyIHN3aXRjaGVzIHByb2ZpbGVzIGNvcnJlY3RseSkuIFRoZSBvbmx5IHdyb25n
IHBhcnQgaXMgKndoaWNoKiBhbXBsaWZpZXIgdGhlIFNwZWFrZXIgcHJvZmlsZSB0b2dnbGVzIGZv
ciB0aGlzIGJvYXJkLgoKIyMgU3VnZ2VzdGVkIGZpeAoKYEhpRmktc3BrLmNvbmZgJ3MgYFNwZWFr
ZXJgIGRldmljZSBpcyBnZW5lcmljLCBzbyB0aGUgY2hhbmdlIG5lZWRzIGEgbWFjaGluZSBjb25k
aXRpb24sIGUuZy4gaW4gdGhlIFNwZWFrZXIgYEVuYWJsZVNlcXVlbmNlYDoKCmBgYApJZi5odWF3
ZWktbWFjaGQgewogICAgQ29uZGl0aW9uIHsgVHlwZSBTdHJpbmcgLi4uICIke3N5czpkZXZpY2Vz
L3ZpcnR1YWwvZG1pL2lkL3Byb2R1Y3RfbmFtZX0iIC4uLiB9CiAgICBUcnVlIHsgY3NldCAibmFt
ZT0nSGVhZHBob25lIFBsYXliYWNrIFN3aXRjaCcgb24iIH0KfQpgYGAKCihDb21tZW50OiBpdCB3
b3VsZCBiZSB3b3J0aCBndWFyZGluZyBvbiBgcHJvZHVjdF9uYW1lID09ICJNQUNIRC1XWFg5ImAs
IHBvc3NpYmx5IGFsc28gYHN5c192ZW5kb3IgPT0gIkhVQVdFSSJgLikKCiMjIEludGVyaW0gd29y
a2Fyb3VuZAoKQSB1c2VyIHNlcnZpY2UgcmUtYXNzZXJ0cyBgYW1peGVyIC1jMCBzc2V0IEhlYWRw
aG9uZSBvbmAgd2hlbmV2ZXIgdGhlIGphY2sgc3dpdGNoZXMsIHdoaWNoIHJlc3RvcmVzIGZ1bGwg
c3BlYWtlciBsZXZlbCB3aGVuIHVucGx1Z2dlZC4gSGVhZHBob25lcy1vbmx5IHBsYXliYWNrIHdo
aWxlIHBsdWdnZWQgaXMgbm90IGFjaGlldmFibGUgb24gdGhpcyBib2FyZCBpbiBzb2Z0d2FyZSDi
gJQgdGhlIHNwZWFrZXJzIGFuZCB0aGUgamFjayBzaGFyZSBvbmUgYW1wbGlmaWVyIGFuZCB0aGVy
ZSBpcyBubyBtdXRlIGxpbmUuCgpJc3N1ZSBVUkwgICAgIDogaHR0cHM6Ly9naXRodWIuY29tL2Fs
c2EtcHJvamVjdC9hbHNhLXVjbS1jb25mL2lzc3Vlcy84NjMKUmVwb3NpdG9yeSBVUkw6IGh0dHBz
Oi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29uZgo=
