Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882B9FB3CE4
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:08:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2AB42601F7;
	Mon, 30 Mar 2026 11:08:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2AB42601F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774861721;
	bh=0/6/mWrx+7z+aPjBr9hvTRIZBzu0RUf/ljJ5d7++AeU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ZnWv8VV5mKXcNESshLOxCexraqeX929bh4XOFFpbEKgWNl6W1h82pJFv2tKIFWU50
	 4lGSKfWWZCd8Q34HuQVk59J82V2OheN6yofb8gxHwK3utlO4WAbxdNyP00bDsH8vu4
	 DwyVvJolrCMZGTf3cfq+esdiGQb3QvrzyYTp6THk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A00CEF805EF; Mon, 30 Mar 2026 11:08:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 82DC2F805E2;
	Mon, 30 Mar 2026 11:08:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D33C9F8052D; Mon, 30 Mar 2026 11:07:57 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 462A7F8021D
	for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2026 11:07:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 462A7F8021D
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a1934966fa5000-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/735@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/735@alsa-project.org>
Subject: ucm2: Qualcomm: add QCS6490 Thundercomm RubikPi3 HiFi config
Date: Mon, 30 Mar 2026 11:07:57 +0200 (CEST)
Message-ID-Hash: FP4SY3TLLPNCJ4H4DGJRS44IGQVVWMB5
X-Message-ID-Hash: FP4SY3TLLPNCJ4H4DGJRS44IGQVVWMB5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FP4SY3TLLPNCJ4H4DGJRS44IGQVVWMB5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgcHVsbCByZXF1ZXN0ICM3MzUgd2FzIG9wZW5lZCBm
cm9tIGhvbmd5YW5nLXJwOgoKUlVCSUsgUGkgMyAoaHR0cHM6Ly9ydWJpa3BpLmFpLyksIGEgbGln
aHR3ZWlnaHQgZGV2ZWxvcG1lbnQgYm9hcmQgYmFzZWQgb24NClF1YWxjb21tIERyYWdvbndpbmfi
hKIgUUNTNjQ5MCBwbGF0Zm9ybSwgaXMgdGhlIGZpcnN0IFBpIGJ1aWx0IG9uIFF1YWxjb21tDQpB
SSBwbGF0Zm9ybXMgZm9yIGRldmVsb3BlcnMuDQoNCkZ1bGwgc3BlY3M6DQotIEhlYWRwaG9uZSBq
YWNrIHVzaW5nIEVTODMxNiBjb2RlYy4NCi0gT25ib2FyZCBEU0kgdG8gSERNSSBicmlkZ2UsIHVz
aW5nIExvbnRpdW0gTFQ5NjExLCBzdXBwb3J0cyBIRE1JIE9VVCBhdWRpby4NCi0gVGhlIFRFUlRJ
QVJZX01JMlMgY2FuIGJlIHVzZWQgdmlhIGEgNDAtcGluIEdQSU8gY29ubmVjdG9yICh1bnVzZWQg
YnkgZGVmYXVsdCkuDQotIEJsdWV0b290aCBhdWRpbyBpcyBzdXBwb3J0ZWQgdmlhIFFVSU5BUllf
TUkyUyAodW51c2VkIGJ5IGRlZmF1bHQpLiANCg0KVGhlIGtlcm5lbCBkZXZpY2UgdHJlZSBpcyBj
dXJyZW50bHkgdW5kZXIgdXBzdHJlYW0gcmV2aWV3LgoKUmVxdWVzdCBVUkwgICA6IGh0dHBzOi8v
Z2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29uZi9wdWxsLzczNQpQYXRjaCBVUkwg
ICAgIDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLXVjbS1jb25mL3B1bGwv
NzM1LnBhdGNoClJlcG9zaXRvcnkgVVJMOiBodHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0
L2Fsc2EtdWNtLWNvbmYK
