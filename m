Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA02ACCFA00
	for <alsa-devel@archiver.kernel.org>; Sat,  1 Nov 2025 14:36:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C5041601E9;
	Sat,  1 Nov 2025 15:36:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C5041601E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1762007788;
	bh=EiUKmWEJabygyjiByHCeJk+1DSoFMozjW86X4jwRKFs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=nb30uL0aGu/TLIXTfe+iB6YfsaXGfDD95LszjkqcU8kjGUVRk0A1dheBQrK35D+oX
	 olPHaNG9PpgaHzNVKzzZ+o+nIZB1mkvV22LIF+LVG/VyDNgqf/GLV37wVtj57h/Dyj
	 C1h6Sq+RYkVMaD2uLLoRV9TUb0Aj252fWVzPwzTU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EE53DF805D4; Sat,  1 Nov 2025 15:35:45 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C82A9F805CB;
	Sat,  1 Nov 2025 15:35:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BBCD3F80246; Sat,  1 Nov 2025 15:35:34 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id BA3F5F80027
	for <alsa-devel@alsa-project.org>; Sat,  1 Nov 2025 15:35:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA3F5F80027
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1873e8b270a24600-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/480@alsa-project.org>
References: <alsa-project/alsa-lib/pr/480@alsa-project.org>
Subject: doxygen: fix for doxygen 1.10.0 and later
Date: Sat,  1 Nov 2025 15:35:34 +0100 (CET)
Message-ID-Hash: 5CG7WQCA7O5JNWASLB27ITTCW5BS32HK
X-Message-ID-Hash: 5CG7WQCA7O5JNWASLB27ITTCW5BS32HK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5CG7WQCA7O5JNWASLB27ITTCW5BS32HK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #480 was opened from borine:

doygen 1.10.0 changed the paths that include files are searched, with the consequence for alsa-lib that the "Topics" tab is no longer fully populated.

See for example the [alsa project online docs](https://www.alsa-project.org/alsa-doc/alsa-lib/topics.html)

To fix this we need to prevent circular #include references when doygen scans its input files, and also to re-order some macros.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/480
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/480.patch
Repository URL: https://github.com/alsa-project/alsa-lib
