Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBA1C77B7F
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Jun 2025 16:12:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7FA6260219;
	Fri, 27 Jun 2025 18:12:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7FA6260219
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1751040758;
	bh=xFxDXNRi+jcl5Dko5GTIY1RurgHXiqQG/wIBG6KMnXY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=KRcUj9ztkezWsmsnYWadWfDXkYt4PiSqR9TAb0MomSSqsF8zGAdG6Ru07WGNdo9EA
	 SL213CqzKnE+t9nHwMnxxzHmbe0fSZ4FYFezPKbqHgBs9D2oqdKl8c8UvFgy3NiG/W
	 JnmqaWvU9kkDMSnNRsv+6Sst7EvXqvcXndjOIxic=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 324FCF805D2; Fri, 27 Jun 2025 18:12:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0501AF8024C;
	Fri, 27 Jun 2025 18:12:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C4E47F80217; Fri, 27 Jun 2025 18:12:01 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id E07B1F800FA
	for <alsa-devel@alsa-project.org>; Fri, 27 Jun 2025 18:11:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E07B1F800FA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <184cf241d1b86900-webhooks-bot@alsa-project.org>
In-Reply-To: <184cf241d167b100-webhooks-bot@alsa-project.org>
References: <184cf241d167b100-webhooks-bot@alsa-project.org>
Subject: Change description of HiFi verbs
Date: Fri, 27 Jun 2025 18:12:01 +0200 (CEST)
Message-ID-Hash: O6GPEVQPFTEF5RHGYC4ZQ6T3KRMSX4HO
X-Message-ID-Hash: O6GPEVQPFTEF5RHGYC4ZQ6T3KRMSX4HO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/O6GPEVQPFTEF5RHGYC4ZQ6T3KRMSX4HO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #586 was opened from ford-prefect:

I wanted to raise this issue before creating a PR -- the string "Play HiFi quality Music" is not very good as a user-facing description for the output of their device's audio capability. The configuration enables both playback and capture (so "Play" is incomplete). There is nothing "Music"-specific about the output. And finally, "HiFi quality" feels like an anachronism at best.

Historically, we've used "Analog Stereo Duplex" for playback/capture and "Analog Stereo Input" or "Analog Stereo Output" for unidirectional configuration (these strings are also well translated at this point).

Another option is to use "Analog Audio", I suppose. Open to other options, if there are ideas.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/586
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
