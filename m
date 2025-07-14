Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1194FC83F1A
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jul 2025 09:08:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CA1B960216;
	Mon, 14 Jul 2025 11:07:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CA1B960216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1752484081;
	bh=J7mAYsiNfmqkTuZdUlI4k6Swtsy2yTEIRXXZOCQA6ro=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=L6VnZtrCWC8H6kAIm2CJ5X6EIKWcphhTiS1/LUMs7na9BY4lF6zPKMHZ2gkHSDowc
	 wQYWDJDcBfiFld8MiB6kqhR4NLgOPQbXcoIzhByDedWmMfc47rPHKw78E7PzScOsl3
	 Vqi1++MMzMlFZYEE0wRl4GGi7TQQY/Yhbk6aZl70=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1FFF8F805E9; Mon, 14 Jul 2025 11:07:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B328AF805F9;
	Mon, 14 Jul 2025 11:07:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8DF7BF804E5; Mon, 14 Jul 2025 11:07:08 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 2506BF800F8
	for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2025 11:07:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2506BF800F8
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <185212eff29e8d00-webhooks-bot@alsa-project.org>
In-Reply-To: <185212efefa23200-webhooks-bot@alsa-project.org>
References: <185212efefa23200-webhooks-bot@alsa-project.org>
Subject: Feature request: Add native support for CS8409 codec
Date: Mon, 14 Jul 2025 11:07:08 +0200 (CEST)
Message-ID-Hash: GV673455RDAW2JNUQMIGJSQESNUMYIQK
X-Message-ID-Hash: GV673455RDAW2JNUQMIGJSQESNUMYIQK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GV673455RDAW2JNUQMIGJSQESNUMYIQK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgaXNzdWUgIzU5MyB3YXMgb3BlbmVkIGZyb20gTWFy
ZWstbWFoYXY6CgpJJ3ZlIHRlc3RlZCB0aGUgQ1M4NDA5IGRyaXZlciBvbiBVYnVudHUgMjQuMDQu
MiB3aXRoIFdheWxhbmTigKYgW2NlbMO9IHRleHQgdHVdCgpJc3N1ZSBVUkwgICAgIDogaHR0cHM6
Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLXVjbS1jb25mL2lzc3Vlcy81OTMKUmVwb3Np
dG9yeSBVUkw6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29uZgo=
