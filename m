Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3798F513E6
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:48:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4ECC2602C4;
	Thu,  5 Mar 2026 23:47:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4ECC2602C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1772750881;
	bh=vk4vbsFXT6KEhwUIJzJGEIjwbT+2lQlL8+pM80nEsNo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=gbKdkvShjNylx3sKiAuzXP34xKYH+XpRfBLl0e6q+Fl0vcA2nGUOX21ytOxHuAd9f
	 D+bn3KsObDqYZciZB7V1qcU6UMK+mMALAa5XuwRzt5rV2BXD8z+dzLPqSdLFRm0hF0
	 ajyY2Ak2l6AaK0yADs8mow2svML/rpymtMIKiCIM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1B84BF805EC; Thu,  5 Mar 2026 23:47:27 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B327F805F3;
	Thu,  5 Mar 2026 23:47:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CDC67F8025A; Thu,  5 Mar 2026 23:47:18 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A6CFF800F3
	for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2026 23:47:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A6CFF800F3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189a137dff66e500-webhooks-bot@alsa-project.org>
In-Reply-To: <189a137dff3bd600-webhooks-bot@alsa-project.org>
References: <189a137dff3bd600-webhooks-bot@alsa-project.org>
Subject: sofhdadsp: missing conf.d symlink causes DMIC invisible on Raptor
 Lake SOF HDA DSP laptops
Date: Thu,  5 Mar 2026 23:47:18 +0100 (CET)
Message-ID-Hash: UTQQDZGBZIWY42P72FWYVSJZLUYTAB22
X-Message-ID-Hash: UTQQDZGBZIWY42P72FWYVSJZLUYTAB22
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UTQQDZGBZIWY42P72FWYVSJZLUYTAB22/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgaXNzdWUgIzcxNCB3YXMgb3BlbmVkIGZyb20gYnVu
YWVuOgoKIyMgSGFyZHdhcmUKLSBMZW5vdm8gVGhpbmtQYWQgWDEgQ2FyYm9uIEdlbiAxMSAoMjFI
TTAwMkNVUykKLSBLZXJuZWw6IDYuMTkuNS0xLWRlZmF1bHQgKG9wZW5TVVNFIFR1bWJsZXdlZWQp
Ci0gU09GIGRyaXZlcjogc29mLWF1ZGlvLXBjaS1pbnRlbC10Z2wKLSBTT0YgZmlybXdhcmU6IGlu
dGVsL3NvZi9zb2YtcnBsLnJpLCB2ZXJzaW9uIDI6MjowLTU3ODY0Ci0gYWxzYS11Y20tY29uZjog
MS4yLjE1LjMKCiMjIFByb2JsZW0KSW50ZXJuYWwgRE1JQyBpcyBjb21wbGV0ZWx5IGludmlzaWJs
ZSB0byBQaXBlV2lyZS9XaXJlUGx1bWJlci4KTm8gbWljcm9waG9uZSBpbnB1dCBhcHBlYXJzIGlu
IHNvdW5kIHNldHRpbmdzLgoKVGhlIERNSUMgaGFyZHdhcmUgaXMgcHJlc2VudCBhbmQgZnVuY3Rp
b25hbCBhdCB0aGUgcmF3IEFMU0EgbGV2ZWw6CgogICAgJCBhcmVjb3JkIC1sCiAgICBjYXJkIDA6
IHNvZmhkYWRzcCBbc29mLWhkYS1kc3BdLCBkZXZpY2UgNjogRE1JQyAoKikgW10KICAgIGNhcmQg
MDogc29maGRhZHNwIFtzb2YtaGRhLWRzcF0sIGRldmljZSA3OiBETUlDMTZrSHogKCopIFtdCgpC
dXQgd3BjdGwgc3RhdHVzIHNob3dlZCBubyBkaWdpdGFsIG1pY3JvcGhvbmUgc291cmNlIGF0IGFs
bC4KCiMjIFJvb3QgQ2F1c2UKVGhlIGNhcmQgcmVwb3J0cyBpdHMgQUxTQSBJRCB3aXRob3V0IGh5
cGhlbnM6CgogICAgJCBjYXQgL3Byb2MvYXNvdW5kL2NhcmQwL2lkCiAgICBzb2ZoZGFkc3AKClVD
TTIgY29uZi5kIGxvb2t1cCBpcyBhbiBleGFjdCBzdHJpbmcgbWF0Y2ggb24gY2FyZCBJRC4gVGhl
IHJlcG8Kc2hpcHMgY29uZi5kL3NvZi1oZGEtZHNwLyAod2l0aCBoeXBoZW5zKSBidXQgdGhlcmUg
aXMgbm8KY29uZi5kL3NvZmhkYWRzcC8gKHdpdGhvdXQgaHlwaGVucykgZW50cnkuIFRoZSBsb29r
dXAgc2lsZW50bHkKZmFpbHMsIFdpcmVQbHVtYmVyIGxvYWRzIG5vIFVDTSBwcm9maWxlLCBhbmQg
dGhlIERNSUMgaXMgbmV2ZXIKYWN0aXZhdGVkLgoKIyMgRml4CiAgICBzdWRvIGxuIC1zIC91c3Iv
c2hhcmUvYWxzYS91Y20yL2NvbmYuZC9zb2YtaGRhLWRzcCBcCiAgICAgICAgICAgICAgIC91c3Iv
c2hhcmUvYWxzYS91Y20yL2NvbmYuZC9zb2ZoZGFkc3AKICAgIHN5c3RlbWN0bCAtLXVzZXIgcmVz
dGFydCB3aXJlcGx1bWJlcgoKQWZ0ZXIgdGhpcywgd3BjdGwgc3RhdHVzIGNvcnJlY3RseSBzaG93
czoKLSBSYXB0b3IgTGFrZS1QL1UvSCBjQVZTIERpZ2l0YWwgTWljcm9waG9uZSDinJMKLSBSYXB0
b3IgTGFrZS1QL1UvSCBjQVZTIFN0ZXJlbyBNaWNyb3Bob25lIOKckwoKIyMgU3VnZ2VzdGVkIEZp
eApBZGQgdG8gdGhlIHJlcG86CiAgICB1Y20yL2NvbmYuZC9zb2ZoZGFkc3AgLT4gc29mLWhkYS1k
c3AvCgpUaGlzIGxpa2VseSBhZmZlY3RzIGFsbCBSYXB0b3IgTGFrZSBsYXB0b3BzIHdoZXJlIHRo
ZSBrZXJuZWwKcmVwb3J0cyB0aGUgY2FyZCBJRCBhcyBzb2ZoZGFkc3AgcmF0aGVyIHRoYW4gc29m
LWhkYS1kc3AuCgpJc3N1ZSBVUkwgICAgIDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVj
dC9hbHNhLXVjbS1jb25mL2lzc3Vlcy83MTQKUmVwb3NpdG9yeSBVUkw6IGh0dHBzOi8vZ2l0aHVi
LmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29uZgo=
