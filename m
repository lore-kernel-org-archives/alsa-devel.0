Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533BCC624A5
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:56:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 434BE601E0;
	Mon, 31 Aug 2026 08:56:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 434BE601E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788159397;
	bh=Kufdquots0dGQ+MQjrq6++JN0oGajHe1MrZRzgUnw4Q=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Xn4BNzYHct+FiQi1I2HmjmQvURP9fem9iCq2GpnnoiCMQFXKkFS33dnH/W9wbPdqb
	 mEnmzCenDZEy0eATw+3yDymoFVD7+I67NoFfxvmNSjSc/RrMyE0YjbQIsosgHwZ+f3
	 ho92bO5C0LyxFAltPkbW4Hu4tJp0Mfgzr7k/t6+8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D7880F8060D; Mon, 31 Aug 2026 08:56:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 551BDF8060F;
	Mon, 31 Aug 2026 08:56:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 80CFDF80604; Mon, 31 Aug 2026 08:55:57 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788159353;
	b=CWawWvwgqvcOR1qnbxecJmR+OdlKYZhhXGmcmssPEJLv+1/XtPjokhZ8bnfzwyCMhwM5
	 2j4kRwd49q4OVjVHcD4tPoP/XNJAssFyxVbtTa0HyB1r+8MzzGRZda+pDcqqH2CTbKgqo
	 YQ7w7wZ2jq0ic7ROpl1bE7Y6oZ1/clLumkzRGgWpL1WGNCFa0YSIEiNvxt2wCdhyWjulw
	 +2E8TEfGdUu4+di6o3+eVW/ItxIX4/Fq3fNVwbz1/hGVui+biJD6AQPqac0X7sq2k3n7R
	 pGbH6Q06UboBOOq64qetzJo3TB3y+xft7ZThVuztaWvtSYkHbwImV7dgnvV6pyUuJmw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788159353;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=Kufdquots0dGQ+MQjrq6++JN0oGajHe1MrZRzgUnw4Q=;
	b=RuoMMoBrmfLlTuFObyPPbRdBFJWcJ5chijuu4NEkC6fUYDoqtoFsu5hQuRcyzdNIg3xl
	 bnIgXppIcUJR0sG8vU/rrey4VhCOeRpxjgvUdk/QvhK43xN+OJ8Y1nT0G5HmuKf1tg+80
	 kYbjBNsoyNqJv05VqJt7WCkT2FBGC81prWODuBDRvWhfvVgN9Wx3z4XSgJjT4khQRk2or
	 qsvN311gnQIzgZQVzX0CGtD3PLyUOkxH18T4PaFbwV08gmsKFImKNgOvwLJ/XdFdMSpAJ
	 M0CGj8ZTj8cdzvhfjLD9rW5ij28U+IbyQdWVWP7M3IQR+9WfuQ/cZwIzFxw+1uPLvsQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 27032F80602
	for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2026 08:55:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 27032F80602
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d0d174e450a800-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/844@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/844@alsa-project.org>
Subject: Rockchip: add PineNote (rk817 + PDM microphone array)
Date: Mon, 31 Aug 2026 08:55:57 +0200 (CEST)
Message-ID-Hash: NMXZCTH5KJXO2UB7HV3UWR7UNSURGEBK
X-Message-ID-Hash: NMXZCTH5KJXO2UB7HV3UWR7UNSURGEBK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NMXZCTH5KJXO2UB7HV3UWR7UNSURGEBK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgcHVsbCByZXF1ZXN0ICM4NDQgd2FzIGVkaXRlZCBm
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
dHRlZCBhbG9uZ3NpZGUgYXMKYWxzYS1wcm9qZWN0L2Fsc2EtdGVzdHMjMjcsIHRvZ2V0aGVyIHdp
dGggdHdvIHZhbGlkYXRvciBmaXhlcyBpdCBuZWVkcyB0bwpydW4gYXQgYWxsIOKAlCBhIGN1cnJl
bnQgZHVtcCBpcyByZWplY3RlZCBiZWZvcmUgaXQgaXMgcmVhZCwgYW5kIG9uZSBvZiB0aGUgZml4
ZXMKdHVybnMgYSBgVHlwZUVycm9yYCBpbnRvIHRoZSBlcnJvciBtZXNzYWdlIHRoZSB2YWxpZGF0
b3IgYWxyZWFkeSBoYWQuIFdpdGgKdGhvc2UgYXBwbGllZDoKCmBgYAokIC4vdWNtLnB5IC0tbGV2
ZWwgMCBjb25maWdzIC4uLy4uLy4uL2Fsc2EtdWNtLWNvbmYvdWNtMiBjb25maWdzIGNvbmZpZ3Mv
Um9ja2NoaXAvUGluZU5vdGUudHh0CiQgZWNobyAkPwowCmBgYAoKbm8gZXJyb3JzLCBubyB3YXJu
aW5ncy4gVGhlIHZhbGlkYXRvciBlYXJuZWQgaXRzIGtlZXAgb24gdGhpcyBvbmU6IGl0IGNhdWdo
dApgTWljIEFycmF5YCBhcyBhbiBpbGxlZ2FsIGRldmljZSBuYW1lLCB0aGUgYE1pY2AvYE1pYzJg
IG1peCwgYW5kIHR3byByZWR1bmRhbnQKdHJhaWxpbmcgYCwwYCBQQ00gc3VmZml4ZXMsIGFsbCBi
ZWZvcmUgYSBtYWludGFpbmVyIGhhZCB0by4KCkNoZWNrZWQgb24gdGhlIGhhcmR3YXJlIGFmdGVy
d2FyZHM6CgpgYGAKJCBhbHNhdWNtIC1jIFBpbmVOb3RlIHNldCBfdmVyYiBIaUZpIGxpc3QgX2Rl
dmljZXMKICAwOiBTcGVha2VyCiAgMTogTWljMQogIDI6IE1pYzIKJCBhcmVjb3JkIC1EIGh3OlBp
bmVOb3RlLDEgLWMgNCAtciA0ODAwMCAtZiBTMTZfTEUgLWQgMiAvdG1wL3Qud2F2CmBgYAoKZm91
ciBsaXZlIGNoYW5uZWxzLiBJIGhhdmUgdGhlIGRldmljZSBhbmQgY2FuIHJlLXJ1biBhbnl0aGlu
ZyBvbiByZXF1ZXN0LgoKUmVxdWVzdCBVUkwgICA6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXBy
b2plY3QvYWxzYS11Y20tY29uZi9wdWxsLzg0NApQYXRjaCBVUkwgICAgIDogaHR0cHM6Ly9naXRo
dWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLXVjbS1jb25mL3B1bGwvODQ0LnBhdGNoClJlcG9zaXRv
cnkgVVJMOiBodHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYK
