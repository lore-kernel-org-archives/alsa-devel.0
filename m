Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A8BFC72AD
	for <alsa-devel@archiver.kernel.org>; Sun, 22 Mar 2026 13:34:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DA92F601F0;
	Sun, 22 Mar 2026 14:34:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DA92F601F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774186470;
	bh=I1SxgaeLhRDbNwoJoP6cW9ASrM+RJq8f4LsH5Mh1/2A=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=rEIDwlz7Kyl+1+xPrqz/PneEAi4ynkhso+XeZrGnSJVuju85DMpEHA22McfcliFet
	 laBLjq2ChiVT+6j4voBYQN621P+GlYtovwqMJlti3WSlcth51FT0ofIX5UU2LANjVE
	 8/FKpmlSK+yKg8uskfi83dhyzIodP5F1Swl6rnmU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0ACE7F805EA; Sun, 22 Mar 2026 14:33:52 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 80DE8F805F4;
	Sun, 22 Mar 2026 14:33:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 439C6F8047D; Sun, 22 Mar 2026 14:33:43 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 3ADF7F800C1
	for <alsa-devel@alsa-project.org>; Sun, 22 Mar 2026 14:33:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3ADF7F800C1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189f2d26441c5d00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/729@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/729@alsa-project.org>
Subject: UCM2: RODECaster Pro II: Add new Multitrack mappings for 1.7.3
 firmware
Date: Sun, 22 Mar 2026 14:33:43 +0100 (CET)
Message-ID-Hash: 6VLRKGZPTBTBOFLAU4OM75TDPQ6BTNID
X-Message-ID-Hash: 6VLRKGZPTBTBOFLAU4OM75TDPQ6BTNID
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6VLRKGZPTBTBOFLAU4OM75TDPQ6BTNID/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgcHVsbCByZXF1ZXN0ICM3Mjkgd2FzIG9wZW5lZCBm
cm9tIHBhcnppdmFsLXNwYWNlOgoKUk9ERSByZWNlbnRseSBjaGFuZ2VkIHRoZSBtYXBwaW5ncyBm
b3IgdGhlICJNdWx0aXRyYWNrIE91dHB1dCIgZnVuY3Rpb25hbGl0eSBvZiB0aGUgUk9ERUNhc3Rl
ciBQcm8gSUkuIA0KSW5zdGVhZCBvZiBoYXZpbmcgZml4ZWQgdmlydHVhbCBkZXZpY2VzIGZvciBz
cGVjaWZpYyBjaGFubmVscywgdGhlIFJPREVDYXN0ZXIgd2lsbCBub3cgb3V0cHV0IHdoYXRldmVy
IHRoZSB1c2VyIGFzc2lnbmVkIHRvIHRoZSBzcGVjaWZpYyBmYWRlcnMgb24gdGhlIGRldmljZSBp
dHNlbGYuDQpUaGV5IGludHJvZHVjZWQgdHdvIG5ldyBVU0IgUElEcyBmb3IgdGhpcyBgMDA5NGAg
KG5ldyBtdWx0aXRyYWNrIGlucHV0ICYgb3V0cHV0KSBhbmQgYDAwOTJgIChuZXcgbXVsdGl0cmFj
ayBvdXRwdXQgb25seSkuDQoNClRoaXMgUFIgYWRkcyB0aGUgbWFwcGluZ3MgZm9yIHRoZSBuZXcg
bW9yZSBnZW5lcmljIGRldmljZXMuIA0KSSB1c2VkIHRoZSBjaGFubmVsIGxheW91dCBwcm92aWRl
ZCBieSBST0RFIGFzIGEgcmVmZXJlbmNlOiBbVGhlIFLDmERFQ2FzdGVyIFBybyBJSSAvIER1byBN
dWx0aXRyYWNrIENoYW5uZWwgTGF5b3V0XShodHRwczovL2hlbHAucm9kZS5jb20vaGMvZW4tdXMv
YXJ0aWNsZXMvMTU0MTI4MzA2NzQ5NTktVGhlLVIlQzMlOThERUNhc3Rlci1Qcm8tSUktRHVvLU11
bHRpdHJhY2stQ2hhbm5lbC1MYXlvdXQpCgpSZXF1ZXN0IFVSTCAgIDogaHR0cHM6Ly9naXRodWIu
Y29tL2Fsc2EtcHJvamVjdC9hbHNhLXVjbS1jb25mL3B1bGwvNzI5ClBhdGNoIFVSTCAgICAgOiBo
dHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYvcHVsbC83MjkucGF0
Y2gKUmVwb3NpdG9yeSBVUkw6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11
Y20tY29uZgo=
