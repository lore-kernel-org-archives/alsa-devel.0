Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396D5C3DA4A
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Aug 2024 09:43:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5568A1E6;
	Tue, 20 Aug 2024 11:42:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5568A1E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1724146978;
	bh=GSGcrWdKy8xdyAe9WTbQA7s0aDKh7eze/Y69ghGAjWI=;
	h=Date:To:From:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=kWRlqxdybqTzDUREIBZYQSXXvO4PjZ5P0siYBkZyHxGsbLCYXH4UF/VAy/hDZroCB
	 SD+LzDPMQC1KBaqAwVNMx4OzJicFlzinCjaDnin7fzUCF3ODyLTXF+IiYP0SDhIT8k
	 8x9OovTmRWkk19ChqBEHeApcenFV/0w9S4OFLAFA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 62EACF80614; Tue, 20 Aug 2024 11:41:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F77DF80601;
	Tue, 20 Aug 2024 11:41:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C32F0F80496; Tue, 20 Aug 2024 11:40:59 +0200 (CEST)
Received: from mail-40140.protonmail.ch (mail-40140.protonmail.ch
 [185.70.40.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E4CC9F80494
	for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2024 11:38:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E4CC9F80494
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=W/LsJMje
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1724146696; x=1724405896;
	bh=lqNxzRgC5JPARXtzFarbOoRV7YdnPnEu9GNEgaOKR6g=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=W/LsJMjerFCLqm4KMKBnVpwzfOkjN8f8fno78MfILI1eO2jqOd5kME79ila07ftCe
	 +ojmDat97Bwfl0YgJXHVEvhmQEd6d2UlA0ZqwSP6StNugp0eTukKZvRZMG6y2M+tvd
	 mZgD4Zznmfz8rLWsqsUnZ0odPRJffbCw7Y7YSsxhXf/R636QV9Ldqfw2iN+5iFCc94
	 HGN7685MrlCDEqEOm7M3K/CtuTeszpyrQXc+04AuA2vyDEwWFM4b16qdeS4D+x1e8x
	 tt/OE83riFRRTcb94FvPjQxXCTkkpAXLsqbp70DzzVXkFO42dzfVnXJbBTMNExYrSS
	 mUpziRiiA3z6g==
Date: Tue, 20 Aug 2024 09:38:12 +0000
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
From: Xerox Slayer <xeroxslayer@proton.me>
Subject: [DISCUSSION] Why doesn't ALSA autogenerate/autoconfigure the mono
 profile by default?
Message-ID: 
 <-hY2k_-HP_RpNxt1vOEArHKgjIw69LG4IcnstasrAk_1knJNIpf7OhREgR7QSJky95DP4pn8-fo7Ne1YDbqQKbqNh0m_b-p2Id1cd5Kq3TU=@proton.me>
Feedback-ID: 112401143:user:proton
X-Pm-Message-ID: 5753455aae0c525378f2cbc161b60e5bcfe94079
MIME-Version: 1.0
Message-ID-Hash: BXE5N7U2Z6DUXY5C65PVXMQYWKITFJEV
X-Message-ID-Hash: BXE5N7U2Z6DUXY5C65PVXMQYWKITFJEV
X-MailFrom: xeroxslayer@proton.me
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=utf-8
X-Content-Filtered-By: Mailman/MimeDel 3.3.9
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BXE5N7U2Z6DUXY5C65PVXMQYWKITFJEV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

U29ycnkgaWYgdGhpcyBpcyB0aGUgd3JvbmcgcGxhY2UgdG8gZGlzY3VzcyB0aGlzLCBidXQgZnJv
bSB3aGF0IEkgbWFuYWdlZCB0byBmaW5kIG91dCwgdGhpcyBpcyBwcmltYXJpbHkgdGhlIHJlc3Bv
bnNpYmlsaXR5IG9mIEFMU0EuCgpUaGlzIHdhcyBwb2ludGVkIG91dCBieSBhIHJlZGRpdCB1c2Vy
LCBhbmQgdG8gYmUgZnJhbmssIEkgd2FzIGtpbmRhIHN1cnByaXNlZCB0aGF0IHRoaXMgaXMgbm90
IGRvbmUgYnkgZGVmYXVsdC4gVGhlIHVzZXIgaW4gcXVlc3Rpb24gaXMgaGVhcmluZyBpbXBhaXJl
ZCAoY2FuIGxpc3RlbiBvbiBvbmx5IG9uZSBlYXIpLCBzbyB0aGUgdXNlciBoYXMgbm8gYmVuZWZp
dCBvZiBhY3R1YWxseSBsaXN0ZW5pbmcgdG8gc3RlcmVvIG9yIGFueSBvdGhlciBtdWx0aWNoYW5u
ZWwgYXVkaW8sIHRodXMgd2FudGVkIHRvIGp1c3Qgc2V0IGV2ZXJ5dGhpbmcgdG8gbW9ubyAoZHVh
bCBtb25vIEkgcHJlc3VtZSkgYW5kIHdhcyBwdXp6bGVkIHdoZW4gdGhlcmUgd2FzIG5vIHN1Y2gg
b3B0aW9uIGluIHB1bHNlYXVkaW8gKHdoaWNoIHB1bGxzIHRoZSBwcm9maWxlcyBmcm9tIEFMU0Ep
LiBJIGRpZCBzb21lIG1vcmUgaW52ZXN0aWdhdGlvbiBhbmQgYXMgaXQgdHVybnMgb3V0LCB0aGlz
IHByb2ZpbGUgaXMgYXV0b2dlbmVyYXRlZCwgYnV0IG9ubHkgaWYgdGhlIGhhcmR3YXJlIGhhcyBz
dWNoIGNhcGFiaWxpdHkgKGFzIGlzIHRoZSBjYXNlIHdpdGggYW55IG90aGVyIHByb2ZpbGUpLiBZ
b3UgY2FuIGVuYWJsZSBpdCBtYW51YWxseSBieSBlZGl0aW5nIGNvbmZpZyBmaWxlcyAoaW4gd2hp
Y2ggY2FzZSBJIHByZXN1bWUgdGhlIGNoYW5uZWwgZG93bmNvbnZlcnNpb24gaXMgZG9uZSBpbiBz
b2Z0d2FyZSksIGJ1dCBpdCBzZWVtZWQgb2RkIHRoYXQgb25lIGhhcyB0byBnbyB0aHJvdWdoIHN1
Y2ggdHJvdWJsZSBqdXN0IHRvIGxpc3RlbiB0byBtb25vIHNvdW5kLgoKVGh1cywgSSB0aGluayB0
aGUgbW9ubyBwcm9maWxlIHNob3VsZCBiZSB0YWtlbiBhcyBhIHNwZWNpYWwgY2FzZSBzY2VuYXJp
byBhbmQgYmUgYXV0b2dlbmVyYXRlZC9jb25maWd1cmVkIGJ5IGRlZmF1bHQsIHJlZ2FyZGxlc3Mg
aWYgaXQncyBzdXBwb3J0ZWQgaW4gaGFyZHdhcmUgb3Igbm90LgpPbmNlIGFnYWluLCBJJ20gc29y
cnkgaWYgdGhpcyBpcyBub3QgdGhlIHBsYWNlIHRvIGFzay9kaXNjdXNzIHRoaXMsIGJ1dCB3b3Vs
ZCBhcHByZWNpYXRlIGlmIHNvbWVvbmUgcG9pbnRlZCBtZSB0byB3aGVyZSBJIGNhbiBhY3R1YWxs
eSBkbyB0aGlzLg==
