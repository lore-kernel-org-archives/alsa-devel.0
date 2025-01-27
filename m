Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1E6C0218F
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2025 08:20:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42B7C601C9;
	Mon, 27 Jan 2025 09:20:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42B7C601C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1737966033;
	bh=VsZHuRpSQESb3JWbI97HulASErGUXzZhy2ZS0SxMPnE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=UGU3pLN9KSB3qWdfd3wG/ff7lboE3x523MNrUAO0JJwV/7vfNnjDkxKLRQfAAzMc7
	 KTqwiEUhpmmvmeWftI77jz+fA9U7PYImqNJiGQbUuw1qXBbVps3qX7pgmbe+YQTzs5
	 KIHt32DSj/wmNs7wnfVtFcMvrJgU5yETb/f79Ikg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4670FF805AC; Mon, 27 Jan 2025 09:20:00 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E0A2F805BF;
	Mon, 27 Jan 2025 09:20:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 51F5DF802DB; Mon, 27 Jan 2025 09:19:41 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id F2203F8013D
	for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2025 09:19:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F2203F8013D
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1737965977528285742-webhooks-bot@alsa-project.org>
References: <1737965977528285742-webhooks-bot@alsa-project.org>
Subject: 
 =?utf-8?q?USB-Audio=3A_ALC4082_-_Add_support_for_ASUS_ROG_Crosshair_X870E_Hero_=28U=E2=80=A6?=
Message-Id: <20250127081942.51F5DF802DB@alsa1.perex.cz>
Date: Mon, 27 Jan 2025 09:19:41 +0100 (CET)
Message-ID-Hash: BQLC2MZOYEOPZYB4H2W7W4HEBGL5MWY5
X-Message-ID-Hash: BQLC2MZOYEOPZYB4H2W7W4HEBGL5MWY5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BQLC2MZOYEOPZYB4H2W7W4HEBGL5MWY5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgcHVsbCByZXF1ZXN0ICM1MDMgd2FzIG9wZW5lZCBm
cm9tIEZhYmNpZW46CgrigKZTQiAwYjA1OjFiN2MpDQoNCmh0dHBzOi8vcm9nLmFzdXMuY29tL21v
dGhlcmJvYXJkcy9yb2ctY3Jvc3NoYWlyL3JvZy1jcm9zc2hhaXIteDg3MGUtaGVyby9zcGVjLwoK
UmVxdWVzdCBVUkwgICA6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20t
Y29uZi9wdWxsLzUwMwpQYXRjaCBVUkwgICAgIDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJv
amVjdC9hbHNhLXVjbS1jb25mL3B1bGwvNTAzLnBhdGNoClJlcG9zaXRvcnkgVVJMOiBodHRwczov
L2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYK
