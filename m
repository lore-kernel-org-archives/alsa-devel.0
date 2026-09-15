Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA72DC88E75
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2026 23:34:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 319CC601F4;
	Wed, 16 Sep 2026 01:33:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 319CC601F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789515238;
	bh=OGf9PzhZ1uTGy8cdCq3MpM5PO7TZK2ld3oTHW8y7beM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=DTxWg4JYbdJR8DuDdBiaH3Xn6dnlQW2yzJ+7xQdkKt1QJn5DaOJWyIMiGSwGQ6JA/
	 UnPy+VbB9VuyH+esV0CnWUCb5fXyG8+Wj57FrpyY3AJPKBeT0tRRyDVFbk1tPkJEfE
	 YlKpDljMTE9Y94N7e3p7ySTM8ut7PRkWwd7EAnl4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BD0EEF805F7; Wed, 16 Sep 2026 01:33:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 587A8F80525;
	Wed, 16 Sep 2026 01:33:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 32874F804D6; Wed, 16 Sep 2026 01:33:17 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789515196;
	b=NIqv3RRZ8tQqPzxKW8GjJRB1e+ATaAencJVnn/iyKtEdyO5E69e6Qt73KTSzfCywsXVV
	 GerjVqcbCsN7VvSHI9wD55q+o3fHddq/xev0754/m+vH4ZAyF5BU+67yKf24dJcUC5WcZ
	 RVLmNcKSG1EjAONkJtI1jx+YPw0iiy1coji/RYXVSLOprGRxMCvph6CfZ0MYGInwXHH3E
	 D++zJTvK5Nzr0EOeoGJZSgMJu5RJ2aFA9Nr4nseaMEuBxibNV0inDrwdy9/J913QYJ0+K
	 XQMgRMCAEXj5134NFkHyv0JE9IRt+pieopjaFPcay5M7icdhrLae+0wSnwdUQyjOfJw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789515196;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=OGf9PzhZ1uTGy8cdCq3MpM5PO7TZK2ld3oTHW8y7beM=;
	b=O3DUKafqsLjvAiA9aZzGhaGMISXt2wzrz7BTEIu5yuSzMFgchnRuFQRxHJhJPLNyFgdn
	 hx8yvBX9T7viRbUUkcmF1qQj9CWVzfwivBOoTSQL1wxvQa4EG21rf9vBeVL31vDVVvwqg
	 UkBxwhCofTKSJMHqcIaRejzSh2RnZJYH6M6IUmGeOK3P5b3qS55iiUV9rLgM7qJTAgUeI
	 nIffU1jRp3lSxcBoyPw4KCGnL23s+O0dYTlfL+8W52cc67fIa3itRt8nYoj8Wlxf9Rfas
	 OqgL8t9dCLJ8Wt3rhAyixKGI3s2TpxlZHfPXX+M4RKVCk1beZ/NPWHGwsFzSV1czjqg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 250C2F80075
	for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2026 01:33:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 250C2F80075
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d5a29692a31700-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/858@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/858@alsa-project.org>
Subject: ucm2: Qualcomm: Add Asus Zenbook A14 (UX3407NA)
Date: Wed, 16 Sep 2026 01:33:17 +0200 (CEST)
Message-ID-Hash: HKGLHOLTWOGKXG3J3H3TWXZ2MG22MIBS
X-Message-ID-Hash: HKGLHOLTWOGKXG3J3H3TWXZ2MG22MIBS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HKGLHOLTWOGKXG3J3H3TWXZ2MG22MIBS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #858 was opened from quic-bjorande:

The Asus Zenbook A14 (UX3407NA) is a Qualcomm Glymur-based laptop featuring:

- 2 speakers
- 2 DMICs
- 3 HDMI/DP ports
- Headphone jack

Add support for speakers and DMICs for now, as work is still pending for the others.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/858
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/858.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
