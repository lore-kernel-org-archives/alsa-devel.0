Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B42C4450A
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Jul 2026 20:45:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C8483601F0;
	Sat, 18 Jul 2026 22:45:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C8483601F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784407541;
	bh=C6308+mYeuxNf6pqoMV75RT3s7nfve1YsLjau5DEhdQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=EKex3olrlAiPofHNDvbZiMdCkV5mLQE3s6w+0TjU+4NgOHCnCvxsi5NhFZwOHeuoN
	 p3MZ+EIT4lO2JVmP9HedXgaKU15fEy6lqYqvKLAHz5hN7fvUAZeSAuSIYkNvOWHE9N
	 L5P2bqyNTt4GqiwF8Z+Lamh3QUh1PkX5wZv1zXZE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0D4C5F805FF; Sat, 18 Jul 2026 22:45:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C0F90F80600;
	Sat, 18 Jul 2026 22:45:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 101FBF80537; Sat, 18 Jul 2026 22:45:04 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784407501;
	b=WjWGLvfQ4l2cg+C4JpBtJEN4l4sjRHV7+iRpD/7z18pfMc5kpkIYoP0RwTYlKF4gnL0r
	 TRbv/vNTuEO2U/jS4mKrq3hXcuAG3U+pKIcEvvqFKNymQEwfE2Y+bBPJ3X6cFE/jXiHZ7
	 lK3uyKWKsK9GUFVWl7x34RcXRqMXY0sXUdefLsip85K7jIZp+TQQHB4xZHsVXoy9AxZ0V
	 Ynh9zKwMKOYIbB+kPZoCDfUbCSqETCDbcOYmxHVO2ApgbZyj2ki/ZK/8l/9HDFHEUDzqW
	 FARylsqN/H2sc11Hd9g3lwVub8LIwJGMu/uOl/DZiitQ/KbLoS5lGcO29baYyqnEIgQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784407501;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=C6308+mYeuxNf6pqoMV75RT3s7nfve1YsLjau5DEhdQ=;
	b=hLZphhW4CDi/9g1Qlhf+4yLvx8YXamjKUKtGg4gIAuI0M7sGmV8RLX1whiFH3kh+zjkn
	 1Kf5FMJAtf0uCacnZwBam8jQUR0al+/LpNRU1MqsygqQ4R07R7n5kC65wQuZxfopzIOec
	 9LbNNl+cYFM3cRjdLj5Qdk9Ul+Xchi7w9wU67vkqjbOhIjserhYLeJsreKOf6iWPR6XAZ
	 OeoQ0rp56vGaz99wix3L7nYeVtCmA0N11kkm0/PjRFx32CKQV5oJsNamB4+UXk1A/8bO7
	 dynoTiuXk1jMjSKOPbIXSqRADMc5eWHafG7s/dNp8Zjjh3PzAlZRnLMCaPNZ2WKaZhw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id B34BAF80212
	for <alsa-devel@alsa-project.org>; Sat, 18 Jul 2026 22:45:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B34BAF80212
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c37d2ace4c1f00-webhooks-bot@alsa-project.org>
In-Reply-To: <18c37d2acd93e800-webhooks-bot@alsa-project.org>
References: <18c37d2acd93e800-webhooks-bot@alsa-project.org>
Subject: Acer Aspire Go 16 (Conexant CX11970): Line Output has higher priority
 than Speaker causing wrong auto-switch after unplugging headphones
