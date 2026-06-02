Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10C6CD6E5D
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jun 2026 18:29:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 967D460236;
	Tue,  2 Jun 2026 20:29:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 967D460236
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780424953;
	bh=VT6truZP2Sf5oGJ4nJL2aZ/aWHb3QzWvaI6Wbjk0pR4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=UBKAMJ9EE7m+YVF9wFETFzyza5nR3G/3dd4FUH1nLBxBaEr8ZZyIAzODlSlBMlF+J
	 rUTdFvo4c66Kp+fuZn5OIm6hWRs/ZqragigyaqHmm5aPm5G1YvQ6a4VhDwHKt4IDWV
	 K+i4WEpFPPoiCzwP50tvMtFxtlAZ7dHNNmnPkVWw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3E7CBF805F8; Tue,  2 Jun 2026 20:28:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DF708F805FE;
	Tue,  2 Jun 2026 20:28:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 598FAF80553; Tue,  2 Jun 2026 20:28:32 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id B8304F8016E
	for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2026 20:28:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B8304F8016E
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b55705d213f600-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/tinycompress/pr/37@alsa-project.org>
References: <alsa-project/tinycompress/pr/37@alsa-project.org>
Subject: utils: sofprobeclient: fix musl build
Date: Tue,  2 Jun 2026 20:28:32 +0200 (CEST)
Message-ID-Hash: JFFGJQGS6XHDZ56ZMNEUMJSUVV6BOXAQ
X-Message-ID-Hash: JFFGJQGS6XHDZ56ZMNEUMJSUVV6BOXAQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JFFGJQGS6XHDZ56ZMNEUMJSUVV6BOXAQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L3Rpbnljb21wcmVzcyBwdWxsIHJlcXVlc3QgIzM3IHdhcyBvcGVuZWQgZnJv
bSBia3VobHM6CgpXaXRoIG11c2wgQyBsaWJyYXJ5LCB3ZSBzZWUgZm9sbG93aW5nIGJ1aWxkIGZh
aWx1cmU6DQpgYGANCnByb2Jlc19kZW11eC5jOiBJbiBmdW5jdGlvbiDigJhwYXJzZXJfcGFyc2Vf
ZGF0YeKAmToNCnByb2Jlc19kZW11eC5jOjMyMTo5OiBlcnJvcjogdW5rbm93biB0eXBlIG5hbWUg
4oCYdWludOKAmTsgZGlkIHlvdSBtZWFuIOKAmGludOKAmT8NCiAgMzIxIHwgICAgICAgICB1aW50
IGkgPSAwOw0KDQpwcm9iZXNfZGVtdXguYzozODY6MjU6IGVycm9yOiB1bmtub3duIHR5cGUgbmFt
ZSDigJh1aW504oCZOyBkaWQgeW91IG1lYW4g4oCYaW504oCZPw0KICAzODYgfCAgICAgICAgICAg
ICAgICAgICAgICAgICB1aW50IGRhdGFfdG9fY29weTsNCmBgYA0KdWludCBpcyBkZWZpbmVkIGlu
IDxzeXMvdHlwZXMuaD4gaGVhZGVyLiBJdCBpcyB1c3VhbGx5IGluY2x1ZGVkIGJ5IDxzdGRsaWIu
aD4gYnV0IGluIG11c2wgc3RkbGliLmggZG9lc24ndCBpbmNsdWRlIGl0LgoKUmVxdWVzdCBVUkwg
ICA6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvdGlueWNvbXByZXNzL3B1bGwvMzcK
UGF0Y2ggVVJMICAgICA6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvdGlueWNvbXBy
ZXNzL3B1bGwvMzcucGF0Y2gKUmVwb3NpdG9yeSBVUkw6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNh
LXByb2plY3QvdGlueWNvbXByZXNzCg==
