Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87195CCF9F8
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Nov 2025 00:32:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3BF3F601F6;
	Thu,  6 Nov 2025 01:32:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3BF3F601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1762389163;
	bh=UIcITqJpu3U/nOPiZdXT5D//rD7DDWM+2T0XQP+SmYE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ulF1RLVnYwTVoCeW2qIg6dKdPN1jEwY8qjXtFHzARrygqaGAwrkCY4fqRJejw4fi9
	 YEcezQBklkoJiV9fEdaUTEvIanFl/AnOTdj/qB64uKCKTFHAYExm6WS3VQW4wIphEe
	 yTJ1jO/MF9VCP7vQdAbeRik8b3Pif4IyalD/D7VE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B490EF805C4; Thu,  6 Nov 2025 01:32:09 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 79040F805D3;
	Thu,  6 Nov 2025 01:32:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DD1D9F80272; Thu,  6 Nov 2025 01:31:50 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D1E9F80100
	for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2025 01:31:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D1E9F80100
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1875438e53fdd500-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/636@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/636@alsa-project.org>
Subject: USB-Audio: Add support for PreSonus Revelator io24
Date: Thu,  6 Nov 2025 01:31:50 +0100 (CET)
Message-ID-Hash: HRNONWXQAT3T5ZUHYGYKLYGGEZOPUL6K
X-Message-ID-Hash: HRNONWXQAT3T5ZUHYGYKLYGGEZOPUL6K
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HRNONWXQAT3T5ZUHYGYKLYGGEZOPUL6K/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #636 was opened from 0PandaDEV:

These mappings are based on the ones from the revelator io44 and adjusted to work with both microphone channels, since the io24 has 2.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/636
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/636.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
