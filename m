Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B13606A321
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2026 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=mQjOtFPF
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C1B2601FE;
	Wed, 11 Nov 2026 19:33:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C1B2601FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794421990;
	bh=FiMLmMq8G1nsmIlstQfaiTpwH6DRiZISg/Otucm6BVg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=mQjOtFPFUP8tr+FYoV3ali2PGhNVWIFqEyTqnfh6a5bZw48kfH8Y09vPVyABGf7Vn
	 MtGu4hekHg3/CscwRu9UNMZlmogTsi2fjke+FG4Nxm4IwCTPFMg/EctpXomywwc7mF
	 vfbGFrTgXRZ9T/58B/KQjiYK4JBgcqqpBt87KfpE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C2834F805FA; Wed, 11 Nov 2026 19:32:36 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 11F54F80600;
	Wed, 11 Nov 2026 19:32:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 776F5F80537; Wed, 11 Nov 2026 19:32:30 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794421949;
	b=PB5GEY+sBlfAdPCSN869qnfs4SYbiADAK2HkgBWftppsdJky+FOYZHQr9ztkXOc9H5AH
	 3eyaougG1/cuMdLj/R/7KVk+u+oZ4XzeeqAWc56+xSjMrSbEIKk03CzzcHaSClur8n3Ct
	 v+Fkzb/EoUpwSZ+zYmwXh8y6jTvHrr05aqFcW7oWp7ZuFyN4eUixkCv3nw8HFidnXdGvf
	 HbGYEODwVaaG/1A31Hf58IRKCjIhg6bOKklxvQ1+MyzcgIM1ErT13KR3xrWmYOy27IHcC
	 jZtsX+b2kdvUpPvhjIUyUNfyFeT7Ti6nmDKv67PsjPeqHIfTvQcluTje2SqAtWXBjsg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794421949;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=FiMLmMq8G1nsmIlstQfaiTpwH6DRiZISg/Otucm6BVg=;
	b=qBGjwcY90mI8ZO7y1iA6veVQ+NRIO3Y/UB8DoJd+8dUc7UkLdw0XOJAIPirqG1hdZgC5
	 BeauDWuw77sBSUbQ7ZVu1h9isYFkya+vxBRh4PyLxD7eifVVD97J6wOq1GnJDbIRxuEoi
	 ZzxgdkmllDjjBPTXWwKsNYMz1SSyuIqTtTrrPwrsRRPxagrHNnhPJh4iIrpacIYfu/RvZ
	 pwLAcU5N0R5q1/Wt+Ys0HBxeGNtLVma4COrUxlNY8/dG29u2aHypGfPeH7xpySYE4YxAk
	 zmDdkfYvXm3vbvBK9JwgD+SiCbltYHg/6zdTKKLwWSDNnNTjsf5/6RGi2hU2qoQ5aMw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 43D1FF8014C
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2026 19:32:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43D1FF8014C
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18e711411217d000-webhooks-bot@alsa-project.org>
In-Reply-To: <18e71141120d1f00-webhooks-bot@alsa-project.org>
References: <18e71141120d1f00-webhooks-bot@alsa-project.org>
Subject: Missing UCM profile for Lenovo IdeaPad Slim 5 14AKP10 (83HX) - AMD
 Ryzen AI 7 350 (Krackan Point)
