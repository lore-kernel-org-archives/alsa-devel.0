Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EF6C5DF85
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2026 15:06:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DC27060279;
	Thu, 20 Aug 2026 17:06:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DC27060279
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787238391;
	bh=JcyFGnho11nCrbDQUpboXsOMhNc4qVE5XK1TUxB6x08=;
	h=Date:To:From:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=dKwR+zn0EJol7wxS963LXM2zf2TGuOgniKY1u7zuwZ5c8w/CgzkczmbCN++i411NM
	 veyMl4fNBN/f73XEm7yGupw/nIdkgYT4+q8BWxox6dRBuJAvK8mhwIe6JKOo/YcN0c
	 iV3FQ4jEPLar/3B4dJn/uGjG3A3Y/XwrVpoCHyWw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 70F0FF80246; Thu, 20 Aug 2026 17:05:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EF8A9F80600;
	Thu, 20 Aug 2026 17:05:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CC8B1F8055C; Tue, 18 Aug 2026 22:37:38 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=79.135.106.97
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787085458;
	b=qPf0adEBo7knKC6+yQAGmQgixtxB7Z10dlh93itg80zpw96Pg+MUgIpazBKYhSoJNeL2
	 tSUMY06h0/J5s1wkSds/Wxt80qob8Jf6HSGHODsU1Ror6idBHWsuokUfI2lYLcvFPIYCL
	 Vs6vXnHwQSO5cQZLybEdYjzjUZfsVlT8YqVuZZxYxJs5OBhfN3bfW6tARlko6DrFe5cjd
	 Kp3/UUos8S/EpQ5KfrRqsVGPr5H2nxKc42tsWfpE9tc9JSc1s5Edbmn7zPAlUJPs9G7ON
	 /iNiUicvPQxTxcpHTN+jAckyOEZAzv6GzLQV/97hcubDSb13bEMS/vy9O5zMUNjpVDQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787085458;
	h=DKIM-Signature:Date:To:From:Subject:Message-ID:MIME-Version;
	bh=pMO55Uj88hcLAPDbcYCr8FndH47j4i3Cez6eK1i4hqA=;
	b=m6tv2/pGYK4u+9eRBCEVl/5V+Ei63QW00IWw/zaADrpy3tdJ2NtsCOCgry6hSdhv6TNn
	 xPkpr5tIDZ0kSWbuTKR68+r6FcwHVOrxSL3WIFxxigDDUJoEMEaI2Ucx53GeZTqpFdLnc
	 P9uxRfVZq68R98gLfVdAZ6c0EyXo1GC3oH+Q0utsV7wIQ6uD+beBnZNtQis5cijgrupEW
	 8VAImBkJMkNjrGvk8lwVkw8y5jPctMu6oX+/90skXR+K4NbO8HPB5M7Glz06K+cR0onGm
	 fP+rboJmL6H3kx3oJqQfzF9ymNA8r6nLuU7Qk082UiwhJiU64PV9RSMhhMK8MZklkEQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=P51nlCwl;
	arc=none smtp.remote-ip=79.135.106.97
