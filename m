Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2142C606A339
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Nov 2026 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=h2SdkFDv
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA675601F7;
	Sat, 14 Nov 2026 14:27:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA675601F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794662876;
	bh=rX9adYZlZyvx/4pmZUKA7hG6zRaEDZvPoaUVEd5fYQQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=h2SdkFDv0NztsQrp1M9E/CwcQChouTu3XMnnBH9aW1KeuOS+1X5BWTPMMhuFXAIlb
	 Zq/z96f9G0JoC9Cu4qrphFwiTjQsiQDMq6sge+6Rtm2bFqc0A6gwq7RYm5UDhE5Dfy
	 Wpxl+wkh08QiwzqyTjJ/8uRKWIKILeqBt8IvJCpE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 43A20F805F6; Sat, 14 Nov 2026 14:27:24 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DFF83F805F6;
	Sat, 14 Nov 2026 14:27:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5E24DF80580; Sat, 14 Nov 2026 14:27:17 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794662835;
	b=TM3+W/xH5boXeGyUw1FXP+9KCRSoXZN9jRiSzT2CQpjystGtx/C9hc5FzGB+V62NLrV3
	 /bv3n91SGh0M8RNQDH07dLwMsjaQvy8fNrz3opeH031ep47ato5PG5oln4bmpaja70X+F
	 H9AVESE+XofpPkLlqFnYIF9Z21+DzShzAdTGClC59oYUFO1QoJfiS2fJWq27l18Vy2H7z
	 EYfz9vPg3HRhNumiiouQ878SdhV1TmV5uT5PvNpDmi+iuu2ypgNgSUE6lFQz/8QcruiCd
	 V9DOBi5JJAlkrDjL9tBNFb9XHihvEmZTeGt0csc8B1pgU3eISLdTmlACqB9fGsESFTA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794662835;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=rX9adYZlZyvx/4pmZUKA7hG6zRaEDZvPoaUVEd5fYQQ=;
	b=gv/Le3RbWdntBPcmuWjBupGZAoKiwVg0lsC4QiFbqgnNuiiiSyfFLNDCwWHSv93Ids+w
	 FJnlJYyKzwRljAs6tuOnH0fZhJ1sywhsmV+endCiGhp4TzAmXzurp6k849/KifT6VMoq+
	 JOi7NUkAlHIjQxWBNUTl88NZqpLF6A++DAT7v3Kj+3zf5AXjNpnjZUAISNaavYUk9e5QY
	 JEL0DVoTN62Ieyg8zRTVPTghx7wT4oc0FZFd2ijHTASZZTS7xdZ7VUo0GFU0Rj5/+Xl5Y
	 f/mSm4BFRLiugEBGyVXNljiOzo1XWm3XNxzuvWIzqoQRl4Lh/t0sqA+wDhbAt28wn0w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 77E3EF80548
	for <alsa-devel@alsa-project.org>; Sat, 14 Nov 2026 14:27:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77E3EF80548
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18e7ec56bc972800-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/914@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/914@alsa-project.org>
Subject: sof-soundwire: es9356: default the DMIC gain to +12 dB
Date: Sat, 14 Nov 2026 14:27:17 +0100 (CET)
Message-ID-Hash: LGIBRVH6G3WCO5LPIKUMUWGAJVXQHYJB
X-Message-ID-Hash: LGIBRVH6G3WCO5LPIKUMUWGAJVXQHYJB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LGIBRVH6G3WCO5LPIKUMUWGAJVXQHYJB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgcHVsbCByZXF1ZXN0ICM5MTQgd2FzIG9wZW5lZCBm
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
Oi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29uZi9wdWxsLzkxNApQYXRjaCBV
UkwgICAgIDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLXVjbS1jb25mL3B1
bGwvOTE0LnBhdGNoClJlcG9zaXRvcnkgVVJMOiBodHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9q
ZWN0L2Fsc2EtdWNtLWNvbmYK