Date: Wed, 11 Nov 2026 19:32:30 +0100 (CET)
Message-ID-Hash: HAQ2FT6LZNSN7SDHKOV77F3IFHWSYUSE
X-Message-ID-Hash: HAQ2FT6LZNSN7SDHKOV77F3IFHWSYUSE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HAQ2FT6LZNSN7SDHKOV77F3IFHWSYUSE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgaXNzdWUgIzkwNyB3YXMgb3BlbmVkIGZyb20gZW1p
bGVydWluOgoKSGVsbG8sIEkgcmVjZW50bHkgZGlzY292ZXJlZCBhIGJ1ZyB0aGF0IEknbSBzdXJl
IGhhcyBhbHJlYWR5IGJlZW4gcmVwb3J0ZWQuIE15IGxhcHRvcCBydW5uaW5nIGFuIEFNRCBLcmFj
a2FuIFBvaW50IHNlcmllcyBwcm9jZXNzb3IgY291bGRuJ3QgdXNlIHRoZSBidWlsdC1pbiBzdGVy
ZW8gbWljcm9waG9uZSBvdXQgb2YgdGhlIGJveCwgc28gSSBkdWcgaW50byBpdCBhbmQgZm91bmQg
YSB0ZW1wb3Jhcnkgd29ya2Fyb3VuZCBzb2x1dGlvbjoKCioqfi8uY29uZmlnL3dpcmVwbHVtYmVy
L3dpcmVwbHVtYmVyLmNvbmYuZC9hbHNhLWNvbmZpZy5jb25mKioKYG1vbml0b3IuYWxzYS5wcm9w
ZXJ0aWVzID0gewogICAgYWxzYS51c2UtdWNtID0gZmFsc2UKfWAKVGhpcyBmaXhlcyB0aGUgaXNz
dWUgYW5kIEknbSBhYmxlIHRvIHVzZSBib3RoIHRoZSBtaWNyb3Bob25lIGFuZCBzcGVha2VycyB3
aXRob3V0IGZ1cnRoZXIgcHJvYmxlbXMuCjxpbWcgd2lkdGg9IjEzMjYiIGhlaWdodD0iMTAxMSIg
YWx0PSJTY3JlZW5zaG90XzIwMjYxMTExXzE5MTYxMCIgc3JjPSJodHRwczovL2dpdGh1Yi5jb20v
dXNlci1hdHRhY2htZW50cy9hc3NldHMvMmJjOTg2MzctNmY2OS00ZmZmLWFjYzAtZDBhM2U4NDQ0
MTNmIiAvPgpfVGhlIEtERSBjb25maWcgcGFuZWwgYmVmb3JlIGFwcGx5aW5nIHRoZSBmaXguXwo8
aW1nIHdpZHRoPSIxMzI2IiBoZWlnaHQ9IjEwMTEiIGFsdD0iU2NyZWVuc2hvdF8yMDI2MTExMV8x
OTMwMTciIHNyYz0iaHR0cHM6Ly9naXRodWIuY29tL3VzZXItYXR0YWNobWVudHMvYXNzZXRzLzRj
YjBkMDEwLTkzYWItNDc0Ny04MDEwLTkyMDRkZDg0ODQ0ZSIgLz4KX0RpdHRvLCBhZnRlciBmaXgg
aXMgYXBwbGllZC5fCgpbYWxzYS1pbmZvLnR4dF0oaHR0cHM6Ly9naXRodWIuY29tL3VzZXItYXR0
YWNobWVudHMvZmlsZXMvMzQ3MDA4MjUvYWxzYS1pbmZvLnR4dCkKU3lzdGVtIEluZm86Ck9wZXJh
dGluZyBTeXN0ZW06IEFyY2ggTGludXggCktERSBQbGFzbWEgVmVyc2lvbjogNi44LjIKS0RFIEZy
YW1ld29ya3MgVmVyc2lvbjogNi4zMS4wClF0IFZlcnNpb246IDYuMTIuMApLZXJuZWwgVmVyc2lv
bjogNy4yLjE1LXplbjEtMS16ZW4gKDY0LWJpdCkKR3JhcGhpY3MgUGxhdGZvcm06IFdheWxhbmQK
UHJvY2Vzc29yczogMTYgw5cgQU1EIFJ5emVuIEFJIDcgMzUwIHcvIFJhZGVvbiA4NjBNCk1lbW9y
eTogMzQgR0Igb2YgUkFNICgzMiw5IEdCIHVzYWJsZSkKR3JhcGhpY3MgUHJvY2Vzc29yOiBBTUQg
UmFkZW9uIDg2ME0gR3JhcGhpY3MKTWFudWZhY3R1cmVyOiBMRU5PVk8KUHJvZHVjdCBOYW1lOiA4
M0hYClN5c3RlbSBWZXJzaW9uOiBJZGVhUGFkIFNsaW0gNSAxNEFLUDEwCgpJc3N1ZSBVUkwgICAg
IDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLXVjbS1jb25mL2lzc3Vlcy85
MDcKUmVwb3NpdG9yeSBVUkw6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11
Y20tY29uZgo=
