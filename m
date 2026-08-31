Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF02C624A5
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:56:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EAD98601C0;
	Mon, 31 Aug 2026 08:56:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EAD98601C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788159386;
	bh=fyshD+7g3wyzJ5kj4RK4CnCY40uAl9KSTGnzWQpDLqk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=vY8BvVlG0MzB0TICEs3TO1AKLz2WydK1Vu/+W1Bh8Hp6HRsWnZKrOd/dhRn2PZL2Z
	 YdZnHRqc77widbeujqdypMpDkTWkouBGK0SYkBu6AiKTbRxiFaRPeD44BlX61B2pTx
	 rpFU4fEwYn6MhaWIYBnKL+IQguVMaB8GOMlutrQY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EBD7BF805F5; Mon, 31 Aug 2026 08:55:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BF715F8051D;
	Mon, 31 Aug 2026 08:55:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6E3B9F8051F; Mon, 31 Aug 2026 08:55:41 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788159337;
	b=p1ZsBYis/ZKTt42Y7SRKTlJfh5x2kcInKARgymWe7LOwH69ShMqs8ur6yStJvTETmNUg
	 IdqG0U0ZIJpPs84kzPPbn3rwFn2k9Vb+qWYnBpMNNV95Y6MU/5aQGH8Y/0kyQ9otWDxXZ
	 nTeXbtZqRUVt/fYNVt/ex0B8YNVslYpiyW1sGG035Ec+BG5/RD7PpHj1kxjXe2dzwKAB5
	 TlAsIPB3wvHhbvnqac6HWSaVcrbMK2rWEZkdHRfFFm4mg8LqrFF2o7G98j4UCc5oskZJA
	 p/ZCtJ0X57mcokoc+BgE8fC9C7H6IVqcMlj/X6jDP250SnYZQx+4bfWtD0xxK0esvsQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788159337;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=fyshD+7g3wyzJ5kj4RK4CnCY40uAl9KSTGnzWQpDLqk=;
	b=r581KY2Ls4LVN7RaE0c3z8+jquKgnbDOoshZ1bJWuV3zAaQdLZFFzKvmOvuTb01pDN4M
	 4vISalyLYEps1p5fyyMjNAruWMsKYFtNMPGLprseNeEB/b2v1vwhzA4dWBH2fCXjjSPP5
	 gdol6bmVfaRdLHs39dUO01uqUezW73L5NIRTPUNZOcquc9SvOfqtTll5+qs6mbXGT95wI
	 wqqUqd/i48+dwyfo940BF1shMXwLYecKFFUgAFzFtpSnTfId4m0rPr6xb5/7zSRagpga5
	 n+NYmsEK5O3SVrW3RuDiwhj2wIINzRHeojQdLGe/3Nmc0t0+ZJtkGZ+ZV1naKAUCb0A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 03FEBF800AC
	for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2026 08:55:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03FEBF800AC
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d0d171139ee100-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/844@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/844@alsa-project.org>
Subject: Rockchip: add PineNote (rk817 + PDM microphone array)
Date: Mon, 31 Aug 2026 08:55:41 +0200 (CEST)
Message-ID-Hash: CQDTSD3YLY2XULYTJRXO7MFSX6HFDZP4
X-Message-ID-Hash: CQDTSD3YLY2XULYTJRXO7MFSX6HFDZP4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CQDTSD3YLY2XULYTJRXO7MFSX6HFDZP4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgcHVsbCByZXF1ZXN0ICM4NDQgd2FzIG9wZW5lZCBm
cm9tIGN2ZXJvcmc6CgpUaGUgUGluZTY0IFBpbmVOb3RlIHBhaXJzIGFuIHJrODE3IGNvZGVjIHdp
dGggYSBmb3VyLW1pY3JvcGhvbmUgUERNIGFycmF5IG9uIGEKc2Vjb25kIFBDTS4gTm90aGluZyBp
biB0aGUgdHJlZSBkZXNjcmliZXMgaXQsIHNvIHRoZSBhcnJheSBpcyBub3Qgb2ZmZXJlZCBhcyBh
CmNhcHR1cmUgc291cmNlIGF0IGFsbCDigJQgd2hpY2ggaXMgbW9zdCBvZiB3aGF0IG1ha2VzIHRo
ZSBtYWNoaW5lIGludGVyZXN0aW5nLApzaW5jZSB0aGUgZm91ciBob2xlcyBhYm92ZSB0aGUgc2Ny
ZWVuIGFyZSBvdGhlcndpc2UgdW51c2VkIGJ5IGFueXRoaW5nLgoKYFNwZWFrZXJgIGFuZCBgTWlj
MWAgYXJlIGFkYXB0ZWQgZnJvbSBgUm9ja2NoaXAvcms4MTctc291bmRgLCB3aGljaCBwYWlycyB0
aGUKc2FtZSBjb2RlYyB3aXRoIHRoZSBzYW1lIG1peGVyIGNvbnRyb2wgbmFtZXMuIGBNaWMyYCBp
cyB0aGUgYXJyYXkgb24KYGh3OlBpbmVOb3RlLDFgOiBjYXB0dXJlLW9ubHksIGZvdXIgY2hhbm5l
bHMsIGFuZCBubyBtaXhlciBjb250cm9scyBvZiBpdHMgb3duLApiZWNhdXNlIGdhaW4gYW5kIHJv
dXRpbmcgZm9yIGl0IGFyZSBmaXhlZCBpbiBoYXJkd2FyZS4KClRoZSBib3Jyb3dlZCBgSWYuMWAg
YmxvY2sgaXMga2VwdCB2ZXJiYXRpbSwgYW5kIHRoZSBib2FyZCdzIGRldmljZSB0cmVlIGV4cGxh
aW5zCndoeSBpdCBpcyByaWdodCBoZXJlIHJhdGhlciB0aGFuIG1lcmVseSBpbmhlcml0ZWQ6IEhQ
T0wvSFBPUiBmZWVkIHRoZSBTcGVha2VyCkFtcCBpbnB1dHMsIHdob3NlIG91dHB1dHMgZmVlZCBg
SW50ZXJuYWwgU3BlYWtlcnNgLCB3aGljaCBgcGluLXN3aXRjaGVzYCB0dXJucwppbnRvIHRoZSBg
SW50ZXJuYWwgU3BlYWtlcnMgU3dpdGNoYCBjb250cm9sLiBUaGUgbXV4IGhhcyB0byBzaXQgb24g
SFAgZm9yIHRoZQpzcGVha2VycyB0byBtYWtlIGFueSBzb3VuZC4KCiMjIyBObyBIZWFkcGhvbmVz
IGRldmljZSwgb24gcHVycG9zZQoKVGhlIGJvYXJkIGRvZXMgaGF2ZSBhIGhlYWRwaG9uZSBwYXRo
IOKAlCB0aGUgY29kZWMncyBIUE9ML0hQT1IgZ28gdG8gYSBVU0ItQwphdWRpby9VU0Igc3dpdGNo
LCBhbmQgYGFyY2gvYXJtNjQvYm9vdC9kdHMvcm9ja2NoaXAvcmszNTY2LXBpbmVub3RlLmR0c2lg
CmRlY2xhcmVzIHRoZSB3aWRnZXQgZm9yIGl0LiBXaGF0IGl0IGhhcyBubyB3YXkgdG8gcmVhY2g6
IHRoZSBzYW1lIGZpbGUncwpgdXNiLWMtY29ubmVjdG9yYCBub2RlIGNhcnJpZXMgb25seSBhIFVT
QjIgSFMgZW5kcG9pbnQsIHdpdGggbm8gYXVkaW8gbW9kZSBhbmQKbm8gbW9kZS1zd2l0Y2ggb3Ig
bXV4IGJpbmRpbmcsIGFuZCB0aGVyZSBpcyBubyBqYWNrIGRldGVjdGlvbiBhbnl3aGVyZSBpbiB0
aGUKdHJlZSBmb3IgYEphY2tDb250cm9sYCB0byBuYW1lLiBBIGBIZWFkcGhvbmVzYCBkZXZpY2Ug
d291bGQgYmUgc2VsZWN0YWJsZSwKc2lsZW50IGFuZCB1bmdhdGVkLiBXb3J0aCByZXZpc2l0aW5n
IGlmIHRoZSBjb25uZWN0b3IgZ2FpbnMgYW4gYXVkaW8tbW9kZQpiaW5kaW5nOyBJIHdvdWxkIHJh
dGhlciBsZWF2ZSBpdCBvdXQgdGhhbiBzaGlwIGEgZGV2aWNlIHRoYXQgZG9lcyBub3RoaW5nLgoK
IyMjIFZhbGlkYXRpb24KClRoZSBhbHNhLWluZm8uc2ggZHVtcCB0aGlzIG5lZWRzIGlzIHN1Ym1p
dHRlZCBhbG9uZ3NpZGUgYXMKYWxzYS1wcm9qZWN0L2Fsc2EtdGVzdHMjVEVTVFNfUFIsIHRvZ2V0
aGVyIHdpdGggdHdvIHZhbGlkYXRvciBmaXhlcyBpdCBuZWVkcyB0bwpydW4gYXQgYWxsIOKAlCBh
IGN1cnJlbnQgZHVtcCBpcyByZWplY3RlZCBiZWZvcmUgaXQgaXMgcmVhZCwgYW5kIG9uZSBvZiB0
aGUgZml4ZXMKdHVybnMgYSBgVHlwZUVycm9yYCBpbnRvIHRoZSBlcnJvciBtZXNzYWdlIHRoZSB2
YWxpZGF0b3IgYWxyZWFkeSBoYWQuIFdpdGgKdGhvc2UgYXBwbGllZDoKCmBgYAokIC4vdWNtLnB5
IC0tbGV2ZWwgMCBjb25maWdzIC4uLy4uLy4uL2Fsc2EtdWNtLWNvbmYvdWNtMiBjb25maWdzIGNv
bmZpZ3MvUm9ja2NoaXAvUGluZU5vdGUudHh0CiQgZWNobyAkPwowCmBgYAoKbm8gZXJyb3JzLCBu
byB3YXJuaW5ncy4gVGhlIHZhbGlkYXRvciBlYXJuZWQgaXRzIGtlZXAgb24gdGhpcyBvbmU6IGl0
IGNhdWdodApgTWljIEFycmF5YCBhcyBhbiBpbGxlZ2FsIGRldmljZSBuYW1lLCB0aGUgYE1pY2Av
YE1pYzJgIG1peCwgYW5kIHR3byByZWR1bmRhbnQKdHJhaWxpbmcgYCwwYCBQQ00gc3VmZml4ZXMs
IGFsbCBiZWZvcmUgYSBtYWludGFpbmVyIGhhZCB0by4KCkNoZWNrZWQgb24gdGhlIGhhcmR3YXJl
IGFmdGVyd2FyZHM6CgpgYGAKJCBhbHNhdWNtIC1jIFBpbmVOb3RlIHNldCBfdmVyYiBIaUZpIGxp
c3QgX2RldmljZXMKICAwOiBTcGVha2VyCiAgMTogTWljMQogIDI6IE1pYzIKJCBhcmVjb3JkIC1E
IGh3OlBpbmVOb3RlLDEgLWMgNCAtciA0ODAwMCAtZiBTMTZfTEUgLWQgMiAvdG1wL3Qud2F2CmBg
YAoKZm91ciBsaXZlIGNoYW5uZWxzLiBJIGhhdmUgdGhlIGRldmljZSBhbmQgY2FuIHJlLXJ1biBh
bnl0aGluZyBvbiByZXF1ZXN0LgoKUmVxdWVzdCBVUkwgICA6IGh0dHBzOi8vZ2l0aHViLmNvbS9h
bHNhLXByb2plY3QvYWxzYS11Y20tY29uZi9wdWxsLzg0NApQYXRjaCBVUkwgICAgIDogaHR0cHM6
Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLXVjbS1jb25mL3B1bGwvODQ0LnBhdGNoClJl
cG9zaXRvcnkgVVJMOiBodHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNv
bmYK
