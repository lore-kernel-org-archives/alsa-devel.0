Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8F9D73601
	for <alsa-devel@archiver.kernel.org>; Sat, 30 Nov 2024 12:29:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 888B421DD;
	Sat, 30 Nov 2024 13:29:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 888B421DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1732969766;
	bh=PNGlgbPzmWPCGyV7SFQDCxYutx5tVCarFD8e1njBrMk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=aX9mYSmrBzwSIFTriVeNeyzEvWcxHviYt4uab+7nQ46XHhVF+xRmIqDMHg12iP+Us
	 xij6il1I4HBC3lDZMj+6sNwzqam+jCNT+YfpEtr0ugKCr5D6gnhsm5SKt8jB+YFtDW
	 N+c6Tx8Y1hCtw4lO4hQnXqlq6ECAkDAkZhQFMiCk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3CF68F805AB; Sat, 30 Nov 2024 13:28:54 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7FFD7F805AB;
	Sat, 30 Nov 2024 13:28:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2FE6EF80236; Sat, 30 Nov 2024 13:28:48 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E143F80073
	for <alsa-devel@alsa-project.org>; Sat, 30 Nov 2024 13:28:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E143F80073
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1732969725839164734-webhooks-bot@alsa-project.org>
References: <1732969725839164734-webhooks-bot@alsa-project.org>
Subject: Linux Mint Cinnamon 22 Soundblaster AE-9 no sound
Message-Id: <20241130122848.2FE6EF80236@alsa1.perex.cz>
Date: Sat, 30 Nov 2024 13:28:48 +0100 (CET)
Message-ID-Hash: IXAQH5PN5CS5EYSVSOP2ILBINOKGPU5L
X-Message-ID-Hash: IXAQH5PN5CS5EYSVSOP2ILBINOKGPU5L
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IXAQH5PN5CS5EYSVSOP2ILBINOKGPU5L/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtbGliIGlzc3VlICM0MjQgd2FzIG9wZW5lZCBmcm9tIFN0YXJmb3hm
czoKCkhpLA0KDQppIGhhdmUgZnJlc2ggaW5zdGFsbGVkIExpbnV4IE1pbnQgQ2lubmFtb24gMjIg
S2VybmVsIDYuOC4wLjQ5LWdlbmVyaWMNCg0KSSBjYW7CtHQgZ2V0IHRoZSBTb3VuZGJsYXN0ZXIg
QUUtOSB0byB3b3JrLiBDcmVhdGl2ZSBMYWJzIGhhcyBubyBEcml2ZXJzIGZvciBMaW51eCBhbmQg
cG9pbnRzIHRvIHRoZSBhbHNhIGNvbW11bml0eS4NCg0KSXMgdGhlcmUgYW55IGNoYW5nZSB0byBn
ZXQgc3VwcG9ydCBmb3IgdGhlIFNvdW5kYmxhc3RlciBBRS05IGluIHRoZSBmdXR1cmUgPw0KDQpJ
IHRoaW5rIHRoZSBiaWcgUHJvYmxlbSBpcyB0aGUgZXh0ZXJuYWwgREFDIGZvciBIZWFkcGhvbmVz
IGZyb20gdGhlIFNvdW5kYmxhc3RlciBBRS05LiBJbiBXaW5kb3dzIHRoaXMgImNsaWNrcyIgb24g
c3RhcnR1cCBhbmQgYWN0aXZhdGVzIHRoZSBEQUMsIGJ1dCBpbiBMaW51eCB0aGlzIGlzIGFsbCBk
ZWFkLgoKSXNzdWUgVVJMICAgICA6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxz
YS1saWIvaXNzdWVzLzQyNApSZXBvc2l0b3J5IFVSTDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2Et
cHJvamVjdC9hbHNhLWxpYgo=
