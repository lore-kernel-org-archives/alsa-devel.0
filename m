Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C936FCA1016
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Sep 2025 04:35:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6238060218;
	Thu, 11 Sep 2025 06:35:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6238060218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1757565351;
	bh=+bIfFxwXS+RIfzxH/LFZDw728oltpr2lHWmYDKhKGH4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=DasMn1uGmoUASXjac6CpkhhTEJ6veBb08oGfV5+omzMk02Zpn+60GYZ0uLiA5EjmA
	 4qJLFO1tL3MQ3mDluxtQ1TiivQMxNiB+nvNnz9W3kHqzyMJWavdE70eR2AwhMNhDsN
	 SeS/Kw2N9rHjgZwuUCXGMrXott3j3O6vGKwbE4TM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6F6CAF805BF; Thu, 11 Sep 2025 06:35:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 08A67F805E2;
	Thu, 11 Sep 2025 06:35:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 747A8F80518; Thu, 11 Sep 2025 06:34:06 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id A3170F800E3
	for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2025 06:34:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3170F800E3
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1864204728f3a800-webhooks-bot@alsa-project.org>
In-Reply-To: <1864204728c5e500-webhooks-bot@alsa-project.org>
References: <1864204728c5e500-webhooks-bot@alsa-project.org>
Subject: Internal microphone (Conexant SN6140) detected but shows
 inactive/unplugged on Lenovo IdeaPad Slim 5 16AKP10 83HY after alsa-ucm-conf
 1.2.14
Date: Thu, 11 Sep 2025 06:34:06 +0200 (CEST)
Message-ID-Hash: M4476GSPPM3K4SETYIBTJTENISC6REPS
X-Message-ID-Hash: M4476GSPPM3K4SETYIBTJTENISC6REPS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/M4476GSPPM3K4SETYIBTJTENISC6REPS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #612 was edited from JayJaber:

On a Lenovo IdeaPad Slim 5 16AKP10 83HY with Conexant SN6140 codec, the internal microphone works correctly with alsa-ucm-conf 1.2.13-2, but with 1.2.14 and newer it is detected but shows up as inactive/unplugged.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/612
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
