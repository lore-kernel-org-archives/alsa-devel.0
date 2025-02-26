Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBC7C021B8
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2025 08:45:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21883602C9;
	Wed, 26 Feb 2025 09:45:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21883602C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1740559553;
	bh=pV3igzPnOpW+6SSx3pnjAIIBAy/QEcAPsiGwjwYUfFg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=XgwqCrxfjW/Mpz6vpuJ0ts2PczQj7col+GCMCqD5yhW+3krn4Kqmg69N9cyXxSDn2
	 PzKILVk5SrmDBeY2s7WIPxYUOqwSg29n+i292fN23iwLDqi8Z1pEArvNVNLTLii6nz
	 oblczsyRR8w26H+xkyToE+hpP+N8bpl5dJxoOS2I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EDF71F805B2; Wed, 26 Feb 2025 09:45:27 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D924F805B2;
	Wed, 26 Feb 2025 09:45:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A79FBF8016E; Wed, 26 Feb 2025 09:44:51 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id C2CF0F800E5
	for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2025 09:44:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2CF0F800E5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1740559488369824409-webhooks-bot@alsa-project.org>
References: <1740559488369824409-webhooks-bot@alsa-project.org>
Subject: add rt713 & rt1318 LED control
Message-Id: <20250226084451.A79FBF8016E@alsa1.perex.cz>
Date: Wed, 26 Feb 2025 09:44:51 +0100 (CET)
Message-ID-Hash: Z2M63JE5ZCAYHHWXETXLBEIERUK5A2SM
X-Message-ID-Hash: Z2M63JE5ZCAYHHWXETXLBEIERUK5A2SM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Z2M63JE5ZCAYHHWXETXLBEIERUK5A2SM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #512 was opened from shumingfan:

add rt713 & rt1318 LED control

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/512
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/512.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
