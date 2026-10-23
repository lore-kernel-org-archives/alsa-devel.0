Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8E1606A31A
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=K02QKTJ5
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74E4E601CB;
	Sat, 24 Oct 2026 01:22:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74E4E601CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792797765;
	bh=6SyvhuPuZ4EoFOKVS9UeVo8DiZUpzrlsjNvh6LQdkuQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=K02QKTJ5FcMRu6lXy4ns98+GrEmbMgQpB2Ur8zd/O1OAu/Y0tx4/P0zu5Z93optVo
	 vhwpU/eKS0VrH/4ybMJkvwy7GrEHGC3cshzwkeL0rI4TVb/gyIHe6ZHjFW6ScVlUzk
	 pXVKOL5Y+JDu5olbVpbAcDREMmy46l3b7C1Q/8Hg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DF917F80603; Sat, 24 Oct 2026 01:22:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D948F80603;
	Sat, 24 Oct 2026 01:22:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7CCC7F80495; Sat, 24 Oct 2026 01:22:03 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A830F80448
	for <alsa-devel@alsa-project.org>; Sat, 24 Oct 2026 01:21:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A830F80448
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18e14c067c206000-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/537@alsa-project.org>
References: <alsa-project/alsa-lib/pr/537@alsa-project.org>
Subject: pcm: dmix: i386: keep the size operand in memory
Date: Sat, 24 Oct 2026 01:22:03 +0200 (CEST)
Message-ID-Hash: IH25XB7XPUD66RTSPQEIHOJZ2V6QAUEM
X-Message-ID-Hash: IH25XB7XPUD66RTSPQEIHOJZ2V6QAUEM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IH25XB7XPUD66RTSPQEIHOJZ2V6QAUEM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtbGliIHB1bGwgcmVxdWVzdCAjNTM3IHdhcyBvcGVuZWQgZnJvbSB5
ZWdvcmljaDoKClRoZSBpMzg2IGBtaXhfYXJlYXNfKigpYCBhc3NlbWJseSBjbG9iYmVycyBlc2ks
IGVkaSwgZWR4LCBlY3gsIGVheCBhbmQgZWJ4LiBBdCBgLU9zYCBnY2MgYWxzbyB1c2VzIGVicCBh
cyBmcmFtZSBwb2ludGVyLCBzbyBubyBnZW5lcmFsIHB1cnBvc2UgcmVnaXN0ZXIgaXMgbGVmdC4K
ClNpbmNlIGFiYzlmMzJjZjQ1YyAoInBjbTogZG1peDogYXNzZW1ibHk6IGdpdmUgbW9yZSBmcmVl
ZG9tIG92ZXIgdGhlIGNvbnN0cmFpbnRzIikgdGhlIGBzaXplYCBvcGVyYW5kIGlzIGAiKyZybSJg
LiBXaXRoIEFWWDUxMkJXIGVuYWJsZWQgKGAtbWFyY2g9c2t5bGFrZS1hdng1MTJgLCBgY2Fubm9u
bGFrZWAsIGBpY2VsYWtlLWNsaWVudGAsIGB4ODYtNjQtdjRgLCBvciBgLW1hdng1MTJid2ApIGFu
ZCBgLU9zYC9gLU96YCwgZ2NjIDE1LjMgYW5kIDE2LjIgdGhlbiBmYWlsOgoKYGBgCnBjbV9kbWl4
X2kzODYuaDo1Mjo5OiBlcnJvcjogJ2FzbScgb3BlcmFuZCBoYXMgaW1wb3NzaWJsZSBjb25zdHJh
aW50cyBvciB0aGVyZSBhcmUgbm90IGVub3VnaCByZWdpc3RlcnMKYGBgCgpUaGlzIHBhdGNoIHJl
c3RvcmVzIHRoZSBgIittImAgY29uc3RyYWludCB1c2VkIGJlZm9yZSB0aGF0IGNvbW1pdCBmb3Ig
YHNpemVgLCBpbiBhbGwgZml2ZSBmdW5jdGlvbnMuCgpGb3VuZCBieSB0aGUgQnVpbGRyb290IGF1
dG9idWlsZGVyczogaHR0cHM6Ly9hdXRvYnVpbGQuYnVpbGRyb290Lm9yZy9yZXN1bHRzL2ZmNjEz
YzJkOTRjMzVhMzhhNTg4NmI3MGQ3MmFhMzdiNTg0NDBiNWQKClRlc3Rpbmc6IGNvbXBpbGVkIGBw
Y21fZG1peF9pMzg2LmhgIHdpdGggZ2NjIDE1LjMuMCBhbmQgMTYuMi4wIChpNjg2KSwgZm9yIC1P
MC8tTzEvLU8yLy1PMy8tT3MvLU96IMOXIDkgYC1tYXJjaGAgdmFsdWVzIMOXIHdpdGgvd2l0aG91
dCBgLWZQSUNgLiBCZWZvcmU6IGFsbCBgLU9zYC9gLU96YCArIEFWWDUxMkJXIGNvbWJpbmF0aW9u
cyBmYWlsLiBBZnRlcjogYWxsIDEwOCBjb21iaW5hdGlvbnMgYnVpbGQuIEEgZnVsbCBpNjg2IEJ1
aWxkcm9vdCBidWlsZCBvZiBhbHNhLWxpYiB3aXRoIHRoZSBmYWlsaW5nIGNvbmZpZ3VyYXRpb24g
cGFzc2VzIGFzIHdlbGwuCgrwn6SWIEdlbmVyYXRlZCB3aXRoIFtDbGF1ZGUgQ29kZV0oaHR0cHM6
Ly9jbGF1ZGUuY29tL2NsYXVkZS1jb2RlKQoKUmVxdWVzdCBVUkwgICA6IGh0dHBzOi8vZ2l0aHVi
LmNvbS9hbHNhLXByb2plY3QvYWxzYS1saWIvcHVsbC81MzcKUGF0Y2ggVVJMICAgICA6IGh0dHBz
Oi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS1saWIvcHVsbC81MzcucGF0Y2gKUmVwb3Np
dG9yeSBVUkw6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS1saWIK