Date: Sat, 18 Jul 2026 22:45:04 +0200 (CEST)
Message-ID-Hash: LFONAEUIEGQCXMVMCRWA7XKWOQHBY2XD
X-Message-ID-Hash: LFONAEUIEGQCXMVMCRWA7XKWOQHBY2XD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LFONAEUIEGQCXMVMCRWA7XKWOQHBY2XD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgaXNzdWUgIzgxMyB3YXMgb3BlbmVkIGZyb20gZnJl
ZXdpbGx5NTVhLWJvb3A6CgojIyBIYXJkd2FyZQoKTm90ZWJvb2s6IEFjZXIgQXNwaXJlIEdvIDE2
IEFHMTYtNzFQCgpBdWRpbyBjb250cm9sbGVyOgpJbnRlbCBSYXB0b3IgTGFrZS1QL1UvSCBjQVZT
IChTT0YpCgpDb2RlYzoKQ29uZXhhbnQgQ1gxMTk3MAoKRGlzdHJpYnV0aW9uOgpEZWJpYW4gMTMg
KFRyaXhpZSkKCmFsc2EtdWNtLWNvbmY6CjEuMi4xNC0xCgpQaXBlV2lyZToKMS40LjIKCldpcmVQ
bHVtYmVyOgowLjUuOAoKCiMjIFByb2JsZW0KClRoZSBoZWFkcGhvbmUgamFjayBkZXRlY3Rpb24g
d29ya3MgY29ycmVjdGx5LgoKV2hlbiBoZWFkcGhvbmVzIGFyZSBwbHVnZ2VkIGluLCB0aGUgYWN0
aXZlIHNpbmsgYmVjb21lcyAiSGVhZHBob25lcyIuCgpBZnRlciB1bnBsdWdnaW5nIHRoZSBoZWFk
cGhvbmVzLCB0aGUgYWN0aXZlIHNpbmsgYmVjb21lcyAiTGluZSBPdXRwdXQiIGluc3RlYWQgb2Yg
IlNwZWFrZXIiLgoKQXMgYSByZXN1bHQsIHRoZSBpbnRlcm5hbCBzcGVha2VycyByZW1haW4gc2ls
ZW50IGFsdGhvdWdoIG5vIGhlYWRwaG9uZXMgYXJlIGNvbm5lY3RlZC4KCgojIyBJbnZlc3RpZ2F0
aW9uCgpUaGUgcHJvYmxlbSBpcyBjYXVzZWQgYnkgdGhlIHByaW9yaXRpZXMgaW4KCi91c3Ivc2hh
cmUvYWxzYS91Y20yL0hEQS9IaUZpLWFuYWxvZy5jb25mCgpDdXJyZW50IHZhbHVlczoKCkxpbmUg
T3V0cHV0OgpQbGF5YmFja1ByaW9yaXR5IDMwMAoKSGVhZHBob25lczoKUGxheWJhY2tQcmlvcml0
eSAyMDAKClNwZWFrZXI6ClBsYXliYWNrUHJpb3JpdHkgMTAwCgoKIyMgVGVzdAoKQ2hhbmdpbmcK
ClBsYXliYWNrUHJpb3JpdHkgMzAwCgp0bwoKUGxheWJhY2tQcmlvcml0eSA1MAoKaW1tZWRpYXRl
bHkgZml4ZXMgdGhlIHByb2JsZW0uCgpBZnRlciByZXN0YXJ0aW5nIFBpcGVXaXJlOgoKSGVhZHBo
b25lcyBwbHVnZ2VkOgrihpIgSGVhZHBob25lcyBzZWxlY3RlZCBhdXRvbWF0aWNhbGx5LgoKSGVh
ZHBob25lcyB1bnBsdWdnZWQ6CuKGkiBTcGVha2VyIHNlbGVjdGVkIGF1dG9tYXRpY2FsbHkuCgpB
dXRvbWF0aWMgc3dpdGNoaW5nIHdvcmtzIHBlcmZlY3RseSBhZnRlcndhcmRzLgoKCiMjIFN1Z2dl
c3Rpb24KClBsZWFzZSBjb25zaWRlciBsb3dlcmluZyB0aGUgTGluZSBPdXRwdXQgcHJpb3JpdHkg
KG9yIGRpc2FibGluZyBMaW5lIE91dHB1dCkgZm9yIG5vdGVib29rcyB1c2luZyB0aGlzIFNPRiAr
IENvbmV4YW50IENYMTE5NzAgY29uZmlndXJhdGlvbi4KCklmIHJlcXVpcmVkLCBJIGNhbiBwcm92
aWRlIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24gb3IgdGVzdCBwYXRjaGVzLgoKSXNzdWUgVVJMICAg
ICA6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29uZi9pc3N1ZXMv
ODEzClJlcG9zaXRvcnkgVVJMOiBodHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2Et
dWNtLWNvbmYK
