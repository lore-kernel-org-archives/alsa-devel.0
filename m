Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FF6EEB57F
	for <alsa-devel@archiver.kernel.org>; Sat,  9 Sep 2023 07:45:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5BC251EB;
	Sat,  9 Sep 2023 09:44:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5BC251EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694245542;
	bh=Leq4kDQyMGQP7c1ng2ojtdfc5R/CczqTRe/7LbnYCKg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=l8J2iWOaoMb1F89gI/0vNVnYwjXARHDG5c+omo2BFScVP0s2UJqvwWtip0EtZW2EE
	 okCMrIZ92DRhjwePmgQ02m9EC05YyziBWY17/OalaKS5zRdmrscdMw/YDZ1BR4KH8E
	 6DwzQ8rGrUH88YnkjzBduSpNZXcDLk9QRtGQaxo0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1E9A0F8047D; Sat,  9 Sep 2023 09:44:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EAF45F80494;
	Sat,  9 Sep 2023 09:44:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0361CF80494; Sat,  9 Sep 2023 09:43:42 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 26D47F800F5
	for <alsa-devel@alsa-project.org>; Sat,  9 Sep 2023 09:43:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26D47F800F5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1694245416488033056-webhooks-bot@alsa-project.org>
References: <1694245416488033056-webhooks-bot@alsa-project.org>
Subject: libasound 1.2.10 seg faults on RPi2 (32-bit) without
 --disable-largefile
Message-Id: <20230909074342.0361CF80494@alsa1.perex.cz>
Date: Sat,  9 Sep 2023 09:43:42 +0200 (CEST)
Message-ID-Hash: 6H4SIVY52WYDDDCOYPRTCSBBIXDDEIPE
X-Message-ID-Hash: 6H4SIVY52WYDDDCOYPRTCSBBIXDDEIPE
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6H4SIVY52WYDDDCOYPRTCSBBIXDDEIPE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtbGliIGlzc3VlICMzNTIgd2FzIG9wZW5lZCBmcm9tIGhlaXRiYXVt
OgoKU2luY2UgdGhlIGRlZmF1bHQgY2hhbmdlIGluIDEuMi4xMCBLb2RpIDMyIG9yIFJQaSB3YXMg
Y3Jhc2hpbmcuIFJldmVydCB0byBwcmV2aW91cyB3aXRoIOKAlCBkaXNhYmxlLWxhcmdlZmlsZQ0K
DQpSZWY6DQotICMzMzMNCi0gaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLWxp
Yi9wdWxsLzMzMyNpc3N1ZWNvbW1lbnQtMTcxMjQxMDU0Mw0KLSBodHRwczovL2ZvcnVtLmxpYnJl
ZWxlYy50di90aHJlYWQvMjc1MDAtbGlicmVlbGVjLW5pZ2h0bHktcnBpMi1sYXRlc3QtYnVpbGRz
LWZhaWwtdG8tYm9vdC8NCi0gaHR0cHM6Ly9naXRodWIuY29tL0xpYnJlRUxFQy9MaWJyZUVMRUMu
dHYvcHVsbC84MTI2DQotIGh0dHBzOi8vZ2l0aHViLmNvbS9MaWJyZUVMRUMvTGlicmVFTEVDLnR2
L3B1bGwvODEyNiNpc3N1ZWNvbW1lbnQtMTcxMjQwOTE3NQoKSXNzdWUgVVJMICAgICA6IGh0dHBz
Oi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS1saWIvaXNzdWVzLzM1MgpSZXBvc2l0b3J5
IFVSTDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLWxpYgo=