Received: from mail-10697.protonmail.ch (mail-10697.protonmail.ch
 [79.135.106.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id ED662F800AC
	for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2026 22:37:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED662F800AC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=P51nlCwl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1787085455; x=1787344655;
	bh=pMO55Uj88hcLAPDbcYCr8FndH47j4i3Cez6eK1i4hqA=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=P51nlCwlE8KOKyx/NYCml2ZYZMQLVJ8kHnCOKgvNM60pi7ypZ3ITxPoFTBodyh/vK
	 R+qS16znXaf00deb1uytsqNzEpKD31GD3O1k9hWhMYJmX2O5mFhFqWeNQ9pQ7DMH+4
	 J2AFcy4c0bvFj40tNvbXAvNDA2ctxjCtJnGztWDYvzrlKhlOOKHL3ZlrSbtu2B7B3x
	 Yz8XM4hmGCcAeiHJnNMVvN7wcYD0RlBcmna9E3SzOWnEqAOEaAgSf0/d2QqpRMd8kA
	 QQtFJtm3mDoDkJvuOk/bsazoLq1OGZFUsMr193wlxaGiTga7AQJQn6RunfJOx+YXlx
	 kcwIm/eP3Sq0w==
Date: Tue, 18 Aug 2026 20:37:32 +0000
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
From: StrawberryYogurt1729 <StrawberryYogurt1729@proton.me>
Subject: Acer Aspire Go 15 (Ryzen 7 7730U),  Realtek ALC256, amplifier issue:
Message-ID: 
 <F5cGGLsj5RaJZ6zcJ6kBF0gXRuAaPnKCOv0oeUOZ0H4WlLatxDSESl5eLmI6ztPW01ckbYNK5-YQFJKz02XPEe10Jz-IKehYnbNkh3gwJIU=@proton.me>
Feedback-ID: 141640409:user:proton
X-Pm-Message-ID: e85b1c81d2f7fc18dad27e4c164a0dbebb36d037
MIME-Version: 1.0
X-MailFrom: StrawberryYogurt1729@proton.me
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 4TGIASLNPCBPMPDPURKJMTFNFQODJDFM
X-Message-ID-Hash: 4TGIASLNPCBPMPDPURKJMTFNFQODJDFM
X-Mailman-Approved-At: Thu, 20 Aug 2026 15:05:52 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=utf-8
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4TGIASLNPCBPMPDPURKJMTFNFQODJDFM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGVsbG8sCgpJJ20gcnVubmluZyBvbiBhbiBBY2VyIEFzcGlyZSBHbyAxNSAoQUcxNS00MlAtUjlG
VykuIEkgaGFkIHRvIG1ha2UgYSBsb2NhbCBtb2RpZmljYXRpb24gYmVjYXVzZSB0aGUgaW50ZXJu
YWwgc3BlYWtlcnMgYW5kIGhlYWRwaG9uZSBvdXRwdXQgd2VyZW4ndCB3b3JraW5nIHdlbGwgZXZl
biBhdCAxMDAlIHZvbHVtZSBpbiBldmVuIHRoZSBtaXhlci4gSSdtIGluIEZlZG9yYS4KClRoZSBt
b2RpZmllciB0aGF0IGZpeGVkIGJvdGggdGhlIGhlYWRwaG9uZXMgYW5kIHNwZWFrZXJzIChJcyBp
dCBtYXliZSB0aGF0IHRoZSBhbXBsaWZpZXIgaXNuJ3QgcG93ZXJpbmc/KSwgYWRkaW5nIGl0IHRv
IHRoZSBtb2Rwcm9iZSB3YXMgdGhpcy4KCm1vZGVsPWFsYzI1Ni1hY2VyCgpJIGhhdmUgYSBmZXcg
c3BlY2lmaWVycyB3aGljaCBtYXkgaGVscCBpZiBpdCdzIGEgbW9yZSBudWFuY2VkIHF1aXJrLgpD
b2RlYzogUmVhbHRlayBBTEMyNTYgKDB4MTBlYzAyNTYpClN1YnN5c3RlbTogMHgxMDI1MTY0MApQ
Q0kgYXVkaW8gY29udHJvbGxlcjogMTAyMjoxNWUzIChSeXplbiBIRCBBdWRpbyBDb250cm9sbGVy
KSwgZGV2aWNlIDA0OjAwLjYKS2VybmVsOiA3LjEuOC0yMDAuZmM0NC54ODZfNjQKSSB1cGxvYWRl
ZCB0byBhbHNhLWluZm8gd2hpY2ggaXQgc2FpZCB3YXMgaGVyZSwgdGhvdWdoIEkga2VlcCBnZXR0
aW5nIGEgYmFkIGdhdGV3YXkgdHJ5aW5nIHRvIGFjY2VzcyBpdDoKCmh0dHBzOi8vYWxzYS1wcm9q
ZWN0Lm9yZy9kYi8/Zj0xOGFmODgyOWFiMjJjMjUyOGZlNjMxZjM4ZGQ0M2EzZjc1N2JiYjcwCgpU
aGFuayB5b3Ugc28gbXVjaC4=
