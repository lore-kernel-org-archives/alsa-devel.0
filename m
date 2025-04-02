Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCD9C28B20
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Apr 2025 06:18:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5FD360205;
	Wed,  2 Apr 2025 08:18:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5FD360205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1743574720;
	bh=xxvkgKTr400paha/SPxLZ+d4Oplkfzf3zy8hj16xcWU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=QnrnjG5tTnuBJhDaTZFsW3w7gz9DtCq1e/v7l25F6sje/ZWsMS60qSZOIOWh2f8Aw
	 7G2K/2HpC/uktJU4VGztSV/AWEGqEuKiczkZE2w0IFAH+49oQOJ37L4z2GKP1QGQDj
	 qFIuPnPvnvDj75lEjypkXpARTCB/oXU5X6Rn/nTA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CA177F805C7; Wed,  2 Apr 2025 08:18:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B021F805C2;
	Wed,  2 Apr 2025 08:18:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E4F8BF80301; Wed,  2 Apr 2025 08:18:00 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 10313F800D2
	for <alsa-devel@alsa-project.org>; Wed,  2 Apr 2025 08:17:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10313F800D2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18326beea16a7400-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-utils/pr/297@alsa-project.org>
References: <alsa-project/alsa-utils/pr/297@alsa-project.org>
Subject: aplay: add support for G.711 A_LAW enconding in AU file format
Date: Wed,  2 Apr 2025 08:18:00 +0200 (CEST)
Message-ID-Hash: P74WCN3I6MASXYCFUR2AFQOOQSEEUI6S
X-Message-ID-Hash: P74WCN3I6MASXYCFUR2AFQOOQSEEUI6S
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/P74WCN3I6MASXYCFUR2AFQOOQSEEUI6S/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdXRpbHMgcHVsbCByZXF1ZXN0ICMyOTcgd2FzIG9wZW5lZCBmcm9t
IGNobGVyb3k6CgpBdCB0aGUgdGltZSBiZWluZywgYXBsYXkgb25seSBzdXBwb3J0cyBHLjcxMSDC
tS1sYXcsIDgtYml0cyBQQ00gYW5kIDE2LWJpdHMgUENNIGVuY29kaW5ncyBmb3IgdGhlIEFVIGZv
cm1hdCB3aGlsZSB0aGUgQVUgZm9ybWF0IHN1cHBvcnRzIG1hbnkgbW9yZS4NCg0KSW4gRXVyb3Bl
IHRoZSBtb3N0IEcuNzExIHVzZWQgZW5jb2RpbmcgaXMgdGhlIEEtbGF3LCB3aGljaCBpcyBhbHNv
IHBhcnQgb2YgdGhlIGVuY29kaW5ncyBzdXBwb3J0ZWQgYnkgdGhlIEFVIGZpbGUgZm9ybWF0Lg0K
DQpBZGQgc3VwcG9ydCBmb3IgdGhhdCBlbmNvZGluZyBpbiBhcGxheS4KClJlcXVlc3QgVVJMICAg
OiBodHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2EtdXRpbHMvcHVsbC8yOTcKUGF0
Y2ggVVJMICAgICA6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11dGlscy9w
dWxsLzI5Ny5wYXRjaApSZXBvc2l0b3J5IFVSTDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJv
amVjdC9hbHNhLXV0aWxzCg==
