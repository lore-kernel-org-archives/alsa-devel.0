Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4554BC4725D
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jan 2024 10:35:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6FE5C84C;
	Mon, 22 Jan 2024 11:35:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6FE5C84C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1705919710;
	bh=g8jYpry/UodYBZ+CtumUo64xQFzY7rDEnltB4eFvnjM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=DNsRA2NkxM8nvscWlMgrFvd5TZHKoAyTjMI1wvRK2Ud7Q+OMl78fT8K9930VhMGvU
	 3bZGXMLjJM7dif2zmBalkkbziwxX94EvqZj+X0S8TmmOUR/qJnCD7B/sZuCdNVNA3K
	 KaoUMp63PHDz/P8TPnfKTV2IDY7LKTewhao+NVQo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B5F60F8055B; Mon, 22 Jan 2024 11:34:38 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A9C8F80587;
	Mon, 22 Jan 2024 11:34:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BC9A1F8025F; Mon, 22 Jan 2024 11:34:30 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 107ABF8020D
	for <alsa-devel@alsa-project.org>; Mon, 22 Jan 2024 11:34:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 107ABF8020D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1705919653204494953-webhooks-bot@alsa-project.org>
References: <1705919653204494953-webhooks-bot@alsa-project.org>
Subject: ucm2: Qualcomm: Lenovo-X13s: reduce default headphones volume further
Message-Id: <20240122103430.BC9A1F8025F@alsa1.perex.cz>
Date: Mon, 22 Jan 2024 11:34:30 +0100 (CET)
Message-ID-Hash: ZJK4GJJVLO3DOLZ6IQ3LNDWVLOLUR7A7
X-Message-ID-Hash: ZJK4GJJVLO3DOLZ6IQ3LNDWVLOLUR7A7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZJK4GJJVLO3DOLZ6IQ3LNDWVLOLUR7A7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #387 was opened from jhovold:

A recent change reduced the default headphones volume from setting 20 (0 dB) to 10 (-15 dB) but also this setting can be quite loud and cause distortion with some headphones.

Reduce the default volume further to setting 2 (-27 dB), which results in more comfortable volume levels with such headphones.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/387
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/387.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
