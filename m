Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6173CC43458
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2026 08:24:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3BC1760237;
	Wed,  1 Jul 2026 10:24:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3BC1760237
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782894296;
	bh=1je74XHrghlGogiSL6UxFDbfYjFIDsBFfQC0v4V2i7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=bHAIKoo62xgIX4KGG0X1QI310qPfuqYFFzcqirhtn03N5cfAhj4aW6BsQ3LII0aee
	 OznegoSA4FqegqNQiDiUbBe7RIR+E5w9X7ZPdMO67zCjlwywiiZFESmALYa15LMVbs
	 JVEigDfEc6xr53L2xGC7juWIUhBkS+yA7A5dzn0s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DEDE8F80609; Wed,  1 Jul 2026 10:24:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 346E4F8060E;
	Wed,  1 Jul 2026 10:24:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 165E9F8051F; Wed,  1 Jul 2026 10:18:10 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=117.135.210.6
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782893888;
	b=qNN+QG/akVu/CcspWywYLwSYDSTnFMtocOK1t93ES2hyIjNXN6irFkBEaAilUX0lnF4z
	 t3Dn7MykWq4+86DCsZNBCB781Wsubd4hENx0Hh8kFR0aEbUnc1zhN/wYKHxICB7hypI4k
	 0Y+ewOBKyYR6JD3kXzuE8BpoY4xCMdYGF8N55hQqaeERgBuNMmAypGaGaA5Glx414n4hH
	 /CYUFXZW9iBQQf5haDJQaDkPS/qQUK0pufhx3ogDovnDbnCvKiURFCr7PhBCEl1ofYni6
	 6AHliPeNer+RqkTd/aaQjaiQskT6tWynUYA2Pxmpouj8IHllF1k8SZen/gaW6gbNZqA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782893888;
	h=DKIM-Signature:Date:From:To:Subject:MIME-Version:Message-ID;
	bh=nwWRLToSnHfZJwvmTBiMrqXuf3raEXZ2GYNlUwtIPFQ=;
	b=JiBnDN7v5tZb7iQX0rTvyJ6U3TkyZV6eWZrN86QCgsrF1LQ92C4RLSCiOQJKnRpYiQTE
	 ZHgdY/xe262NvFI006NvwHy/FXQtrTh5xfFM3PC6eNTRA1tmufadIY8A6JVM3DOCZ6Tiv
	 Al2jBVCCvY65/XND8F3M8eBNes26gFqm31Qpk9uhbrlJVe9ke5Vm1CFN9V4xRtxRGrY5Z
	 Xdh2hKqfWgZ20fjeE3BuFXp7TF3An5JJ/wmBJRvvJcol6DFx8qKYaIUqhy6VIXuqoE8u8
	 VOdeJ8vKBQOuLRLyeIG/PKtHpYQB5xcECv5GbxafDobZgwtb0SSQECRUmIc4PsrATRQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=R1vTx1kn;
	arc=none smtp.remote-ip=117.135.210.6
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 511A2F80152
	for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2026 10:18:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 511A2F80152
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=R1vTx1kn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=nwWRLToSnHfZJwvmTBiMrqXuf3raEXZ2GYNlUwtIPFQ=; b=R
	1vTx1knpOoFf+X+hzLxFMQtfNzEyooyogIyO/s/6WqrBKUpTnPUoCfscZ/gkEvl5
	6dc57t0crD4RzeaeTb0qU9rFHzdMBibtggzO8JjM7k+VRHjGBBhmv4MQ70XWUS74
	fc2zbkstqahX5p94tIYv7WwTGiM2OtC0uj9BJoAcro=
Received: from os_dengxiang82$126.com ( [180.167.10.98] ) by
 ajax-webmail-wmsvr-41-117 (Coremail) ; Wed, 1 Jul 2026 16:18:00 +0800 (CST)
X-Originating-IP: [180.167.10.98]
Date: Wed, 1 Jul 2026 16:18:00 +0800 (CST)
From: os_dengxiang82  <os_dengxiang82@126.com>
To: "Takashi Iwai" <tiwai@suse.de>
Cc: tiwai@suse.com, bo.liu@senarytech.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re:Re: [PATCH] ALSA: hda/conexant: Fix microphone mute after
 power-on reboot
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 126com
In-Reply-To: <87se63upn1.wl-tiwai@suse.de>
References: <20260701065533.72517-1-os_dengxiang82@126.com>
 <87se63upn1.wl-tiwai@suse.de>
X-NTES-SC: 
 AL_Qu2TAPSSvEAj5imeYukckkobgOc8X8GyvPwi2YBWc88OhAvL3S8OZEZBJGLrz9KPIi2ljxmJdgdUysFkcIpdcx+4xrWmv0AbtDF/E4PDYQ==
