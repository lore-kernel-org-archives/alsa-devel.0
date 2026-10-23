Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43326606A31E
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2026 17:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=CmcW74rO
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4AEB86018A;
	Fri, 23 Oct 2026 19:31:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4AEB86018A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792776686;
	bh=6v5NUqGmuJEV1J+GUxEkowHStW3tNJ9k6DQxuI5DsIA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=CmcW74rOF3CKt1rn1GhTpf4dnZ/LaTl2BiPkqqimWqfwuy8kObzr6HmhBF5hQAVKS
	 vsXXDnB0NsA1W61dtAEnyNGLLTGd/K30Nebizmjy9pVOJ4L5W6rd9fJ96wDE+IE1o9
	 REB7W5P5mhtODNEeSKwBn2AqY2sUphRIZeQsFcd4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 70E6FF804B4; Fri, 23 Oct 2026 19:30:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D86FBF805C7;
	Fri, 23 Oct 2026 19:30:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7C1F2F80548; Fri, 23 Oct 2026 19:30:47 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id D6B55F80100
	for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2026 19:30:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6B55F80100
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18e138dc03d66500-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/889@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/889@alsa-project.org>
Subject: ucm2: Qualcomm: x1e80100: Surface11-HiFi: disable DP RX mixer routes
 by default
Date: Fri, 23 Oct 2026 19:30:47 +0200 (CEST)
Message-ID-Hash: MV7JJZI754ZUFEHTNHY2NBOJY6T2OY4Z
X-Message-ID-Hash: MV7JJZI754ZUFEHTNHY2NBOJY6T2OY4Z
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MV7JJZI754ZUFEHTNHY2NBOJY6T2OY4Z/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgcHVsbCByZXF1ZXN0ICM4ODkgd2FzIG9wZW5lZCBm
cm9tIHJhbW9uamVzdXNtaXJhbmRhLWRlYnVnOgoKU2VjdGlvblZlcmIgaW4gYFN1cmZhY2UxMS1I
aUZpLmNvbmZgIHVuY29uZGl0aW9uYWxseSBlbmFibGVzIHRoZSBgRElTUExBWV9QT1JUX1JYXzBg
IGFuZCBgRElTUExBWV9QT1JUX1JYXzFgIEF1ZGlvIE1peGVyIHJvdXRlcyAoYE11bHRpTWVkaWEz
YCBhbmQgYE11bHRpTWVkaWE0YCksIGFuZCBgU2VjdGlvbkRldmljZS4iSERNSTAiYCAvIGAiSERN
STEiYCBsYWNrIGEgYERpc2FibGVTZXF1ZW5jZWAuCgpXaGVuIFBpcGVXaXJlIC8gV2lyZVBsdW1i
ZXIgc3RhcnRzIG9yIHByb2JlcyB0aGUgY2FyZCB3aXRoIG5vIGV4dGVybmFsIERpc3BsYXlQb3J0
IG1vbml0b3IgYXR0YWNoZWQsIG9wZW5pbmcgYE11bHRpTWVkaWEzYCAvIGBNdWx0aU1lZGlhNGAg
dHJpZ2dlcnMgNDQgdG8gNTQgZXJyb3JzIGluIGBkbWVzZ2Agb24gZXZlcnkgc3RhcnQvcmVzdGFy
dDoKCmBgYApoZG1pLWF1ZGlvLWNvZGVjIGhkbWktYXVkaW8tY29kZWMuMi5hdXRvOiBBU29DOiBl
cnJvciBhdCBzbmRfc29jX2RhaV9zdGFydHVwIG9uIGkycy1oaWZpOiAtMjIKYGBgCgpLZWVwIHRo
ZSBEaXNwbGF5UG9ydCBtaXhlciByb3V0ZXMgZGlzYWJsZWQgKGAwYCkgaW4gYFNlY3Rpb25WZXJi
YCBhbmQgYWRkIHRoZSBtYXRjaGluZyBgRGlzYWJsZVNlcXVlbmNlYCB0byBgSERNSTBgIGFuZCBg
SERNSTFgIHNvIHRoZXkgYXJlIG9ubHkgZW5hYmxlZCB3aGVuIGFuIGV4dGVybmFsIERpc3BsYXlQ
b3J0IGF1ZGlvIHNpbmsgaXMgYWN0dWFsbHkgc2VsZWN0ZWQuCgpUZXN0ZWQgb24gYSBNaWNyb3Nv
ZnQgU3VyZmFjZSBQcm8gMTEgT0xFRCAoWDFFODAxMDApLgoKU2lnbmVkLW9mZi1ieTogUmFtw7Nu
IEplc8O6cyBNaXJhbmRhIDxyYW1vbmplc3VzbWlyYW5kYUBnbWFpbC5jb20+CgpSZXF1ZXN0IFVS
TCAgIDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLXVjbS1jb25mL3B1bGwv
ODg5ClBhdGNoIFVSTCAgICAgOiBodHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2Et
dWNtLWNvbmYvcHVsbC84ODkucGF0Y2gKUmVwb3NpdG9yeSBVUkw6IGh0dHBzOi8vZ2l0aHViLmNv
bS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29uZgo=
