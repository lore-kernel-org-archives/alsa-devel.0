Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11160CD6E64
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:19:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B7D86021D;
	Tue,  2 Jun 2026 11:19:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B7D86021D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780391972;
	bh=o3/QAjWFR2xYKj6+WgA0lVwf+DzoSq6k65nm0KejytI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=k9hyRn/Cae1y6VUKQA5aZ8EQhXBhbsI/C5oLVS3gf9hOHU7xyL+3tkCcciGuovl3d
	 leILZI/82xOyhO9rK2i4vQM0tpvnVO5RgDinpcuVMitvFaHK4/o5nAwrA0uDP95WqL
	 xDKUrvbaDi0jCUXs4XmLYi0JeleP2OLVsFeL7FoA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 20C19F805A1; Tue,  2 Jun 2026 11:19:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BB3CEF805FA;
	Tue,  2 Jun 2026 11:19:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CAFDEF804F2; Tue,  2 Jun 2026 11:18:57 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D340F800B0
	for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2026 11:18:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D340F800B0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b539085480b300-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/509@alsa-project.org>
References: <alsa-project/alsa-lib/pr/509@alsa-project.org>
Subject: Fix theoretical one-byte buffer overrun
Date: Tue,  2 Jun 2026 11:18:57 +0200 (CEST)
Message-ID-Hash: 6HNCM7SYYO2SGSJ4VEFGHNBHKTMYEZWM
X-Message-ID-Hash: 6HNCM7SYYO2SGSJ4VEFGHNBHKTMYEZWM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6HNCM7SYYO2SGSJ4VEFGHNBHKTMYEZWM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #509 was opened from dirkmueller:

If 64 (sizeof(buf))= or more characters were provided in the input string, this unconditionally writes a null byte to `buf[64]`, which is one byte past the end of the array.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/509
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/509.patch
Repository URL: https://github.com/alsa-project/alsa-lib
