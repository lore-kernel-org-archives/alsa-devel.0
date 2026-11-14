Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BA0606A323
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Nov 2026 13:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=RTMycHkp
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF656601FD;
	Sat, 14 Nov 2026 14:03:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF656601FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794661427;
	bh=SwpuXgA3+FbpCOcHR0k8YO0Ol+lUVfEn8aF03HMBBjA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=RTMycHkp4iwPq4fjj5OpIo69yHVOWZKtNBkkYAeOWU/YEd0dgC6DBtpdS7yiZ5VUQ
	 JphJzp7GHwTV9lpknHvgc+2CtD1nwEvw1J9b/EFwEMnGlCi+ZBqnRNrde5LUZb/f+W
	 p5Zj3e45tI/wlOQWcIKCM+KVfZ4a0yVbqNKcjxZU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 11873F805F3; Sat, 14 Nov 2026 14:03:13 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 63095F805FB;
	Sat, 14 Nov 2026 14:03:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3EAFF80580; Sat, 14 Nov 2026 14:03:05 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794661384;
	b=K3Dh+g8PWnjByAN8YU9H5DFgrJ8XznGLtg0LMedGdJI1JHko+eWFfMT9+zEphiOIRItt
	 dBsTTcYLHpXsa+ml8nZNRbAYvZ0b4y5e6k95j4Uq78V6AfSwjzy4JbpvCgkwpzWYISD9R
	 +Fi7SRo24mAVFCNiD5Uh/akZF9c5e8j/+pTnb4TslGNmvh0k6X6CIRJt6sIitjzsd+X5Q
	 yFsrUeU7+q20GDpQXhNIRnXliZpF7dbnJ9AKOxzTpyQh6gVRLZEEU0RN1tfLapM8Sdfky
	 3ZqAQbBeLES1tt3TUNeC19/nRELtA5xsDp+EXOrgi1rdaB1ZgZ4gFbQAAxT+U1qPo8w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794661384;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=SwpuXgA3+FbpCOcHR0k8YO0Ol+lUVfEn8aF03HMBBjA=;
	b=KZsCa1gMYX4XkG/b23KX9Z5BEP9XSzk2cbLNCzpni2xjtIrSBz936kcZyszoa0v7bHyz
	 3PTn4PdRJEMjwVXSlQ812kcoI3r3bnqCYdjbhg9zUTr+ks3JIDfVqItEDgcWubjWCgzjk
	 cM+r6T4Rsnoa2dco2kpvXNUVSQf2dfsEL4FUO0q/3sjTDqDJYV8n2AbuKxxToDTwajHEv
	 tExFlcDSDj9OnosA8bYx7ZHBU4wKCCi77QPM47T9h5weBpS17XHur+VwpknMLW4wlPk5A
	 IMMxAcjmFKYDzhCkNt8jhrWMSqWXm3iytQ/GKepEf0eJSO8sLNdzWRkeH32mDYvhD1Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 44F3DF80095
	for <alsa-devel@alsa-project.org>; Sat, 14 Nov 2026 14:03:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44F3DF80095
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18e7eb04de1d2200-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/913@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/913@alsa-project.org>
Subject: sof-soundwire: es9356: default the DMIC gain to +12 dB
Date: Sat, 14 Nov 2026 14:03:05 +0100 (CET)
Message-ID-Hash: T4CYATZWS5ZX3ILEZTGGTRNMMPAAF5H7
X-Message-ID-Hash: T4CYATZWS5ZX3ILEZTGGTRNMMPAAF5H7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/T4CYATZWS5ZX3ILEZTGGTRNMMPAAF5H7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgcHVsbCByZXF1ZXN0ICM5MTMgd2FzIG9wZW5lZCBm
cm9tIGthbm5veTIwMjQ6CgpTZXQgYSB1c2FibGUgZGVmYXVsdCBmb3IgdGhlIGludGVybmFsIERN
SUMgY2FwdHVyZSBnYWluLgoKIyMjIFByb2JsZW0KClRoZSBFUzkzNTYgRE1JQyBnYWluIGNvbnRy
b2wgKGBlczkzNTYgRlUxMSBDYXB0dXJlIFZvbHVtZWApIHJlc2V0cyB0byAwIGRCLgpUaGUgY29u
dHJvbCBoYXMgZm91ciA2IGRCIHN0ZXBzICgwLzYvMTIvMTggZEIpLCBzbyAwIGRCIGxlYXZlcyB0
aGUgcmVjb3JkZWQKdm9pY2Ugd2VsbCBiZWxvdyB0aGUgbm9pc2UgZmxvb3I6IHRoZSBpbnRlcm5h
bCBtaWNyb3Bob25lIGlzIHVudXNhYmxlIHVudGlsCnRoZSBtaXhlciBpcyBhZGp1c3RlZCBieSBo
YW5kLCBhbmQgdXNlcnMgaGF2ZSBubyByZWFzb24gdG8ga25vdyB0aGF0IHRoZQpjb250cm9sIGV4
aXN0cy4KCiMjIyBDaGFuZ2UKCkFkZCBhbiBgRW5hYmxlU2VxdWVuY2VgIHRvIHRoZSBgTWljYCBk
ZXZpY2UgaW4gYHNvZi1zb3VuZHdpcmUvZXM5MzU2LmNvbmZgCnRoYXQgc2V0cyB0aGUgZ2FpbiB0
byArMTIgZEIuICBUaGlzIGZvbGxvd3MgdGhlIHBhdHRlcm4gdXNlZCBieSBvdGhlciBjb2RlY3MK
KGZvciBleGFtcGxlIGBjb2RlY3MvY3M0Mmw0My1kbWljLmNvbmZgIGNvbmZpZ3VyZXMgaXRzIGlu
cHV0cyBpbiB0aGUgZGV2aWNlCmBFbmFibGVTZXF1ZW5jZWApLiAgVGhlIGNvbnRyb2wgaXMgc3Rp
bGwgYSBub3JtYWwgbWl4ZXIgY29udHJvbCwgc28gdGhlIGxldmVsCmNhbiBiZSBjaGFuZ2VkIGF0
IHJ1bnRpbWUuCgp8IGZpbGUgfCBjaGFuZ2UgfAp8LS0tfC0tLXwKfCBgdWNtMi9zb2Ytc291bmR3
aXJlL2VzOTM1Ni5jb25mYCB8IGBNaWNgOiBzZXQgYGVzOTM1NiBGVTExIENhcHR1cmUgVm9sdW1l
YCB0byAyICgrMTIgZEIpIGluIGBFbmFibGVTZXF1ZW5jZWAgfAoKIyMjIFRlc3RpbmcKCk1FQ0hS
RVZPIFdVSklFIDE0U0FIIChBTUQgQUNQNi4zLCBFUzkzNTYgb24gU291bmRXaXJlIGxpbmsgMCku
ICBUaGUgZ2FpbiB3YXMKc2V0IHRvIDAgZEIgYnkgaGFuZCBhbmQgUGlwZVdpcmUgd2FzIHRoZW4g
cmVzdGFydGVkOgoKLSBgYW1peGVyIC1jIDEgY3NldCBudW1pZD0xMCAwYAotIGBzeXN0ZW1jdGwg
LS11c2VyIHJlc3RhcnQgcGlwZXdpcmUgcGlwZXdpcmUtcHVsc2Ugd2lyZXBsdW1iZXJgCi0gYGFt
aXhlciAtYyAxIGNnZXQgbnVtaWQ9MTBgIOKGkiBgOiB2YWx1ZXM9MmAgKHRoZSBkZXZpY2UgY2Ft
ZSB1cCBhdCArMTIgZEIpCgpgd3BjdGwgc3RhdHVzYCBzaG93cyBTcGVha2VyIGFuZCBJbnRlcm5h
bCBNaWNyb3Bob25lLCBhbmQgcmVjb3JkaW5nIHRocm91Z2gKdGhlIGludGVybmFsIG1pY3JvcGhv
bmUgaXMgdXNhYmxlIHdpdGhvdXQgdG91Y2hpbmcgdGhlIG1peGVyLgoKUmVsYXRlZDogdGhlIG1h
dGNoaW5nIGRCIHNjYWxlIGZpeCBmb3IgdGhpcyBjb250cm9sIGlzCmh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvYnJvb25pZS9zb3VuZC9jLzQxMmEwNjFlYmY4YwoKU2lnbmVkLW9mZi1ieTogWmFjaGFy
eSBIdWFuZyA8enV6aGVuaHVhbmczNjVAZ21haWwuY29tPgoKUmVxdWVzdCBVUkwgICA6IGh0dHBz
Oi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29uZi9wdWxsLzkxMwpQYXRjaCBV
UkwgICAgIDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLXVjbS1jb25mL3B1
bGwvOTEzLnBhdGNoClJlcG9zaXRvcnkgVVJMOiBodHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9q
ZWN0L2Fsc2EtdWNtLWNvbmYK