MIME-Version: 1.0
Message-ID: <235d28fc.65dd.19f1cc1a68d.Coremail.os_dengxiang82@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: dSkvCgD33385zURqA6gVAA--.54243W
X-CM-SenderInfo: xrvbvv5qj0xtdqjyjqqrswhudrp/xtbBrhkt5GpEzTllGwAA3a
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-MailFrom: os_dengxiang82@126.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: J23GTZLEZCZ3XT5GBGC6BUBXW4MU2NX6
X-Message-ID-Hash: J23GTZLEZCZ3XT5GBGC6BUBXW4MU2NX6
X-Mailman-Approved-At: Wed, 01 Jul 2026 08:24:25 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/J23GTZLEZCZ3XT5GBGC6BUBXW4MU2NX6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGkgVGFrYXNoaSwKCgogIFRoaXMgZmFpbHVyZSBvY2N1cnMgZHVyaW5nIGJvb3R1cCBhcyB3ZWxs
IGFzIGFmdGVyIHJ1bnRpbWUgcmVzdW1lLiBEb2VzIHJ1bnRpbWUgcmVzdW1lIGhlcmUgcmVmZXIg
dG8gdGhlIHJlc3VtZSBoYW5kbGVyLCBsaWtlIC5yZXN1bWUgPSBjeF9yZXN1bWU/IG9yIHNvbWV0
aGluZyBlbHNlPyBMb29raW5nIGZvcndhcmQgdG8geW91ciByZXBseS4KeGlhbmcKCgoKQXQgMjAy
Ni0wNy0wMSAxNTozNzoyMiwgIlRha2FzaGkgSXdhaSIgPHRpd2FpQHN1c2UuZGU+IHdyb3RlOgo+
T24gV2VkLCAwMSBKdWwgMjAyNiAwODo1NTozMyArMDIwMCwKPmRlbmd4aWFuZyB3cm90ZToKPj4g
Cj4+IFNvbWUgZGV2aWNlcyBoYXZlIG11dGUgc2V0dGluZ3MgaW4gdGhlaXIgZmlybXdhcmUgc2V0
IGJ5IHRoZSBmYWN0b3J5Lgo+PiBUaGlzIGlzIHRvIHN0b3AgcG9wcGluZyBub2lzZSB3aGVuIHRo
ZSBkZXZpY2VzIHR1cm4gb24uIEJ1dCB0aGlzIHNldHRpbmcKPj4gbWFrZXMgdGhlIG1pY3JvcGhv
bmVzIHVuYWJsZSB0byByZWNvcmQgc291bmQgcHJvcGVybHkuIFRoaXMgcGF0Y2gKPj4gc29sdmVz
IHRoaXMgcHJvYmxlbSBhbmQgaXMgY29tcGF0aWJsZSB3aXRoIGNvbmV4YW50IGNoaXBzLgo+PiAK
Pj4gU2lnbmVkLW9mZi1ieTogZGVuZ3hpYW5nIDxvc19kZW5neGlhbmc4MkAxMjYuY29tPgo+Cj5I
bW0sIHRoaXMgZG9lc24ndCBsb29rIGxpa2UgYSByaWdodCBzb2x1dGlvbi4KPgo+SXMgaXQgb25s
eSB0aGUgcHJvYmxlbSBhZnRlciB0aGUgYm9vdD8gIE9yIGlzIGl0IGFuIGlzc3VlIGFmdGVyIHRo
ZQo+cnVudGltZSBQTSBzdXNwZW5kPyAgVGhlIGFtcCB2YWx1ZSBtdXN0IGJlIHJlc3RvcmVkIGJ5
IHRoZSBydW50aW1lCj5yZXN1bWUsIGFuZCBpZiB0aGlzIGRvZXNuJ3Qgd29yayBleHBlY3RlZCwg
aXQncyBhIHRoaW5nIHRvIGJlCj5hZGRyZXNzZWQgdGhlcmUsIG5vdCBpbiB0aGUgUENNIGhvb2sg
YXQgYWxsLgo+Cj4KPnRoYW5rcywKPgo+VGFrYXNoaQo+Cj4+IC0tLQo+PiAgc291bmQvaGRhL2Nv
ZGVjcy9jb25leGFudC5jIHwgMjEgKysrKysrKysrKysrKysrKysrKysrCj4+ICAxIGZpbGUgY2hh
bmdlZCwgMjEgaW5zZXJ0aW9ucygrKQo+PiAKPj4gZGlmZiAtLWdpdCBhL3NvdW5kL2hkYS9jb2Rl
Y3MvY29uZXhhbnQuYyBiL3NvdW5kL2hkYS9jb2RlY3MvY29uZXhhbnQuYwo+PiBpbmRleCAzZDky
MjYyNzYzZjYuLjMyMjlmOWVmNTk2OSAxMDA2NDQKPj4gLS0tIGEvc291bmQvaGRhL2NvZGVjcy9j
b25leGFudC5jCj4+ICsrKyBiL3NvdW5kL2hkYS9jb2RlY3MvY29uZXhhbnQuYwo+PiBAQCAtMTE4
NCw2ICsxMTg0LDI0IEBAIHN0YXRpYyB2b2lkIGFkZF9jeDUwNTFfZmFrZV9tdXRlcyhzdHJ1Y3Qg
aGRhX2NvZGVjICpjb2RlYykKPj4gIAlzcGVjLT5nZW4uZGFjX21pbl9tdXRlID0gdHJ1ZTsKPj4g
IH0KPj4gIAo+PiArc3RhdGljIHZvaWQgY3h0X2ZpeGVkX21pY19ib29zdChzdHJ1Y3QgaGRhX2Nv
ZGVjICpjb2RlYywgaGRhX25pZF90IG5vZGVfaWQpCj4+ICt7Cj4+ICsJc3RydWN0IGNvbmV4YW50
X3NwZWMgKnNwZWMgPSBjb2RlYy0+c3BlYzsKPj4gKwl1bnNpZ25lZCBpbnQgdmFsdWUgPSAwOwo+
PiArCj4+ICsJdmFsdWUgPSBzbmRfaGRhX2NvZGVjX3JlYWQoY29kZWMsIG5vZGVfaWQsIDAsIEFD
X1ZFUkJfR0VUX0FNUF9HQUlOX01VVEUsIDApOwo+PiArCXNuZF9oZGFfY29kZWNfYW1wX3N0ZXJl
byhjb2RlYywgbm9kZV9pZCwgSERBX0lOUFVULCAwLCBIREFfQU1QX1ZPTE1BU0ssIHZhbHVlKTsK
Pj4gK30KPj4gKwo+PiArc3RhdGljIHZvaWQgY3h0X2NhcHR1cmVfaG9vayhzdHJ1Y3QgaGRhX3Bj
bV9zdHJlYW0gKmhpbmZvLCAgc3RydWN0IGhkYV9jb2RlYyAqY29kZWMsCj4+ICsJCQkgICAgICAg
c3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0sIGludCBhY3Rpb24pCj4+ICt7Cj4+
ICsJc3RydWN0IGNvbmV4YW50X3NwZWMgKnNwZWMgPSBjb2RlYy0+c3BlYzsKPj4gKwloZGFfbmlk
X3QgbXV4X3BpbiA9IHNwZWMtPmdlbi5pbXV4X3BpbnNbc3BlYy0+Z2VuLmN1cl9tdXhbMF1dOwo+
PiArCj4+ICsJY3h0X2ZpeGVkX21pY19ib29zdChjb2RlYywgbXV4X3Bpbik7Cj4+ICt9Cj4+ICsK
Pj4gIHN0YXRpYyBpbnQgY3hfcHJvYmUoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMsIGNvbnN0IHN0
cnVjdCBoZGFfZGV2aWNlX2lkICppZCkKPj4gIHsKPj4gIAlzdHJ1Y3QgY29uZXhhbnRfc3BlYyAq
c3BlYzsKPj4gQEAgLTEyNzEsNiArMTI4OSw5IEBAIHN0YXRpYyBpbnQgY3hfcHJvYmUoc3RydWN0
IGhkYV9jb2RlYyAqY29kZWMsIGNvbnN0IHN0cnVjdCBoZGFfZGV2aWNlX2lkICppZCkKPj4gIAlp
ZiAoZXJyIDwgMCkKPj4gIAkJZ290byBlcnJvcjsKPj4gIAo+PiArCWlmIChzcGVjLT5nZW4ucGNt
X2NhcHR1cmVfaG9vayA9PSBOVUxMKQo+PiArCQlzcGVjLT5nZW4ucGNtX2NhcHR1cmVfaG9vayA9
IGN4dF9jYXB0dXJlX2hvb2s7Cj4+ICsKPj4gIAkvKiBTb21lIGxhcHRvcHMgd2l0aCBDb25leGFu
dCBjaGlwcyBzaG93IHN0YWxscyBpbiBTMyByZXN1bWUsCj4+ICAJICogd2hpY2ggZmFsbHMgaW50
byB0aGUgc2luZ2xlLWNtZCBtb2RlLgo+PiAgCSAqIEJldHRlciB0byBtYWtlIHJlc2V0LCB0aGVu
Lgo+PiAtLSAKPj4gMi4zOS41Cj4+IAo=
